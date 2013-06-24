#
# Cookbook Name:: host
# Recipe:: baseconfig
# Author : Anirban Saha (anirban.saha@mobilewalla.com)
# Copyright 2013, Mobilewalla Pte. Ltd.
#
# All rights reserved - Do Not Redistribute
#
require 'open-uri'
userdata = open('http://169.254.169.254/latest/user-data/').read
localip = open('http://169.254.169.254/latest/meta-data/local-ipv4/').read

pre_hostname, pre_tier = "#{userdata}".split
hostname = "#{pre_hostname}".split("=")[1]
tier = "#{pre_tier}".split("=")[1]
shortname = "#{hostname}".split(".")[0]

template "/etc/hostname" do
  source "hostname.erb"
  variables({
    :host_name => "#{hostname}"
  })
  notifies :run, "execute[set-hostname]", :immediately
end

template "/etc/hosts" do
  source "hosts.erb"
  variables({
    :short_name => "#{shortname}",
    :local_ip => "#{localip}"
  })
end

execute "set-hostname" do
  command "/sbin/start hostname"
  action :nothing
end

package "ruby" do
  action [:install]
end
