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
File.open(temp_file).each_line{ |s|
  s = s.chomp()
  disk_list = "#{disk_list}" + "\"/dev/" + "#{s}\", "
}

disk_list = disk_list[0..-3]
File.delete(temp_file)

package "mdadm" do
  action [:install]
end

package "xfsprogs" do
  action [:install]
end

mount "/mnt" do
  device "/dev/xvdb"
  action [:umount, :disable]
end

mdadm "/dev/md0" do
  devices [ "#{disk_list}" ]
  level "0"
  chunk "64"
  action [ :create, :assemble ]
  notifies :run, "execute[update-mdadm-file]", :immediately
end

execute "update-mdadm-file" do
  command "/sbin/mdadm --detail --scan >> /etc/mdadm/mdadm.conf"
  action :nothing
end
