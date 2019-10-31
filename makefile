prefix ?= /usr
libdir ?= ${prefix}/lib
pkglibdir ?= ${libdir}/dracut

.PHONY: install all

all: 

install: all
	mkdir -p $(DESTDIR)$(pkglibdir)/modules.d/91kpartx
	install -m 0755 -t $(DESTDIR)$(pkglibdir)/modules.d/91kpartx module-setup.sh parse-kpartx.sh
