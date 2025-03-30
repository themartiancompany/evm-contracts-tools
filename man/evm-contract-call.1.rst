..
   SPDX-License-Identifier: AGPL-3.0-or-later

   ----------------------------------------------------------------------
   Copyright © 2024, 2025  Pellegrino Prevete

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


=================
evm-contract-call
=================

--------------------------------------------------------------
Ethereum Virtual Machine-compatible Contract Caller
--------------------------------------------------------------
:Version: evm-contract-call |version|
:Manual section: 1

Synopsis
========

evm-contract-call *[options]* *address* *method* (*args*)

Description
===========

Runs smart contract functions as if they were
normal programs.

The caller uses the Ethers JavaScript library to
communicate with blockchain networks and integrates
natively with and depends on evm-wallet
but it's also possible to directly provide seeds files.

Networks
=========
All those supported by
'evm-chains-info' as
well as direct RPC addresses.

Options
=======

-a                      Call authentication.
-A abi                  Contract ABI path.
-B bytecode             Contract bytecode path.
-C compiler_output      Contract compiler output
                        path (the hardhat artifact).
-N wallet_name          EVM wallet name.
-w wallet_path          EVM wallet file path.
-p wallet_path          EVM wallet password file.
-s wallet_seed          Standard 12-words seed phrase file.
-n network              EVM network name. Accepted values
                        are all those supported by
                        evm-chains-info as well as RPC addresses.
-t call_type            Static (read-only) or dynamic (read/write).
-k api_key              Etherscan-like service key.
-V msg_value            How much <measure_unit> attach to the
                        transaction.
-u measure_unit         Measure unit for the transaction
                        value. It can be 'ether' or 'wei'.
-r retries_max          Maximum number of retries before
                        declaring the call failed.
-T call_timeout         Maximum number of seconds before
                        declaring the call failed.
-S rpc_selection        RPC selection method. It can be
                        'kirsh' or 'random'.

-h                      This message.
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

* evm-contract-deployer-get
* evm-contract-deployment-address
* evm-contract-deployments-dir
* evm-contract-deployment-networks
* evm-contract-deployment-versions
* evm-contracts-abi-get
* evm-wallet

.. include:: variables.rst
