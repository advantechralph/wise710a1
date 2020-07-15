.PHONY: info
info: $(builddir)/.pathinfo $(builddir)/.info_sample

$(builddir)/.pathinfo: 
	@echo currdir=$(currdir)
	@echo builddir=$(builddir)


