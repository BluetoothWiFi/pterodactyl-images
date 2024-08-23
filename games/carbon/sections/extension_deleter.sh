#!/bin/bash

source /helpers/messages.sh

########################
# EXTENSION УДАЛЯТОР #
########################
# Макимально юзелесс, но я думаю что так надо...
Debug "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
Debug "Инициализицирую /sections/extension_deleter.sh!"

Info "Для выключения проверки на отключенные расширения перейдите в Запуск(Startup) -> Проверять отключенные расширения..."

if [ "${CHK_DIS_EXT}" == "1" ]; then
  # Check if any of the extensions variables are set to false
  if [ "${RUSTEDIT_EXT}" == "0" ] || [ "${DISCORD_EXT}" == "0" ] || [ "${CHAOS_EXT}" == "0" ] || [ "${NOSTEAM_EXT}" == "0" ]; then
      if [[ "${FRAMEWORK}" != "vanilla" ]]; then
          Info "Проверка загруженных расширений..."

          # Check RustEdit Extension
          if [ "${RUSTEDIT_EXT}" == "0" ]; then
              if [[ ${FRAMEWORK} =~ "carbon" ]]; then
                if [ -f "/home/container/${MODDING_ROOT}/extensions/Oxide.Ext.RustEdit.dll" ]; then
                  Debug "Отключенное расширение RustEdit было обнаружено. Произвожу демонтаж..."
                  rm "/home/container/${MODDING_ROOT}/extensions/Oxide.Ext.RustEdit.dll"
                  Success "Расширение RustEdit было удалено!"
                fi
              fi
              if [[ ${FRAMEWORK} =~ "oxide" ]]; then
                if [ -f "/home/container/RustDedicated_Data/Managed/Oxide.Ext.RustEdit.dll" ]; then
                  Debug "Отключенное расширение RustEdit было обнаружено в папке. Произвожу демонтаж..."
                  rm "/home/container/RustDedicated_Data/Managed/Oxide.Ext.RustEdit.dll"
                  Success "Расширение RustEdit было удалено!"
                fi
              fi
          fi

          # Check Discord Extension
          if [ "${DISCORD_EXT}" == "0" ]; then
              if [[ ${FRAMEWORK} =~ "carbon" ]]; then
                if [ -f "/home/container/${MODDING_ROOT}/extensions/Oxide.Ext.Discord.dll" ]; then
                  Debug "Отключенное расширение Discord было обнаружено. Произвожу демонтаж..."
                  rm "/home/container/${MODDING_ROOT}/extensions/Oxide.Ext.Discord.dll"
                  Success "Расширение Discord было удалено!"
                fi
              fi
              if [[ ${FRAMEWORK} =~ "oxide" ]]; then
                if [ -f "/home/container/RustDedicated_Data/Managed/Oxide.Ext.Discord.dll" ]; then
                  Debug "Отключенное расширение Discord было обнаружено в папке. Произвожу демонтаж..."
                  rm "/home/container/RustDedicated_Data/Managed/Oxide.Ext.Discord.dll"
                  Success "Расширение Discord было удалено!"
                fi
              fi
          fi

        # Download Chaos Code Extension
          if [ "${CHAOS_EXT}" == "0" ]; then
              if [[ ${FRAMEWORK} =~ "carbon" ]]; then
                if [ -f "/home/container/${MODDING_ROOT}/extensions/Oxide.Ext.Chaos.dll" ]; then
                  Debug "Отключенное расширение Chaos было обнаружено. Произвожу демонтаж..."
                  rm "/home/container/${MODDING_ROOT}/extensions/Oxide.Ext.Chaos.dll"
                  Success "Расширение Chaos было удалено!"
                fi
              fi
              if [[ ${FRAMEWORK} =~ "oxide" ]]; then
                if [ -f "/home/container/RustDedicated_Data/Managed/Oxide.Ext.Chaos.dll" ]; then
                  Debug "Отключенное расширение Chaos было обнаружено в папке. Произвожу демонтаж..."
                  rm "/home/container/RustDedicated_Data/Managed/Oxide.Ext.Chaos.dll"
                  Success "Расширение Chaos было удалено!"
                fi
              fi
          fi

          # Check NoSteam Extension
          if [ "${NOSTEAM_EXT}" == "0" ]; then
              if [[ ${FRAMEWORK} =~ "carbon" ]]; then
                if [ -f "/home/container/${MODDING_ROOT}/harmony/NoSteam.dll" ]; then
                  Debug "Отключенное расширение NoSteam было обнаружено. Произвожу демонтаж..."
                  rm "/home/container/${MODDING_ROOT}/harmony/NoSteam.dll"
                  Success "Расширение NoSteam было удалено!"
                fi
              fi
              if [[ ${FRAMEWORK} =~ "oxide" ]]; then
                if [ -f "/home/container/HarmonyMods/NoSteam.dll" ]; then
                  Debug "Отключенное расширение NoSteam было обнаружено в папке. Произвожу демонтаж..."
                  rm "/home/container/HarmonyMods/NoSteam.dll"
                  Success "Расширение NoSteam было удалено!"
                fi
              fi
          fi
        
          Debug "Очистка завершена!"
          Success "Всё было проверено и очищено!"
      else
          Success "Фреймворк ванилла, удалять нечего :)"
      fi
  else
      Success "Ни одно расширение не выключено, пропускаю этот шаг..."
  fi
else
    Info "Проверка отключена, пропускаю этот шаг..."
fi
  
