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

package "haproxy" do
  action :install
end

service "haproxy" do
    supports :restart => true, :status => true, :reload => true
      action [:enable, :start]
end
