
.PHONY: bsp
bsp: $(builddir)/.bsp

$(builddir)/.bsp: prepare $(builddir)/.prebsp \
	$(builddir)/.createcontainer \
	$(builddir)/.exportcontainer \
	$(builddir)/.clonerootfs \
	$(builddir)/.bspfolders \
	$(builddir)/.clonebspscripts \
	$(builddir)/.clonebspimage \
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
	@echo "$${releaseinfo}" > $(builddir)/$(bspname)/image/version

$(builddir)/.packedrootfs: 
	@$(call cmd,rm -rf $(builddir)/$(bspname)/image/$(packedrootfs),bsp)
	@$(call cmd, cd $(builddir)/rootfs; tar --numeric-owner -zcpvf $(builddir)/$(bspname)/image/$(packedrootfs) .,bsp)

$(builddir)/.postbsp: 
	@$(call cmd,echo Build BSP Done!!,bsp)

