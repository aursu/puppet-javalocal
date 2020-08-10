# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include javalocal::params
class javalocal::params {
    $java_version_major         = '8u261'
    $java_version_minor         = 'b12'
    $java_url_hash              = 'a4634525489241b9a9e1aa73d9e118e6'
    $java_se                    = 'jdk'
    $java_alternative           = "java-8-oracle-${::architecture}"
    $java_alternative_prio      = 2071
    $java_alternative_template  = 'javalocal/debian-alternatives.erb'
}
