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
  - dnsutils
  - transmission-gtk
  - calibre
  - mkvtoolnix-gui
  - gimp
  - krita
  - audacious

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

*Install NordVPN*
```
$ wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
$ sudo apt install ./nordvpn-release_1.0.0_all.deb
$ sudo apt update
$ sudo apt install nordvpn
```

*Login*
```
$ nordvpn login
```

*Update Settings*
```
$ nordvpn set protocol TCP
$ nordvpn set killswitch enabled
```

*Connect - Recommended*
```
$ nordvpn connect
```

*Connect - P2P*
```
$ nordvpn connect P2P
```

*Status*
```
$ nordvpn status
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

*Convert - AAC*
```
$ ffmpeg -i <inputfile> -c:a aac <filename>.m4a
```

Video File Modification
=======================

*Inspect Streams*
```
$ ffprobe -show_streams -i <inputfile>
```

*Inspect Content*
```
$ ffmpeg -i <inputfile>
```

*Convert - All to MKV (H.264/AAC)*

The libx264 encoder with a CRF (Constant Rate Factor) of 17 or 18 will
generate a mostly visually lossless output.
```
$ ffmpeg -i <inputfile> -c:v libx264 -crf 18 -c:a aac <filename>.mkv
```

*Convert - H.264/AAC to MKV (H.264/AAC)*
```
$ ffmpeg -i <inputfile> -c copy <filename>.mkv
```
