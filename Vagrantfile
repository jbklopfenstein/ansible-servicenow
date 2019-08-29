Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "aws-csr-ansible"

  #Configure Sync Folders
  config.vm.synced_folder ".", "/home/vagrant/app"

  #Configure VM Settings
  config.vm.provider :"virtualbox" do |vb|
     vb.name = "aws-csr-ansible"
     vb.memory = "2048"
     vb.cpus = 2
  end

  #Provisioning via Shell
  config.vm.provision "shell", :path => "./tools/bootstrap_vagrant.sh"
end
