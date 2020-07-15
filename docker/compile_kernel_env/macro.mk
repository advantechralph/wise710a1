CURRDIR=$(shell realpath -m .)
export SHELL=bash
############################
#           path           #
############################
builddir:=$(CURRDIR)/build
logdir:=$(builddir)/log
############################
#          docker          #
############################
repo:=advantechralph/work:tpc71w_compile_kernel_env
container:=tpc71w_compile_kernel_env
