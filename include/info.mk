
.PHONY: info
info: 
	@echo CURRDIR=$(CURRDIR)
	@echo modelname=$(modelname)
	@echo builddir=$(builddir)
	@echo bspname=$(bspname)
	@echo dtb=$(dtb)
	@echo spl=$(spl)

.PHONY: models
models: 
	@echo $$(find models -mindepth 1 -maxdepth 1 -name "*.mk" -printf "%P\n" | sed -e "s/\.mk *$$//g")

