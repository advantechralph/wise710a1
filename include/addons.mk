addonsrootfs=$(builddir)/rootfs
addonsmountlist=dev/pts dev proc sys

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

.PHONY: addonsprepare
addonsprepare:
	$(call mountforchroot)

.PHONY: addonspreparestop
addonspreparestop:
	$(call umountforchroot)

