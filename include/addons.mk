addonsrootfs=$(builddir)/rootfs
addonsmountlist=dev/pts dev proc sys
ubuntubaseurl=http://cdimage.ubuntu.com/ubuntu-base/releases/18.04/release/ubuntu-base-18.04-base-armhf.tar.gz
#ubuntufilename=$(shell $(call packedfilename,$(ubuntubaseurl)))
ubuntufilename=$(shell basename $(ubuntubaseurl))
define packedfilename
    _u=$(1); echo $${_u##*/} | sed -e 's/\.\(tar\.[^ ]*\|tgz\|zip\) *$$//'; 
endef

define checkmountpoint
  $$( \
    mountpoint -q $1; \
    echo $$?; \
    )
endef

# test
define checkdevmountpoint
  @ [ "$(call checkmountpoint,/dev)" -eq 0 ] && echo yes!! || echo no!!
endef

define mountforchroot
  @ \
    if [ -z "$(addonsrootfs)" ]; then echo '$$'"(addonsrootfs) needs to be defined!!" ;exit 1; fi; \
    _l="$(addonsmountlist)"; \
    for _d in $$_l; do\
      mountpoint -q $(addonsrootfs)/$$_d; \
      if [ $$? -eq 0 ]; then \
        umount $(addonsrootfs)/$$_d ;\
      fi; \
    done ;\
    mount -o bind /dev $(addonsrootfs)/dev; \
    mount -o bind /dev/pts $(addonsrootfs)/dev/pts; \
    mount -t proc proc $(addonsrootfs)/proc; \
    mount -t sysfs sys $(addonsrootfs)/sys; \
    mv $(addonsrootfs)/etc/resolv.conf $(addonsrootfs)/etc/resolv.conf.bkp; \
    echo "nameserver 8.8.8.8" > $(addonsrootfs)/etc/resolv.conf; \
  
endef

define chrootaddons
  @ \
    if [ -z "$(addonsrootfs)" ]; then echo '$$'"(addonsrootfs) needs to be defined!!" ;exit 1; fi; \
    RUNLEVEL=1 && chroot $(addonsrootfs) echo RUNLEVEL=$${RUNLEVEL}; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get update; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y i2c-tools; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y device-tree-compiler; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y kmod; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y can-utils; \
    RUNLEVEL=1 && chroot $(addonsrootfs) sed -i "/^\([\#?\/]\|$$\)/ba;d;:a;" /root/.viminfo; \
    RUNLEVEL=1 && chroot $(addonsrootfs) sed -i "/^$$/ba;d;:a;" /root/.bash_history; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get clean; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get autoclean; \

endef

define umountforchroot
  @ \
    if [ -z "$(addonsrootfs)" ]; then echo '$$'"(addonsrootfs) needs to be defined!!" ;exit 1; fi; \
    _l="$(addonsmountlist)"; \
    for _d in $$_l; do\
      mountpoint -q $(addonsrootfs)/$$_d; \
      if [ $$? -eq 0 ]; then \
        umount $(addonsrootfs)/$$_d ;\
      fi; \
    done ;\
    rm -rf $(addonsrootfs)/etc/resolv.conf; \
    mv $(addonsrootfs)/etc/resolv.conf.bkp $(addonsrootfs)/etc/resolv.conf; \
    
endef

.PHONY: addonstest
addonstest: 
	$(call mountforchroot)
	$(call chrootaddons)
	$(call umountforchroot)

define installqemu
  @ \
    if [ -z "$(addonsrootfs)" ]; then echo '$$'"(addonsrootfs) needs to be defined!!" ;exit 1; fi; \
    [ ! -e "$(addonsrootfs)/usr/bin/qemu-arm-static" ] && cp -a $(toolsdir)/qemu-arm-static $(addonsrootfs)/usr/bin; \
    exit 0; \

endef

define basicaddons
  @ \
    if [ -z "$(addonsrootfs)" ]; then echo '$$'"(addonsrootfs) needs to be defined!!" ;exit 1; fi; \
    RUNLEVEL=1 && chroot $(addonsrootfs) echo RUNLEVEL=$${RUNLEVEL}; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get update; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y sudo bc curl vim wget; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y language-pack-en; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y build-essential; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y autoconf automake; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y systemd network-manager; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y ssh openssh-server; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y net-tools ethtool ifupdown iputils-ping ; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y rsyslog; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y htop; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y cpio; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y at time dosfstools tree; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y i2c-tools; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y device-tree-compiler; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y kmod; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y can-utils; \

endef

define extraaddons
  @ \
    if [ -z "$(addonsrootfs)" ]; then echo '$$'"(addonsrootfs) needs to be defined!!" ;exit 1; fi; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y alien mysql-common parted pax mailutils rsync psmisc libusb-1.0-0 libusb-1.0-0-dev uuid; \

endef

define nodejsaddons
  @ \
    if [ -z "$(addonsrootfs)" ]; then echo '$$'"(addonsrootfs) needs to be defined!!" ;exit 1; fi; \
    RUNLEVEL=1 && chroot $(addonsrootfs) sh -c "curl -sL https://deb.nodesource.com/setup_14.x | bash -"; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get install -y nodejs; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt list --installed | sort > $(builddir)/list.base; \

endef

define addonsend
  @ \
    if [ -z "$(addonsrootfs)" ]; then echo '$$'"(addonsrootfs) needs to be defined!!" ;exit 1; fi; \
    RUNLEVEL=1 && chroot $(addonsrootfs) sed -i "/^\([\#?\/]\|$$\)/ba;d;:a;" /root/.viminfo; \
    RUNLEVEL=1 && chroot $(addonsrootfs) sed -i "/^$$/ba;d;:a;" /root/.bash_history; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get clean; \
    RUNLEVEL=1 && chroot $(addonsrootfs) apt-get autoclean; \
    tar -C $(rootfs) --numeric-owner -zcpvf - . | tar -C $(builddir)/rootfs -zxpvf - ; \
    RUNLEVEL=1 && chroot $(addonsrootfs) sh -c "echo 'root:123456' | chpasswd "; \
    RUNLEVEL=1 && chroot $(addonsrootfs) sed -ie '/^[\# ]*PermitRootLogin.*/{s/^.*$$/PermitRootLogin yes/;}' /etc/ssh/sshd_config; \
    RUNLEVEL=1 && chroot $(addonsrootfs) rm -rf /usr/lib/NetworkManager/conf.d/10-globally-managed-devices.conf; \
    echo "$${releaseinfo}" > $(builddir)/rootfs/etc/version; \

endef

.PHONY: ubuntubaseaddons
ubuntubaseaddons: $(builddir)/.fetchubuntubase $(builddir)/.unpackubuntubase $(builddir)/.addonsubuntubase

$(builddir)/.addonsubuntubase: 
	$(call installqemu)
	$(call mountforchroot)
	$(call basicaddons)
	$(call extraaddons)
	$(call nodejsaddons)
	$(call addonsend)
	$(call umountforchroot)

$(builddir)/.fetchubuntubase: 
	@curl -o $(builddir)/$(ubuntufilename) $(ubuntubaseurl)
	@touch $@

$(builddir)/.unpackubuntubase: 
	@mkdir -p $(addonsrootfs)
	@tar -C $(addonsrootfs) -zxpvf $(builddir)/$(ubuntufilename) 
	@touch $@

.PHONY: nodejs
nodejs: 
	$(call installqemu)
	$(call mountforchroot)
	$(call nodejsaddons)
	$(call umountforchroot)


.PHONY: addonsprepare
addonsprepare:
	$(call mountforchroot)

.PHONY: addonspreparestop
addonspreparestop:
	$(call umountforchroot)

