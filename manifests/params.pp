# Class: serf::params
#
#
class serf::params {

  if $::kernel != 'Linux' {
    fail("Unsupported kernel \"${::kernel}\". Module currently only supports Linux. Pull requests welcome! https://github.com/justinclayton/puppet-module-serf/pull_requests")
  }

  case $::architecture {
    'x86_64': { $arch = 'amd64' }
    'i386':   { $arch = '386'   }
    default:  { fail("Unsupported kernel architecture \"${::architecture}\". Module only supports i386 and x86_64. Serf supports arm, but module is untested.") }
  }
}