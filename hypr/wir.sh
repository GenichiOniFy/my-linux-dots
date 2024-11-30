#!/bin/bash
if output=$(sudo wg show); then
    echo "Команда выполнена успешно"
    if [ -n "$output" ]; then
        echo "Отключение VPN..."
        sudo wg-quick down genichi_server
    else
        echo "Включение VPN..."
        sudo wg-quick up genichi_server
    fi
else
    echo "Что-то не так"
fi
