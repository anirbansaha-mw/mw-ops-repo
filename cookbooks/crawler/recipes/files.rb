#
# Cookbook Name:: crawler
# Recipe:: files
# Author : Anirban Saha (anirban.saha@mobilewalla.com)
# Copyright 2013, Mobilewalla Pte. Ltd.
#
# All rights reserved - Do Not Redistribute
#
require 'open-uri'

%w{/mnt/local/wordster /mnt/local/wordster/mw  /mnt/local/wordster/mw/crawler /mnt/local/wordster/mw/crawler/apple /mnt/local/wordster/mw/crawler/apple/rank_rt}.each do |dir|
directory "#{dir}" do
    mode        "0755"
    owner       "wordster"
    group       "wordster"
    action      :create
 end
end

remote_file "/tmp/crawler_files.tar" do
  source "http://us-west-chef-server.wordsterbeta.com:9999/crawler_files.tar"
  mode "0664"
  action :create_if_missing
end

%w{1 2 3 4 5 6 7 8}.each do |dir|
directory "/mnt/local/wordster/mw/crawler/apple/rank_rt/instance#{dir}" do
    mode        "0755"
    owner       "wordster"
    group       "wordster"
    action      :create
    notifies    :run, "execute[populate-archive]", :immediately
 end

execute "populate-archive" do
  command "/bin/tar -xf /tmp/crawler_files.tar --directory /mnt/local/wordster/mw/crawler/apple/rank_rt/instance#{dir}/"
  action :nothing
 end
end

file_count = 24
no_of_files = 8

userdata = open('http://169.254.169.254/latest/user-data/').read
pre_hostname, pre_tier = "#{userdata}".split
hostname = "#{pre_hostname}".split("=")[1]
shortname = "#{hostname}".split(".")[0]

host_num = shortname[-1,1]
host_num = host_num.to_i
end_index = no_of_files * host_num
start_index = end_index - no_of_files
if end_index > file_count
	end_index = file_count
	prev_host_num = host_num - 1
	start_index = prev_host_num * no_of_files
end

instance_start_index = 1
final_start_index = 0
temp_start_index = ""

while start_index < end_index do
	if start_index < 10
		temp_start_index = "0" + "#{start_index}"
		final_start_index = temp_start_index
	else
		final_start_index = start_index
	end

template "/mnt/local/wordster/mw/crawler/apple/rank_rt/instance#{instance_start_index}/src/CountryCodes.properties" do
  source  "CountryCodes.All#{final_start_index}.erb"
  mode  "0644"
  owner "wordster"
  group "wordster"
end

instance_start_index += 1
start_index += 1

end
