
.PHONY: status
status: 
	@echo "container: $(shell docker inspect -f '{{.State.Status}}' $(container) 2>/dev/null)"
	@echo "created: $(call iscreated)"
	@echo "running: $(call isrunning)"

define iscreated
  $(shell docker inspect $(container) 2>/dev/null | grep -iq created; \
    [ $$? -eq 0 ] && echo 1 || echo 0 )
endef

define isrunning
  $(shell docker inspect -f '{{.State.Status}}' $(container) 2>/dev/null | grep -iq running; \
    [ $$? -eq 0 ] && echo 1 || echo 0 )
endef

