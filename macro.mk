############################
#           basic          #
############################
CURRDIR=$(shell realpath -m .)
export SHELL=bash
modelname:=wise710a1_2g
rootfs=$(CURRDIR)/rootfs
logo=$(CURRDIR)/logo/adv_logo_1024x600_32bpp.bmp
kernel=$(CURRDIR)/kernel/zImage
spl=$(CURRDIR)/spl/SPL
dtb=$(CURRDIR)/dtb/imx6dl-wise710-a1.dtb
u-boot=$(CURRDIR)/u-boot
scripts=$(CURRDIR)/scripts/basic
distro=ubuntu18044
#bspname=$(shell echo "$(modelname)_$(distro)_$(shell date "+%Y%m%d")" | sed -e 's/^./\U&/g' -e 's/_./\U&/g')
#bspname=$(modelname)_$(distro)_$(shell date "+%Y%m%d")
bspname=WISE-710-A1_2G_r1_Ubuntu1804_20200924
packedrootfs=$(distro).tar.gz
define releaseinfo
$(shell date +"%Y%m%d%H%M%S")
uboot:2016.03
kernel:4.1.15
rootfs:$(distro)
version:$(modelname) r1
endef
export releaseinfo
############################
#           path           #
############################
builddir:=$(CURRDIR)/build
logdir:=$(builddir)/log
toolsdir:=$(CURRDIR)/tools
############################
#          docker          #
############################
repo:=advantechralph/work:wise710a1
container:=$(modelname)_bsp
############################
#       Ubuntu Base        #
############################
ubuntubaseurl=http://cdimage.ubuntu.com/ubuntu-base/releases/18.04/release/ubuntu-base-18.04-base-armhf.tar.gz
cp210xsdkurl=https://www.silabs.com/documents/public/software/USBXpressHostSDK-Linux.tar
