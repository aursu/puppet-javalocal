# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include javalocal::params
class javalocal::params {
    $java_version_major         = '8u221'
    $java_version_minor         = 'b11'
    $java_url_hash              = '230deb18db3e4014bb8e3e8324f81b43'
    $java_se                    = 'jdk'
    $java_alternative           = "java-8-oracle-${::architecture}"
    $java_alternative_prio      = 2071
    $java_alternative_template  = 'javalocal/debian-alternatives.erb'
}
