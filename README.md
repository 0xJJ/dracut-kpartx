# dracut-kpartx
dracut-kpartx is a dracut module to run `kpartx -u` for selected devices
specified via kernel command line. This will update the in-kernel partition
table for said devices.

## Usage
Activate this module (eg. run dracut with option `-m kpartx`) and add
`rd.kpartx.uuid=${UUID}` to the kernel command line for every devices you want
the partition table to be updated after initial mounting.

## Use Case
Consider you want full this encryption with one LUKS device and several
partitions on it. The standard approach is to have LVM on top of the LUKS
device. But if you want to spare yourself the overhead of LVM, you may treat
the LUKS device like any other hard disk with its one partition table.

The kernel will not recognize the partition table and the partitions on the
loop device on its own. But after a call to `kpartx` everything will work
flawlessly.

Below you find an example setup:
```
$ lsblk
NAME                                             MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
sda                                                8:0    0 100,8G  0 disk  
└─sda1                                             8:1    0 100,8G  0 part  
  └─luks-0d975963-83cd-4b99-bea5-6b1d332e4d0e    254:0    0 100,8G  0 crypt 
    ├─luks-0d975963-83cd-4b99-bea5-6b1d332e4d0e1 254:1    0    60G  0 part  /
    └─luks-0d975963-83cd-4b99-bea5-6b1d332e4d0e2 254:2    0 100,8G  0 part  /home
sdb                                                8:16   1   3,7G  0 disk  
└─sdb1                                             8:17   1   512M  0 part  /boot
```
