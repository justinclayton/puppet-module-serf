# == Class: serf
#
#   Downloads the serf binary from http://serfdom.io,
#   installs the appropriate init script,
#   and manages agent configuration
#
# === Parameters
#
# [*version*]
#   Specify version of serf binary to download. Defaults to '0.4.1'
#   http://serfdom.io does not currently provide a url for latest version.
#
# [*handlers_dir*]
#   Where to put the event handler scripts managed by this module.
# === Examples
#
#  You can invoke this module with simply:
#
#  include serf
#
#  which is the equivalent of:
#
#  class { serf:
#    version => '0.4.1',
#    bin_dir => '/usr/local/bin'
#  }
#
# === Authors
#
# Justin Clayton <justin@claytons.net>
#
# === Copyright
#
# Copyright 2014 Justin Clayton, unless otherwise noted.
#
class serf (
  $version              = '0.4.1',
  $bin_dir              = '/usr/local/bin',
  $conf_dir             = '/etc/serf',
  $handlers_dir         = '/etc/serf/handlers',
  $arch                 = $serf::params::arch,
  $init_script_url      = $serf::params::init_script_url,
  $init_script_dir      = $serf::params::init_script_dir,
  $init_script_filename = $serf::params::init_script_filename,
  $config_hash          = {}
) inherits serf::params {

  $download_url = "https://dl.bintray.com/mitchellh/serf/${version}_linux_${arch}.zip"

  staging::file { 'serf.zip':
    source => $download_url,
  } ->

  staging::extract { 'serf.zip':
    target  => $bin_dir,
    creates => "${bin_dir}/serf",
  } ->

  file { [$conf_dir, $handlers_dir]:
    ensure  => directory,
  } ->

  staging::file { $init_script_filename:
    source => $init_script_url,
    target => $init_script_dir,
  } ->

  file { 'config.json':
    ensure => file,
    path   => "${conf_dir}/config.json",
    content => template('serf/config.json.erb'),
  } ~>

  # file { 'serf.sysv.init':
  #   ensure  => file,
  #   path    => '/etc/init.d/serf',
  #   mode    => '0755',
  #   content => template('serf/serf.sysv.init.erb'),
  # } ~>

  service { 'serf':
    enable   => true,
    ensure   => running,
  }

}
