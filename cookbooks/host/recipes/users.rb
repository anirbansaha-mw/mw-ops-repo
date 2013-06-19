#
# Cookbook Name:: host
# Recipe:: users
# Author : Anirban Saha (anirban.saha@mobilewalla.com)
# Copyright 2013, Mobilewalla Pte. Ltd.
#
# All rights reserved - Do Not Redistribute
#

group "wordster" do
  gid 1001
  action :create
end

user "wordster" do
  comment "Default MW User"
  uid 1001
  gid "wordster"
  home "/home/wordster"
  shell "/bin/bash"
end

template "/etc/sudoers.d/wordster" do
  source "wordster_user.erb"
end
