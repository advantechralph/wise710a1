ifeq ($(modelname),tpc71wn21pa)
bspname:=TPC71W-N21PA-r1-Ubuntu1604-$(shell date +"%Y%m%d")
rootfs=$(CURRDIR)/rootfs/n21pa
spl=$(CURRDIR)/spl/n21pa/SPL
dtb=$(CURRDIR)/dtb/n10pa/imx6q-tpc71w-n21pa.dtb
u-boot=$(CURRDIR)/u-boot/n21pa
endif
