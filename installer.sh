#!/bin/bash


yes |sudo pacman -U linux-lts-5.4.53-1-x86_64.pkg.tar.zst
yes |sudo pacman -U linux-lts-headers-5.4.53-1-x86_64.pkg.tar.zst
sudo grub-mkconfig -o /boot/grub/grub.cfg
yes |sudo pacman -U anbox-image-gapps-rooted-2018.07.19-7-x86_64.pkg.tar.zst
yes |sudo pacman -U anbox-modules-dkms-git-1_r1223.4b8f89b-1-any.pkg.tar.zst
yes |sudo pacman -U anbox-git-1_r1223.4b8f89b-1-x86_64.pkg.tar.zst
sudo mkdir /dev/binder

# enable systemd-networkd
sudo systemctl enable systemd-networkd
# start the services
sudo systemctl start systemd-networkd
# enable anbox-container-manager.service
sudo systemctl enable anbox-container-manager.service
sudo systemctl start anbox-container-manager.service

# create the folder anbox-container-manager.service.d
sudo mkdir -p /etc/systemd/system/anbox-container-manager.d/
# copy enable-anbox-bridge.conf
sudo cp enable-anbox-bridge.conf /etc/systemd/system/anbox-container-manager.d/ 
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo 'After finished, Please Reboot'
echo 'After reboot, you can start Anbox from the application menu'