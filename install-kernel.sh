#!/bin/bash

work_dir=$(pwd)

echo -e "Please give your kernel a name:"
read kernel_name

# install kernel to root after building
sudo make modules_install

# copy kernel image to boot partition
sudo cp -v ${work_dir}/arch/x86_64/boot/bzImage /boot/vmlinuz-${kernel_name}

# create preset file
preset_file=${work_dir}/${kernel_name}.preset

touch ${preset_file}

echo -e "ALL_config=\"/etc/mkinitcpio.conf\"" >> ${preset_file}
echo -e "ALL_kver=\"/boot/vmlinuz-${kernel_name}\"" >> ${preset_file}
echo -e "PRESETS=('default' 'fallback')" >> ${preset_file}
echo -e "default_image=\"/boot/initramfs-${kernel_name}.img\"" >> ${preset_file}
echo -e "fallback_image=\"/boot/initramfs-${kernel_name}-fallback.img\"" >> ${preset_file}
echo -e "fallback_options=\"-S autodetect\"" >> ${preset_file}

sudo mv ${preset_file} /etc/mkinitcpio.d/

# generate initcpio file
sudo mkinitcpio -p ${kernel_name}

# update bootloader
sudo grub-mkconfig -o /boot/grub/grub.cfg

# check if driver not installed
sudo pacman -Qi nvidia-dkms > /dev/null 2>&1

if [ $? > 0 ]; then 
    sudo pacman -Sy nvidia-dkms 
fi

modules_file=/etc/modules-load.d/modules.conf

[[ ! -f ${modules_file} ]] && 
sudo touch ${modules_file} && 
sudo echo -e "nouveau\nloop\nfuse\n" > ${modules_file} ;

[[ -f ${modules_file} ]] &&
cat ${modules_file} | grep nouveau > /dev/null 2>&1 ;

if [ $? == 1 ]; then 
    cp ${modules_file} ${work_dir}
    echo -e "\nnouveau\n" >> ${work_dir}/modules.conf
    sudo mv ${work_dir}/modules.conf /etc/modules-load.d/
else
    echo "config existed"
fi

sudo mkinitcpio -p ${kernel_name}