# Class: javalocal
#
# @summary jalocal clasee required for in-module Hiera initialization
#
# Parameters:
#
#  [*java_se*]
#    String. One of 'jdk' or 'jre' depends on Java distribution set
#
#  [*install_path*]
#    String. Default is jdk1.8.0_181. It is directory inside system Java path
#    which consts of Oracle Java distribution
#
#  [*control_java*]
#    Boolean. Default - true. If set to true than module javalocal will use
#    class 'java' from standard module puppetlabs/java that could be not
#    desirable on some environments. Class 'java' is used for setting up java
#    into OS alternatives system, therefore set control_java flag to false will
#    disable this feature as well
#
# @example
#   include javalocal
class javalocal (
    String  $java_se,
    String  $system_path,
    Optional[String]
            $install_path,
    Boolean $control_java,
    String  $version_major = $javalocal::params::java_version_major,
    String  $version_minor = $javalocal::params::java_version_minor,
    String  $url_hash      = $javalocal::params::java_url_hash,
) inherits javalocal::params
{
}
