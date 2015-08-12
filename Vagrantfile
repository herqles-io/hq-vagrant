# -*- mode: ruby -*-
# vi: set ft=ruby :

domain = 'vagrant.herqles.io'

nodes = [
  {
    :hostname => 'db',
    :ip => '192.168.33.10',
     :box => 'puppetlabs/centos-7.0-64-puppet'
  },
  {
    :hostname => 'manager',
    :ip => '192.168.33.11',
    :box => 'puppetlabs/centos-7.0-64-puppet',
    :fwdhost => 8000,
    :fwdguest => 80
  },
  {
    :hostname => 'worker',
    :ip => '192.168.33.11',
    :box => 'puppetlabs/centos-7.0-64-puppet'
  }
]

Vagrant.configure("2") do |config|

  nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = node[:box]
      node_config.vm.hostname = node[:hostname] + '.' + domain
      node_config.vm.network :private_network, ip: node[:ip]

      if node[:fwdhost]
        node_config.vm.network :forwarded_port, guest: node[:fwdguest], host: node[:fwdhost]
      end

      memory = node[:ram] ? node[:ram] : 512;
      node_config.vm.provider :virtualbox do |vb|
        vb.customize [
          'modifyvm', :id,
          '--name', node[:hostname],
          '--memory', memory.to_s
        ]
      end

      node_config.vm.provision :puppet do |puppet|
        puppet.options = '--verbose --debug'
        puppet.environment = 'vagrant'
        puppet.environment_path = 'puppet/environments'
        puppet.working_directory = '/vagrant/puppet/environments/vagrant'
        puppet.hiera_config_path = 'puppet/hiera.yaml'
      end
    end
  end
end