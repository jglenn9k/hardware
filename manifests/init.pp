# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include hardware
class hardware {
  case $facts['os']['name'] {
    'Ubuntu': {
      kmod::load {'ipmi_msghandler':}
      kmod::load {'ipmi_devintf':}
      kmod::load {'ipmi_si':}

      file { 'Hardware Binaries':
        ensure  => 'directory',
        path    => '/opt/hardware',
        recurse => true,
        source  => "puppet:///modules/hardware/${hardware::files}",
      }
      exec { 'Install Hardware tools':
        command => "bash ${hardware::binary}",
        cwd     => '/opt/hardware',
        path    => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin',
      }
    }
    'windows': {
      package { 'vcredist2008':
        ensure   => 'installed',
        provider => 'chocolaty',
      }
    }
    default: { }
  }
}
