NAME   = runamux
SCRIPT = bin/$(NAME)

PREFIX    ?= /usr/local
BINPREFIX ?= $(PREFIX)/bin
LIBPREFIX ?= $(PREFIX)/libexec
DOCPREFIX ?= $(PREFIX)/share/doc
MANPREFIX ?= $(PREFIX)/share/man

MANDOC_OPTS ?= -O indent=2,width=58

all:

install: docs/README
	mkdir -p $(DESTDIR)$(BINPREFIX)
	cp -pt   $(DESTDIR)$(BINPREFIX) bin/*
	mkdir -p $(DESTDIR)$(LIBPREFIX)
	cp -prt  $(DESTDIR)$(LIBPREFIX) libexec/*
	mkdir -p $(DESTDIR)$(DOCPREFIX)/$(NAME)
	cp -prt  $(DESTDIR)$(DOCPREFIX)/$(NAME) docs/*
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	help2man -No $(DESTDIR)$(MANPREFIX)/man1/$(NAME).1 $(SCRIPT)

docs/README: $(SCRIPT)
	help2man -N $(SCRIPT) | mandoc -T utf8 $(MANDOC_OPTS) | col -b > $@

uninstall:
	rm -f  $(DESTDIR)$(MANPREFIX)/man1/$(NAME).1
	rm -f  $(DESTDIR)$(BINPREFIX)/$(NAME)
	rm -rf $(DESTDIR)$(DOCPREFIX)/$(NAME)
	rm -rf $(DESTDIR)$(LIBPREFIX)/$(NAME)

stow:
	mkdir -p $(HOME)/.local/bin
	ln -fsrt $(HOME)/.local/bin $(SCRIPT)
	mkdir -p $(HOME)/.local/libexec
	ln -fsrt $(HOME)/.local/libexec libexec/$(NAME)

unstow:
	rm -f $(HOME)/.local/$(SCRIPT)
	rm -f $(HOME)/.local/libexec/$(NAME)

.PHONY: all install uninstall stow unstow
