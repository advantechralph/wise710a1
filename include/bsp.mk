
.PHONY: bsp
bsp: $(builddir)/.bsp

.PHONY: packbsp
packbsp: $(builddir) $(builddir)/.packbsp

.PHONY: bsp2
bsp2: $(builddir)/.bsp2

.PHONY: ubuntubasebsp
ubuntubasebsp: $(builddir)/.bspubuntubase

$(builddir)/.packbsp:
	@cd $(builddir) && tar -zcpvf $(bspname).tar.gz $(bspname)

$(builddir)/.bsp: prepare $(builddir)/.prebsp \
	$(builddir)/.createcontainer \
	$(builddir)/.exportcontainer \
	$(builddir)/.clonerootfs \
	$(builddir)/.bspfolders \
	$(builddir)/.clonebspscripts \
	$(builddir)/.clonebspimage \
	$(builddir)/.packedrootfs \
	$(builddir)/.postbsp

$(builddir)/.bsp2: prepare $(builddir)/.prebsp \
	$(builddir)/.modifyrootfs \
	$(builddir)/.packedrootfs \
	$(builddir)/.postbsp

$(builddir)/.bspubuntubase: prepare $(builddir)/.prebsp \
	$(builddir)/.fetchubuntubase \
	$(builddir)/.unpackubuntubase \
	$(builddir)/.addonsubuntubase \
	$(builddir)/.bspfolders \
	$(builddir)/.clonebspscripts \
	$(builddir)/.clonebspimage \
	$(builddir)/.modifyrootfs \
	$(builddir)/.packedrootfs \
	$(builddir)/.postbsp

$(builddir)/.prebsp: 
	@$(call cmd,echo Build BSP...,bsp)

$(builddir)/.createcontainer: 
	@$(call cmd,docker create --name $(container) $(repo) bash,bsp)
	@$(call cmd,touch $@,bsp)

$(builddir)/.exportcontainer:
	@$(call cmd,mkdir -p $(builddir)/rootfs,bsp)
	@$(call cmd,docker export $(container) | tar -xpvf - -C $(builddir)/rootfs,bsp)
	@$(call cmd,touch $@,bsp)

$(builddir)/.clonerootfs: 
	@$(call cmd,cd $(rootfs); tar --numeric-owner -zcpvf - . | tar -zxpvf - -C $(builddir)/rootfs,bsp)
	@echo "$${releaseinfo}" > $(builddir)/rootfs/etc/version

$(builddir)/.bspfolders: 
	@mkdir -p $(builddir)/$(bspname)/{image,scripts}
	@$(call cmd,touch $@,bsp)

$(builddir)/.clonebspscripts: 
	@$(call cmd,cd $(scripts); tar --numeric-owner -zcpvf - . | tar -zxpvf - -C $(builddir)/$(bspname)/scripts; ,bsp)

$(builddir)/.clonebspimage: 
	@$(call cmd,cp -apf $(logo) $(builddir)/$(bspname)/image,bsp)
	@$(call cmd,cp -apf $(kernel) $(builddir)/$(bspname)/image,bsp)
	@$(call cmd,cp -apf $(spl) $(builddir)/$(bspname)/image,bsp)
	@$(call cmd,cp -apf $(dtb) $(builddir)/$(bspname)/image,bsp)
	@$(call cmd,cp -apf $(u-boot)/* $(builddir)/$(bspname)/image,bsp)

$(builddir)/.modifyrootfs: 
	@if [ -f "$(builddir)/rootfs/root/.viminfo" ] ; then sed -i "/^\([\#?\/]\|$$\)/ba;d;:a;" $(builddir)/rootfs/root/.viminfo; fi
	@if [ -f $(builddir)/rootfs/root/.bash_history ] ; then sed -i "/^$$/ba;d;:a;" $(builddir)/rootfs/root/.bash_history; fi
	@echo "$${releaseinfo}" > $(builddir)/$(bspname)/image/version

ggg:

$(builddir)/.packedrootfs: 
	@$(call cmd,rm -rf $(builddir)/$(bspname)/image/$(packedrootfs),bsp)
	@$(call cmd, cd $(builddir)/rootfs; tar --numeric-owner -zcpvf $(builddir)/$(bspname)/image/$(packedrootfs) .,bsp)

$(builddir)/.postbsp: 
	@$(call cmd,echo Build BSP Done!!,bsp)

