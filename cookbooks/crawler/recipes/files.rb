#
# Cookbook Name:: crawler
# Recipe:: files
# Author : Anirban Saha (anirban.saha@mobilewalla.com)
# Copyright 2013, Mobilewalla Pte. Ltd.
#
# All rights reserved - Do Not Redistribute
#

%w{/mnt/local/wordster /mnt/local/wordster/mw  /mnt/local/wordster/mw/crawler /mnt/local/wordster/mw/crawler/apple /mnt/local/wordster/mw/crawler/apple/rank_rt}.each do |dir|
directory "#{dir}" do
    mode        "0755"
    owner       "wordster"
    group       "wordster"
    action      :create
 end
end
