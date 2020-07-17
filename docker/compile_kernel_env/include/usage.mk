
define bar
$(shell printf "#%.0s" {1..55})
endef

define title
$(shell printf "# %-51s #" "")
$(shell printf "# %-51s #" "Compile Kernel Image Docker Usage")
$(shell printf "# %-51s #" "")
endef

define usage_info

$(call bar)
$(call title)
$(call bar)

Usage: 

    $$ make [TARGET]

    Create Docker container for building NXP i.MX6 series kernel or u-boot image environment. 

    TARGET: 

        <empty>                      Show this usage. 
        help                         Show this usage. 
        bash                         Enter container bash. 
        status                       Show current container information. 
	commit                       Commit container to image. 
        push                         Push image to Docker Hub. 

endef

export usage_info

usage help: 
	@echo "$${usage_info}" | more


