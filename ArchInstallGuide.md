```shell
#connect wifi
wifi-menu

#check time
timedatectl set-ntp true

#check your disk's type(gpt or uefi)
ls /sys/fireware/efi/efivars

#partition your disk
fdisk -l
cfdisk

#format your partition in diffirent type
#fat32
mkfs.fat -F32 /dev/sda1
#ext4
mkfs.ext4 /dev/sda2
#swap
mkswap /dev/sda3
swapon /dev/sda3

#check your partition
lsblk

#mount your partiton
mount /dev/sda2 /mnt
mkdir /mnt/efi
mount /dev/sda1 /mnt/efi

#change mirror in order to download package quickly
vim /etc/pacman.d/mirrorlist

#install some base package
pacstrap /mnt base linux linux-firmware

#write the information of partition to fstab
genfstab -U /mnt >> /mnt/etc/fstab

#you can check your fstab
less /mnt/etc/fstab

#go into /mnt
arch-chroot /mnt

#change system's zoneinfo
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc

#in order to conveniently edit following configuration,
#we need to download vim or nano etc
pacman -S vim nano

#change local.gen unmark the following configuration.
#I choose the configuration of China, according to your own situation
vim /etc/locale.gen
---
en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
zh_TW.UTF-8 UTF-8
---
locale.gen

#write it
vim /etc/locale.conf
---
LANG=en_US.UTF-8
---

#write your hostname
vim /etc/hostname

---
xuwuruoshui
---

#write your hosts
/etc/hosts
127.0.0.1	localhost
::1		localhost
127.0.1.1	yourhostname.localdomain	yourhostname

#config your password
passwd

#config your linux boot loader with grub
#install os-probe in order to detect other operating system
pacman -S grub efibootmgr os-prober

#'/efi/boot' depends on your ESP
grub-install --target=x86_64-efi --efi-directory=/efi/boot --bootloader-id=GRUB

#generate /boot/grub/grub.cfg
grub-mkconfig -o /boot/grub/grub.cfg

#configure your network connection
pacman -S dhcpcd wpa_supplicant dialog iw netctl

#sign out chroot
exit
umount -R /mnt
reboot

#connect your network
wif-menu

#install sudo
pacman -s sudo
groupadd sudo
useradd -m -G sudo yourname
passwd yourname

#all users enable use sudo,umark the following
export EDITOR=vim
visudo
---
%sudo All=(ALL) All
---
#logout
exit

#login your new user
sudo pacman -S vim
sudo pacman -S xorg xorg-xinit
sudo pacman -S plasma-meta plasma-wayland-session 

#add the configurations of starting up the kde 
vim .xinitrc
exec startplasma-x11
startx

#After the computer starts,add the following configurations to
vim  ~/.bash_profile

---
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
---

# sddm will manage your login'view
vim /etc/sddm.conf.d/kde_settings.conf

---
[Autologin]
Relogin=true
Session=plasma.desktop
User=xuwuruoshui
---

systemctl enable sddm
```
