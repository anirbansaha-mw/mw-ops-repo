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
  action :umount
end

file "/tmp/something" do
  owner "root"
  group "root"
  mode "0644"
  content "#{disk_list}"
  action :create
end
