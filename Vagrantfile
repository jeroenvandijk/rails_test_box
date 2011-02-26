Vagrant::Config.run do |config|
  config.vm.box = "lucid64"
  config.vm.box_url = "http://files.vagrantup.com/lucid64.box"

  config.vm.customize do |vm|
    vm.name = "Rails Test Environment"
    vm.memory_size = 512
  end
  
  # Set up host only network so we can use nfs
  config.vm.network("33.33.33.10")
    
  config.vm.share_folder('rails', 'rails', 'rails', :nfs => true)
  
  config.vm.forward_port("ssh", 22, 2222)
  
  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "vagrant_main"
    
    chef.cookbooks_path = "cookbooks"
    
    chef.json.merge!({
      :rubies => %w( 1.8.7 jruby),# ree  ruby-head  rbx-head  jruby  ironruby  maglev-head ),
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
