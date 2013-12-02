execute "apt-get update" do
  command "apt-get update"
end

package "nginx" do
  action :install
end

cookbook_file "/etc/nginx/sites-enabled/default" do
  source "default"
  owner "root"
  group "root"
  mode 00644
  notifies :restart, "service[nginx]"
end

service "nginx" do
    supports :status => true, :restart => true, :reload => true
      action :start
end
