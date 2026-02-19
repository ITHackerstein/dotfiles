# davide's dotfiles

## Steps to install a new system

For now I'm assuming that you are setting up the disk with a boot partition and a root partition divided in four submodules: root, home, nix and swap.

```bash
nix-shell -p btrfs-progs

# Setup the two partitions
sudo fdisk /dev/sdx
# Format and label the two partitions
sudo mkfs.fat -F32 /dev/sdx1
sudo fatlabel /dev/sdx1 NIXBOOT
sudo mkfs.btrfs /dev/sdx2
sudo btrfs filesystem label /dev/sdx2 NIXROOT
# Create the subvolumes
sudo mount /dev/sdx2 /mnt
sudo btrfs subvolume create /mnt/{root,home,nix,swap}
sudo umount /mnt
# Mount everything
sudo mount -o compress=zstd,subvol=root /dev/sdx2 /mnt
sudo mount --mkdir -o compress=zstd,subvol=home /dev/sdx2 /mnt/home
sudo mount --mkdir -o compress=zstd,noatime,subvol=nix /dev/sdx2 /mnt/nix
sudo mount --mkdir -o noatime,subvol=swap /dev/sdx2 /mnt/swap
sudo mount --mkdir /dev/sdx1 /mnt/boot
sudo truncate -s 0 /mnt/swap/swapfile
sudo chmod 0600 /mnt/swap/swapfile
sudo chattr +C /mnt/swap/swapfile
sudo dd if=/dev/zero of=/mnt/swap/swapfile bs=1G count=4 status=progress # Change the block size and count to match the desired swapfile size
sudo mkswap /mnt/swap/swapfile
sudo swapon /mnt/swap/swapfile
```

Now that you have setup the disk you want to clone the dotfiles repository to your desired folder. Right now all of my systems are single-user so for simplicity I place it in `/home/<user>/.dotfiles`.
```bash
sudo mkdir -p /mnt/home/davide
git clone https://github.com/ITHackerstein/dotfiles /mnt/home/davide/.dotfiles
```

Once you've done this make sure to change the `hosts` directory to add the new system and also generate the new hardware configuration.
```bash
sudo nixos-generate-config --root /mnt --show-hardware-config > /path/to/new/host/hardware-configuration.nix
```
Change the file systems to match the options used above and also labels for simplicity.

Finally, you can install the system:
```bash
sudo nixos-install --root /mnt --flake /path/to/dotfiles#new-host
```

Once installed, remember to change the permissions of the dotfiles if you don't want them to be owned by root:
```bash
sudo nixos-enter --root /mnt 'chown -R <user>:users /path/to/dotfiles'
```

And, as a last step, remember to change the password of each user:
```bash
sudo nixos-enter --root /mnt 'passwd <user>'
```

Now you can reboot the system, open a shell for the user and run
```bash
home-manager switch --flake /path/to/dotfiles
```
