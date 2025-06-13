#!/bin/bash

flag="$HOME/.config/waybar/scripts/vpn/flag"
region="$HOME/.config/waybar/scripts/vpn/region"
country="$HOME/.config/waybar/scripts/vpn/country"
VPN_INTERFACE="tun0"

check_internet() {
    ping -c 1 -W 1 8.8.8.8 &> /dev/null
}

if ! check_internet; then
    echo "{\"text\": \"📡: нет соединения\"}"
    echo "0" > "$flag"
    exit 1
fi

# Получаем статус VPN и обновляем кэш регионов
if ip a | grep -q "$VPN_INTERFACE"; then
    if ! grep -q "2" "$flag"; then
        curl -s https://ipapi.co/region -o "$region"
        curl -s https://ipapi.co/country -o "$country"
        echo "2" > "$flag"
    fi
    ICON="🛡️"
else
    if ! grep -q "1" "$flag"; then
        curl -s https://ipapi.co/region -o "$region"
        curl -s https://ipapi.co/country -o "$country"
        echo "1" > "$flag"
    fi
    ICON="🌐"
fi

COUNTRY=$(cat "$country")
REGION=$(cat "$region")
TEXT="$ICON: $COUNTRY $REGION "  # Добавим точки как пробел

# Бегущая строка
scroll_file="/tmp/waybar_vpn_scroll_index"
[[ -f "$scroll_file" ]] || echo 0 > "$scroll_file"
i=$(<"$scroll_file")
i=$(( (i + 1) % ${#TEXT} ))
echo "$i" > "$scroll_file"
SCROLL_TEXT="${TEXT:i}${TEXT:0:i}"

# Обрезаем до 30 символов
echo "{\"text\": \"${SCROLL_TEXT:0:7}\"}"

