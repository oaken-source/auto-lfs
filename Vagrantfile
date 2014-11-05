
 # This file describes the environment of the Ubuntu 12.04 LTS virtual machine
 # used to bootstrap LFS.
 ##############################################################################

VAGRANTFILE_API_VERSION = "2"

VM_CPUS = "8"
VM_MEMORY = "2048" #MB

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Arch Linux
  config.vm.box = "arch32"
  config.vm.box_url = "http://files.65grad.de/boxes/arch32.box"

  # attach the virtual disk that holds LFS
  config.vm.provider :virtualbox do |vb|
    vb.customize ['createhd', '--filename', 'lfs_disk.vdi',
        '--size', 500 * 1024]
    vb.customize ['storageattach', :id, '--storagectl', 'SATA',
        '--port', 1, '--device', 0, '--type', 'hdd',
        '--medium', 'lfs_disk.vdi']

    vb.customize [ "modifyvm", :id, "--memory", VM_MEMORY ]
    vb.customize [ "modifyvm", :id, "--ioapic", "on" ]
    vb.customize [ "modifyvm", :id, "--cpus", VM_CPUS ]
  end

  config.vm.network :private_network, ip: "192.168.22.22"

  # initiate bootstrap process
  config.vm.provision :shell, :inline => "cd /vagrant && ./bootstrap.sh"
end
