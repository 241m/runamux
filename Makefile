NAME   = runamux
SCRIPT = bin/$(NAME)

PREFIX    ?= /usr/local
BINPREFIX ?= $(PREFIX)/bin
LIBPREFIX ?= $(PREFIX)/libexec
DOCPREFIX ?= $(PREFIX)/share/doc
MANPREFIX ?= $(PREFIX)/share/man

MANDOC_OPTS ?= -O indent=2

all:

install: docs/README
	mkdir -p $(DESTDIR)$(BINPREFIX)
	cp -p  bin/* $(DESTDIR)$(BINPREFIX)
	mkdir -p $(DESTDIR)$(LIBPREFIX)
	cp -pr libexec/* $(DESTDIR)$(LIBPREFIX)
	mkdir -p $(DESTDIR)$(DOCPREFIX)/$(NAME)
	cp -pr docs/* $(DESTDIR)$(DOCPREFIX)/$(NAME)
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	help2man -N -o $(DESTDIR)$(MANPREFIX)/man1/$(NAME).1 $(SCRIPT)

docs/README: $(SCRIPT)
	help2man -N $(SCRIPT) | mandoc -T utf8 $(MANDOC_OPTS) | col -b > $@

uninstall:
	rm -f  $(DESTDIR)$(MANPREFIX)/man1/$(NAME).1
	rm -f  $(DESTDIR)$(BINPREFIX)/$(NAME)
	rm -rf $(DESTDIR)$(DOCPREFIX)/$(NAME)
	rm -rf $(DESTDIR)$(LIBPREFIX)/$(NAME)
