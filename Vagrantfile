# vi: set ft=ruby :

Vagrant.require_version ">= 1.7.0"

VM_RAM = "2048" #MB
VM_CPU = "8"

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider :virtualbox do |vb|
    vb.customize ['createhd',
      '--filename', 'lfs.vdi',
      '--size', 500 * 1024]
    vb.customize ['storageattach', :id,
      '--storagectl', 'SATAController',
      '--port', 1,
      '--device', 0,
      '--type', 'hdd',
      '--medium', 'lfs.vdi']

    vb.customize [ "modifyvm", :id, "--memory", VM_RAM ]
    vb.customize [ "modifyvm", :id, "--ioapic", "on" ]
    vb.customize [ "modifyvm", :id, "--cpus", VM_CPU ]
  end

  config.vm.provision 'ansible' do |ansible|
    ansible.verbose = 'v'
    ansible.playbook = 'play_preparation.yml'
  end
end
