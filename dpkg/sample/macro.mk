
# basic macro
currdir:=$(shell pwd)
builddir:=$(currdir)/build
packagedir:=$(shell realpath -m $(builddir)/$(name))
debiandir:=$(shell realpath -m $(packagedir)/DEBIAN)
debfile:=$(builddir)/$(name).deb


# dpkg info
name=dpkg-sample
version=0.1
revision=1
arch=amd64
define desc
Ralph's Debian Package Sample
endef
define editor
Ralph Wang <ralph.wang@advantech.com.tw>
endef
define depends
sed, bash
endef

