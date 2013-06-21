#
# Cookbook Name:: crawler
# Recipe:: raidconfig
# Author : Anirban Saha (anirban.saha@mobilewalla.com)
# Copyright 2013, Mobilewalla Pte. Ltd.
#
# All rights reserved - Do Not Redistribute
#

disk_output = `/bin/cat /proc/partitions | grep xvd | awk '{ print $NF }' | grep -v xvda`
disk_output = disk_output.chomp()

disk_content=<<EOF
#{disk_output}
EOF
temp_file = "/tmp/disks"
File.open(temp_file, "w") { |f| f.write disk_content }
disk_list = ""
disk_count = 0
File.open(temp_file).each_line{ |s|
  s = s.chomp()
  disk_list = "#{disk_list}" + "/dev/" + "#{s} "
  disk_count = disk_count + 1
}

disk_list = disk_list[0..-2]
File.delete(temp_file)

package "mdadm" do
  action [:install]
end

package "xfsprogs" do
  action [:install]
  notifies :run, "execute[create-raid]", :immediately
end

mount "/mnt" do
  device "/dev/xvdb"
  action [:umount, :disable]
end

execute "create-raid" do
  command "/sbin/mdadm --create /dev/md0 --force --run --level=0 --raid-devices=#{disk_count} #{disk_list}"
  action :nothing
  notifies :run, "execute[update-mdadm-file]", :immediately
end

execute "update-mdadm-file" do
  command "/sbin/mdadm --detail --scan >> /etc/mdadm/mdadm.conf"
  action :nothing
  notifies :run, "execute[create-filesystem]", :immediately
end

execute "create-filesystem" do
  command "/sbin/mkfs.xfs /dev/md0"
  action :nothing
end

directory "/mnt/local" do
    mode        "0755"
    owner       "wordster"
    group       "wordster"
    action      :create
end

mount "/mnt/local" do
  device "/dev/md0"
  fstype "xfs"
  options "defaults"
  dump 0
  pass 0
  action   [:mount, :enable]
end
