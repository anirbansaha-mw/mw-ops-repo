name "crawler"
description "Crawler role (for crawler nodes)"
run_list(
       "recipe[host::baseconfig]",
       "recipe[host::ntp]",
       "recipe[host::users]",
       "recipe[host::daemontools]",
       "recipe[crawler::raidconfig]",
       "recipe[crawler::packages]"
)
