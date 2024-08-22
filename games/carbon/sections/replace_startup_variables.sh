#!/bin/bash

source /helpers/messages.sh

#############################
# REPLACE STARTUP VARIABLES #
#############################

Debug "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
Debug "Запускаю /sections/replace_startup_variables.sh!"

Info "Изменяю переменные запуска..."

# Replace Startup Variables (Keep this here. Important. Forgot exactly what the command does. But here's GPT's interpretation of it)
# https://capture.dropbox.com/amLrR7iuKdJ3kSY6
# Takes the start up command and converts the {{}} into the appropriate bash syntax?
MODIFIED_STARTUP=$(eval echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')
Debug ":/home/container$ ${MODIFIED_STARTUP}"

Success "Переменные были изменены успешно!"
