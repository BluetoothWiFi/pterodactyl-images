#!/bin/bash

source /helpers/messages.sh

########################
# EXTENSION DOWNLOADER #
########################

Debug "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
Debug "Инициалицирую /sections/extension_download.sh!"

Info "Проверка раcширений..."

# Check if any of the extensions variables are set to true
if [ "${RUSTEDIT_EXT}" == "1" ] || [ "${DISCORD_EXT}" == "1" ] || [ "${CHAOS_EXT}" == "1" ] || [ "${NOSTEAM_EXT}" == "1" ]; then
    if [[ "${FRAMEWORK}" != "vanilla" ]]; then
        # Make temp directory
        Debug "Создаю временную дерикторию..."
        mkdir -p /home/container/temp

        # Download RustEdit Extension
        if [ "${RUSTEDIT_EXT}" == "1" ]; then
            Debug "Downloading RustEdit Extension"
            curl -sSL -o /home/container/temp/Oxide.Ext.RustEdit.dll https://github.com/k1lly0u/Oxide.Ext.RustEdit/raw/master/Oxide.Ext.RustEdit.dll
            Success "RustEdit Extention Downloaded!"
        fi

        # Download Discord Extension
        if [ "${DISCORD_EXT}" == "1" ]; then
            Debug "Downloading Discord Extension"
            curl -sSL -o /home/container/temp/Oxide.Ext.Discord.dll https://umod.org/extensions/discord/download
            Success "Discord Extension Downloaded!"
        fi

        # Download Chaos Code Extension
        if [ "${CHAOS_EXT}" == "1" ]; then
            Debug "Downloading Chaos Code Extension"
            curl -sSL -o /home/container/temp/Oxide.Ext.Chaos.dll https://chaoscode.io/oxide/Oxide.Ext.Chaos.dll
            Success "Chaos Code Extension Downloaded!"
        fi

        # Download NoSteam Extension
        if [ "${NOSTEAM_EXT}" == "1" ]; then
            Debug "Загружаю расширение NoSteam by Kaidoz"
            curl -sSL -o /home/container/temp/NoSteam.dll https://github.com/BluetoothWiFi/nosteam/raw/main/NoSteam.dll
            Success "Расширение NoSteam было загружено!"
        fi

        # Handle Move of files based on framework
        files=(/home/container/temp/Oxide.Ext.*.dll)
        if [ ${#files[@]} -gt 0 ]; then
            Info "Укладка расширений по папкам..."
            
            # If the framework is carbon, move it into the modding root folder
            if [[ ${FRAMEWORK} =~ "carbon" ]]; then
                Debug "У Вас выбран Carbon!"
                # Create Carbon Extensions folder in case they want extensions, but also are changing their modding root
                # Prevents this error: mv: target '/home/container/carbon-poop/extensions/' is not a directory
                Debug "Создаю папку /home/container/${MODDING_ROOT}/extensions/"
                mkdir -p "/home/container/${MODDING_ROOT}/extensions/"
                Info "Перемещаю туда файлы..."
                if [ "${RUSTEDIT_EXT}" == "1" ] || [ "${DISCORD_EXT}" == "1" ] || [ "${CHAOS_EXT}" == "1" ]; then
                    mv -v /home/container/temp/Oxide.Ext.*.dll "/home/container/${MODDING_ROOT}/extensions/"
                fi
                if [ "${NOSTEAM_EXT}" == "1" ]; then
                    mv -v /home/container/temp/NoSteam.dll "/home/container/${MODDING_ROOT}/harmony/"
                fi
            fi
            
            # If framework is oxide
            if [[ ${FRAMEWORK} =~ "oxide" ]]; then
                Debug "У Вас выбран Oxide!"
                if [ "${RUSTEDIT_EXT}" == "1" ] || [ "${DISCORD_EXT}" == "1" ] || [ "${CHAOS_EXT}" == "1" ]; then
                    mv -v /home/container/temp/Oxide.Ext.*.dll /home/container/RustDedicated_Data/Managed/
                fi
                if [ "${NOSTEAM_EXT}" == "1" ]; then
                    mv -v /home/container/temp/NoSteam.dll "/home/container/${MODDING_ROOT}/HarmonyMods/"
                fi
            fi

            Success "Файлы были перемещены!"
        else
            Success "Перемещать нечего... Пропускаю..."
        fi

        # Clean up temp folder
        Debug "Очистка временной дериктории"
        rm -rf /home/container/temp
        Debug "Очистка завершена!"
        Success "Все загрузки завершены!"
    else
        Error "Фреймворк ванилла, но вы включили расширения, вы уверены что Вам они нужны?"
    fi
else
    Success "Ни одно расширение не включено, пропускаю этот шаг..."
fi
