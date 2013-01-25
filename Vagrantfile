# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = 'precise32'
  config.vm.box_url = 'http://files.vagrantup.com/precise32.box'
  config.vm.host_name = 'shared-dev-box'
  config.vm.forward_port 22, 2222

  config.vm.provision :puppet,
    :manifests_path => 'puppet/manifests',
    :module_path    => 'puppet/modules'
end
