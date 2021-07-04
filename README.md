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

# Домашнее задание №7

Команды следует запускать из директории packer, так как в нем
предполагается наличие файла ключа `packer_key.json`

Также необходимо создать файл `variables.json` по примеру `variables.json.examples`

## Создание базового образа

```shell
packer build --var-file=variables.json ubuntu16.json
```

### Используя скрипт

```shell
../config-scripts/create-reddit-vm.sh
```

## Создание образа с запущенным приложением

```shell
packer build --var-file=variables.json immutable.json
```

# Домашнее задание №8

Для работы с terraform необходимо перейти в каталог terraform и выполнить

```shell
terraform init
```

Также необходимо создать файл `terraform.tfvars` по примеру `terraform.tfvars.example`

## Описание конфигурации

- `inputs.tf` входные параметры
- `main.tf` конфигурация провиженера и инстансов
- `lb.tf` конфигурация балансировщика
- `outputs.tf` выходные параметры

# Домашнее задание №9

Созданы 2 окружение `stage` и `prod`.

Настроено хранение state в yandex object storage.

Необходимо создать сервисный аккаунт и access key для него.

```shell
yc iam access-key create --service-account-name SERVICE_ACCOUNT_NAME
```

Для инициализации backend необходимо указать реквизиты при запуске `terraform init`

```shell
terraform init -backend-config="access_key=YOUR_ACCESS_KEY" -backend-config="secret_key=YOUR_SECRET_KEY"
```

## Provisioners для app

Добавлены provisioners для app. Так как база данных находится на отдельном инстансе,
необходимо добавить в `puma.service` переменную окружения `DATABASE_URL`.
Для этого в модуле `db` выведена output переменная `internal_ip_address_db` и далее она передается
как входная переменная для модуля `app`. В модуле `app` создается файл `db.env` с нужной
переменной окружения.

Для корректного подключения к базе данных необходимо было поменять конфигурационный файл `mongod.conf`
в образе `reddit-db`. Изначально база данных принимала подключения только на адрес `localhost`.
