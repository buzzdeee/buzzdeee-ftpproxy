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
# Author Name <sebastia@l00-bugdead-prods.de>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
define ftpproxy (
  $service_ensure  = 'running',
  $service_enable  = true,
  $service_flags   = undef,
){

  if $title != "ftpproxy" {
    $service_name = regsubst($title, '-', '_', 'G')
    exec { "copy ftpproxy ${service_name}":
      command => "/bin/cp /etc/rc.d/ftpproxy /etc/rc.d/${service_name}"
      creates => "/etc/rc.d/${service_name}",
      before  => Service[$service_name],
    }
  } else {
    $service_name = $title
  }

  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
    flags  => $service_flags,
  }
}
