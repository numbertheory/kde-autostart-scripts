## kde-autostart-scripts

Useful scripts I hate having to reinvent. Not just for KDE, but these are all based on Fedora 41, KDE Spin.

### Install

Clone the repo, and then go to the Autostart setting. Click to add a new Login script, and point to the script to get it to run.

This will create a file like this in `~/.config/autostart`: 

```
~/.config/autostart/clear-klipper.sh.desktop
```

Modify this file so that the `Exec` starts with `/bin/bash -c` (see example):

```
[Desktop Entry]
Exec=/bin/bash -c <your-local-path>/clear-klipper.sh
Icon=application-x-shellscript
Name=clear-klipper.sh
Type=Application
X-KDE-AutostartScript=true
```
