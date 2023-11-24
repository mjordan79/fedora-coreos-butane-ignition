FROM debian:12

WORKDIR /ipxe-build

VOLUME /builtimg

ADD scripts/EFI.ipxe /ipxe-build
ADD scripts/Legacy.ipxe /ipxe-build
ADD scripts/build.sh /ipxe-build

RUN apt update -y && apt install -y git gcc make liblzma-dev genisoimage syslinux isolinux

CMD ./build.sh

