# == Class: ftpproxy
#
# Full description of class ftpproxy here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'ftpproxy':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Sebastian Reitenbach <sebastia@l00-bugdead-prods.de>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
define ftpproxy::ftpproxy (
  $ensure = 'running',
  $enable = true,
  $flags  = undef,
){

  if $title == 'ftpproxy' {
    $service_name = $title
  } else {
    $tmp = regsubst($title, '[/ ]', '_', 'G')
    $service_name = "ftpproxy_${tmp}"
    exec { "cp ftpproxy ${service_name}":
      command => "/bin/cp /etc/rc.d/ftpproxy /etc/rc.d/${service_name}",
      creates => "/etc/rc.d/${service_name}",
      before  => Service[$service_name],
    }
  }

  service { $service_name:
    ensure => $ensure,
    enable => $enable,
    flags  => $flags,
  }
}
