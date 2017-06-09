# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # Custom variables
  $directory = "" # Directory containing sites
  $hostname = "MyBox"
  $vmGroupName = "/My Development Environments"
  $ipAddress = "192.168.90.90"

  config.vm.box = "centos/7"

  config.vm.hostname = $hostname

  config.vm.network "private_network", ip: $ipAddress
  config.vm.network "forwarded_port", guest: 80, host: 8900, auto_correct: true

  config.vm.synced_folder $directory, "/var/www", type: "virtualbox", create: true
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/home/vagrant/sync", type: "virtualbox"

  config.vm.provider "virtualbox" do |v|
    v.name = $hostname
    v.customize ["modifyvm", :id,
      "--memory", "1024",
      "--groups", $vmGroupName]
  end

  config.vm.provision "Bootstrap", type: "shell" do |s|
    s.name = "Bootstrap"
    s.path = "provisioners/setup.sh"
  end

  config.vm.provision "Composer", type: "shell" do |s|
    s.name = "Composer"
    s.privileged = false
    s.path = "provisioners/composer.sh"
  end

  config.vm.provision "Sites", type: "shell" do |s|
    s.name = "Sites"
    s.privileged = false
    s.path = "provisioners/sites.sh"
  end

end
