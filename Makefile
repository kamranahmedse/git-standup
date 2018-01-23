prefix=/usr/local
exec_prefix=$(prefix)
bindir=$(exec_prefix)/bin
datarootdir=$(prefix)/share
datadir=$(datarootdir)
mandir=$(datarootdir)/man
man1_dir=$(mandir)/man1

# files that need mode 755
EXEC_FILES=git-standup

.PHONY: all install uninstall

all:
	@echo "usage: make install"
	@echo "       make uninstall"
	@echo "       make man"

git-standup.1.gz: git-standup.1
	gzip -fk $<

install: git-standup.1.gz
	mkdir -p $(bindir) $(man1_dir)
	install -m 0755 $(EXEC_FILES) $(bindir)
	install -m 0644 "git-standup.1.gz" $(man1_dir)

man: git-standup.1.gz

uninstall:
	test -d $(bindir) && \
	cd $(bindir) && \
	rm -f $(EXEC_FILES)
	test -f "$(man1_dir)/git-standup.1.gz" && \
	rm -f "$(man1_dir)/git-standup.1.gz"
