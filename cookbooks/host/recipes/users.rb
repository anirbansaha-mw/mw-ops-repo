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
  supports  :manage_home => true
end

directory "/home/wordster/.ssh" do
    mode        "0755"
    owner       "wordster"
    group       "wordster"
    action      :create
    notifies :run, "execute[copy-user-key]", :immediately
end

execute "copy-user-key" do
  command "/bin/cp /home/ubuntu/.ssh/authorized_keys /home/wordster/.ssh/; chown wordster.wordster /home/wordster/.ssh/authorized_keys"
  action :nothing
  subscribes :run, "directory[/home/wordster/.ssh]", :immediately
end

template "/etc/sudoers.d/wordster" do
  source "wordster_user.erb"
  mode 00440
end
