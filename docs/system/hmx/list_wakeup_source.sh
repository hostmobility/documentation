#!/bin/sh

# Try to shorten a sysfs device path to /sys/bus/*/devices/* if possible
shorten_path() {
    p="$1"

    base="$(basename "$p")"

    if echo "$p" | grep -q "/i2c-"; then
        sp="/sys/bus/i2c/devices/$base"
        [ -d "$sp" ] && echo "$sp" && return
    fi

    if echo "$p" | grep -q "/spi"; then
        sp="/sys/bus/spi/devices/$base"
        [ -d "$sp" ] && echo "$sp" && return
    fi

    if echo "$p" | grep -q "/mmc"; then
        sp="/sys/bus/mmc/devices/$base"
        [ -d "$sp" ] && echo "$sp" && return
    fi

    if echo "$p" | grep -q "/usb"; then
        sp="/sys/bus/usb/devices/$base"
        [ -d "$sp" ] && echo "$sp" && return
    fi

    # fallback to full path
    echo "$p"
}

# Markdown header
echo "| WAKEUP ID | INTERFACE | SET WAKEUP PATH | STATUS | EVENTS | EVENTS PATH |"
echo "|-----------|-------|--------------|--------|--------|-------------|"

for w in /sys/class/wakeup/wakeup*; do
    [ -e "$w" ] || continue

    WAKEUP_ID="$(basename "$w")"
    EVENTS="$(cat "$w/event_count" 2>/dev/null)"
    EVENTS_PATH="$w/event_count"

    RAWPATH="$(readlink -f "$w/device" 2>/dev/null)"

    IFACE="unknown"
    DISABLE_PATH="n/a"
    STATUS="n/a"

    if [ -n "$RAWPATH" ]; then
        DEVICE_PATH="$(shorten_path "$RAWPATH")"

        case "$DEVICE_PATH" in
            /sys/bus/i2c/*) IFACE="i2c" ;;
            /sys/bus/spi/*) IFACE="spi" ;;
            /sys/bus/mmc/*) IFACE="mmc" ;;
            /sys/bus/usb/*) IFACE="usb" ;;
            */gpio*|*/gpio-keys*) IFACE="gpio" ;;
            */rtc*|*/alarmtimer*) IFACE="rtc" ;;
            */platform/*) IFACE="platform" ;;
        esac

        if [ -f "$DEVICE_PATH/power/wakeup" ]; then
            DISABLE_PATH="$DEVICE_PATH/power/wakeup"
            STATUS="$(cat "$DISABLE_PATH" 2>/dev/null)"
        fi
    fi

    echo "| $WAKEUP_ID | $IFACE | $DISABLE_PATH | $STATUS | $EVENTS | $EVENTS_PATH |"
done
