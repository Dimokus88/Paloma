#!/bin/bash
echo ================================================================================
echo ================================================================================
echo ===========██████╗░██╗███╗░░░███╗░█████╗░██╗░░██╗██╗░░░██╗░██████╗==============
echo ===========██╔══██╗██║████╗░████║██╔══██╗██║░██╔╝██║░░░██║██╔════╝==============
echo ===========██║░░██║██║██╔████╔██║██║░░██║█████═╝░██║░░░██║╚█████╗░==============
echo ===========██║░░██║██║██║╚██╔╝██║██║░░██║██╔═██╗░██║░░░██║░╚═══██╗==============
echo ===========██████╔╝██║██║░╚═╝░██║╚█████╔╝██║░╚██╗╚██████╔╝██████╔╝==============
echo ===========╚═════╝░╚═╝╚═╝░░░░░╚═╝░╚════╝░╚═╝░░╚═╝░╚═════╝░╚═════╝░==============
echo ================================================================================
echo ============================= https://t.me/Dimokus =============================
echo ================================================================================
sleep 5
echo ================================================================================
echo ================================================================================
echo ██████╗░░█████╗░░██╗░░░░░░░██╗███████╗██████╗░███████╗██████╗░  ██████╗░██╗░░░██╗
echo ██╔══██╗██╔══██╗░██║░░██╗░░██║██╔════╝██╔══██╗██╔════╝██╔══██╗  ██╔══██╗╚██╗░██╔╝
echo ██████╔╝██║░░██║░╚██╗████╗██╔╝█████╗░░██████╔╝█████╗░░██║░░██║  ██████╦╝░╚████╔╝░
echo ██╔═══╝░██║░░██║░░████╔═████║░██╔══╝░░██╔══██╗██╔══╝░░██║░░██║  ██╔══██╗░░╚██╔╝░░
echo ██║░░░░░╚█████╔╝░░╚██╔╝░╚██╔╝░███████╗██║░░██║███████╗██████╔╝  ██████╦╝░░░██║░░░
echo ╚═╝░░░░░░╚════╝░░░░╚═╝░░░╚═╝░░╚══════╝╚═╝░░╚═╝╚══════╝╚═════╝░  ╚═════╝░░░░╚═╝░░░
sleep 1
echo ====================░█████╗░██╗░░██╗░█████╗░░██████╗██╗░░██╗=====================
echo ====================██╔══██╗██║░██╔╝██╔══██╗██╔════╝██║░░██║=====================
echo ====================███████║█████═╝░███████║╚█████╗░███████║=====================
echo ====================██╔══██║██╔═██╗░██╔══██║░╚═══██╗██╔══██║=====================
echo ====================██║░░██║██║░╚██╗██║░░██║██████╔╝██║░░██║=====================
echo ====================╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚═╝░░╚═╝=====================
sleep 10

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
(echo ${my_root_password}; echo ${my_root_password}) | passwd root
service ssh restart
service nginx start
sleep 1
binary="palomad"
folder=".paloma"
denom="ugrain"
chain="paloma-testnet-6"
gitfold="paloma"
genesis="https://raw.githubusercontent.com/palomachain/testnet/master/paloma-testnet-6/genesis.json"
sleep 1

SYNH(){
	if [[ -z `ps -o pid= -p $nodepid` ]]
	then
		cd /
		echo ===================================================================
		echo ===Нода не работает, перезапускаю...Node not working, restart...===
		echo ===================================================================
		rm ./nohup.out
		rm ./nohup.err
		nohup  $binary start >nohup.out 2>nohup.err </dev/null &  nodepid=`echo $!`
		echo $nodepid
		sleep 5
		curl -s localhost:26657/status
		synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
		echo $synh
	else
		cd /
		echo =================================
		echo ===Нода работает.Node working.===
		echo =================================
		curl -s localhost:26657/status
		tail ./nohup.out
		tail ./nohup.err
		synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
		cat /root/$folder/config/priv_validator_key.json
		echo $nodepid
		echo $synh
	fi
	
	echo =====Ваш адрес =====
	echo ===Your address ====
	echo $address
	echo ==========================
	echo =====Your valoper=====
	echo ======Ваш valoper=====
	echo $valoper
	echo ===========================
	date
}
#||||||||||||||||||||||||||||||||||||||

#*******************ФУНКЦИЯ РАБОЧЕГО РЕЖИМА НОДЫ|*************************
WORK (){
while [[ $synh == false ]]
do		
	sleep 5m
	date
	SYNH
	echo =======================================================================
	echo =============Check if the validator keys are correct! =================
	echo =======================================================================
	echo =======================================================================
	echo =============Проверьте корректность ключей валидатора!=================
	echo =======================================================================
	cat /root/$folder/config/priv_validator_key.json
	sleep 20
	echo =================================================
	echo ===============WALLET NAME and PASS==============
	echo =================================================
	echo =========== Name ${WALLET_NAME} Имя =============
	echo ========== Pass ${PASSWALLET} Пароль ============
	echo =================================================
	echo =============Имя кошелька и его пароль===========
	echo =================================================
	sleep 5
	#===============СБОР НАГРАД И КОМИССИОННЫХ===================
	reward=`$binary query distribution rewards $address $valoper -o json | jq -r .rewards[].amount`
	reward=`printf "%.f \n" $reward`
	echo ==============================
	echo ==Ваши награды: $reward $denom==
	echo ===Your reward $reward $denom===
	echo ==============================
	sleep 5
		if [[ `echo $reward` -gt 1000000 ]]
	then
		echo =============================================================
		echo ============Rewards discovered, collecting...================
		echo =============================================================
		echo =============================================================
		echo =============Обнаружены награды, собираю...==================
		echo =============================================================
		(echo ${PASSWALLET}) | $binary tx distribution withdraw-rewards $valoper --from $address --gas="auto" --fees 5555$denom --commission -y
		reward=0
		sleep 5
	fi
	#============================================================
	
	#+++++++++++++++++++++++++++АВТОДЕЛЕГИРОВАНИЕ++++++++++++++++++++++++
	if [[ $autodelegate == yes ]]
	then
		balance=`$binary q bank balances $address -o json | jq -r .balances[].amount `
		balance=`printf "%.f \n" $balance`
		echo =================================================
		echo ===============Balance check...==================
		echo =================================================
		echo =================================================
		echo =============Проверка баланса...=================
		echo =================================================
		echo =========================
		echo ==Ваш баланс: $balance ==
		echo = Your balance $balance =
		echo =========================
		sleep 5
		if [[ `echo $balance` -gt 1000000 ]]
		then
			echo ======================================================================
			echo ============Balance = $balance . Delegate to validator================
			echo ======================================================================
			echo ======================================================================
			echo =============Баланс = $balance . Делегирую валидатору=================
			echo ======================================================================
			stake=$(($balance-500000))
			(echo ${PASSWALLET}) | $binary tx staking delegate $valoper ${stake}`echo $denom` --from $address --chain-id $chain --gas="auto" --fees 5555$denom -y
			sleep 5
			stake=0
			balance=0
		fi
	else	
		echo ===========================================================
		echo =============== auto-delegation disabled ==================
		echo ===============автоделегирование отключено=================
		echo ===========================================================
	fi
	#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	

	synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
	
	#--------------------------ВЫХОД ИЗ ТЮРЬМЫ--------------------------
	jailed=`$binary query staking validator $valoper -o json | jq -r .jailed`
	while [[  $jailed == true ]] 
	do
		echo ==Внимание! Валидатор в тюрьме, попытка выхода из тюрьмы произойдет через 30 минут==
		echo =Attention! Validator in jail, attempt to get out of jail will happen in 30 minutes=
		sleep 30m
		(echo ${PASSWALLET}) | $binary tx slashing unjail --from $address --chain-id $chain --fees 5000$denom -y
		sleep 10
		jailed=`$binary query staking validator $valoper -o json | jq -r .jailed`
	done
	#-------------------------------------------------------------------
done
}
#************************************************************************************************************************

#======================================================== КОНЕЦ БЛОКА ФУНКЦИЙ ====================================================================================

ver="1.18.1" && \
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz" && \
sudo rm -rf /usr/local/go && \
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz" && \
rm "go$ver.linux-amd64.tar.gz" && \
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile && \
source $HOME/.bash_profile && \
go version
sleep 1
cd /
wget $gitrep
tar -xvzf paloma_0.2.5-prealpha_Linux_x86_64.tar.gz
 ls
mv $binary /usr/local/bin/$binary
chmod +x /usr/local/bin/$binary
cd /
sudo wget -P /usr/lib https://github.com/CosmWasm/wasmvm/raw/main/api/libwasmvm.x86_64.so
$binary version
sleep 1
PASSWALLET=q542we221
WALLET_NAME=My_wallet

echo ${PASSWALLET}
echo ${WALLET_NAME}
sleep 2

#=======init ноды==========
echo =INIT=
$binary init "$MONIKER" --chain-id $chain --home /root/$folder
sleep 5
#==========================

#===========ДОБАВЛЕНИЕ КОШЕЛЬКА============
(echo "${MNEMONIC}"; echo ${PASSWALLET}; echo ${PASSWALLET}) | $binary keys add ${WALLET_NAME} --recover
address=`(echo ${PASSWALLET}) | $(which $binary) keys show $WALLET_NAME -a`
valoper=`(echo ${PASSWALLET}) | $(which $binary) keys show $WALLET_NAME  --bech val -a`
echo =====Ваш адрес =====
echo ===Your address ====
echo $address
echo ==========================
echo =====Your valoper=====
echo ======Ваш valoper=====
echo $valoper
echo ===========================
#==================================

wget -O $HOME/$folder/config/genesis.json $genesis
sha256sum ~/$folder/config/genesis.json
cd && cat $folder/data/priv_validator_state.json
#==========================
rm $HOME/$folder/config/addrbook.json
wget -O $HOME/$folder/config/addrbook.json $addrbook

# ------ПРОВЕРКА НАЛИЧИЯ priv_validator_key--------
wget -O /var/www/html/priv_validator_key.json ${LINK_KEY}
file=/var/www/html/priv_validator_key.json


#---проверка наличия пользовательского priv_validator_key---
if  [[ -f "$file" ]]
then
	cd /
	rm /root/$folder/config/priv_validator_key.json
	echo ==========priv_validator_key found==========
	echo ========Обнаружен priv_validator_key========
	cp /var/www/html/priv_validator_key.json /root/$folder/config/
	echo ========Validate the priv_validator_key.json file=========
	echo ==========Сверьте файл priv_validator_key.json============
	cat /root/$folder/config/priv_validator_key.json
else
	echo =====================================================================
	echo =========== priv_validator_key not found, making a backup ===========
	echo =====================================================================
	echo =====================================================================
	echo ====== priv_validator_key не обнаружен, создаю резервную копию ======
	echo =====================================================================
	sleep 2
	cp /root/$folder/config/priv_validator_key.json /var/www/html/
	echo =========================================================================================
	echo = priv_validator_key has been created! Save the output to a .json file on google drive. =
	echo == Place a direct link to download the file in the manifest and update the deployment! ==
	echo ==================================Work has been suspended!===============================
	echo =========================================================================================
	echo = priv_validator_key создан! Сохраните вывод в файл с расширением .json на google диск. =
	echo ==== Разместите прямую ссылку на скачивание файла в манифесте и обновите деплоймент! ====
	echo ====================================Работа приостановлена!===============================
	cat /root/$folder/config/priv_validator_key.json
	sleep infinity
fi
# -----------------------------------------------------------

$binary config chain-id $chain

$binary config keyring-backend os
sleep 5

sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025$denom\"/;" $HOME/$folder/config/app.toml
sleep 1
external_address=$(wget -qO- eth0.me)
sed -i.bak -e "s/^external_address *=.*/external_address = \"$external_address:26656\"/" $HOME/$folder/config/config.toml
sleep 1
pruning="custom" && \
pruning_keep_recent="100" && \
pruning_keep_every="0" && \
pruning_interval="50" && \
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/$folder/config/app.toml && \
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/$folder/config/app.toml && \
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/$folder/config/app.toml && \
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/$folder/config/app.toml
sleep 1
sed -i -e "s/^seeds *=.*/seeds = \"$SEED\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEER\"/" $HOME/$folder/config/config.toml
sleep 1
indexer="null" && \
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/$folder/config/config.toml
sleep 1
snapshot_interval="0" && \
sed -i.bak -e "s/^snapshot-interval *=.*/snapshot-interval = \"$snapshot_interval\"/" $HOME/$folder/config/app.toml
sleep 1

# ||||||||||||||||||||||||||||||||||||||||||||||||Backup||||||||||||||||||||||||||||||||||||||||||||||||||||||
#=======Загрузка снепшота блокчейна===
if [[ -n $LINK_SNAPSHOT ]]
then
	cd /root/$folder/
	wget -O snap.tar $LINK_SNAPSHOT
	tar xvf snap.tar 
	rm snap.tar
	echo ===============================================
	echo ===== Snapshot загружен!Snapshot loaded! ======
	echo ===============================================
	cd /
fi
#==================================
source $HOME/.bashrc
# ====================RPC======================
if [[ -n $SNAP_RPC ]]
then

LATEST_HEIGHT=`curl -s $SNAP_RPC/block | jq -r .result.block.header.height`; \
BLOCK_HEIGHT=$((LATEST_HEIGHT - $SHIFT)); \
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

echo $LATEST_HEIGHT $BLOCK_HEIGHT $TRUST_HASH

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC,$SNAP_RPC\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"| ; \
s|^(seeds[[:space:]]+=[[:space:]]+).*$|\1\"\"|" $HOME/$folder/config/config.toml
echo RPC
sleep 5
fi
#================================================
# |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
source $HOME/.bashrc
#===========ЗАПУСК НОДЫ============

echo =Run node...=
cd /
nohup  $binary start >nohup.out 2>nohup.err </dev/null &  nodepid=`echo $!`
echo $nodepid
source $HOME/.bashrc
sleep 20
synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
echo $synh
tail ./nohup.out
tail ./nohup.err
sleep 2
#=========Пока нода не синхронизирована - повторять===========
while [[ $synh == true ]]
do
	sleep 5m
	date
	echo ==============================================
	echo =Нода не синхронизирована! Node is not sync! =
	echo ==============================================
	SYNH
	
done

#=======Если нода синхронизирована - начинаем работу ==========
while	[[ $synh == false ]]
do 	
	sleep 5m
	date
	echo ================================================================
	echo =Нода синхронизирована успешно! Node synchronized successfully!=
	echo ================================================================
	SYNH
	val=`$binary query staking validator $valoper -o json | jq -r .description.moniker`
	echo $val
	synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
	echo $synh
	if [[ -z "$val" ]]
	then
		echo =Создание валидатора... Creating a validator...=
		(echo ${PASSWALLET}) | $binary tx staking create-validator --amount="1000000$denom" --pubkey=$($binary tendermint show-validator) --moniker="$MONIKER"	--chain-id="$chain"	--commission-rate="0.10" --commission-max-rate="0.20" --commission-max-change-rate="0.01" --min-self-delegation="1000000" --gas="auto"	--from="$address" --fees="5550$denom" -y
		echo 'true' >> /var/validator
		val=`$binary query staking validator $valoper -o json | jq -r .description.moniker`
		echo $val
	else
		val=`$binary query staking validator $valoper -o json | jq -r .description.moniker`
		echo $val
		MONIKER=`echo $val`
		WORK
	fi
done
