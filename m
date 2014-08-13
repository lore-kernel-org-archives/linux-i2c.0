From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH v7 0/2] i2c: imx: add DMA support for freescale i2c driver
Date: Wed, 13 Aug 2014 17:46:53 +0800
Message-ID: <1407923215-3749-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, marex@denx.de
Cc: LW@KARO-electronics.de, mark.rutland@arm.com, fugang.duan@freescale.com, shawn.guo@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


Changed in v7:
- when  waiting for transfer complete use schedule() instead of udelay(=
).

Changed in v6:
- changed the inappropriate print message.
- rebase to the latest code.

Changed in v5:
- add "*chan_dev =3D dma->chan_using->device->dev" for code cleanup.
- add the test logs.

Changed in v4:
- cancelled  "i2c_imx->use_dma".
- changed "Dma" to "DMA".
- add Timeout handling  for Transfer complete.

Changed in v3:
- fix a bug when request the dma faild.
- some minor fixes for coding style.
- other minor fixes.

Changed in v2:
- remove has_dma_support property
- unify i2c_imx_dma_rx and i2c_imx_dma_tx
- unify i2c_imx_dma_read and i2c_imx_pio_read
- unify i2c_imx_dma_write and i2c_imx_pio_write

Added in v1:
- Enable dma if it's support dma and transfer size bigger than the thre=
shold.
- Add device tree bindings for i2c eDMA support.
- Add eDMA support for i2c driver.

Test log for imx i2c:=20
8/13/2014

U-Boot 2014.01-00667-g90a68ca (Jul 31 2014 - 16:46:21)=20

CPU: Freescale LayerScape SLS1020, Version: 1.0, (0x87080010)=20
Clock Configuration:=20
CPU0(ARMV7):1000 MHz,=20
Bus:300 MHz, DDR:800 MHz (1600 MT/s data rate),=20
Reset Configuration Word (RCW):=20
00000000: 0608000a 00000000 00000000 00000000=20
00000010: 20000000 00407900 e0025a00 21046000=20
00000020: 00000000 00000000 00000000 00038000=20
00000030: 00000000 881b7540 00000000 00000000=20
Board: LS1021ATWR=20
CPLD: V1.1=20
PCBA: V2.0=20
VBank: 0=20
I2C: ready=20
DRAM: 1 GiB (DDR3, 32-bit, CL=3D10, ECC off)=20
Using SERDES1 Protocol: 32 (0x20)=20
=46lash: 128 MiB=20
MMC: FSL_SDHC: 0=20
EEPROM: Invalid ID (00 00 00 00)=20
Not a microcode=20
In: serial=20
Out: serial=20
Err: serial=20
SATA link 0 timeout.=20
AHCI 0001.0300 1 slots 1 ports ? Gbps 0x1 impl SATA mode=20
flags: 64bit ncq pm clo only pmp fbss pio slum part ccc=20
scanning bus for devices...=20
=46ound 0 device(s).=20
Net: eTSEC1 is in sgmii mode.=20
eTSEC2 is in sgmii mode.=20
eTSEC1 [PRIME], eTSEC2, eTSEC3=20
Hit any key to stop autoboot: 0=20
=3D> run yyboot=20
Speed: 1000, full duplex=20
BOOTP broadcast 1=20
BOOTP broadcast 2=20
BOOTP broadcast 3=20
BOOTP broadcast 4=20
BOOTP broadcast 5=20
*** Unhandled DHCP Option in OFFER/ACK: 44=20
*** Unhandled DHCP Option in OFFER/ACK: 46=20
*** Unhandled DHCP Option in OFFER/ACK: 44=20
*** Unhandled DHCP Option in OFFER/ACK: 46=20
DHCP client bound to address 10.193.20.100=20
Using eTSEC1 device=20
TFTP from server 10.193.20.106; our IP address is 10.193.20.100=20
=46ilename 'yuanyao/uImage.ls1'.=20
Load address: 0x82000000=20
Loading: ##############################################################=
###=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
##########################T T #######################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#############=20
497.1 KiB/s=20
done=20
Bytes transferred =3D 6385952 (617120 hex)=20
Speed: 1000, full duplex=20
Using eTSEC1 device=20
TFTP from server 10.193.20.106; our IP address is 10.193.20.100=20
=46ilename 'yuanyao/ls1021a-twr.dtb'.=20
Load address: 0x8f000000=20
Loading: #####=20
2.1 MiB/s=20
done=20
Bytes transferred =3D 21545 (5429 hex)=20
Speed: 1000, full duplex=20
Using eTSEC1 device=20
TFTP from server 10.193.20.106; our IP address is 10.193.20.100=20
=46ilename 'yuanyao/Ramdisk.uboot'.=20
Load address: 0x88000000=20
Loading: ##############################################################=
###=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#################################################################=20
#####################################=20
2.4 MiB/s=20
done=20
Bytes transferred =3D 19156457 (1244de9 hex)=20
## Booting kernel from Legacy Image at 82000000 ...=20
Image Name: Linux Kernel=20
Image Type: ARM Linux Kernel Image (uncompressed)=20
Data Size: 6385888 Bytes =3D 6.1 MiB=20
Load Address: 80008000=20
Entry Point: 80008000=20
Verifying Checksum ... OK=20
## Loading init Ramdisk from Legacy Image at 88000000 ...=20
Image Name: fsl-image-core-ls1021atwr-201406=20
Image Type: ARM Linux RAMDisk Image (gzip compressed)=20
Data Size: 19156393 Bytes =3D 18.3 MiB=20
Load Address: 00000000=20
Entry Point: 00000000=20
Verifying Checksum ... OK=20
## Flattened Device Tree blob at 8f000000=20
Booting using the fdt blob at 0x8f000000=20
Loading Kernel Image ... OK=20
Loading Ramdisk to bdcf9000, end bef3dda9 ... OK=20
Loading Device Tree to bdcf0000, end bdcf8428 ... OK=20

Starting kernel ...=20

Booting Linux on physical CPU 0xf00=20
Linux version 3.12.0+ (b46683@rock) (gcc version 4.8.3 20131202 (prerel=
ease) (crosstool-NG linaro-1.13.1-4.8-2013.12 - Linaro GCC 2013.11) ) #=
222 SMP Wed Aug 13 16:08:49 CST 2014=20
CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=3D30c73c7d=20
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cach=
e=20
Machine: Freescale Layerscape LS1021A, model: LS1021A TWR Board=20
Memory policy: ECC disabled, Data cache writealloc=20
PERCPU: Embedded 7 pages/cpu @88811000 s7680 r8192 d12800 u32768=20
Built 1 zonelists in Zone order, mobility grouping on. Total pages: 260=
096=20
Kernel command line: root=3D/dev/ram0 rw console=3DttyS0,115200=20
PID hash table entries: 4096 (order: 2, 16384 bytes)=20
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)=20
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)=20
Memory: 1014224K/1048576K available (4463K kernel code, 244K rwdata, 13=
16K rodata, 207K init, 222K bss, 34352K reserved, 0K highmem)=20
Virtual kernel memory layout:=20
vector : 0xffff0000 - 0xffff1000 ( 4 kB)=20
fixmap : 0xfff00000 - 0xfffe0000 ( 896 kB)=20
vmalloc : 0xc0800000 - 0xff000000 (1000 MB)=20
lowmem : 0x80000000 - 0xc0000000 (1024 MB)=20
pkmap : 0x7fe00000 - 0x80000000 ( 2 MB)=20
modules : 0x7f000000 - 0x7fe00000 ( 14 MB)=20
=2Etext : 0x80008000 - 0x805acf74 (5780 kB)=20
=2Einit : 0x805ad000 - 0x805e0e00 ( 208 kB)=20
=2Edata : 0x805e2000 - 0x8061f0d8 ( 245 kB)=20
=2Ebss : 0x8061f0e0 - 0x80656ca8 ( 223 kB)=20
SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, Nodes=3D1=20
Hierarchical RCU implementation.=20
RCU restricting CPUs from NR_CPUS=3D4 to nr_cpu_ids=3D2.=20
NR_IRQS:16 nr_irqs:16 16=20
Architected cp15 timer(s) running at 12.50MHz (phys).=20
Switching to timer-based delay loop=20
sched_clock: ARM arch timer >56 bits at 12500kHz, resolution 80ns=20
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 4294=
967286ms=20
Console: colour dummy device 80x30=20
Calibrating delay loop (skipped), value calculated using timer frequenc=
y.. 25.00 BogoMIPS (lpj=3D125000)=20
pid_max: default: 32768 minimum: 301=20
Mount-cache hash table entries: 512=20
CPU: Testing write buffer coherency: ok=20
CPU0: update cpu_power 1024=20
CPU0: thread -1, cpu 0, socket 15, mpidr 80000f00=20
Setting up static identity map for 0x804619a8 - 0x804619dc=20
CPU1: Booted secondary processor=20
CPU1: update cpu_power 1024=20
CPU1: thread -1, cpu 1, socket 15, mpidr 80000f01=20
Brought up 2 CPUs=20
SMP: Total of 2 processors activated.=20
CPU: All CPU(s) started in HYP mode.=20
CPU: Virtualization extensions available.=20
devtmpfs: initialized=20
VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 5=
=20
NET: Registered protocol family 16=20
DMA: preallocated 256 KiB pool for atomic coherent allocations=20
cpuidle: using governor ladder=20
cpuidle: using governor menu=20
irq: no irq domain found for /soc/uqe@2400000/qeic@80 !=20
irq: no irq domain found for /soc/uqe@2400000/qeic@80 !=20
bio: create slab <bio-0> at 0=20
layerscape-pcie 3400000.pcie: PCI host bridge to bus 0000:00=20
pci_bus 0000:00: root bus resource [bus 00-ff]=20
pci_bus 0000:00: root bus resource [io 0x4010000000-0x401000ffff]=20
pci_bus 0000:00: root bus resource [mem 0x4100000000-0x41ffffffff] (bus=
 address [0x00000000-0xffffffff])=20
PCI: bus0: Fast back to back transfers disabled=20
PCI: bus1: Fast back to back transfers enabled=20
pci 0000:00:00.0: BAR 0: assigned [mem 0x4100000000-0x4100ffffff 64bit]=
=20
pci 0000:00:00.0: BAR 6: assigned [mem 0x4101000000-0x4101ffffff pref]=20
pci 0000:00:00.0: PCI bridge to [bus 01]=20
pci 0000:00:00.0: PCI bridge to [bus 01]=20
layerscape-pcie 3500000.pcie: PCI host bridge to bus 0001:00=20
pci_bus 0001:00: root bus resource [bus 00-ff]=20
pci_bus 0001:00: root bus resource [io 0x4810000000-0x481000ffff] (bus =
address [0x480fff0000-0x480fffffff])=20
pci_bus 0001:00: root bus resource [mem 0x4900000000-0x49ffffffff] (bus=
 address [0x00000000-0xffffffff])=20
PCI: bus0: Fast back to back transfers disabled=20
PCI: bus1: Fast back to back transfers enabled=20
pci 0001:00:00.0: BAR 0: assigned [mem 0x4900000000-0x4900ffffff 64bit]=
=20
pci 0001:00:00.0: BAR 6: assigned [mem 0x4901000000-0x4901ffffff pref]=20
pci 0001:00:00.0: PCI bridge to [bus 01]=20
pci 0000:00:00.0: PCI bridge to [bus 01]=20
pci 0001:00:00.0: PCI bridge to [bus 01]=20
vgaarb: loaded=20
SCSI subsystem initialized=20
usbcore: registered new interface driver usbfs=20
usbcore: registered new interface driver hub=20
usbcore: registered new device driver usb=20
i2c i2c-0: IMX I2C adapter registered=20
i2c i2c-0: using dma0chan16 (tx) and dma0chan17 (rx) for DMA transfers=20
i2c i2c-1: IMX I2C adapter registered=20
i2c i2c-1: using dma0chan18 (tx) and dma0chan19 (rx) for DMA transfers=20
pps_core: LinuxPPS API ver. 1 registered=20
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <g=
iometti@linux.it>=20
PTP clock support registered=20
fsl-ifc 1530000.ifc: Freescale Integrated Flash Controller=20
Switched to clocksource arch_sys_counter=20
NET: Registered protocol family 2=20
TCP established hash table entries: 8192 (order: 4, 65536 bytes)=20
TCP bind hash table entries: 8192 (order: 5, 163840 bytes)=20
TCP: Hash tables configured (established 8192 bind 8192)=20
TCP: reno registered=20
UDP hash table entries: 512 (order: 2, 24576 bytes)=20
UDP-Lite hash table entries: 512 (order: 2, 24576 bytes)=20
NET: Registered protocol family 1=20
RPC: Registered named UNIX socket transport module.=20
RPC: Registered udp transport module.=20
RPC: Registered tcp transport module.=20
RPC: Registered tcp NFSv4.1 backchannel transport module.=20
Trying to unpack rootfs image as initramfs...=20
rootfs image is not initramfs (no cpio magic); looks like an initrd=20
=46reeing initrd memory: 18704K (bdcf9000 - bef3d000)=20
NFS: Registering the id_resolver key type=20
Key type id_resolver registered=20
Key type id_legacy registered=20
jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.=20
msgmni has been set to 2017=20
io scheduler noop registered=20
io scheduler deadline registered=20
io scheduler cfq registered (default)=20
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled=20
21c0500.serial: ttyS0 at MMIO 0x21c0500 (irq =3D 118, base_baud =3D 937=
5000) is a 16550A=20
console [ttyS0] enabled=20
21c0600.serial: ttyS1 at MMIO 0x21c0600 (irq =3D 118, base_baud =3D 937=
5000) is a 16550A=20
of_serial 2402000.ucc: clk or clock-frequency not defined=20
of_serial: probe of 2402000.ucc failed with error -2=20
of_serial 2402200.ucc: clk or clock-frequency not defined=20
of_serial: probe of 2402200.ucc failed with error -2=20
serial: Freescale lpuart driver=20
2950000.serial: ttyLP0 at MMIO 0x2950000 (irq =3D 112, base_baud =3D 62=
50000) is a FSL_LPUART=20
brd: module loaded=20
loop: module loaded=20
60000000.nor: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer I=
D 0x000089 Chip ID 0x00227e=20
Amd/Fujitsu Extended Query Table at 0x0040=20
Amd/Fujitsu Extended Query version 1.3.=20
number of CFI chips: 1=20
4 ofpart partitions found on MTD device 60000000.nor=20
Creating 4 MTD partitions on "60000000.nor":=20
0x000000000000-0x000000020000 : "NOR RCW Image"=20
0x000000020000-0x000000120000 : "NOR DTB Image"=20
0x000000120000-0x000000920000 : "NOR Linux Kernel Image"=20
0x000000920000-0x000003b20000 : "NOR Ramdisk Root File System"=20
6Freescale DSPI master initialized=20
CAN device driver interface=20
flexcan 2a70000.can: device registered (reg_base=3Dc0816000, irq=3D158)=
=20
flexcan 2a80000.can: device registered (reg_base=3Dc0818000, irq=3D159)=
=20
libphy: Freescale PowerQUICC MII Bus: probed=20
fsl-gianfar ethernet.4: enabled errata workarounds, flags: 0x4=20
fsl-gianfar ethernet.4 eth0: mac: 00:e0:0c:bc:e5:60=20
fsl-gianfar ethernet.4 eth0: Running with NAPI enabled=20
fsl-gianfar ethernet.4 eth0: RX BD ring size for Q[0]: 256=20
fsl-gianfar ethernet.4 eth0: TX BD ring size for Q[0]: 256=20
fsl-gianfar ethernet.5: enabled errata workarounds, flags: 0x4=20
fsl-gianfar ethernet.5 eth1: mac: 00:e0:0c:bc:e5:61=20
fsl-gianfar ethernet.5 eth1: Running with NAPI enabled=20
fsl-gianfar ethernet.5 eth1: RX BD ring size for Q[0]: 256=20
fsl-gianfar ethernet.5 eth1: TX BD ring size for Q[0]: 256=20
fsl-gianfar ethernet.6: enabled errata workarounds, flags: 0x4=20
fsl-gianfar ethernet.6 eth2: mac: 00:e0:0c:bc:e5:62=20
fsl-gianfar ethernet.6 eth2: Running with NAPI enabled=20
fsl-gianfar ethernet.6 eth2: RX BD ring size for Q[0]: 256=20
fsl-gianfar ethernet.6 eth2: TX BD ring size for Q[0]: 256=20
pps pps0: new PPS source ptp0=20
e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI=20
e1000: Copyright (c) 1999-2006 Intel Corporation.=20
e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k=20
e1000e: Copyright(c) 1999 - 2013 Intel Corporation.=20
xhci-hcd xhci-hcd.0.auto: xHCI Host Controller=20
xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1=
=20
xhci-hcd xhci-hcd.0.auto: irq 125, io mem 0x03100000=20
hub 1-0:1.0: USB hub found=20
hub 1-0:1.0: 1 port detected=20
xhci-hcd xhci-hcd.0.auto: xHCI Host Controller=20
xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2=
=20
hub 2-0:1.0: USB hub found=20
hub 2-0:1.0: 1 port detected=20
usbcore: registered new interface driver usb-storage=20
mousedev: PS/2 mouse device common for all mice=20
i2c /dev entries driver=20
sdhci: Secure Digital Host Controller Interface driver=20
sdhci: Copyright(c) Pierre Ossman=20
sdhci-pltfm: SDHCI platform and OF driver helper=20
mmc0: SDHCI controller on 1560000.esdhc [1560000.esdhc] using ADMA=20
Value in jrstart addr c0e0005c, value prev 0 new f=20
caam 1700000.crypto: Instantiated RNG4 SH0=20
caam 1700000.crypto: Instantiated RNG4 SH1=20
caam 1700000.crypto: device ID =3D 0x0a140300 (Era 67108864)=20
caam 1700000.crypto: job rings =3D 4, qi =3D 0=20
caam algorithms registered in /proc/crypto=20
caam_jr 1710000.jr: registering rng-caam=20
usbcore: registered new interface driver usbhid=20
usbhid: USB HID core driver=20
TCP: cubic registered=20
Initializing XFRM netlink socket=20
NET: Registered protocol family 10=20
sit: IPv6 over IPv4 tunneling driver=20
NET: Registered protocol family 17=20
NET: Registered protocol family 15=20
can: controller area network core (rev 20120528 abi 9)=20
NET: Registered protocol family 29=20
can: raw protocol (rev 20120528)=20
Key type dns_resolver registered=20
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)=20
RAMDISK: gzip image found at block 0=20
usb 1-1: new high-speed USB device number 2 using xhci-hcd=20
hub 1-1:1.0: USB hub found=20
hub 1-1:1.0: 4 ports detected=20
usb 2-1: new SuperSpeed USB device number 2 using xhci-hcd=20
usb 2-1: Parent hub missing LPM exit latency info. Power management wil=
l be impacted.=20
hub 2-1:1.0: USB hub found=20
hub 2-1:1.0: 4 ports detected=20
VFS: Mounted root (ext2 filesystem) on device 1:0.=20
devtmpfs: mounted=20
=46reeing unused kernel memory: 204K (805ad000 - 805e0000)=20
INIT: version 2.88 booting=20
Starting udev=20
udevd[108]: starting version 182=20
Starting Bootlog daemon: bootlogd.=20
Populating dev cache=20
Configuring network interfaces... IPv6: ADDRCONF(NETDEV_UP): eth0: link=
 is not ready=20
udhcpc (v1.21.1) started=20
Sending discover...=20
libphy: mdio@2d24000:02 - Link is Down=20
Sending discover...=20
libphy: mdio@2d24000:02 - Link is Up - 1000/Full=20
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready=20
Sending discover...=20
Sending select for 10.193.20.100...=20
Lease of 10.193.20.100 obtained, lease time 14400=20
/etc/udhcpc.d/50default: Adding DNS 10.192.130.201=20
/etc/udhcpc.d/50default: Adding DNS 10.211.0.3=20
/etc/udhcpc.d/50default: Adding DNS 10.196.51.200=20
done.=20
net.ipv4.conf.default.rp_filter =3D 1=20
net.ipv4.conf.all.rp_filter =3D 1=20
hwclock: can't open '/dev/misc/rtc': No such file or directory=20
Wed Jun 25 11:59:00 UTC 2014=20
hwclock: can't open '/dev/misc/rtc': No such file or directory=20
Running postinst /etc/rpm-postinsts/100-sysvinit-inittab...=20
Running postinst /etc/rpm-postinsts/101-debianutils...=20
update-rc.d: /etc/init.d/run-postinsts exists during rc.d purge (contin=
uing)=20
Removing any system startup links for run-postinsts ...=20
/etc/rcS.d/S99run-postinsts=20
INIT: Entering runlevel: 5=20
Starting OpenBSD Secure Shell server: sshd=20
generating ssh RSA key...=20
generating ssh ECDSA key...=20
generating ssh DSA key...=20
done.=20
hwclock: can't open '/dev/misc/rtc': No such file or directory=20
Starting network benchmark server: netserver.=20
Starting system log daemon...0=20
Starting kernel log daemon...0=20
Starting internet superserver: xinetd.=20
Stopping Bootlog daemon: bootlogd.=20

Poky (Yocto Project Reference Distro) 1.5 ls1021atwr /dev/ttyS0=20

ls1021atwr login: root=20
root@ls1021atwr:~# i2cdump -y 1 0x52 i=20
0 1 2 3 4 5 6 7 8 9 a b c d e f 0123456789abcdef=20
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
root@ls1021atwr:~# i2cdump -y 1 0x52=20
No size specified (using byte-data access)=20
0 1 2 3 4 5 6 7 8 9 a b c d e f 0123456789abcdef=20
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
root@ls1021atwr:~# i2cset -f -y 1 0x52 0x00 0xa0 0xa1 0xa2 0xa3 0xa4 0x=
a5 0xa6 0xa7 0xa8 0xa9 0xaa 0xab 0xac 0xad 0xae 0xaf i=20
root@ls1021atwr:~# i2cset -f -y 1 0x52 0x10 0xb0 0xb1 0xb2 0xb3 0xb4 0x=
b5 0xb6 0xb7 0xb8 0xb9 0xba 0xbb 0xbc 0xbd 0xbe 0xbf i=20
root@ls1021atwr:~# i2cset -f -y 1 0x52 0x20 0xc0 0xc1 0xc2 0xc3 0xc4 0x=
c5 0xc6 0xc7 0xc8 0xc9 0xca 0xcb 0xcc 0xcd 0xce 0xcf i=20
root@ls1021atwr:~# i2cset -f -y 1 0x52 0x30 0xd0 0xd1 0xd2 0xd3 0xd4 0x=
d5 0xd6 0xd7 0xd8 0xd9 0xda 0xdb 0xdc 0xdd 0xde 0xdf i=20
root@ls1021atwr:~# i2cset -f -y 1 0x52 0x40 0xe0 0xe1 0xe2 0xe3 0xe4 0x=
e5 0xe6 0xe7 0xe8 0xe9 0xea 0xeb 0xec 0xed 0xee 0xef i=20
root@ls1021atwr:~# i2cdump -y 1 0x52 i=20
0 1 2 3 4 5 6 7 8 9 a b c d e f 0123456789abcdef=20
00: a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab ac ad ae af ????????????????=20
10: b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb bc bd be bf ????????????????=20
20: c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb cc cd ce cf ????????????????=20
30: d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 da db dc dd de df ????????????????=20
40: e0 e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb ec ed ee ef ????????????????=20
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
root@ls1021atwr:~# i2cdump -y 1 0x52=20
No size specified (using byte-data access)=20
0 1 2 3 4 5 6 7 8 9 a b c d e f 0123456789abcdef=20
00: a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab ac ad ae af ????????????????=20
10: b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb bc bd be bf ????????????????=20
20: c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb cc cd ce cf ????????????????=20
30: d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 da db dc dd de df ????????????????=20
40: e0 e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb ec ed ee ef ????????????????=20
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................=20
root@ls1021atwr:~#=20
