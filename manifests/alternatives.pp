# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include javalocal::alternatives
class javalocal::alternatives (
    String
            $java_install_path,
    String  $java_alternative       = $javalocal::params::java_alternative,
    Integer $java_alternative_prio  = $javalocal::params::java_alternative_prio,
    String  $template               = $javalocal::params::java_alternative_template,
    Stdlib::Unixpath
            $system_path            = $javalocal::system_path,
    Enum['jre', 'jdk']
            $java_se                = $javalocal::java_se,
    Boolean $control_java           = $javalocal::control_java,
)  inherits javalocal::params
{
    assert_private()

    $java_path = "${system_path}/${java_install_path}"
    $alternative_path = "${system_path}/${java_alternative}"

    if $facts['os']['family'] == 'Debian' {
        $java_alternative_path = $java_se ? {
            'jdk'   => "${alternative_path}/jre/bin/java",
            default => "${alternative_path}/bin/java",
        }

        file { "${system_path}/.${java_alternative}.jinfo":
            ensure  => 'file',
            content => $template,
            tag     => 'java-alternatives',
        }

        file { $alternative_path:
            ensure => 'link',
            target => $java_install_path,
            notify => File['default-java'],
            tag    => 'java-alternatives',
        }

        file { "${system_path}/default-java":
            ensure => 'link',
            target => $java_alternative,
            alias  => 'default-java',
        }

        Package <| title == 'java-common' |> -> Exec <| tag == 'update-alternatives' |>

        [ 'java', 'keytool', 'orbd', 'pack200',
          'rmid', 'rmiregistry', 'servertool',
          'tnameserv', 'unpack200', 'policytool',
          ['jexec', 'jre/lib/jexec']
        ].each |$x| {
            [$xname, $xpath] = $x ? {
                String => [$x, "jre/bin/${x}"],
                Array  => $x
            }
            exec {"update-alternatives --install /usr/bin/${xname} ${xname} ${alternative_path}/${xpath} ${java_alternative_prio}":
                unless => "grep -q ${alternative_path} /var/lib/dpkg/alternatives/${xname}",
                path   => '/bin:/usr/bin:/sbin:/usr/sbin',
                tag    => 'update-alternatives',
            }
        }
    }
    else {
        # RedHat and other
        $java_alternative_path = $java_se ? {
            'jdk'   => "${java_path}/jre/bin/java",
            default => "${java_path}/bin/java",
        }
    }

    notify { $java_alternative_path: }

    if $control_java {
        $dummy_package_name = "oracle-java8-${java_se}"
        class { 'java':
            package               => $dummy_package_name,
            version               => 'absent',
            java_alternative      => $java_alternative,
            java_alternative_path => $java_alternative_path,
            java_home             => $alternative_path,
        }
        Exec <| tag == 'update-alternatives' |> -> Class['java::config']
        File <| tag == 'java-alternatives' |> -> Class['java::config']
    }
}
