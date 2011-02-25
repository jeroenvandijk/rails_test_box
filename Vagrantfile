Vagrant::Config.run do |config|
  config.vm.box = "lucid64  "
  config.vm.box_url = "http://files.vagrantup.com/lucid64.box"

  config.vm.customize do |vm|
    vm.name = "Rails Test Environment"
    vm.memory_size = 256  
  end
    
  config.vm.share_folder('rails', 'rails', 'rails')
  
  config.vm.forward_port("ssh", 22, 2222)
  
  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "vagrant_main"
    
    chef.cookbooks_path = "cookbooks"
    
    chef.json.merge!({
      :rubies => %w( ruby-1.8.7-p249 ree ruby-1.9.1-p376 ),
      :mysql => { 
        :server_root_password => "root"
      },
      :memcached => { 
        :ipaddress => "127.0.0.1"
      }    
    })
  
    chef.log_level = :debug
  end
  
  
end
