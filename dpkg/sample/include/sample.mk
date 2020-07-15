
.PHONY: sample
sample: $(builddir) $(builddir)/.fetch_sample $(builddir)/.patch_sample $(builddir)/.build_sample 

$(builddir)/.fetch_sample: 
	@cp -a sample $(builddir)
	@touch $@

$(builddir)/.patch_sample: 
	@sed -i "s/__name__/$(name)/" $(builddir)/sample/DEBIAN/*
	@sed -i "s/__version__/$(version)/" $(builddir)/sample/DEBIAN/*
	@sed -i "s/__revision__/$(revision)/" $(builddir)/sample/DEBIAN/*
	@sed -i "s/__arch__/$(arch)/" $(builddir)/sample/DEBIAN/*
	@sed -i "s/__desc__/$(desc)/" $(builddir)/sample/DEBIAN/*
	@sed -i "s/__editor__/$(editor)/" $(builddir)/sample/DEBIAN/*
	@sed -i "s/__depends__/$(depends)/" $(builddir)/sample/DEBIAN/*
	@touch $@

$(builddir)/.build_sample: $(builddir)
	@dpkg --build $(builddir)/sample $(builddir)

$(builddir)/.install_sample: 
	@[ -f "$(builddir)/$(name)_$(version)-$(revision)_$(arch).deb" ] && dpkg --install $(builddir)/$(name)_$(version)-$(revision)_$(arch).deb

$(builddir)/.info_sample: 
	@[ -f "$(builddir)/$(name)_$(version)-$(revision)_$(arch).deb" ] && dpkg --info $(builddir)/$(name)_$(version)-$(revision)_$(arch).deb

