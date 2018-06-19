# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include javalocal::params
class javalocal::params {
    $java_version_major         = '8u171'
    $java_version_minor         = 'b11'
    $java_url_hash              = '512cd62ec5174c3487ac17c61aaa89e8'
    $java_se                    = 'jdk'
    $java_install_path          = 'jdk1.8.0_171'
    $java_alternative           = "java-8-oracle-${::architecture}"
    $java_alternative_prio      = 2071
    $java_alternative_template  = 'javalocal/debian-alternatives.pp'
}
