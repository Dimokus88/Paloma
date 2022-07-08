# Устанавливаем Pigeons на серввере Paloma

* Подключаем к контейнеру по SSH

* Выполняем команды по порядку:

```apt install nano```

```wget -O - https://github.com/palomachain/pigeon/releases/download/v0.2.5-alpha/pigeon_0.2.5-alpha_Linux_x86_64v3.tar.gz```

```tar -C /usr/local/bin -xvzf - pigeon```

```chmod +x /usr/local/bin/pigeon```

```mkdir ~/.pigeon```

* Создаем кошеле Ethereum, после воода команды задаем пароль ***q542we221***

```pigeon evm keys generate-new ~/.pigeon/keys/evm/eth-main```

* Сохраняем вывод в текстовый файл

* Задаем переменную вашего адреса Ethereum
например мой адрес

![image](https://user-images.githubusercontent.com/23629420/177959700-c12db1ca-8c98-41fb-a9e8-40a35f19115d.png)

```ETH_SIGNING_KEY=0x9c98871931d740d5c09922B27315a019231DfbFf```

* Берем из текстовго файл адрес кошелька вида ***/root/.pigeon/keys/evm/eth-main/UTC--2022-07-08T07-20-32.ХХХХХХХХХХХ--ХХХХХХХХХХХХХХХХХХХХХХХХХХХХ***
делаем команду вставляя свой адрес:

```cat /root/.pigeon/keys/evm/eth-main/UTC--2022-07-08T07-20-32.ХХХХХХХХХХХ--ХХХХХХХХХХХХХХХХХХХХХХХХХХХХ```

Сохраняем вывод в текстовый файл.


Устанавливаем значение переменной, после ввода команды запросит пароль от кошелька - по-умолчанию это ***q542we221***

```export VALIDATOR="$(palomad keys list --list-names | head -n1)"```

создаем yaml файл

```nano ~/.pigeon/config.yaml```

вставляем следующее содержимое:

```loop-timeout: 5s
paloma:
  chain-id: paloma-testnet-6
  call-timeout: 20s
  keyring-dir: ~/.paloma
  keyring-pass-env-name: PASS
  keyring-type: os
  signing-key: ${VALIDATOR}
  base-rpc-url: http://localhost:26657
  gas-adjustment: 1.5
  gas-prices: 0.003ugrain
  account-prefix: paloma
evm:
  eth-main:
    chain-id: 1
    base-rpc-url: https://rpc.ankr.com/eth
    keyring-pass-env-name: PASS2
    signing-key: ${ETH_SIGNING_KEY}
    keyring-dir: ~/.pigeon/keys/evm/eth-main```
    
* пробуем запуститься
```PASS=q542we221 PASS2=q542we221 pigeon start```

Если логи пошли, то останавливаем ctrl+c и запускаем пустив логи в файл:

nohup PASS=q542we221 PASS2=q542we221 pigeon start >pigeon.out 2>pigeon.err </dev/null &
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
