ifeq ($(modelname),wise710a1_2g)
bspname=WISE710A1-2GB-r1-Ubuntu1604-$(shell date +"%Y%m%d")
rootfs=$(CURRDIR)/rootfs/wise710a1
spl=$(CURRDIR)/spl/wise710a1_2g/SPL
dtb:=$(CURRDIR)/dtb/imx6dl-wise710-a1.dtb
u-boot:=$(CURRDIR)/u-boot/wise710a1_2g
endif
