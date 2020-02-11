R2_PLUGIN_PATH=$(shell r2pm -H R2PM_PLUGDIR)

CFLAGS=-g -fPIC $(shell pkg-config --cflags r_core)
LDFLAGS=-shared $(shell pkg-config --libs r_core) $(shell pkg-config --libs sqlite3)
SO_EXT=$(shell uname|grep -q Darwin && echo dylib || echo so)

PLUGIN=r2wakare.$(SO_EXT)

all: $(PLUGIN)

$(PLUGIN): wakare.o utils.o
	$(CC) $(LDFLAGS) $^ -o $@

%.o: %.c
	$(CC) $(CFLAGS) -r $^ -o $@

.PHONY: clean
clean:
	rm -f *.o
	rm -f *.$(SO_EXT)

.PHONY: install
install:
	cp -f $(PLUGIN) $(R2_PLUGIN_PATH)/

.PHONY: uninstall
uninstall:
	rm -f $(R2_PLUGIN_PATH)/$(PLUGIN)
