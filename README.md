# pinephone archliaarch64-builder

Cross build archlinux ARM on other platforms with docker and QEMU.

## Archlinux Packages

- binfmt-qemu-all-arch
- binfmt-qemu-static-all-arch
- qemu-user-static-bin
- docker qemu

## Setup Commands

```
$ docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
$ docker run --rm -t arm64v8/ubuntu uname -a # test that this works
$ docker buildx ls
$ docker buildx create --name aarch64-builder
$ docker buildx use aarch64-builder
$ docker buildx inspect --bootstrap
```

## Build Docker Image

- Create `Dockerfile`
- Build image

```
$ docker buildx build --platform linux/arm64 -t clukawski/archarm-on-mobile-builder:latest
```

## Bulid Raw/Squashfs Disk Image

### WARNING/ACHTUNG

You need `CAP_SYS_ADMIN` for mounting bind mounts/loopback mounts in here, however this is essentially allowing the container root access. **DO NOT RUN THIS SOMEWHERE YOU DON'T TRUST/IN SHARED ENVIRONMENTS.** Don't append --rm if you want to be able to get the pinephone's image out after.


```
# docker run --cap-add=CAP_SYS_ADMIN -t clukawski/archarm-on-mobile-builder-temp:latest bash -c '/opt/arch-pine64-build/build.sh -a aarch64 -d pinephone -u sxmo -h ionosphere --osk-sdl --noconfirm'
# docker cp $

```

Copy out the image from the container, and optionally delete the container.
```
# docker container ls -a 
# docker cp container_name:/opt/arch-pine64-build/build/archlinux-pinephone-$ENV-$DATE .
```
