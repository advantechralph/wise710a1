
.PHONY: test
test: prepare $(builddir)/.pretest $(builddir)/.posttest

$(builddir)/.pretest: 
	@$(call cmd,echo Build Test...,test)

$(builddir)/.posttest: 
	@$(call cmd,echo Build Test Done!!,test)

