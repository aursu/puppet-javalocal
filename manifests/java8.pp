# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include javalocal::java8
class javalocal::java8 (
    Lsys::Java8Major
            $version_major = $javalocal::version_major,
    Lsys::Java8Minor
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
    case $facts['os']['architecture'] {
        'i386', 'i586': { $arch = 'i586' }
        default: { $arch = 'amd64' }
    }

    if $install_path {
        $dist_install_path = $install_path
    }
    elsif $version_major =~ /(\d+)u(\d+)/ {
        $update = 0 + $2
        if $update > 162 {
            $dist_install_path = "${java_se}1.${1}.0_${2}-${arch}"
        }
        else
        {
            $dist_install_path = "${java_se}1.${1}.0_${2}"
        }
    }
    else {
        $dist_install_path = "${java_se}-${version_major}"
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
