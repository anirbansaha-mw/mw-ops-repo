#
# Cookbook Name:: host
# Recipe:: cron
# Author : Anirban Saha (anirban.saha@mobilewalla.com)
# Copyright 2013, Mobilewalla Pte. Ltd.
#
# All rights reserved - Do Not Redistribute
#

cron "instance1_cron" do
  minute "0"
  hour "*"
  day "*"
  month "*"
  weekday "*"
  command "/mnt/local/wordster/mw/crawler/apple/rank_rt/instance1/itunesRank.sh"
  user "wordster"
  action :delete
end

cron "instance2_cron" do
  minute "30"
  hour "*"
  day "*"
  month "*"
  weekday "*"
  command "/mnt/local/wordster/mw/crawler/apple/rank_rt/instance2/itunesRank.sh"
  user "wordster"
  action :delete
end

cron "instance3_cron" do
  minute "0"
  hour "*"
  day "*"
  month "*"
  weekday "*"
  command "/mnt/local/wordster/mw/crawler/apple/rank_rt/instance3/itunesRank.sh"
  user "wordster"
  action :delete
end

cron "instance4_cron" do
  minute "30"
  hour "*"
  day "*"
  month "*"
  weekday "*"
  command "/mnt/local/wordster/mw/crawler/apple/rank_rt/instance4/itunesRank.sh"
  user "wordster"
  action :delete
end

cron "instance5_cron" do
  minute "0"
  hour "*"
  day "*"
  month "*"
  weekday "*"
  command "/mnt/local/wordster/mw/crawler/apple/rank_rt/instance5/itunesRank.sh"
  user "wordster"
  action :delete
end

cron "instance6_cron" do
  minute "30"
  hour "*"
  day "*"
  month "*"
  weekday "*"
  command "/mnt/local/wordster/mw/crawler/apple/rank_rt/instance6/itunesRank.sh"
  user "wordster"
  action :delete
end

cron "instance7_cron" do
  minute "0"
  hour "*"
  day "*"
  month "*"
  weekday "*"
  command "/mnt/local/wordster/mw/crawler/apple/rank_rt/instance7/itunesRank.sh"
  user "wordster"
  action :delete
end

cron "instance8_cron" do
  minute "30"
  hour "*"
  day "*"
  month "*"
  weekday "*"
  command "/mnt/local/wordster/mw/crawler/apple/rank_rt/instance8/itunesRank.sh"
  user "wordster"
  action :delete
end

cron "nagios1_cron" do
  minute "0"
  hour "*"
  day "*"
  month "*"
  weekday "*"
  command "/mnt/local/wordster/mw/nagios/apple/rank_rt/instance1/nagios_log_itunesRankCrawlerLog.sh"
  user "wordster"
  action :delete
end

cron "nagios2_cron" do
  minute "30"
  hour "*"
  day "*"
  month "*"
  weekday "*"
  command "/mnt/local/wordster/mw/nagios/apple/rank_rt/instance2/nagios_log_itunesRankCrawlerLog.sh"
  user "wordster"
  action :delete
end
