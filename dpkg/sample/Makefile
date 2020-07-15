include macro.mk
include include/*.mk

.PHONY: all clean test sample install uninstall purge

all: clean sample

install: $(builddir)/.install_sample

uninstall: 
	@dpkg --remove $(name)

purge:
	@dpkg --purge $(name)

clean: 
	@dpkg --purge $(name) >/dev/null 2>&1
	@rm -rf $(builddir)

