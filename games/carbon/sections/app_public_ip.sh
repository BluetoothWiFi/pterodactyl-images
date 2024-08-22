#!/bin/bash

source /helpers/messages.sh

########################
#  APP PUBLIC IP FIX   #
########################

Debug "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
Debug "Инициализирую /sections/app_public_ip.sh!"

Info "Настройка айпи-адреса"

# Make internal Docker IP address available to processes.
Debug "Предоставляю доступ другим процессам к внутреннему айпи докера..."
export INTERNAL_IP=`ip route get 1 | awk '{print $(NF-2);exit}'`

# Grab the public IP address of the node
Debug "Получаю публичный айпи ноды сервера"
PUBLIC_IP=$(curl -sS ifconfig.me)

Debug "Внутренний айпи: ${INTERNAL_IP}"
Debug "Публичный айпи: ${PUBLIC_IP}"

# If there is no app public ip set then set it to the public IP address of the node
if [ -z ${APP_PUBLIC_IP} ]; then
    Info "Изменяю APP_PUBLIC_IP на айпи (${PUBLIC_IP}) ноды."
    APP_PUBLIC_IP=${PUBLIC_IP}
# Otherwise the person did set the app public IP, so warn them that this could be dangerous.
else
    Warn "Вы не оставляли переменную APP_PUBLIC_IP пустой.. Будем надяться, что вы знаете что делаете!"
fi

# Display what the App Public IP is set to
Info "Публичный айпи адрес теперь: ${APP_PUBLIC_IP}"

Success "Публичный айпи был успешно установлен и проверен!"
