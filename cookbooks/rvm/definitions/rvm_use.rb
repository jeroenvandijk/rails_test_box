define :rvm_use do
  rvm_ruby = RVM::Ruby.new params[:name]
  
  rvm_default rvm_ruby.version # FIXME shouldn't be necessary
  
  # The following code has been inspired from Chef's Adam Jacob http://gist.github.com/336951
  ruby_block "/home/vagrant/.rvm/bin/rvm use #{rvm_ruby.version}" do
    block do    
      Chef::Mixin::Command.popen4(%{
                                      bash -l -c "rvm_path=#{node[:rvm][:home]} && 
                                      #{node[:rvm][:bin]}/rvmsudo &&
                                      source #{node[:rvm][:home]}/scripts/rvm && 
                                      env"
                                    }.gsub("\n", '')) do |p,i,o,e|
        o.each_line do |line|
          env_bits = line.strip.split("=")
          ENV[env_bits[0]] = env_bits[1] if env_bits.size == 2
        end
      end
    
    end
  end
  
end