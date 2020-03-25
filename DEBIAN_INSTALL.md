Setup
=====

```
Configure bootstrap network
$ printf "auto lo\nauto eno0\niface eno0 inet dhcp\n" | \
  sudo tee -a /etc/network/interfaces                     # Configure bootstrap network
$ sudo service networking restart                         # Apply bootstrap network configuration
$ sudo apt update && sudo apt upgrade
$ sudo apt install network-manager
$ printf "auto lo\n" | sudo tee /etc/network/interfaces   # Clear bootstrap network configuration. This allows
						          # network-manager to manage the eno0 interface.
$ sudo service network-manager restart
$ sudo reboot                                             # Verify network configuration
$ sudo apt install <apt_package_list>
$ sudo update-alternatives --set \                        # Apply manual alternatives
  editor /usr/bin/vim.nox
$ sudo update-alternatives --set \
  x-terminal-emulator /usr/bin/kitty
$ sudo systemctl stop mpd && \                            # Stop and disable system mpd
  sudo systemctl disable mpd    
$ systemctl --user mpd start && \                         # Start and enable user mpd
  systemctl --user enable mpd
$ systemctl --user syncthing start && \                   # Start and enable user syncthing
  systemctl --user enable syncthing
$ sudo vim /etc/default/grub                              # Set grub configuration to contents listed below
$ sudo update-grub                                        # Load grub configuration
```

Apt Packages
============
  - network-manager
  - network-manager-openvpn
  - lightdm
  - bspwm (x-window-manager)
  - kitty (x-terminal-emulator)
  - firefox-esr (x-www-browser)
  - vim-nox (editor)
  - rofi
  - neofetch
  - git
  - htop
  - feh
  - ncmpcpp
  - mpd
  - tldr
  - pass
  - pinentry-gtk2
  - flake8
  - isort
  - black
  - curl
  - xdg-utils
  - acpi
  - lm-sensors
  - s-tui
  - pavucontrol
  - tmux
  - libreoffice
  - xfonts-terminus
  - conky
  - mpc
  - webext-browserpass
  - webext-https-everywhere
  - webext-noscript
  - webext-privacy-badger
  - okular
  - mutt
  - inkscape [inkscape-tutorials]
  - w3m
  - pulseaudio
  - syncthing
  - irssi
  - gnome-mpv
  - ffmpeg
  - opus-tools
  - dnsutils
  - transmission-gtk
  - calibre
  - mkvtoolnix-gui
  - gimp

Alternatives
============

*Query*
```
$ update-alternatives --get-selections
```

*Set*
```
$ update-alternatives --config <alternative>
```

Import GPG Key
==============
```
$ mkdir /media/usb
$ mount /dev/sdb1 /media/usb
$ gpg --import /media/usb/PGP/<key_id>.asc
``

Unix Pass
=========
```
$ git clone git@git.jteppinette.com:pass-store.git ~/.password-store 
```

VPN
===

*Retrieve OpenVPN Configuration Files*
```
$ wget https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip
$ unzip ovpn.zip
$ rm ovpn.zip
$ rm -rf ovpn_udp
$ mv ovpn_tcp ~/.config/nordvpn

*Add VPN Connection*

You can use the NordVPN server recommendation service at https://nordvpn.com/servers/tools/
to locate the nearest VPN.

```
$ nmcli connection import type openvpn file ~/.config/nordvpn/<server>.nordvpn.com.tcp
$ nmcli connection modify <server>.nordvpn.com.tcp user <email>
```

*Activate VPN Connection*
```
$ nmcli connection up --ask <server>.nordvpn.com.tcp
Password: <password>
```

*Deactivate VPN Connection*
```
$ nmcli connection down <server>.nordvpn.com.tcp
```

Sensors & Battery
=================

*Print Battery Information*
```
$ acpi
```

*Load Required Sensor Modules*
```
$ sudo sensors-detect
...
$ sensors
```

*Statistics UI*
```
$ s-tui
```

Grub
====

*/etc/default/grub*
```
GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="ro quiet splash loglevel=0 rd.systemd.show_status=quiet rd.udev.log-priority=3 gfxpayload=keep $vt_handoff"
GRUB_CMDLINE_LINUX=""
```

*Music Player*
```
$ ncmpcpp
```

Games
=====
* flare-game

Audio File Modification
=======================

*Convert - OGG Opus*
```
$ ffmpeg -i <inputfile> -c:a libopus <filename>.ogg
```

Video File Modification
=======================

Use the inspect commands below to determine the input bitrate to use
during conversion.

*Inspect Streams*
```
$ ffprobe -show_streams -i <inputfile>
```

Using the input streams bitrate and the table below of bitrate to output size
conversions, a reasonable output bitrate can be determined. However, a good
recommendation for streaming high quality content is 2.5Mbps.

Additional information on bitrates can be found in the
article [What Bitrate Should I Use When Encoding My Video How Do I Optimize My Video For The Web](https://www.ezs3.com/public/What_bitrate_should_I_use_when_encoding_my_video_How_do_I_optimize_my_video_for_the_web.cfm).

Output Size       | Bitrate   | Filesize
------------------|-----------|----------------
320x240           | 400 kbps  | 3MB / minute
480x270           | 700 kbps  | 5MB / minute
1024 x 576        | 1500 kbps | 11MB / minute
1280x720  (720p)  | 2500 kbps | 19MB / minute
1920x1080 (1080p) | 4000 kbps | 30MB / minute

*Convert - All to MKV (VP8/OPUS)*

```
$ ffmpeg -i <inputfile> -c:v vp8 -b:v <video_bitrate> -crf 10 -c:a libopus <outputfile>
```

*Convert - All to MKV (VP8/OPUS) w/ Subtitles*
```
$ ffmpeg -i <inputfile> -i <subtitles_inputfile> -metadata:s:s:0 language=en -c:v vp8 -b:v <video_bitrate> -crf 10 -c:a libopus <outputfile>
```

*Add Subtitles*
```
$ ffmpeg -i <inputfile> -i <subtitles_inputfile> -metadata:s:s:0 language=en -c copy <outputfile>
```
