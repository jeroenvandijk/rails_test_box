execute "aptitude update"

%w(build-essential automake libtool gettext mono-devel mono-1.0-devel subversion libpng-dev libtiff-dev libgif-dev libjpeg-dev libexif-dev autoconf automake bison flex libcairo2-dev libpango1.0-dev nant mono-2.0-devel monodevelop).each do |pkg|
  execute "aptitude -q -y install #{pkg}"
  # package pkg
end

package "unzip"