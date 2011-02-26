define :rvm_install do
  rvm_ruby = RVM::Ruby.new params[:name]

  rvm_ruby.recipes.each do |recipe|
    require_recipe recipe
  end

  rvm_ruby.packages.each do |pkg|
    package pkg
  end

  execute "install ruby #{rvm_ruby.version}" do
    user node[:rvm][:user] 
    command "#{node[:rvm][:bin]}/rvm install #{rvm_ruby.version}"
    not_if "ls #{node[:rvm][:home]}/rubies | grep #{rvm_ruby.version}"
  end

  rvm_use rvm_ruby.version

end