CC       ?= gcc
CFLAGS   ?= -std=c11 -Wall -Wextra -Werror -pedantic -O2
ifeq ($(BUILD),debug)
CFLAGS = -std=c11 -Wall -Wextra -pedantic -Og -ggdb3
endif

INCS     := $(shell pkg-config --cflags gio-2.0 json-glib-1.0)
LIBS     := $(shell pkg-config --libs gio-2.0 json-glib-1.0)

SDK_SOURCES := lib/promptr-protocol/jsonrpc.c lib/promptr-protocol/provider-server.c
SDK_HEADERS := lib/promptr-protocol/jsonrpc.h lib/promptr-protocol/provider-server.h
PLUGIN_DIR ?= $(if $(XDG_CONFIG_HOME),$(XDG_CONFIG_HOME),$(HOME)/.config)/promptr/plugins/opencode

promptr-opencode: main.c $(SDK_SOURCES) $(SDK_HEADERS)
	$(CC) $(CFLAGS) $(INCS) -o $@ main.c $(SDK_SOURCES) $(LIBS)

debug:
	$(MAKE) BUILD=debug

install: promptr-opencode
	install -Dm755 promptr-opencode "$(PLUGIN_DIR)/promptr-opencode"
	install -Dm644 plugin.json "$(PLUGIN_DIR)/plugin.json"

test: promptr-opencode
	python3 tests/test_adapter.py

clean:
	rm -f promptr-opencode

.PHONY: clean debug install test
