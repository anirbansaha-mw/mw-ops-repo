#
# Cookbook Name:: host
# Recipe:: daemontools
# Author : Anirban Saha (anirban.saha@mobilewalla.com)
# Copyright 2013, Mobilewalla Pte. Ltd.
#
# All rights reserved - Do Not Redistribute
#

package "daemontools" do
  action [:install]
end

package "daemontools-run" do
  action [:install]
  notifies :run, "execute[start-daemontools]", :immediately
end

execute "start-daemontools" do
  command "/sbin/initctl start svscan"
  action :nothing
  subscribes :run, "package[daemontools-run]", :immediately
end

link "/service" do
  to "/etc/service"
end

directory "/service/chef-client-sync" do
    mode        "0755"
    owner       "root"
    group       "root"
    action      :create
end

directory "/service/chef-client-sync/log" do
    mode        "0755"
    owner       "root"
    group       "root"
    action      :create
end

template "/service/chef-client-sync/log/run" do
  source "daemontools_log_run.erb"
  mode "0755"
  owner "root"
  group "root"
end

template "/service/chef-client-sync/run" do
  source "daemontools_run.erb"
  mode "0755"
  owner "root"
  group "root"
  notifies :run, "execute[start-sync-service]", :immediately
end

execute "start-sync-service" do
  command "/usr/bin/svc -t /service/chef-client-sync"
  action :nothing
  subscribes :run, "template[/service/chef-client-sync/run]", :immediately
end
