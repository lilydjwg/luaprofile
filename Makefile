CC=gcc
CFLAGS=-g -Wall -fPIC -O2 -I. $(DEFINE)
LDFLAGS=-ldl
INSTALL=install
PREFIX=/usr/local

.PHONY: all clean

all: luaprofile.so luaprofile

luaprofile.so: luaprofile.o
	$(CC) -shared $< -o $@ $(LDFLAGS)

luaprofile: main.o
	$(CC) $< -o $@

main.o: main.c
	$(CC) -c $< -o $@ $(CFLAGS) -DLIB_FILE=\"$(PREFIX)/lib/luaprofile.so\"

clean:
	-rm *.o luaprofile.so luaprofile

install: all
	$(INSTALL) -m755 -t $(PREFIX)/lib luaprofile.so
	$(INSTALL) -m755 -t $(PREFIX)/bin luaprofile

uninstall:
	rm -f $(PREFIX)/lib/luaprofile.so
	rm -f $(PREFIX)/bin/luaprofile
