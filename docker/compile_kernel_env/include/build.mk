.PHONY: build
build: prepare $(builddir)/.dockerbuild

$(builddir)/.dockerbuild: 
	@docker build --network=host -t $(repo) .
	@touch $@

