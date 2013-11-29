package "build-essential" do
  action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/haproxy-1.5-dev19.tar.gz" do
  source "http://haproxy.1wt.eu/download/1.5/src/devel/haproxy-1.5-dev19.tar.gz"
  action :create_if_missing
end

bash "install_haproxy" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar -zvxf haproxy-1.5-dev19
    cd haproxy-1.5-dev19
    make TARGET=linux26
    cp haproxy /usr/sbin/haproxy
  EOH
  creates "/usr/sbin/haproxy"
end

cookbook_file "/etc/default/haproxy" do
    source "haproxy-default"
    owner "root"
    group "root"
    mode 00644
    notifies :restart, "service[haproxy]"
end

cookbook_file "/etc/haproxy/haproxy.cfg" do
  source "haproxy.cfg"
  owner "root"
  group "root"
  mode 00644
  notifies :restart, "service[haproxy]"
end

cookbook_file "/etc/haproxy/whitelist.lst" do
  source "whitelist.lst"
  owner "root"
  group "root"
  mode 00644
  notifies :restart, "service[haproxy]"
end

service "haproxy" do
    supports :restart => true, :status => true, :reload => true
      action [:enable, :start]
end
