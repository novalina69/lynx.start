# Welcome to the LYNX MainNet [manual node installation]

Chain ID: b62febe5aadff3d5399090b9565cb420387d3c66f2ccd7c7ac1f532c4f50f573  
Based on tag: v1.8.5  

Please join out Lynx MainNet <a target="_blank" href="https://t.me/">Telegram channel</a>  
Network Monitor: https://monitor.lynxchain.io/  


! This repo is for manual installation.  


To start a Lynx MainNet node you need install EOSIO software. You can compile from sources or install from precompiled binaries:  

# 1. Installing EOSIO  
---------------------------------------------------  

# 1.1 EOSIO - Installing from sources  

A. Create folder, download sources, compile and install:  

```
mkdir /opt/EOSIO  
cd /opt/EOSIO  

git clone https://github.com/eosio/eos --recursive    
cd eos  

git checkout v1.8.5  
git submodule update --init --recursive   

./scripts/eosio_build.sh -P -y
./scripts/eosio_install.sh
```  

B. Copy binaries to keep old versions and make sym link to latest:  

```
mkdir /opt/bin
mkdir /opt/bin/v1.8.5
cp /opt/EOSIO/eos/build/programs/nodeos/nodeos /opt/bin/v1.8.5/
cp /opt/EOSIO/eos/build/programs/cleos/cleos /opt/bin/v1.8.5/
cp /opt/EOSIO/eos/build/programs/keosd/keosd /opt/bin/v1.8.5/
ln -sf /opt/bin/v1.8.5 /opt/bin/bin
```

So /opt/bin/bin will point to latest binaries  


# 1.2 EOSIO - installing from precompiled binaries  

A. Download the latest version of EOSIO for your OS from:  
https://github.com/EOSIO/eos/releases/tag/v1.8.5   
For example, for ubuntu 18.04 you need to download deb eosio_1.8.9-ubuntu-18.04_amd64.deb              
To install it you can use apt:  
```
apt install ./eosio_1.8.5-ubuntu-18.04_amd64.deb   
```
It will download all dependencies and install EOSIO to /usr/opt/eosio/v1.8.5  
B. Copy binaries to keep old versions and make sym link to latest:  

```
 mkdir /opt/bin
 mkdir /opt/bin/v1.8.5
 cp /usr/opt/eosio/v1.8.5/bin/nodeos /opt/bin/v1.8.5/
 cp /usr/opt/eosio/v1.8.5/bin/cleos /opt/bin/v1.8.5/
 cp /usr/opt/eosio/v1.8.5/bin/keosd /opt/bin/v1.8.5/
 ln -sf /opt/bin/v1.8.5/ /opt/bin/bin
```

So /opt/bin/bin will be point to latest binaries  

---------------------------------------------------------  
# 2. Update EOSIO software to new version  

# 2.1 Update sources  

```
cd /opt/EOSIO/eos
git checkout -f
git branch -f
git pull
git checkout v1.8.5   
git submodule update --init --recursive   


./scripts/eosio_build.sh -P -y
./scripts/eosio_uninstall.sh
./scripts/eosio_install.sh

mkdir /opt/bin/v1.8.5
cp /opt/EOSIO/eos/build/programs/nodeos/nodeos /opt/bin/v1.8.5/
cp /opt/EOSIO/eos/build/programs/cleos/cleos /opt/bin/v1.8.5/
cp /opt/EOSIO/eos/build/programs/keosd/keosd /opt/bin/v1.8.5/
ln -sf /opt/bin/v1.8.5 /opt/bin/bin
```  

# 2.2 Update binaries  
To upgrade precompiled installation pleasse folow the same steps as in 1.2 (Installation from precompiled)  

------------------------------------------------------------------  

# 3. Install Lynx MainNet node [manual]  
    
```
    mkdir /opt/LynxMainNet
    cd /opt/LynxMainNet
    git clone https://github.com/needly/lynx.start.git ./

```

- In case you use a different data-dir folders -> edit all paths in files cleos.sh, start.sh, stop.sh, config.ini, Wallet/start_wallet.sh, Wallet/stop_wallet.sh  

- The first thing you will need to do is download the Lynx Wallet and create a new Mainnet account  <a target="_blank" href="https://www.lynxwallet.io/">here</a>. 

- To register as Block Producer you should go to the <a target="_blank" href="https://permission.lynxchain.io/">Permission Portal</a> login and request permission to regproduse  
  when you got this permission and you finish prepare node you can run command 
  ```
  ./cleos.sh system regproducer YOU_ACCOUNT PUBKEY "URL" LOCATION -p YOU_ACCOUNT
  ```

- If non BP node: use the same config, just comment out rows with producer-name and signature-provider  
  
- Edit config.ini:  
  - server address: p2p-server-address = ENRT_YOUR_NODE_EXTERNAL_IP_ADDRESS:9876  

  - if BP: your producer name: producer-name = YOUR_BP_NAME  
  - if BP: add producer keypair for signing blocks (this pub key should be used in regproducer action):  
  signature-provider = YOUR_PUB_KEY_HERE=KEY:YOUR_PRIV_KEY_HERE  
  - replace p2p-peer-address list with fresh generated on monitor site: https://monitor.lynxchain.io/#p2p  
  - Check chain-state-db-size-mb value in config, it should be not bigger than you have RAM:  
    chain-state-db-size-mb = 16384  
  
- Open TCP Ports (8888, 9876) on your firewall/router  


- Start wallet, run  
```
cd /opt/LynxMainNet
./Wallet/start_wallet.sh  
```

**First run should be with --delete-all-blocks and --genesis-json**  
```
cd /opt/LynxMainNet/lynxNode
./start.sh --delete-all-blocks --genesis-json genesis.json
```  
Check logs stderr.txt if node is running ok. 


- Create your wallet file  
```
./cleos.sh wallet create --to-file pass.tx
```
Your password will be in pass.txt it will be used when unlock wallet  


- Unlock your wallet  
```
./cleos.sh wallet unlock  
```
enter the wallet password.  


- Import your key  
```
./cleos.sh wallet import
```
Enter your private key  



- Check if you can access you node using link http://you_server:8888/v1/chain/get_info (<a href="http://lynx.cryptolions.io/v1/chain/get_info" target="_blank">Example</a>)  


==============================================================================================  

# 4.1 Restore/Start from Backup
   Download latest block and state archive for your OS from http://backup.cryptolions.io/LynxMainNet/
   
   ```
   wget http://backup.cryptolions.io/LynxMainNet/ubuntu18/latest-blocks.tar.gz
   wget http://backup.cryptolions.io/LynxMainNet/ubuntu18/latest-state.tar.gz
   ```
   After downloaded extract their
   ```
   tar xzvf blocks-latest.tar.gz -C .
   tar xzvf state-latest.tar.gz -C .
   ```
   You got two folders block and state.  
   Ater that go to **NODE** folder, and remove files from folder blocks and state
   ```
   cd /opt/LynxMainNet/lynxNode
   rm blocks/*
   rm state/*
   ```
   After that go where you extracted archive and move file from folder 
   ```
   mv ~/blocks/* /opt/LynxMainNet/lynxNode/blocks/
   mv ~/state/* /opt/LynxMainNet/lynxNode/state/
   ```
   After files moved start your NODE
   ```
   ./start.sh
   ```
# 4.2 Restore/Start from Snapshots
   Download latest snapshot from http://backup.cryptolions.io/LynxMainNet/snapshots/ to snapshots folder in your **NODE** directory
   ```
   cd /opt/LynxMainNet/lynxNode/snapshots/
   wget http://backup.cryptolions.io/LynxMainNet/snapshots/latest-snapshot.bin
   ```
   after it downloaded run `start.sh` script with option `--snapshot` and snapshot file path
   ```
   cd /opt/LynxMainNet/lynxNode
   ./start.sh --snapshot /opt/LynxMainNet/lynxNode/snapshots/latest-snapshot.bin
   ```
 ---


# Other Tools/Examples  

- Cleos commands:  

Send LNX
```
./cleos.sh transfer <your account> <receiver account> "1.0000 LNX" "test memo text"
```
Get Balance  
```
./cleos.sh get currency balance eosio.token <account name>
```
Create account  
```
./cleos.sh system newaccount --stake-net "10.0000 LNX" --stake-cpu "10.0000 LNX" --buy-ram-bytes 4096 <your accountr> <new account> <pkey1> <pkey2>
```  
List registered producers (-l <limit>)  
```
./cleos.sh get table eosio eosio producers -l 100  
```
List your last action (use -h to get help, do not work now, works with history node only)  
```
./cleos.sh get actions <account name>
```
  
List staked/delegated  
```
./cleos.sh system listbw <account>   
```
 
# Lynx MainNet History nodes
**Hyperion History**  
https://history.lynxchain.io    
https://lynx.eosusa.news/v2/docs/

**Block Explorers**   
https://lynx.bloks.io/    

**Permissions**
https://permission.lynxchain.io
--------------  

# Backups
### Full(blocks and states):
  * [Ubuntu 18](http://backup.cryptolions.io/LynxMainNet/ubuntu18/)  
  
### Snapshot:
  * [Snapshots](http://backup.cryptolions.io/LynxTestnet/snapshots/)

--------------