#Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu"
  
  config.omnibus.chef_version = :latest

  config.vm.define "haproxy" do |haproxy|
    haproxy.vm.hostname = "haproxy"
    haproxy.vm.network "private_network", ip: "10.0.0.100"
    haproxy.vm.network "forwarded_port", guest: 80, host: 8081
    haproxy.vm.provision :chef_solo do |chef|
      chef.add_recipe "haproxy"
      chef.add_recipe "tools"
      chef.json = {
        "authorization" => {
          "sudo" => {
            "users" => [ "vagrant" ],
            "passwordless" => true,
          }
        }
      }
    end
  end

  config.vm.define "web" do |web|
    web.vm.hostname = "web"
    web.vm.network "private_network", ip: "10.0.0.101"
    web.vm.provision :chef_solo do |chef|
      chef.add_recipe "nginx"
    end
  end

end
