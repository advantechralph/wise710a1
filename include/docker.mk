
.PHONY: importcontainer
rootfs2image: 
	@tar -C $(builddir)/rootfs --numeric-owner -zcpvf - . | docker import - $(repo)

.PHONY: cleancontainer
cleancontainer: 
	@docker stop $(container)
	@docker rm $(container)
