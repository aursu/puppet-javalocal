# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include javalocal::java8
class javalocal::java8 (
    Javalocal::Java8Major
            $version_major = $javalocal::version_major,
    Javalocal::Java8Minor
            $version_minor = $javalocal::version_minor,
    String  $url_hash      = $javalocal::url_hash,
    Enum['jre', 'jdk']
            $java_se       = $javalocal::java_se,
    Stdlib::Unixpath
            $system_path   = $javalocal::system_path,
    Optional[String]
            $install_path  = $javalocal::install_path,
    Boolean $control_java  = $javalocal::control_java,
)
{
    # default architecture is amd64 or x86_64
    # also provide support for i386 and i586
    case $facts['os']['architecture'] {
        'i386', 'i586': { $arch = 'i586' }
        default: { $arch = 'amd64' }
    }

    if $install_path {
        $base_install_path = $install_path
        $dist_install_path = $base_install_path
    }
    elsif $version_major =~ /(\d+)u(\d+)/ {
        $version = 0 + $1
        $update = 0 + $2
        $base_install_path = "${java_se}1.${1}.0_${2}"
        if $facts['os']['family'] in ['RedHat', 'Amazon'] and $version >= 8 and $update > 162 {
            $dist_install_path = "${base_install_path}-${arch}"
        }
        else
        {
            $dist_install_path = $base_install_path
        }

    }
    else {
        $base_install_path = "${java_se}-${version_major}"
        $dist_install_path = $base_install_path
    }

    # trick for puppet module puppetlabs/java version 3.0.0 and below
    if $base_install_path != $dist_install_path {
        file { "${system_path}/${base_install_path}":
            ensure => 'link',
            target => $dist_install_path,
            before => Java::Oracle[$dist_install_path],
        }
    }

    java::oracle { $dist_install_path:
        version_major => $version_major,
        version_minor => $version_minor,
        url_hash      => $url_hash,
        java_se       => $java_se,
    }

    class { 'javalocal::alternatives':
        java_install_path => $dist_install_path,
        control_java      => $control_java,
        require           => Java::Oracle[$dist_install_path],
    }
}
