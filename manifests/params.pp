# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include javalocal::params
class javalocal::params {
    $java_version_major         = '8u181'
    $java_version_minor         = 'b13'
    $java_url_hash              = '96a7b8442fe848ef90c96a2fad6ed6d1'
    $java_se                    = 'jdk'
    $java_alternative           = "java-8-oracle-${::architecture}"
    $java_alternative_prio      = 2071
    $java_alternative_template  = 'javalocal/debian-alternatives.pp'
}
