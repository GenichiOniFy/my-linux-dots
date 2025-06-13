#!/bin/bash

# Мониторы
PRIMARY="eDP-1"
SECONDARY="HDMI-A-1"

# Проверяем, активен ли вторичный монитор
if [[ $(hyprctl monitors | grep "$SECONDARY") ]]; then
    # Если да, выключаем его и оставляем только основной
    hyprctl keyword monitor "$SECONDARY,preferred,0x0,1"
    hyprctl keyword monitor "$PRIMARY,disable"
else
    # Если нет, включаем оба (или можно настроить иначе)
    hyprctl keyword monitor "$PRIMARY,enable"
fi
