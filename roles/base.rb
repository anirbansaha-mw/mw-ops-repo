name "base"
description "Base role (generic configuration)"
run_list[
       "recipe[host::baseconfig]"
       "recipe[host::ntp]"
        ]
