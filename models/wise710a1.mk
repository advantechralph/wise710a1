ifeq ($(modelname),wise710a1)
bspname=WISE710A1-r1-Ubuntu1604-$(shell date +"%Y%m%d")
rootfs=$(CURRDIR)/rootfs/wise710a1
spl=$(CURRDIR)/spl/wise710a1/SPL
dtb=$(CURRDIR)/dtb/wise710a1/imx6dl-wise710-a1.dtb
u-boot=$(CURRDIR)/u-boot/wise710a1
endif
