EFI files for PXE boot comes from the following packages:
syslinux-common, syslinux-efi

The DHCP server comes from the package:
isc-dhcp-server

The TFTP server comes from:
tftpd-hpa

For Ignition injection, we use an NginX server, adding a location block:

location /images {
    autoindex on;
}

for the root dir /var/www/html/images location.
