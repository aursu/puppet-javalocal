# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include javalocal::params
class javalocal::params {
    $java_version_major         = '8u191'
    $java_version_minor         = 'b12'
    $java_url_hash              = '2787e4a523244c269598db4e85c51e0c'
    $java_se                    = 'jdk'
    $java_alternative           = "java-8-oracle-${::architecture}"
    $java_alternative_prio      = 2071
    $java_alternative_template  = 'javalocal/debian-alternatives.pp'
}
