Vagrant::Config.run do |config|
  config.vm.box = "base"

  config.vm.customize do |vm|
      vm.name = "Rails Test Environment"
      vm.memory_size = 256  
    end
    
  config.vm.share_folder('rails', 'rails', 'rails')
  
  config.vm.provisioner = :chef_solo
  config.chef.cookbooks_path = "cookbooks"
  config.chef.json.merge!(
    :rubies => %w( ruby-1.8.7-p249 ree ruby-1.9.1-p376 ),
    :mysql => { 
      :server_root_password => "root"
    },
    :memcached => { 
      :ipaddress => "127.0.0.1"
    }
  )
  
  config.chef.log_level = :info
  
  config.vm.forward_port("ssh", 22, 2222)
end
