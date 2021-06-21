#  Домашнее задание №5

## Подключение по SSH через bastion

```
ssh -J <bastion_user>@<bastion_ip> <host_user>@<host_ip>
```

### Подключение вида ssh someinternalhost

В файл ~/.ssh/config добавляем следующее

```
Host bastion
  user <bastion_user>
  hostname <bastion_ip>

Host someinternalhost
  user <host_user>
  hostname <host_ip>
  ProxyCommand ssh -q -W %h:%p bastion
```

## Настройка VPN сервера

```shell
sudo bash setupvpn.sh
```

### Получение сертификата SSL для web-консоли pritunl

```shell
sudo service pritunl stop
sudo wget https://bootstrap.pypa.io/get-pip.py
sudo python3 -m pip install certbot
sudo certbot certonly --standalone -d 178.154.227.222.sslip.io
sudo service pritunl start
sudo pritunl set app.server_cert "$(sudo cat /etc/letsencrypt/live/178.154.227.222.sslip.io/fullchain.pem)"
sudo pritunl set app.server_key "$(sudo cat /etc/letsencrypt/live/178.154.227.222.sslip.io/privkey.pem)"

```

bastion_IP = 178.154.227.222
someinternalhost_IP = 10.128.0.13

# Домашнее задание №6

## Данные тестового приложения

testapp_IP = 178.154.204.96
testapp_port = 9292

## Пример деплоя приложения

```shell
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=metadata.yaml
```
