#!/bin/bash
while true; do
  while true; do
    if [ -n "$(qdbus-qt6 org.kde.klipper /klipper org.kde.klipper.klipper.getClipboardContents)" ]; then
      break
    fi
    sleep 0.5s
  done
  sleep 25s
  qdbus-qt6 org.kde.klipper /klipper org.kde.klipper.klipper.clearClipboardHistory
done
