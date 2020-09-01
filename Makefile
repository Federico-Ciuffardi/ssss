# ssss - simple syssssem setup sync
# See LICENSE file for copyright and license details.
.POSIX:

SRC = ssss.c
OBJ = $(SRC:.c=.o)

all: options ssss 

options:
	@echo ssss: build options:
	@echo "CFLAGS  = $(STCFLAGS)"
	@echo "LDFLAGS = $(STLDFLAGS)"
	@echo "CC      = $(CC)"

config.h:
	cp config.def.h config.h

.c.o:
	$(CC) $(STCFLAGS) -c $<

ssss.o: config.h ssss.h

$(OBJ): config.h

ssss: $(OBJ)
	$(CC) -o $@ $(OBJ) $(STLDFLAGS)

clean:
	rm -f ssss $(OBJ) ssss-$(VERSION).tar.gz

dissss: clean
	mkdir -p ssss-$(VERSION)
	cp -R FAQ LEGACY TODO LICENSE Makefile README config.mk\
		config.def.h ssss.info ssss.h $(SRC)\
		ssss-$(VERSION)
	tar -cf - ssss-$(VERSION) | gzip > ssss-$(VERSION).tar.gz
	rm -rf ssss-$(VERSION)

inssssall: ssss
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f ssss $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/ssss
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < ssss.1 > $(DESTDIR)$(MANPREFIX)/man1/ssss.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/ssss.1

uninssssall:
	rm -f $(DESTDIR)$(PREFIX)/bin/ssss
	rm -f $(DESTDIR)$(MANPREFIX)/man1/ssss.1

.PHONY: all options clean dissss inssssall uninssssall
