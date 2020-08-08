# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "archlinux/archlinux"
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb|
    vb.name = "sddm-theme-simple-login-test"
    vb.gui = true
    vb.cpus = "2"
    vb.memory = "2048"
    vb.customize ["modifyvm", :id, "--vram", "128"]
    vb.customize ["modifyvm", :id, "--graphicscontroller", "vboxvga"]
   end

  config.vm.provision "shell", inline: <<-SHELL
    chmod +x /vagrant/vagrant_setup.sh
    sudo /vagrant/vagrant_setup.sh
  SHELL

end
