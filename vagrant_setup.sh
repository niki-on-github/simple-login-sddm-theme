#!/bin/sh

setup_pacman() {
    pacman-key --refresh-keys
    pacman -Sy --noconfirm --needed archlinux-keyring
}

setup_sddm() {
    pacman -S --noconfirm --needed sddm qt5 git
    cp -rfv /vagrant /usr/share/sddm/themes/simple-login
    grep "simple-login" /etc/sddm.conf >/dev/null 2>&1 || echo -e "[Theme]\nCurrent=simple-login" | sudo tee /etc/sddm.conf
    systemctl enable -f sddm
}

# MAIN
setup_pacman
setup_sddm
reboot
