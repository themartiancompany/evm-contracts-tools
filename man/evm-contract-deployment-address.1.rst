..
   SPDX-License-Identifier: AGPL-3.0-or-later

   ----------------------------------------------------------------------
   Copyright © 2024, 2025, 2026  Pellegrino Prevete

   All rights reserved
   ----------------------------------------------------------------------

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU Affero General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU Affero General Public License for more details.

   You should have received a copy of the GNU Affero General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.


=================================
evm-contract-deployment-address
=================================

-----------------------------------------------------------------------------------
Ethereum Virtual Machine (EVM) deployment address discover tool
------------------------------------------------------------------------------------
:Version: evm-contract-deployment-address |version|
:Manual section: 1


Synopsis
========

evm-contract-deployment-address *[options]* *address* *transaction_deployment*


Description
===========

Determines the deployment address of a smart contract
given the application name.

To obtain transaction data it uses libraries from
EVM Transactions Tools.


Networks
=========

All those supported by
'evm-chains-info' as
well as direct RPC addresses.


Options
=======

-V deployer_verify      Whether to verify the input
                        address is the deployer.
-r retries_max          Maximum number of retries before
                        declaring the call failed.
-S rpc_selection        RPC selection method. It can be
                        'kirsh' or 'random'.


Credentials options
=====================

-N wallet_name          EVM wallet name.
-w wallet_path          EVM wallet file path.
-p wallet_path          EVM wallet password file.
-s wallet_seed          Standard 12-words seed phrase file.
-t call_type            Static (read-only) or dynamic (read/write).
-k api_key              Etherscan-like service key.


LibEVM options
===============

-a                      Whether to perform an authenticated
                        RPC call.
-n network              EVM network name. Accepted values
                        are all those supported by
                        evm-chains-info as well as RPC addresses.


Application options
====================

-h                      Displays help.
-c                      Enable color output
-v                      Enable verbose output


Bugs
====

https://github.com/themartiancompany/evm-contracts-tools/-/issues


Copyright
=========

Copyright Pellegrino Prevete. AGPL-3.0.


See also
========

* evm-contract-call
* evm-contract-deployment-address
* evm-contract-deployments-dir
* evm-contract-deployment-networks
* evm-contract-deployment-versions
* evm-contracts-abi-get
* evm-wallet

.. include:: variables.rst
