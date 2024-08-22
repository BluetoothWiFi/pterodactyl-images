#!/bin/bash

################################
# STEAMCMD DOWNLOAD GAME FILES #
################################
# We need to source this file first before we do any auto update or validation logic

if [ -f /helpers/steamcmd.sh ]; then
  Debug "/helpers/steamcmd.sh найден!"
  # Directly run the script without chmod
  source /helpers/steamcmd.sh
else
  Error "/helpers/steamcmd.sh не существует или не был найден :(" "1"
fi

#######################################################
# CLEAN RUSTDEDICATED_DATA FOLDER OF OXIDE EXTENSIONS #
#######################################################

if [ -f /helpers/clean_rustdedicated.sh ]; then
  Debug "/helpers/clean_rustdedicated.sh найден!"
  # Directly run the script without chmod
  source /helpers/clean_rustdedicated.sh
else
  Error "/helpers/clean_rustdedicated.sh не существует или не был найден :(" "1"
fi

###################################
# HANDLE AUTO UPDATE / VALIDATION #
###################################

source /helpers/messages.sh

Debug "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
Debug "Выполняю /sections/auto_update_validate.sh!"

Info "Обработка автоматического обновления приложения с последующей его проверкой..."

# If the switch is occurring from oxide to rust, we want to validate all the steam files first before
# downloading carbon every time. Force validation. This will remove all references to oxide in the files.
if [[ "${CARBONSWITCH}" == "TRUE" ]]; then
    Info "Обнаружен карбон!"
    Info "Запускаю процесс проверки файлов..."
    # Go to this function
    SteamCMD_Validate
    Clean_RustDedicated
elif [[ "${FRAMEWORK}" == "vanilla" ]]; then
    Info "Обнаружена ванилла!"
    Info "Запускаю процесс проверки файлов..."
    SteamCMD_Validate
    Clean_RustDedicated
elif [[ "${AUTO_UPDATE}" == "1" ]]; then # Else, we're going to handle the auto update. If the auto update is set to true, or is null or doesn't exist
    
    # Check if we're going to validate after updating
    if [ "${VALIDATE}" == "1" ]; then
        # If VALIDATE set to true, validate game server via this function
        SteamCMD_Validate
    else
        # Else don't validate via this function
        SteamCMD_No_Validation
    fi
else
    # Else don't update or validate server
    Warn "Пропускаю обновление сервера, так как была отключена проверка файлов."
fi
