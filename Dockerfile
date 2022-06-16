FROM --platform=linux/arm64 agners/archlinuxarm-arm64v8
RUN sed -i -e 's~#IgnorePkg.*~IgnorePkg = filesystem~g' '/etc/pacman.conf'
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm archlinux-keyring
RUN pacman -S --noconfirm git wget libarchive util-linux e2fsprogs arch-install-scripts dosfstools lsof squashfs-tools curl coreutils parted base-devel
WORKDIR /opt/
RUN git clone https://github.com/dreemurrs-embedded/arch-pine64-build
WORKDIR /opt/arch-pine64-build
run echo 'wireplumber' >> ui/sxmo/packages
run echo 'pipewire-jack' >> ui/sxmo/packages
run echo 'noto-fonts' >> ui/sxmo/packages
RUN echo '/opt/arch-pine64-build/build.sh -a aarch64 -d pinephone -u sxmo -h ionosphere --osk-sdl --noconfirm' > /opt/build-pinephone.sh
RUN chmod +x /opt/build-pinephone.sh
