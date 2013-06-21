#
# Cookbook Name:: crawler
# Recipe:: raidconfig
# Author : Anirban Saha (anirban.saha@mobilewalla.com)
# Copyright 2013, Mobilewalla Pte. Ltd.
#
# All rights reserved - Do Not Redistribute
#

package "mdadm" do
  action [:install]
end

package "xfsprogs" do
  action [:install]
end

template "/etc/ntp.conf" do
  source "ntp.conf.erb"
  notifies :restart, "service[ntp]", :immediately
end

service "ntp" do
  action [:enable, :start]
  subscribes :reload, "template[/etc/ntp.conf]", :immediately
end
