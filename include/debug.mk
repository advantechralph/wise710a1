V=1
_L=$(shell [ $(V) -gt 0 ] && echo 1 || echo 0)
_V=$(shell [ $(V) -gt 1 ] && echo 1 || echo 0)
