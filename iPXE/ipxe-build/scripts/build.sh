#! /bin/bash
echo "Cloning iPXE source code..."
rm -fr ipxe
git clone git://git.ipxe.org/ipxe.git

echo "Editing branding.h"
sed -i 's/#define\ PRODUCT_NAME\ ""/#define\ PRODUCT_NAME\ "iPXE Custom Build\ project\ by\ mjordan79"/' ipxe/src/config/branding.h
#sed -i 's/#define\ PRODUCT_SHORT_NAME\ "iPXE"/#define\ PRODUCT_SHORT_NAME\ "ipxe-latest"/' ipxe/src/config/branding.h
#sed -i 's/#define\ PRODUCT_URI\ "http:\/\/ipxe.org"/#define\ PRODUCT_URI\ "https:\/\/paypal.me\/sebaxakerhtc"/' ipxe/src/config/branding.h
#sed -i 's/#define\ PRODUCT_TAG_LINE\ "Open\ Source\ Network\ Boot\ Firmware"/#define\ PRODUCT_TAG_LINE\ "by\ mjordan79"/' ipxe/src/config/branding.h

echo "Editing general.h"
sed -i 's/#undef\tDOWNLOAD_PROTO_HTTPS/#define\ DOWNLOAD_PROTO_HTTPS/' ipxe/src/config/general.h
sed -i 's/#undef\tDOWNLOAD_PROTO_FTP/#define\ DOWNLOAD_PROTO_FTP/' ipxe/src/config/general.h
sed -i 's/#undef\tDOWNLOAD_PROTO_NFS/#define\ DOWNLOAD_PROTO_NFS/' ipxe/src/config/general.h
sed -i 's/\/\/#undef\tSANBOOT_PROTO_ISCSI/#define\ SANBOOT_PROTO_ISCSI/' ipxe/src/config/general.h
sed -i 's/\/\/#undef\tSANBOOT_PROTO_HTTP/#define\ SANBOOT_PROTO_HTTP/' ipxe/src/config/general.h
sed -i 's/\/\/#define\tIMAGE_PXE/#define\ IMAGE_PXE/' ipxe/src/config/general.h
sed -i 's/\/\/#define\tIMAGE_SCRIPT/#define\ IMAGE_SCRIPT/' ipxe/src/config/general.h
sed -i 's/\/\/#define\tIMAGE_BZIMAGE/#define\ IMAGE_BZIMAGE/' ipxe/src/config/general.h
sed -i 's/\/\/#define\ DIGEST_CMD/#define\ DIGEST_CMD/' ipxe/src/config/general.h
sed -i 's/\/\/#define\ REBOOT_CMD/#define\ REBOOT_CMD/' ipxe/src/config/general.h
sed -i 's/\/\/#define\ POWEROFF_CMD/#define\ POWEROFF_CMD/' ipxe/src/config/general.h
sed -i 's/\/\/#define\ IMAGE_TRUST_CMD/#define\ IMAGE_TRUST_CMD/' ipxe/src/config/general.h
sed -i 's/\/\/#define\ PING_CMD/#define\ PING_CMD/' ipxe/src/config/general.h
sed -i 's/\/\/#define\ CONSOLE_CMD/#define\ CONSOLE_CMD/' ipxe/src/config/general.h
sed -i 's/\/\/#define\ IPSTAT_CMD/#define\ IPSTAT_CMD/' ipxe/src/config/general.h
sed -i 's/\/\/#define\ CERT_CMD/#define\ CERT_CMD/' ipxe/src/config/general.h

echo "Editing console.h"
sed -i 's/\/\/#undef\tCONSOLE_PCBIOS/#define\ CONSOLE_PCBIOS/' ipxe/src/config/console.h
sed -i 's/\/\/#define\tCONSOLE_FRAMEBUFFER/#define\ CONSOLE_FRAMEBUFFER/' ipxe/src/config/console.h
sed -i 's/\/\/#define\tCONSOLE_DIRECT_VGA/#define\ CONSOLE_DIRECT_VGA/' ipxe/src/config/console.h

echo "Building iPXE ..."
sleep 3
mkdir -p /builtimg/bios
mkdir -p /builtimg/uefi
make -j -C ipxe/src

echo "Adding scripts..."
cp ./Legacy.ipxe ./ipxe/src/
cp ./EFI.ipxe ./ipxe/src/

echo "Creating Legacy BIOS Images..."
sleep 3
make bin/ipxe.iso EMBED=Legacy.ipxe -j -C ipxe/src && mv ipxe/src/bin/ipxe.iso /builtimg/bios
make bin/ipxe.dsk EMBED=Legacy.ipxe -j -C ipxe/src && mv ipxe/src/bin/ipxe.dsk /builtimg/bios
make bin/ipxe.lkrn EMBED=Legacy.ipxe -j -C ipxe/src && mv ipxe/src/bin/ipxe.lkrn /builtimg/bios
make bin/ipxe.usb EMBED=Legacy.ipxe -j -C ipxe/src && mv ipxe/src/bin/ipxe.usb /builtimg/bios
make bin/ipxe.pxe EMBED=Legacy.ipxe -j -C ipxe/src && mv ipxe/src/bin/ipxe.pxe /builtimg/bios
make bin/ipxe.kpxe EMBED=Legacy.ipxe -j -C ipxe/src && mv ipxe/src/bin/ipxe.kpxe /builtimg/bios
make bin/ipxe.kkpxe EMBED=Legacy.ipxe -j -C ipxe/src && mv ipxe/src/bin/ipxe.kkpxe /builtimg/bios
make bin/ipxe.kkkpxe EMBED=Legacy.ipxe -j -C ipxe/src && mv ipxe/src/bin/ipxe.kkkpxe /builtimg/bios
make bin/undionly.kpxe EMBED=Legacy.ipxe -j -C ipxe/src && mv ipxe/src/bin/undionly.kpxe /builtimg/bios

echo "Editing general.h"
sed -i 's/#define\ IMAGE_PXE/\/\/#define\ IMAGE_PXE/' ipxe/src/config/general.h
sed -i 's/#define\ IMAGE_BZIMAGE/\/\/#define\ IMAGE_BZIMAGE/' ipxe/src/config/general.h
sed -i 's/\/\/#define\tIMAGE_EFI/#define\ IMAGE_EFI/' ipxe/src/config/general.h

echo "Editing console.h"
sed -i 's/#define\ CONSOLE_PCBIOS/\/\/#define\ CONSOLE_PCBIOS/' ipxe/src/config/console.h
sed -i 's/\/\/#undef\tCONSOLE_EFI/#define\tCONSOLE_EFI/' ipxe/src/config/console.h

echo "Creating EFI 64 bit Images ..."
sleep 3
make bin-x86_64-efi/ipxe.efi EMBED=EFI.ipxe -j -C ipxe/src && cp ipxe/src/bin-x86_64-efi/ipxe.efi /builtimg/uefi/ipxe-x64.efi
make bin-x86_64-efi/ipxe.usb EMBED=EFI.ipxe -j -C ipxe/src && mv ipxe/src/bin-x86_64-efi/ipxe.usb /builtimg/uefi/ipxe-efi-x64.usb
make bin-x86_64-efi/ipxe.iso EMBED=EFI.ipxe -j -C ipxe/src && mv ipxe/src/bin-x86_64-efi/ipxe.iso /builtimg/uefi/ipxe-efi-x64.iso
make bin-x86_64-efi/snponly.efi EMBED=EFI.ipxe -j -C ipxe/src && cp ipxe/src/bin-x86_64-efi/snponly.efi /builtimg/uefi/snponly-x64.efi

echo "Creating EFI 32 bit Images ..."
sleep 3
make bin-i386-efi/ipxe.efi EMBED=EFI.ipxe -j -C ipxe/src && cp ipxe/src/bin-i386-efi/ipxe.efi /builtimg/uefi/ipxe-x86.efi
make bin-i386-efi/ipxe.usb EMBED=EFI.ipxe -j -C ipxe/src && mv ipxe/src/bin-i386-efi/ipxe.usb /builtimg/uefi/ipxe-efi-x86.usb
make bin-i386-efi/ipxe.iso EMBED=EFI.ipxe -j -C ipxe/src && mv ipxe/src/bin-i386-efi/ipxe.iso /builtimg/uefi/ipxe-efi-x86.iso
make bin-i386-efi/snponly.efi EMBED=EFI.ipxe -j -C ipxe/src && cp ipxe/src/bin-i386-efi/snponly.efi /builtimg/uefi/snponly-x86.efi

echo "Cleaning project"
make clean -j -C ipxe/src
echo "Script completed"

