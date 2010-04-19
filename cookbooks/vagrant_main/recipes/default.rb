require_recipe "apt"
require_recipe "git"
require_recipe "build-essential"
require_recipe "zlib"
require_recipe "curl"

require_recipe "rvm"

node[:rubies].each do |version|
  rvm_use     version
  require_recipe "rails_test_gems"
end

rvm_default node[:rubies].first

require_recipe "memcached"
require_recipe "rails_test_databases"

