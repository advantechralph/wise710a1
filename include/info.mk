
.PHONY: info
info: 
	@echo "============== path ==============="
	@echo CURRDIR=$(CURRDIR)
	@echo builddir=$(builddir)
	@echo "=============== bsp ==============="
	@echo bspname=$(bspname)
	@echo rootfs=$(builddir)/rootfs
	@echo "============= docker  ============="
	@echo repo=$(repo)
	@echo container=$(container)

