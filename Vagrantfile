Vagrant.configure("2") do |config|
  config.vm.box = 'debian/stretch64'

  config.vm.define "pgmaster" do |subconfig|
    subconfig.vm.network "public_network", ip: "192.168.1.120", type: "static", bridge: ["Intel(R) Ethernet Connection I218-LM", "eth0"]
    subconfig.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
    subconfig.vm.provision :shell, path: "./master/master.sh"
  end

  config.vm.define "pgslave" do |subconfig|
    subconfig.vm.network "public_network", ip: "192.168.1.121", type: "static", bridge: ["Intel(R) Ethernet Connection I218-LM", "eth0"]
    subconfig.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
    subconfig.vm.provision :shell, path: "./slave/slave.sh"
  end

end
