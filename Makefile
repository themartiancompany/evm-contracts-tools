# SPDX-License-Identifier: AGPL-3.0

#    -----------------------------------------------------
#    Copyright © 2024, 2025, 2026  Pellegrino Prevete
#
#    All rights reserved
#    -----------------------------------------------------
#
#    This program is free software: you can redistribute
#    it and/or modify it under the terms of the
#    GNU Affero General Public License as published by
#    the Free Software Foundation, either version 3 of
#    the License, or (at your option) any later version.
#
#    This program is distributed in the hope that it
#    will be useful, but WITHOUT ANY WARRANTY;
#    without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU Affero General Public License for
#    more details.
#
#    You should have received a copy of the
#    GNU Affero General Public License
#    along with this program.
#    If not, see <https://www.gnu.org/licenses/>.

_NPM ?= true
PREFIX ?= /usr/local
_PROJECT=evm-contracts-tools
_PROJECT_NPM=$(_PROJECT)
DOC_DIR=$(DESTDIR)$(PREFIX)/share/doc/$(_PROJECT)
BIN_DIR=$(DESTDIR)$(PREFIX)/bin
MAN_DIR?=$(DESTDIR)$(PREFIX)/share/man
LIB_DIR=$(DESTDIR)$(PREFIX)/lib/$(_PROJECT)

_INSTALL_FILE=\
  install \
    -vDm644
_INSTALL_DIR=\
  install \
    -vdm755
_INSTALL_EXE=\
  install \
    -vDm755

DOC_FILES=\
  $(wildcard \
      *.rst) \
  $(wildcard \
      *.md)

_BASH_FILES=\
  evm-contract-bytecode-get \
  evm-contract-call \
  evm-contract-deployer-get \
  evm-contract-deployment-abi \
  evm-contract-deployment-address \
  evm-contract-deployment-bytecode \
  evm-contract-deployment-compiler-output \
  evm-contract-deployment-networks \
  evm-contract-deployment-versions \
  evm-contract-deployments-dir
_NODE_FILES=\
  address-check \
  bytecode-creation-get \
  bytecode-runtime-get \
  contract-get \
  deployer-get \
  deployer-verify \
  evm-contract-call-dynamic \
  evm-contract-call-static

_CHECK_TARGETS=\
  shellcheck
_CHECK_TARGETS_ALL=\
  check \
  $(_CHECK_TARGETS)
_INSTALL_SCRIPTS_TARGETS=\
  install-bash-scripts \
  install-node-scripts
INSTALL_DOC_TARGETS=\
  install-doc \
  install-man
_INSTALL_TARGETS=\
  install-scripts \
  $(_INSTALL_DOC_TARGETS)
_INSTALL_TARGETS_ALL=\
  install \
  $(_INSTALL_TARGETS) \
  $(_INSTALL_SCRIPTS_TARGETS) \
  install-npm

_PHONY_TARGETS=\
  $(_CHECK_TARGETS_ALL) \
  $(_INSTALL_TARGETS_ALL)
  
all: build-scripts build-man

check: shellcheck

shellcheck:

	shellcheck \
	  -s \
	    "bash" \
	  $(_BASH_FILES)

build-scripts:

	git \
	  submodule \
	    update \
	    --init \
	      "$(_PROJECT)/nodejs" || \
	true

build-man:

	git \
	  submodule \
	    update \
	    --init \
	      "man" || \
	true
	mkdir \
	  -p \
	  "build/man"
	cd \
	  "man"; \
	make \
	  build-man
	cp \
	  "man/build/"* \
	  "build/man"

build-npm:

	git \
	  submodule \
	    update \
	    --init \
	      "$(_PROJECT)/nodejs" || \
	true
	cd \
	  "$(_PROJECT)/nodejs"; \
	make \
	  build-npm
	mv \
	  "build" \
	  "../.."

install: $(_INSTALL_TARGETS)

install-scripts: $(_INSTALL_SCRIPTS_TARGETS)

install-bash-scripts:

	for _file in $(_BASH_FILES); do \
	  $(_INSTALL_EXE) \
	    "$(_PROJECT)/bash/$${_file}" \
	    "$(BIN_DIR)/$${_file}"; \
	done

install-node-scripts:

	_node_submodule="$$( \
          ls \
	    "$(_PROJECT)/nodejs")"; \
	if [[ "$${_node_submodule}" == "" ]]; then \
	  git \
	    submodule \
	      update \
	      --init \
	        "$(_PROJECT)/nodejs"; \
	fi
	if [[ "$(_NPM)" == "false" ]]; then \
	  $(_INSTALL_DIR) \
	    "$(LIB_DIR)/nodejs"; \
	  cp \
	    -r \
	    $$(printf \
	         "${PWD}/$(_PROJECT)/nodejs/%s " \
	         $$(cat \
	              "$(_PROJECT)/nodejs/package.json" | \
	              jq \
	                --raw-output \
	                '.files[]')) \
	    "$(LIB_DIR)/nodejs"; \
	  for _file in "$(_PROJECT)/nodejs/lib/"*; do \
	    _name="$$( \
	      basename \
	        "$${_file}")"; \
	    rm \
	      "$(LIB_DIR)/$${_name}"; \
	    ln \
	      -s \
	      "$(PREFIX)/lib/$(_PROJECT)/nodejs/lib/$${_name}" \
	      "$(LIB_DIR)/$${_name}" || \
	      true; \
	  done; \
	  if [[ ! -d "$(DESTDIR)$(PREFIX)/lib/node_modules/$(_PROJECT_NPM)" ]]; then \
	    ln \
	      -s \
	      "$(PREFIX)/lib/$(_PROJECT)/nodejs" \
	      "$(DESTDIR)$(PREFIX)/lib/node_modules/$(_PROJECT_NPM)"; \
	  fi; \
	elif [[ "$(_NPM)" == "true" ]]; then \
	  make \
	    install-npm; \
	  ln \
	   -s \
	   "$(PREFIX)/lib/node_modules/$(_PROJECT_NPM)" \
	   "$(LIB_DIR)/nodejs"; \
	fi

install-doc:

	$(_INSTALL_FILE) \
	  $(DOC_FILES) \
	  -t \
	  "$(DOC_DIR)/"

install-man:

	cd \
	  "man"; \
	  make \
	    install-man

install-npm:

	git \
	  submodule \
	    update \
	    --init \
	      "$(_PROJECT)/nodejs" || \
	true
	cd \
	  "$(_PROJECT)/nodejs"; \
	make \
	  install-npm

.PHONY: $(_PHONY_TARGETS)
