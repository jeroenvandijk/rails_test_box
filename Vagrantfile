Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. For a detailed explanation
  # and listing of configuration options, please check the documentation
  # online.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "base"
  # config.vm.project_directory = "/home/vagrant/rails"
  # config.ssh.username = "root"
  
  config.vm.share_folder('rails', 'rails', 'rails')
  
  config.vm.provisioner = :chef_solo
  config.chef.cookbooks_path = "cookbooks"
  config.chef.json.merge!({
    :mysql => { 
      :server_root_password => "root"
    }
  })
  
end
