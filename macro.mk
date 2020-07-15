############################
#           basic          #
############################
CURRDIR=$(shell realpath -m .)
export SHELL=bash
modelname:=wise710a1
rootfs=$(CURRDIR)/rootfs
logo=$(CURRDIR)/logo/adv_logo_1024x600_32bpp.bmp
kernel=$(CURRDIR)/kernel/zImage
spl=$(CURRDIR)/spl/SPL
dtb=$(CURRDIR)/dtb/imx6dl-wise710-a1.dtb
u-boot=$(CURRDIR)/u-boot
scripts=$(CURRDIR)/scripts/basic
packedrootfs=ubuntu18044.tar.gz
define releaseinfo
$(shell date +"%Y%m%d%H%M%S")
uboot:2016.03
kernel:4.1.15
rootfs:ubunu16044
version:$(modelname) r1
endef
export releaseinfo
############################
#           path           #
############################
builddir:=$(CURRDIR)/build
logdir:=$(builddir)/log
############################
#          docker          #
############################
repo:=advantechralph/work:wise710a1
container:=$(modelname)_bsp
