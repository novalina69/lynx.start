#!/bin/bash

################################################################################
# Lynx tools
#
# 
# Created by http://CryptoLions.io
#
# https://github.com/needly/lynx.start  
#
###############################################################################

NODEOSBINDIR="/opt/bin/bin"
DATADIR="/opt/LynxMainNet/Wallet"
WALLET_HOST="127.0.0.1"
WALLET_POSRT="3000"


$DATADIR/open_wallet.sh
$NODEOSBINDIR/keosd --config-dir $ --wallet-dir $DATADIR --unix-socket-path $DATADIR/keosd.sock --http-server-address $WALLET_HOST:$WALLET_POSRT "$@" > $DATADIR/stdout.txt 2> $DATADIR/stderr.txt & echo $! > $DATADIR/wallet.pid

