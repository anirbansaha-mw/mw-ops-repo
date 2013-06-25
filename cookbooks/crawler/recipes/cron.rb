#
# Cookbook Name:: host
# Recipe:: cron
# Author : Anirban Saha (anirban.saha@mobilewalla.com)
# Copyright 2013, Mobilewalla Pte. Ltd.
#
# All rights reserved - Do Not Redistribute
#

%w{1 3 5 7}.each do |num1|
cron "instance#{num1}_cron" do
  minute "0"
  hour "*"
  day "*"
  month "*"
  weekday "*"
  command "/mnt/local/wordster/mw/crawler/apple/rank_rt/instance#{num1}/itunesRank.sh"
  user "wordster"
  action :create
 end
end

%w{2 4 6 8}.each do |num2|
cron "instance#{num2}_cron" do
  minute "30"
  hour "*"
  day "*"
  month "*"
  weekday "*"
  command "/mnt/local/wordster/mw/crawler/apple/rank_rt/instance#{num2}/itunesRank.sh"
  user "wordster"
  action :create
 end
end

cron "nagios1_cron" do
  minute "0"
  hour "*"
  day "*"
  month "*"
  weekday "*"
  command "/mnt/local/wordster/mw/nagios/apple/rank_rt/instance1/nagios_log_itunesRankCrawlerLog.sh"
  user "wordster"
  action :create
end

cron "nagios2_cron" do
  minute "30"
  hour "*"
  day "*"
  month "*"
  weekday "*"
  command "/mnt/local/wordster/mw/nagios/apple/rank_rt/instance2/nagios_log_itunesRankCrawlerLog.sh"
  user "wordster"
  action :create
end
