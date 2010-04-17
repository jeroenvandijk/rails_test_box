set_unless[:memcached][:ipaddress] = node[:ipaddress]
set_unless[:memcached][:memory] = 64
set_unless[:memcached][:port] = 11211
set_unless[:memcached][:user] = "nobody"
