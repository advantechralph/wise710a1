

ifdef _REALRUN

include macro.mk
include include/*.mk
include models/*.mk

else
	
export _REALRUN=1
.DEFAULT_GOAL:=usage
_MAKEFILE=$(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
_MAKEFLAGS=$(filter-out --,$(MAKEFLAGS))

foldertargets=$(shell find . -mindepth 1 -maxdepth 1 -type d -not -name ".*" -printf "%P ")
.PHONY: $(foldertargets)
$(foldertargets): 
	@[ -e "/usr/bin/time" ] && time make -f $(_MAKEFILE) $@ $(filter-out --,$(_MAKEFLAGS)) || make -f $(_MAKEFILE) $@ $(filter-out --,$(_MAKEFLAGS)) 

%: 
	@time make -f $(_MAKEFILE) $@ $(filter-out --,$(_MAKEFLAGS))

endif

