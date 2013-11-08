# == Class: serf
#
# Full description of class serf here.
#
# === Parameters
#
# Document parameters here.
#
# [*version*]
#   Specify version of serf binary to download. Defaults to '0.2.0'
#   http://serfdom.io does not currently provide a url for latest version.
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
#  You can invoke this module with simply:
#
#  include serf
#
#  which is the equivalent of:
#
#  class { serf:
#    version => '0.2.0',
#    bin_dir => '/usr/local/bin'
#  }
#
# === Authors
#
# Justin Clayton <justin@claytons.net>
#
# === Copyright
#
# Copyright 2013 Justin Clayton, unless otherwise noted.
#
class serf (
  $version      = '0.2.0',
  $bin_dir      = '/usr/local/bin',
  $conf_dir     = '/etc/serf',
  $arch         = $serf::params::arch,
) inherits serf::params {

  $download_url = "https://dl.bintray.com/mitchellh/serf/${version}_linux_${arch}.zip"

  staging::file { 'serf.zip':
    source => $download_url,
  } ->

  staging::extract { 'serf.zip':
    target  => $bin_dir,
    creates => "${bin_dir}/serf",
  }

  file { 'serf.upstart.init':
    ensure  => file,
    path    => '/etc/init/serf.conf',
    mode    => '0755', # TODO: is this necessary?
    content => template('serf/serf.upstart.init.erb'),
  } ~>

  service { 'serf':
    enable   => true,
    ensure   => running,
    provider => 'upstart',
  }

}
