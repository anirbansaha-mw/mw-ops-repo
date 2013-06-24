#
# Cookbook Name:: host
# Recipe:: nagios
# Author : Anirban Saha (anirban.saha@mobilewalla.com)
# Copyright 2013, Mobilewalla Pte. Ltd.
#
# All rights reserved - Do Not Redistribute
#

%w{/mnt/local/wordster/mw/nagios /mnt/local/wordster/mw/nagios/apple /mnt/local/wordster/mw/nagios/apple/rank_rt}.each do |dir|
directory "#{dir}" do
    mode        "0755"
    owner       "wordster"
    group       "wordster"
    action      :create
 end
end

%w{1 2}.each do |dir|
directory "/mnt/local/wordster/mw/nagios/apple/rank_rt/instance#{dir}" do
    mode        "0755"
    owner       "wordster"
    group       "wordster"
    action      :create
 end
end

%w{/mnt/local/wordster/mw/nagios/apple/rank_rt/instance1 /mnt/local/wordster/mw/nagios/apple/rank_rt/instance2}.each do |dir|
directory "#{dir}/logs" do
    mode        "0755"
    owner       "wordster"
    group       "wordster"
    action      :create
 end
end

template "/mnt/local/wordster/mw/nagios/apple/rank_rt/instance1/nagios_log_itunesRankCrawlerLog.sh" do
  source "nagios_log_itunesRankCrawlerLog.sh.erb"
  mode "0775"
  owner "wordster"
  group "wordster"
end

template "/mnt/local/wordster/mw/nagios/apple/rank_rt/instance2/nagios_log_itunesRankCrawlerLog.sh" do
  source "nagios_log_itunesRankCrawlerLog.sh.erb"
  mode "0775"
  owner "wordster"
  group "wordster"
end

template "/mnt/local/wordster/mw/nagios/apple/rank_rt/instance1/nagios_log_itunesRankCrawlerLog.py" do
  source "nagios_log_itunesRankCrawlerLog.py.erb"
  mode "0775"
  owner "wordster"
  group "wordster"
  variables({
    :instance_1 => "instance1",
    :instance_2 => "instance3",
    :instance_3 => "instance5",
    :instance_4 => "instance7"
  })
end

template "/mnt/local/wordster/mw/nagios/apple/rank_rt/instance2/nagios_log_itunesRankCrawlerLog.py" do
  source "nagios_log_itunesRankCrawlerLog.py.erb"
  mode "0775"
  owner "wordster"
  group "wordster"
  variables({
    :instance_1 => "instance2",
    :instance_2 => "instance4",
    :instance_3 => "instance6",
    :instance_4 => "instance8"
  })
end
