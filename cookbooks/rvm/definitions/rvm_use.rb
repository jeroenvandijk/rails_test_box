define :rvm_use do
  ruby_version = RVM.ruby_version params[:name]
  
  rvm_install ruby_version
  rvm_default ruby_version # FIXME shouldn't be necessary
  
  # The following code has been inspired from Chef's Adam Jacob http://gist.github.com/336951
  ruby_block "/home/vagrant/.rvm/bin/rvm use #{ruby_version}" do
    block do    
      Chef::Mixin::Command.popen4(%{
                                      bash -l -c "rvm_path=#{node[:rvm][:home]} && 
                                      #{node[:rvm][:bin]}/rvmsudo &&
                                      source #{node[:rvm][:home]}/scripts/rvm && 
                                      env"
                                    }.gsub("\n", '')) do |p,i,o,e|
        o.each_line do |line|
          env_bits = line.strip.split("=")
          ENV[env_bits[0]] = env_bits[1]
        end
      end
    
    end
  end
  
end