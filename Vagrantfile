#Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian-wheezy-x64-nocm"
  config.vm.box_url = "https://s3-eu-west-1.amazonaws.com/ffuenf-vagrant-boxes/debian/debian-7.2.0-amd64.box"
  
  config.omnibus.chef_version = :latest

  config.vm.define "haproxy" do |haproxy|
    haproxy.vm.hostname = "haproxy"
    haproxy.vm.network "private_network", ip: "10.0.0.100"
    haproxy.vm.network "forwarded_port", guest: 80, host: 8081
    haproxy.vm.provision :chef_solo do |chef|
      chef.add_recipe "haproxy"
      chef.add_recipe "tools"
      chef.json = {
        "haproxy" => {
          "install_method" => "source",
          "source" => {
            "version" => "1.5-dev19",
            "url" => "http://haproxy.1wt.eu/download/1.5/src/devel/haproxy-1.5-dev19.tar.gz",
            "checksum" => "cb411f3dae1309d2ad848681bc7af1c4c60f102993bb2c22d5d4fd9f5d53d30f"
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
      chef.add_recipe "tools"
    end
  end

end
