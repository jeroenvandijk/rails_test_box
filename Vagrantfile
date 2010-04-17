Vagrant::Config.run do |config|
  config.vm.box = "base"

  config.vm.customize do |vm|
      vm.name = "Rails Test Environment"
      vm.memory_size = 512
    end
  
  config.vm.share_folder('rails', 'rails', 'rails')
  
  config.vm.provisioner = :chef_solo
  config.chef.cookbooks_path = "cookbooks"
  config.chef.json.merge!({
    :mysql => { 
      :server_root_password => "root"
    },
    :memcached => { 
      :ipaddress => "127.0.0.1"
    }
  })
  
  config.chef.log_level = :debug
  
  config.vm.forward_port("ssh", 22, 2222)
end
