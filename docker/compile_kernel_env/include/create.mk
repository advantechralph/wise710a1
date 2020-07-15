.PHONY: create
create: $(builddir)/.dockercreate

$(builddir)/.dockercreate: 
	@if [ $(call iscreated) -eq 0 ] ; then \
		mkdir -p $(builddir)/share; \
		docker create --name $(container) \
			--network host \
			--hostname $(container) \
			-v $(builddir)/share:/share \
			-t $(repo) ; \
	fi



#	@if [ $(call iscreated) -eq 0 ] ; then \

