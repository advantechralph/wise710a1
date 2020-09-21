
define bar
$(shell printf "#%.0s" {1..55})
endef

define title
$(shell printf "# %-51s #" "")
$(shell printf "# %-51s #" "Advantech $(modelname) BSP Usage")
$(shell printf "# %-51s #" "")
endef

define usage_info

$(call bar)
$(call title)
$(call bar)

Create BSP: 

  BSP from docker image: 

    $$ make bsp

    or 

    $$ make modelname=tpc71wn10pa_soreel bsp

    or 

    $$ make modelname=tpc71wn21pa bsp

  BSP from Ubuntu base image with addons: 

    $$ make ubuntubasebsp

Makefiles: 

  include/
  ├── addons.mk                      # Based on Ubuntu base to do add-on
  ├── bsp.mk
  ├── builddir.mk
  ├── clean.mk
  ├── cmd.mk
  ├── debug.mk
  ├── docker.mk
  ├── info.mk
  ├── log.mk
  ├── prepare.mk
  ├── test.mk
  └── usage.mk


endef

export usage_info

usage help: 
	@echo "$${usage_info}" | more

default: usage;

