# Make sure apt-get -y update runs before anything else.
stage { 'preinstall':
  before => Stage['rvm-install']
}

class apt_get_update {
  exec { '/usr/bin/apt-get -y update':
    user => 'root'
  }
}
class { 'apt_get_update':
  stage => preinstall
}

class install_core_packages {
  if !defined(Package['build-essential']) {
    package { 'build-essential':
      ensure => installed
    }
  }

  if !defined(Package['git-core']) {
    package { 'git-core':
      ensure => installed
    }
  }

  if !defined(Package['tmux']) {
    package { 'tmux':
      ensure => installed
    }
  }
}
class { 'install_core_packages': }

class install_rvm {
  include rvm
  rvm::system_user { vagrant: ; }

  rvm_system_ruby {
    'ruby-1.9.3-p374':
      ensure => 'present',
      default_use => true;
  }

  rvm_gem {
    'ruby-1.9.3-p374@default/puppet':
      ensure => '3.0.2',
      require => Rvm_system_ruby['ruby-1.9.3-p374'];
  }
}

class { 'install_rvm': }
