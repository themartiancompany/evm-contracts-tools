#
# SPDX-License-Identifier: GPL-3.0-or-later

PREFIX ?= /usr/local
_PROJECT=evm-contract-tools
DOC_DIR=$(DESTDIR)$(PREFIX)/share/doc/$(_PROJECT)
BIN_DIR=$(DESTDIR)$(PREFIX)/bin
LIB_DIR=$(DESTDIR)$(PREFIX)/lib

DOC_FILES=$(wildcard *.rst)
SCRIPT_FILES=$(wildcard $(_PROJECT)/*)

all:

check: shellcheck

shellcheck:
	shellcheck -s bash $(SCRIPT_FILES)

install: install-scripts install-doc

install-scripts:

	install -vDm 755 $(_PROJECT)/evm-contract-call-dynamic "$(LIB_DIR)/$(_PROJECT)/evm-contract-call-dynamic"
	install -vDm 755 evm-contracts-tools/evm-contract-call-static "$(LIB_DIR)/$(_PROJECT)/evm-contract-call-static"
	install -vDm 755 $(_PROJECT)/contract-get "$(LIB_DIR)/$(_PROJECT)/evm-contract-call-static"
	install -vDm 755 $(_PROJECT)/evm-contract-call "$(BIN_DIR)/evm-contract-call"

install-doc:

	install -vDm 644 $(DOC_FILES) -t $(DOC_DIR)

.PHONY: check install install-doc install-scripts shellcheck
