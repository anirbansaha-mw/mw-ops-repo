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

mount "/mnt" do
  device "/dev/xvdb"
  action :umount
end
