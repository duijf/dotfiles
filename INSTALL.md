# Install instructions for Arch Linux

These are the commands I use to set up Arch Linux. I'm posting them here so I
don't have to figure them out every time.

## Fix entries in the EFI boot menu

```
$ efibootmgr
$ efibootmgr -b 0013 -B
```

## Set up network connectivity

```
$ sudo wifi-menu
$ timedatectl set-ntp true
```

## Partition disks. 

This is our end goal:

```
$ lsblk -f
NAME          FSTYPE      LABEL UUID                                   FSAVAIL FSUSE% MOUNTPOINT
sda                                                                                   
├─sda1        vfat              43BC-1982                                             /boot/efi
└─sda2        crypto_LUKS       8c5b5606-0701-4a05-815c-7b4211998a3f                  
  └─lvm       LVM2_member       xLRScz-lFtV-LTpG-yETK-hrYV-iGXV-0edFui                
    ├─vg-boot ext4              0ae40cb6-e84e-469c-be87-c2ce88f5265e    368.6M    17% /boot
    ├─vg-swap swap        swap  7cde0cde-4c1b-44e9-9494-d6ba5315b9d2                  [SWAP]
    └─vg-root ext4              4d000a96-83b1-4d15-a9aa-7e02592a005c    215.1G     2% /
```

Steps:

```
# Choose GPT as a partition table, remove all existing partitions.
$ cfdisk /dev/sda

# Create base filesystems
$ mkfs.fat /dev/sda1
$ cryptsetup luksFormat --type luks1 /dev/sda2
$ cryptsetup open /dev/sda2 lvm

# Set up LVM related containers
$ pvcreate /dev/mapper/lvm
$ vgcreate vg /dev/mapper/lvm
$ lvcreate -L 500M vg -n boot
$ lvcreate -L 2G vg -n swap
$ lvcreate -l +100%FREE vg -n root

# Create filesystems on LVM devices
$ mkswap -L swap /dev/mapper/vg-swap
$ mkfs.ext4 /dev/mapper/vg-boot
$ mkfs.ext4 /dev/mapper/vg-root
```

## Pacstrap

Mount everything to `/mnt` and call `pacstrap`:

```
$ mount /dev/mapper/vg-root /mnt
$ mkdir /mnt/boot
$ mount /dev/mapper/vg-boot /mnt/boot
$ mkdir /mnt/boot/efi
$ mount /dev/sda1 /mnt/boot/efi
$ pacstrap /mnt base base-devel 
```

Generate `/etc/fstab` and change root to the new system:

```
$ genfstab -U /mnt >> /mnt/etc/fstab
$ arch-chroot /mnt
```

## Basic configuraiton

Set the localtime in software and hardware

```
$ ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime 
$ hwclock --systohc
```

Generate locales

```
# Uncomment `en_US.UTF-8 UTF-8`
$ vi /etc/locale.gen 
$ locale-gen

# Set LANG=en_US.UTF-8
$ vi /etc/locale.conf
```

Hostnames and networking

```
$ echo 'axiom' > /etc/hostname

# Edit `/etc/hosts` to look like this
$ cat /etc/hosts
127.0.0.1 localhost
::1 localhost
127.0.0.1 axiom.localdomain axiom
```

## `mkinitcpio` and bootloaders

I want to type the disk encryption passphrase only once. Therefore, we'll add
a new keyfile for the LUKS encryption.

```
$ dd bs=512 count=4 if=/dev/urandom of=/crypto_keyfile.bin
$ cryptsetup luksAddKey /dev/sda2 /crypto_keyfile.bin

# The permissions need to be tight. Not sure if this should be 400 or 000.
# Try this one first (and edit this file once you find out what it should be).
$ chmod 000 /crypto_keyfile.bin
```

Edit `mkinitcpio.conf` to look like this:

```
MODULES=()
BINARIES=()
FILES=/crypto_keyfile.bin
HOOKS=(base udev autodetect modconf block encrypt lvm2 filesystems keyboard fsck)
```

You can now generate a Linux image for the bootloader

```
$ mkinitcpio -p linux
```

Bootloader and microcode updates:

```
$ pacman -S grub efibootmgr intel-ucode

# Ensure that the grub env var file contains the setting
# for opening LUKS volumes.
$ vi /etc/default/grub
GRUB_ENABLE_CRYPTODISK=y

# Generate the config and install Grub
$ mkdir -p /boot/grub
$ grub-mkconfig -o /boot/grub/grub.cfg
$ grub-install /dev/sda
```

## Final things

```
# Set the root password
$ passwd

# Ensure you can connect to WiFi once rebooted
$ sudo pacman -S wpa_supplicant

$ reboot
```
