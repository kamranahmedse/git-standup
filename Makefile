PREFIX ?= /usr/local
EXEC_PREFIX ?= $(PREFIX)
BINDIR ?= $(EXEC_PREFIX)/bin
DATAROOTDIR ?= $(PREFIX)/share
DATADIR ?= $(DATAROOTDIR)
MANDIR ?= $(DATAROOTDIR)/man
MAN1DIR ?= $(MANDIR)/man1

# files that need mode 755
EXEC_FILES = git-standup

.PHONY: all install uninstall

all:
	@echo "usage: make install"
	@echo "       make uninstall"
	@echo "       make man"

git-standup.1.gz: git-standup.1
	gzip -fk $<

install: git-standup.1.gz
	mkdir -p $(BINDIR)
	install -m 0755 $(EXEC_FILES) $(BINDIR)
	install -m 0644 "git-standup.1.gz" $(MAN1DIR)

man: git-standup.1.gz

uninstall:
	test -d $(BINDIR) && \
	cd $(BINDIR) && \
	rm -f $(EXEC_FILES)
	test -f "$(MAN1DIR)/git-standup.1.gz" && \
	rm -f "$(MAN1DIR)/git-standup.1.gz"
