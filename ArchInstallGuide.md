# 1. Arch Install Guide
## 1.1 System Install
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

#format your partition
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

#install the base package
pacstrap /mnt base linux linux-firmware

#write the information of partition to fstab
genfstab -U /mnt >> /mnt/etc/fstab

#check your fstab
less /mnt/etc/fstab

#go into /mnt
arch-chroot /mnt

#change system's zoneinfo
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc

#in order to conveniently edit following configuration,
pacman -S vim nano

#change local.gen unmark the following configuration.
#according to your own situation
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
LANG=zh_CN.UTF-8
---

#hostname
vim /etc/hostname
---
xuwuruoshui
---

#hosts
#If the system has a permanent IP address, it should be used instead of 127.0.1.1.
vim /etc/hosts

---
127.0.0.1	localhost
::1		localhost
127.0.1.1	yourhostname.localdomain	yourhostname
---
#config your password
passwd

#config your linux boot loader with grub
#install os-probe in order to detect other operating system
pacman -S grub efibootmgr os-prober

#'/efi/boot' depends on your ESP
grub-install --target=x86_64-efi --efi-directory=/efi/boot --bootloader-id=GRUB

#generate /boot/grub/grub.cfg
grub-mkconfig -o /boot/grub/grub.cfg

#add some net's tools
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
```
## 1.2 Drive
```
#Touch Pad
xf86-input-libinput xf86-input-synaptics 

#normal gpu driver
xf86-video-vesa

#intel
xf86-video-intel

#nvidia
nvidia nvidia-lts nvidia-utils

#bluetooth
bluez
bluez-utils

#scan bluetooth which is alive
modinfo btusb
systemctl enable bluetooth
systemctl start bluetooth

#mount ntfs
ntfs-3g  gvfs-mtp

# hibernate
#append resume=uuid=xxx,xxx is your swap's uuid,you can use 'sudo blkid' to see your uuid
vim /etc/default/grub
---
grub_cmdline_linux_default="quiet intel_pstate=enable resume=uuid=ada344b4-7158-4858-9778-07ba0dcbcf3e"

# update grub
grub-mkconfig -o /boot/grub/grub.cfg
# edit /etc/mkinitcpio.conf,and add 'resume' in hooks
vim /etc/mkinitcpio.conf
hooks="base udev resume autodetect modconf block filesystems keyboard fsck"
# generate initramfs' image
mkinitcpio -p linux

```

## 1.3 KDE Desktop
```
sudo pacman -S xorg xorg-xinit
sudo pacman -S plasma-meta plasma-desktop dolpin krunner partitionmanager konsole ksysguard

#add the configurations of starting up the kde 
vim .xinitrc
exec startplasma-x11

#start plasma
startx

#After the computer starts,add the following configurations to
vim  ~/.bash_profile

---
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
---


#network with gui
systemctl enable networkmanager
systemctl start networkmanager

#login with gui
systemctl enable sddm
systemctl start sddm


# sddm will manage your login'view,if you want to let the user login automatically,config it
vim /etc/sddm.conf.d/kde_settings.conf

---
[autologin]
relogin=true
session=plasma.desktop
user=xuwuruoshui
---
```
# 1.4 Deepin
```
#add xorg
sudo pacman -S xorg  xorg-xinit  lightdm

#set session
vim /etc/lightdm/lightdm.conf
------------------------
greeter-session=lightdm-deepin-greeter  
------------------------

vim ~/.xinitrc
--------------
exec startdde 
--------------

systemctl enable lightdm            
systemctl start lightdm     # 开启桌面 
```

# 2. Software Install

## 2.1 Repository Config
```shell
#mirror
sudo vim /etc/pacman.d/mirrorlist
---
#add your own  mirrolist
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
---
sudo pacman -Syy

#archlinuxcn
sudo vim /etc/pacman.conf
---
[archlinuxcn]
SigLevel = Optional TrustAll
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
---
sudo pacman -Syy
sudo pacman -S archlinux-keyring
```
## 2.2 Normal Software

```shell
# bash自动补全
bash-completion

# 显卡切换
optimus-manager

# 字体
ttf-roboto noto-fonts ttf-dejavu

# 文泉驿
wqy-bitmapfont wqy-microhei wqy-microhei-lite wqy-zenhei

# 思源字体
noto-fonts-cjk adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts

# tim（yay）
deepin-wine-tim

# QQ
qq-linux

# 微信（yay）
deepin-wine-wechat

#截图软件
flameshot-git 

# wps
wps-office

# 谷歌浏览器
google-chrome（安装完后执行 `google-chrome-stable `）

# markdown编辑器
typora yosoro-bin

# 录屏软件 bug:https://www.maartenbaert.be/simplescreenrecorder/troubleshooting/
simplescreenrecorder-wlroots-git

# 百度云
baidunetdisk

# 网易云音乐
netease-cloud-music 

# 装逼神器，打印图标（配置：`$HOME/.config/neofetch/config.conf`）
neofetch 

# 装逼神器，彩虹渐变
lolcat 

#dcok栏
latte-dock

#更换壁纸
variety 

# 全局菜单
libdbusmenu-glib

# 进程管理
net-tools

#更新grub(yay)
update-grub

# u盘刻录工具
etcher

#磁力
motrix

#装比命令行 https://www.jianshu.com/p/869e60e661ff

#zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#修改主题，主题通常在home下隐藏，ctrl+h查看隐藏文件，xxxx这里不要后缀只要名字
nano ~/.zshrc
ZSH_THEME="XXXXXX"

#zsh插件
#高亮
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#自动补全插件
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
sudo gedit ~/.zshrc
在plugins=(git 添加插件), 在其他插件后加一个空格输入zsh-syntax-highlighting和zsh-autosuggestions
source ~/.zshrc 

#fish
fish(https://wiki.archlinux.org/index.php/Fish_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#%E6%8A%8Afish%E8%AE%BE%E4%B8%BA%E9%BB%98%E8%AE%A4shell ) 


#科学上网
electron-ssr
(修改系统代理为自动代理，这里上谷歌找个支持electron-xxx的高速节点，配合谷歌上switchyomega插件
终端加速)
～/.zshrc
---
export http_proxy=http://127.0.0.1:12333
---

#数据库 https://www.jianshu.com/p/12c871f937f7
#报Public Key Retrieval is not allowed错，驱动属性设置为true
mysql

#数据库gui
dbeaver

#java
jdk
#list java version
archlinux-java status
#修改jdk版本
sudo archlinux-java set java-12-jdk

#mongodb（yay）
mongodb-bin
systemctl start mongodb.service
mongo

#redis
redis
systemctl start redis
redis-cli

#wine
#add multilib mirror
vim /etc/pacman.conf
----------
[multilib]
Include = /etc/pacman.d/mirrorlist
----------
#supported i386
vim ~/.zshrc
----------
export WINEPREFIX=$HOME/.config/wine/
export WINEARCH=win32
----------
```

# 2.3 Normal Commond
```shell
# clean the unuseful package
sudo pacman -R $(pacman -Qdtq)
sudo pacman -Scc

# clean the var
sudo journalctl --vacuum-size=50M
```

