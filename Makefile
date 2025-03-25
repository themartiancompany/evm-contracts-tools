# SPDX-License-Identifier: GPL-3.0-or-later

#    ----------------------------------------------------------------------
#    Copyright © 2024, 2025  Pellegrino Prevete
#
#    All rights reserved
#    ----------------------------------------------------------------------
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

PREFIX ?= /usr/local
_PROJECT=evm-contracts-tools
DOC_DIR=$(DESTDIR)$(PREFIX)/share/doc/$(_PROJECT)
BIN_DIR=$(DESTDIR)$(PREFIX)/bin
MAN_DIR?=$(DESTDIR)$(PREFIX)/share/man
LIB_DIR=$(DESTDIR)$(PREFIX)/lib

_INSTALL_FILE=install -Dm644
_INSTALL_DIR=install -dm755
_INSTALL_EXE=install -Dm755

DOC_FILES=\
  $(wildcard *.rst) \
  $(wildcard *.md)
SCRIPT_FILES=$(wildcard $(_PROJECT)/*)

all:

check: shellcheck

shellcheck:
	shellcheck -s bash $(SCRIPT_FILES)

install: install-scripts install-doc install-man

install-scripts:

	$(_INSTALL_EXE) \
	  "$(_PROJECT)/evm-contract-call-dynamic" \
	  "$(LIB_DIR)/$(_PROJECT)/evm-contract-call-dynamic"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/evm-contract-call-static" \
	  "$(LIB_DIR)/$(_PROJECT)/evm-contract-call-static"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/contract-get" \
	  "$(LIB_DIR)/$(_PROJECT)/contract-get"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/deployer-get" \
	  "$(LIB_DIR)/$(_PROJECT)/deployer-get"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/deployer-verify" \
	  "$(LIB_DIR)/$(_PROJECT)/deployer-verify"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/evm-contract-deployer-get" \
	  "$(BIN_DIR)/evm-contract-deployer-get"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/evm-contract-deployment-address" \
	  "$(BIN_DIR)/evm-contract-deployment-address"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/evm-contract-deployment-networks" \
	  "$(BIN_DIR)/evm-contract-deployment-networks"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/evm-contract-deployment-versions" \
	  "$(BIN_DIR)/evm-contract-deployment-versions"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/evm-contract-deployments-dir" \
	  "$(BIN_DIR)/evm-contract-deployments-dir"
	$(_INSTALL_EXE) \
	  "$(_PROJECT)/evm-contract-call" \
	  "$(BIN_DIR)/evm-contract-call"

install-doc:

	$(_INSTALL_FILE) \
	  $(DOC_FILES) \
	  -t \
	  "$(DOC_DIR)/"

install-man:

	$(_INSTALL_DIR) \
	  "$(MAN_DIR)/man1"
	rst2man \
	  "man/evm-contract-call.1.rst" \
	  "$(MAN_DIR)/man1/evm-contract-call.1"
	rst2man \
	  "man/evm-contract-deployer-get.1.rst" \
	  "$(MAN_DIR)/man1/evm-contract-deployer-get.1"

.PHONY: check install install-doc install-man install-scripts shellcheck
