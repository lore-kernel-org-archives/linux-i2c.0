From: Andrey Gusev <ronne-cmBhpYW9OiY@public.gmane.org>
Subject: Error ' I2C transfer at 0x48 failed' on 2.6.33
Date: Sat, 27 Feb 2010 00:49:53 +0300
Message-ID: <20100227004953.13369fcd@power-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello all!

Thera are errors in dmeg on 2.6.33:

[    6.259606] PowerMac i2c bus pmu 2 registered
[    6.262123] PowerMac i2c bus pmu 1 registered
[    6.264616] PowerMac i2c bus mac-io 0 registered
[    6.267041] i2c i2c-6: I2C transfer at 0x48 failed, size 0, err -6  =
                         =20
[    6.269629] i2c i2c-6: I2C transfer at 0x49 failed, size 0, err -6  =
                         =20
[    6.272097] i2c i2c-6: I2C transfer at 0x4a failed, size 0, err -6
[    6.274583] i2c i2c-6: I2C transfer at 0x4b failed, size 0, err -6  =
                         =20
[    6.277010] i2c i2c-6: I2C transfer at 0x4c failed, size 0, err -6  =
                         =20
[    6.279436] i2c i2c-6: I2C transfer at 0x4d failed, size 0, err -6  =
                         =20
[    6.281837] i2c i2c-6: I2C transfer at 0x4e failed, size 0, err -6  =
                         =20
[    6.284006] i2c i2c-6: I2C transfer at 0x4f failed, size 0, err -6  =
                         =20
[    6.286140] i2c i2c-6: I2C transfer at 0x2c failed, size 0, err -6
[    6.288253] i2c i2c-6: I2C transfer at 0x2d failed, size 0, err -6
[    6.290353] i2c i2c-6: I2C transfer at 0x2e failed, size 0, err -6  =
                         =20
[    6.292661] i2c i2c-6: I2C transfer at 0x2f failed, size 0, err -6
[    6.294971] PowerMac i2c bus uni-n 1 registered
[    6.297484] i2c i2c-7: I2C transfer at 0x48 failed, size 0, err -6
[    6.300765] DS1775 digital thermometer [@49]
[    6.302772] Temp: 27.0 C  Hyst: 75.0 C  OS: 80.0 C
[    6.305581] ADM1030 fan controller [@2c]                            =
                         =20
[    6.307896] PowerMac i2c bus uni-n 0 registered

Same log on 2.6.32.8:

[    6.252901] PowerMac i2c bus pmu 2 registered
[    6.255852] PowerMac i2c bus pmu 1 registered
[    6.258573] PowerMac i2c bus mac-io 0 registered
[    6.262216] PowerMac i2c bus uni-n 1 registered
[    6.266255] DS1775 digital thermometer [@49]
[    6.268665] Temp: 26.5 C  Hyst: 75.0 C  OS: 80.0 C
[    6.271728] ADM1030 fan controller [@2c]
[    6.274272] PowerMac i2c bus uni-n 0 registered


There is full dmesg:

[    0.000000] Using PowerMac machine description
[    0.000000] Total memory =3D 1536MB; using 4096kB for hash table (at=
 cfc00000)
[    0.000000] Linux version 2.6.33 (andrey@power-debian) (gcc version =
4.4.3 20100108 (prerelease) (Debian 4.4.2-9) ) #8 SMP PREEMPT Thu Feb 2=
5 23:30:24 MSK 2010
[    0.000000] Found initrd at 0xc1b00000:0xc2106c00
[    0.000000] Found UniNorth memory controller & host bridge @ 0xf8000=
000 revision: 0x24
[    0.000000] Mapped at 0xff7c0000
[    0.000000] Found a Keylargo mac-io controller, rev: 3, mapped at 0x=
ff740000
[    0.000000] PowerMac motherboard: PowerMac G4 Windtunnel
[    0.000000] CPU maps initialized for 1 thread per core
[    0.000000]  (thread shift is 0)
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f0000000. Fi=
rmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f0000000  ranges:
[    0.000000]  MEM 0x00000000f1000000..0x00000000f1ffffff -> 0x0000000=
0f1000000=20
[    0.000000]   IO 0x00000000f0000000..0x00000000f07fffff -> 0x0000000=
000000000
[    0.000000]  MEM 0x0000000090000000..0x00000000afffffff -> 0x0000000=
090000000=20
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f2000000. Fi=
rmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f2000000 (primary) ranges:
[    0.000000]  MEM 0x00000000f3000000..0x00000000f3ffffff -> 0x0000000=
0f3000000=20
[    0.000000]   IO 0x00000000f2000000..0x00000000f27fffff -> 0x0000000=
000000000
[    0.000000]  MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000=
080000000=20
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f4000000. Fi=
rmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f4000000  ranges:
[    0.000000]  MEM 0x00000000f5000000..0x00000000f5ffffff -> 0x0000000=
0f5000000=20
[    0.000000]   IO 0x00000000f4000000..0x00000000f47fffff -> 0x0000000=
000000000
[    0.000000] via-pmu: Server Mode is disabled
[    0.000000] PMU driver v2 initialized for Core99, firmware: 0c
[    0.000000] nvram: Checking bank 0...
[    0.000000] nvram: gen0=3D1392, gen1=3D1391
[    0.000000] nvram: Active bank is: 0
[    0.000000] nvram: OF partition at 0x410
[    0.000000] nvram: XP partition at 0x1020
[    0.000000] nvram: NR partition at 0x1120
[    0.000000] Top of RAM: 0x60000000, Total RAM: 0x60000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00030000
[    0.000000]   Normal   0x00030000 -> 0x00030000
[    0.000000]   HighMem  0x00030000 -> 0x00060000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00060000
[    0.000000] On node 0 totalpages: 393216
[    0.000000] free_area_init_node: node 0, pgdat c05121e0, node_mem_ma=
p c05a5000
[    0.000000]   DMA zone: 1536 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 195072 pages, LIFO batch:31
[    0.000000]   HighMem zone: 1536 pages used for memmap
[    0.000000]   HighMem zone: 195072 pages, LIFO batch:31
[    0.000000] PERCPU: Embedded 9 pages/cpu @c11b0000 s15848 r8192 d128=
24 u65536
[    0.000000] pcpu-alloc: s15848 r8192 d12824 u65536 alloc=3D16*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 390144
[    0.000000] Kernel command line: root=3D/dev/mapper/power--group-roo=
t ro=20
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 52428=
8 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 =
bytes)
[    0.000000] High memory: 786432k
[    0.000000] Memory: 1542140k/1572864k available (5052k kernel code, =
29612k reserved, 216k data, 458k bss, 256k init)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffc1000..0xfffff000  : fixmap
[    0.000000]   * 0xff800000..0xffc00000  : highmem PTEs
[    0.000000]   * 0xfdcda000..0xff800000  : early ioremap
[    0.000000]   * 0xf1000000..0xfdcda000  : vmalloc & ioremap
[    0.000000] SLUB: Genslabs=3D13, HWalign=3D32, Order=3D0-3, MinObjec=
ts=3D0, CPUs=3D2, Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:128
[    0.000000] mpic: Setting up MPIC " MPIC 1   " version 1.2 at 800400=
00, max 4 CPUs
[    0.000000] mpic: ISU size: 64, shift: 6, mask: 3f
[    0.000000] mpic: Initializing for 64 sources
[    0.000000] irq: irq 55 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 55
[    0.000000] GMT Delta read from XPRAM: 240 minutes, DST: on
[    0.000000] time_init: decrementer frequency =3D 33.304558 MHz
[    0.000000] time_init: processor frequency   =3D 866.666664 MHz
[    0.000000] clocksource: timebase mult[781a8ad] shift[22] registered
[    0.000000] clockevent: decrementer mult[886a5c3] shift[32] cpu[0]
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled, bootconsole disabled
[    0.000000] irq: irq 22 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 22
[    0.000000] irq: irq 23 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 23
[    0.001335] Mount-cache hash table entries: 512
[    0.001914] device-tree: Duplicate name in /cpus/PowerPC,G4@0/l2-cac=
he, renamed to "l2-cache#1"
[    0.002025] device-tree: Duplicate name in /cpus/PowerPC,G4@0, renam=
ed to "l2-cache#1"
[    0.002173] device-tree: Duplicate name in /cpus/PowerPC,G4@1/l2-cac=
he, renamed to "l2-cache#1"
[    0.002279] device-tree: Duplicate name in /cpus/PowerPC,G4@1, renam=
ed to "l2-cache#1"
[    0.006530] PowerMac SMP probe found 2 cpus
[    0.006628] irq: irq 42 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 42
[    0.006658] KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001=
000
[    0.006681]  channel 0 bus <multibus>
[    0.006694]  channel 1 bus <multibus>
[    0.006722] irq: irq 26 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 26
[    0.006738] KeyWest i2c @0x80018000 irq 26 /pci@f2000000/mac-io@17/i=
2c@18000
[    0.006759]  channel 0 bus <multibus>
[    0.006778] PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000/pmu-i2c
[    0.006796]  channel 1 bus <multibus>
[    0.006809]  channel 2 bus <multibus>
[    0.006834] pmf: no parser for command 17 !
[    0.006897] Processor timebase sync using GPIO 0x73
[    0.006913] mpic: requesting IPIs ...=20
[    0.006930] irq: irq 251 on host /pci@f2000000/mac-io@17/interrupt-c=
ontroller@40000 mapped to virtual irq 123
[    0.006944] irq: irq 252 on host /pci@f2000000/mac-io@17/interrupt-c=
ontroller@40000 mapped to virtual irq 124
[    0.006957] irq: irq 253 on host /pci@f2000000/mac-io@17/interrupt-c=
ontroller@40000 mapped to virtual irq 125
[    0.006969] irq: irq 254 on host /pci@f2000000/mac-io@17/interrupt-c=
ontroller@40000 mapped to virtual irq 126
[    0.006979] CPU0: L2CR is 80080000
[    0.006991] CPU0: L3CR is 8f0b0000
[478142820.421235] CPU1: L2CR was 80000
[478142820.421277] CPU1: L2CR set to 80080000
[478142820.421283] CPU1: L3CR was 0
[478142820.421443] CPU1: L3CR set to 8f0b0000
[    0.014100] Processor 1 found.
[    0.014178] clockevent: decrementer mult[886a5c3] shift[32] cpu[1]
[    0.014236] Brought up 2 CPUs
[    0.016624] NET: Registered protocol family 16
[    0.018729] MPC7450 family performance monitor hardware support regi=
stered
[    0.018793] irq: irq 25 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 25
[    0.018849] irq: irq 47 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 47
[    0.019426] PCI: Probing PCI hardware
[    0.019785] pci 0000:00:10.0: reg 10: [mem 0x91000000-0x91ffffff]
[    0.019798] pci 0000:00:10.0: reg 14: [mem 0x98000000-0x9fffffff pre=
f]
[    0.019810] pci 0000:00:10.0: reg 18: [mem 0x00000000-0x0007ffff pre=
f]
[    0.019833] pci 0000:00:10.0: reg 30: [mem 0x90000000-0x9001ffff pre=
f]
[    0.019935] irq: irq 48 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 48
[    0.020612] pci 0001:10:15.0: reg 10: [mem 0x800c0000-0x800fffff]
[    0.020625] pci 0001:10:15.0: reg 14: [io  0x0410-0x0417]
[    0.020637] pci 0001:10:15.0: reg 18: [io  0x0400-0x0407]
[    0.020680] pci 0001:10:15.0: supports D2
[    0.020712] pci 0001:10:17.0: reg 10: [mem 0x80000000-0x8007ffff]
[    0.020775] pci 0001:10:18.0: reg 10: [mem 0x80081000-0x80081fff]
[    0.020839] pci 0001:10:19.0: reg 10: [mem 0x80080000-0x80080fff]
[    0.020938] irq: irq 58 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 58
[    0.020984] irq: irq 27 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 27
[    0.021026] irq: irq 28 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 28
[    0.022293] pci 0002:20:0d.0: reg 10: [mem 0xf5004000-0xf5007fff]
[    0.022358] pci 0002:20:0e.0: reg 10: [mem 0xf5000000-0xf5000fff]
[    0.022405] pci 0002:20:0e.0: supports D1 D2
[    0.022412] pci 0002:20:0e.0: PME# supported from D0 D1 D2 D3hot
[    0.022421] pci 0002:20:0e.0: PME# disabled
[    0.022450] pci 0002:20:0f.0: reg 10: [mem 0xf5200000-0xf53fffff]
[    0.022480] pci 0002:20:0f.0: reg 30: [mem 0xf5100000-0xf51fffff pre=
f]
[    0.022560] irq: irq 39 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 39
[    0.022593] irq: irq 40 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 40
[    0.022629] irq: irq 41 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 41
[    0.023485] PCI 0001:10 Cannot reserve Legacy IO [io  0x0000-0x0fff]
[    0.023506] pci 0000:00:10.0: BAR 2: assigned [mem 0xf1000000-0xf107=
ffff pref]
[    0.023551] pci 0000:00:10.0: BAR 2: set to [mem 0xf1000000-0xf107ff=
ff pref] (PCI address [0xf1000000-0xf107ffff]
[    0.023590] pci_bus 0000:00: resource 0 [io  0x802000-0x1001fff]
[    0.023598] pci_bus 0000:00: resource 1 [mem 0xf1000000-0xf1ffffff]
[    0.023606] pci_bus 0000:00: resource 2 [mem 0x90000000-0xafffffff]
[    0.023614] pci_bus 0001:10: resource 0 [io  0x0000-0x7fffff]
[    0.023622] pci_bus 0001:10: resource 1 [mem 0xf3000000-0xf3ffffff]
[    0.023629] pci_bus 0001:10: resource 2 [mem 0x80000000-0x8fffffff]
[    0.023638] pci_bus 0002:20: resource 0 [io  0xff7fe000-0xffffdfff]
[    0.023645] pci_bus 0002:20: resource 1 [mem 0xf5000000-0xf5ffffff]
[    0.032304] bio: create slab <bio-0> at 0
[    0.033969] vgaarb: device added: PCI:0000:00:10.0,decodes=3Dio+mem,=
owns=3Dmem,locks=3Dnone
[    0.034035] vgaarb: loaded
[    0.034680] usbcore: registered new interface driver usbfs
[    0.034864] usbcore: registered new interface driver hub
[    0.035104] usbcore: registered new device driver usb
[    0.035592] Advanced Linux Sound Architecture Driver Version 1.0.21.
[    0.036171] Switching to clocksource timebase
[    0.043194] NET: Registered protocol family 2
[    0.043404] IP route cache hash table entries: 32768 (order: 5, 1310=
72 bytes)
[    0.044358] TCP established hash table entries: 131072 (order: 8, 10=
48576 bytes)
[    0.046702] TCP bind hash table entries: 65536 (order: 7, 786432 byt=
es)
[    0.048440] TCP: Hash tables configured (established 131072 bind 655=
36)
[    0.048479] TCP reno registered
[    0.048506] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.048562] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.048923] NET: Registered protocol family 1
[    0.049057] PCI: CLS mismatch (32 !=3D 1020), using 32 bytes
[    0.049279] Trying to unpack rootfs image as initramfs...
[    0.369486] Freeing initrd memory: 6171k freed
[    0.370710] Thermal assist unit not available
[    0.373340] highmem bounce pool size: 64 pages
[    0.385214] msgmni has been set to 1490
[    0.388218] alg: No test for stdrng (krng)
[    0.411794] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
[    0.411877] io scheduler noop registered
[    0.412180] io scheduler cfq registered (default)
[    0.413008] nvidiafb: Device ID: 10de0172=20
[    0.417678] nvidiafb: CRTC0 analog not found
[    0.421676] nvidiafb: CRTC1 analog not found
[    0.498461] i2c i2c-0: unable to read EDID block.
[    0.618461] i2c i2c-0: unable to read EDID block.
[    0.738463] i2c i2c-0: unable to read EDID block.
[    0.996692] nvidiafb: EDID found from BUS2
[    0.996741] nvidiafb: CRTC 1 is currently programmed for DFP
[    0.996763] nvidiafb: Using DFP on CRTC 1
[    0.996780] nvidiafb: Panel size is 1600 x 1200
[    0.996799] nvidiafb: Panel is LVDS
[    0.998421] nvidiafb: Flat panel dithering disabled
[    1.003723] Console: switching to colour frame buffer device 200x75
[    1.008910] nvidiafb: PCI nVidia NV17 framebuffer (32MB @ 0x98000000=
)
[    1.021532] Generic non-volatile memory driver v1.1
[    1.021785] Linux agpgart interface v0.103
[    1.021863] agpgart-uninorth 0000:00:0b.0: Apple UniNorth 2 chipset
[    1.023371] agpgart-uninorth 0000:00:0b.0: configuring for size idx:=
 64
[    1.023625] agpgart-uninorth 0000:00:0b.0: AGP aperture is 256M @ 0x=
0
[    1.023914] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.025358] pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh-XVmvHMARGASRxgTJ+F1o3A@public.gmane.org=
shing.org>)
[    1.025441] ttyPZ0 at MMIO 0x80013020 (irq =3D 22) is a Z85c30 ESCC =
- Serial port
[    1.025707] ttyPZ1 at MMIO 0x80013000 (irq =3D 23) is a Z85c30 ESCC =
- Serial port
[    1.032836] brd: module loaded
[    1.036427] loop: module loaded
[    1.036539] MacIO PCI driver attached to Keylargo chipset
[    1.037660] irq: irq 32 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 32
[    1.038303] irq: irq 19 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 19
[    1.038324] irq: irq 11 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 16
[    1.038607] irq: irq 20 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 20
[    1.038627] irq: irq 12 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 17
[    1.038873] irq: irq 5 on host /pci@f2000000/mac-io@17/interrupt-con=
troller@40000 mapped to virtual irq 18
[    1.038893] irq: irq 6 on host /pci@f2000000/mac-io@17/interrupt-con=
troller@40000 mapped to virtual irq 21
[    1.039179] irq: irq 7 on host /pci@f2000000/mac-io@17/interrupt-con=
troller@40000 mapped to virtual irq 24
[    1.039199] irq: irq 8 on host /pci@f2000000/mac-io@17/interrupt-con=
troller@40000 mapped to virtual irq 29
[    1.040422] Uniform Multi-Platform E-IDE driver
[    1.041027] ide-pmac 0002:20:0d.0: enabling device (0000 -> 0002)
[    2.052701] ide-pmac: Found Apple UniNorth ATA-6 controller (PCI), b=
us ID 3, irq 39
[    2.052790] Probing IDE interface ide0...
[    2.316888] hda: IBM-IC35L060AVVA07-0, ATA DISK drive
[    2.928911] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO=
4
[    2.929085] hda: UDMA/100 mode selected
[    2.929326] ide0 at 0xf210a000-0xf210a070,0xf210a160 on irq 39
[    3.941726] ide-pmac: Found Apple KeyLargo ATA-4 controller (macio),=
 bus ID 2, irq 19
[    3.941809] Probing IDE interface ide1...
[    4.460947] ide1 at 0xf10fc000-0xf10fc070,0xf10fc160 on irq 19
[    5.472746] ide-pmac: Found Apple KeyLargo ATA-3 controller (macio),=
 bus ID 0, irq 20
[    5.472822] Probing IDE interface ide2...
[    5.991968] ide2 at 0xf2102000-0xf2102070,0xf2102160 on irq 20
[    5.992192] ide-gd driver 1.18
[    5.992285] hda: max request size: 128KiB
[    6.005942] hda: 120103200 sectors (61492 MB) w/1863KiB Cache, CHS=3D=
65535/16/63
[    6.006207] hda: cache flushes supported
[    6.006402]  hda: [mac] hda1 hda2 hda3 hda4
[    6.017474] sungem.c:v0.98 8/24/03 David S. Miller (davem-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org=
)
[    6.080150] PHY ID: 2060e1, addr: 0
[    6.081446] eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:93:a=
b:d1:a6
[    6.081509] eth0: Found BCM5421 PHY
[    6.082108] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.082370] ohci_hcd 0001:10:18.0: enabling device (0000 -> 0002)
[    6.082443] ohci_hcd 0001:10:18.0: OHCI Host Controller
[    6.082783] ohci_hcd 0001:10:18.0: new USB bus registered, assigned =
bus number 1
[    6.082898] ohci_hcd 0001:10:18.0: irq 27, io mem 0x80081000
[    6.153669] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[    6.153728] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    6.153795] usb usb1: Product: OHCI Host Controller
[    6.153837] usb usb1: Manufacturer: Linux 2.6.33 ohci_hcd
[    6.153881] usb usb1: SerialNumber: 0001:10:18.0
[    6.154388] hub 1-0:1.0: USB hub found
[    6.154446] hub 1-0:1.0: 2 ports detected
[    6.154630] ohci_hcd 0001:10:19.0: enabling device (0000 -> 0002)
[    6.156831] ohci_hcd 0001:10:19.0: OHCI Host Controller
[    6.159203] ohci_hcd 0001:10:19.0: new USB bus registered, assigned =
bus number 2
[    6.161380] ohci_hcd 0001:10:19.0: irq 28, io mem 0x80080000
[    6.233648] usb usb2: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[    6.235760] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    6.237855] usb usb2: Product: OHCI Host Controller
[    6.239939] usb usb2: Manufacturer: Linux 2.6.33 ohci_hcd
[    6.242020] usb usb2: SerialNumber: 0001:10:19.0
[    6.244567] hub 2-0:1.0: USB hub found
[    6.246675] hub 2-0:1.0: 2 ports detected
[    6.249034] uhci_hcd: USB Universal Host Controller Interface driver
[    6.251554] mice: PS/2 mouse device common for all mice
[    6.253924] rtc-generic rtc-generic: rtc core: registered rtc-generi=
c as rtc0
[    6.256246] i2c /dev entries driver
[    6.259606] PowerMac i2c bus pmu 2 registered
[    6.262123] PowerMac i2c bus pmu 1 registered
[    6.264616] PowerMac i2c bus mac-io 0 registered
[    6.267041] i2c i2c-6: I2C transfer at 0x48 failed, size 0, err -6
[    6.269629] i2c i2c-6: I2C transfer at 0x49 failed, size 0, err -6
[    6.272097] i2c i2c-6: I2C transfer at 0x4a failed, size 0, err -6
[    6.274583] i2c i2c-6: I2C transfer at 0x4b failed, size 0, err -6
[    6.277010] i2c i2c-6: I2C transfer at 0x4c failed, size 0, err -6
[    6.279436] i2c i2c-6: I2C transfer at 0x4d failed, size 0, err -6
[    6.281837] i2c i2c-6: I2C transfer at 0x4e failed, size 0, err -6
[    6.284006] i2c i2c-6: I2C transfer at 0x4f failed, size 0, err -6
[    6.286140] i2c i2c-6: I2C transfer at 0x2c failed, size 0, err -6
[    6.288253] i2c i2c-6: I2C transfer at 0x2d failed, size 0, err -6
[    6.290353] i2c i2c-6: I2C transfer at 0x2e failed, size 0, err -6
[    6.292661] i2c i2c-6: I2C transfer at 0x2f failed, size 0, err -6
[    6.294971] PowerMac i2c bus uni-n 1 registered
[    6.297484] i2c i2c-7: I2C transfer at 0x48 failed, size 0, err -6
[    6.300765] DS1775 digital thermometer [@49]
[    6.302772] Temp: 27.0 C  Hyst: 75.0 C  OS: 80.0 C
[    6.305581] ADM1030 fan controller [@2c]
[    6.307896] PowerMac i2c bus uni-n 0 registered
[    6.310514] device-mapper: ioctl: 4.16.0-ioctl (2009-11-05) initiali=
sed: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    6.313537] Reducing overheating limit to 75.0 C (Hyst: 70.0 C)
[    6.319704] usbcore: registered new interface driver hiddev
[    6.322145] usbcore: registered new interface driver usbhid
[    6.324156] usbhid: USB HID core driver
[    6.326130] ALSA device list:
[    6.328079]   No soundcards found.
[    6.331110] TCP cubic registered
[    6.333058] NET: Registered protocol family 17
[    6.335615] registered taskstats version 1
[    6.338121] input: PMU as /devices/virtual/input/input0
[    6.340494] rtc-generic rtc-generic: setting system clock to 2010-02=
-26 18:36:50 UTC (1267209410)
[    6.342453] Freeing unused kernel memory: 256k init
[    6.468525] usb 1-1: new low speed USB device using ohci_hcd and add=
ress 2
[    6.611817] usb 1-1: New USB device found, idVendor=3D0458, idProduc=
t=3D002e
[    6.613917] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    6.615903] usb 1-1: Product: NetScroll+ Traveler
[    6.618143] usb 1-1: Manufacturer: KYE
[    6.632922] input: KYE NetScroll+ Traveler as /devices/pci0001:10/00=
01:10:18.0/usb1/1-1/1-1:1.0/input/input1
[    6.635562] generic-usb 0003:0458:002E.0001: input,hidraw0: USB HID =
v1.10 Mouse [KYE NetScroll+ Traveler] on usb-0001:10:18.0-1/input0
[    6.750868] usb 2-1: new full speed USB device using ohci_hcd and ad=
dress 2
[    6.888872] usb 2-1: New USB device found, idVendor=3D05e3, idProduc=
t=3D0608
[    6.891102] usb 2-1: New USB device strings: Mfr=3D0, Product=3D1, S=
erialNumber=3D0
[    6.893150] usb 2-1: Product: USB2.0 Hub
[    6.916194] hub 2-1:1.0: USB hub found
[    6.919564] hub 2-1:1.0: 4 ports detected
[    6.952135] firewire_ohci 0002:20:0e.0: enabling device (0000 -> 000=
2)
[    7.010527] firewire_ohci: Added fw-ohci device 0002:20:0e.0, OHCI v=
ersion 1.10
[    7.067274] au8830 0001:10:15.0: enabling device (0004 -> 0007)
[    7.069535] Vortex: init....=20
[    7.218819] usb 2-1.1: new full speed USB device using ohci_hcd and =
address 3
[    7.313805] usb 2-1.1: New USB device found, idVendor=3D05e3, idProd=
uct=3D0608
[    7.316143] usb 2-1.1: New USB device strings: Mfr=3D0, Product=3D1,=
 SerialNumber=3D0
[    7.318249] usb 2-1.1: Product: USB2.0 Hub
[    7.322164] hub 2-1.1:1.0: USB hub found
[    7.326545] hub 2-1.1:1.0: 4 ports detected
[    7.397963] done.
[    7.408782] usb 2-1.2: new low speed USB device using ohci_hcd and a=
ddress 4
[    7.511060] firewire_core: created device fw0: GUID 000393fffeabd1a6=
, S400
[    7.517828] usb 2-1.2: New USB device found, idVendor=3D04d9, idProd=
uct=3D0022
[    7.520165] usb 2-1.2: New USB device strings: Mfr=3D0, Product=3D2,=
 SerialNumber=3D0
[    7.522427] usb 2-1.2: Product: USB Keyboard
[    7.538196] input: USB Keyboard as /devices/pci0001:10/0001:10:19.0/=
usb2/2-1/2-1.2/2-1.2:1.0/input/input2
[    7.541056] generic-usb 0003:04D9:0022.0002: input,hidraw1: USB HID =
v1.10 Keyboard [USB Keyboard] on usb-0001:10:19.0-1.2/input0
[    7.568949] input: USB Keyboard as /devices/pci0001:10/0001:10:19.0/=
usb2/2-1/2-1.2/2-1.2:1.1/input/input3
[    7.571682] generic-usb 0003:04D9:0022.0003: input,hidraw2: USB HID =
v1.10 Device [USB Keyboard] on usb-0001:10:19.0-1.2/input1
[    7.645799] usb 2-1.1.4: new low speed USB device using ohci_hcd and=
 address 5
[    7.745813] usb 2-1.1.4: New USB device found, idVendor=3D0766, idPr=
oduct=3D0204
[    7.748361] usb 2-1.1.4: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D0
[    7.750866] usb 2-1.1.4: Product: USB IR Combo Device=20
[    7.753489] usb 2-1.1.4: Manufacturer: TopSeed Tech Corp.
[    7.770234] input: TopSeed Tech Corp. USB IR Combo Device  as /devic=
es/pci0001:10/0001:10:19.0/usb2/2-1/2-1.1/2-1.1.4/2-1.1.4:1.0/input/inp=
ut4
[    7.773340] topseed 0003:0766:0204.0004: input,hidraw3: USB HID v1.0=
0 Keyboard [TopSeed Tech Corp. USB IR Combo Device ] on usb-0001:10:19.=
0-1.1.4/input0
[    7.790595] input: TopSeed Tech Corp. USB IR Combo Device  as /devic=
es/pci0001:10/0001:10:19.0/usb2/2-1/2-1.1/2-1.1.4/2-1.1.4:1.1/input/inp=
ut5
[    7.794365] topseed 0003:0766:0204.0005: input,hiddev0,hidraw4: USB =
HID v1.00 Mouse [TopSeed Tech Corp. USB IR Combo Device ] on usb-0001:1=
0:19.0-1.1.4/input1
[    8.481173] eth0: Link is up at 100 Mbps, full-duplex.
[   14.318113] CPU-temp: 28.4 C, Case: 23.1 C,  Fan: 0 (tuned -11)
[   72.787245] kjournald starting.  Commit interval 5 seconds
[   72.787277] EXT3-fs (dm-1): mounted filesystem with writeback data m=
ode
[   75.397357] udev: starting version 151
[   78.279801] EXT3-fs (dm-1): using internal journal
[   78.757027] SCSI subsystem initialized
[   78.895081] irq: irq 1 on host /pci@f2000000/mac-io@17/interrupt-con=
troller@40000 mapped to virtual irq 30
[   78.895147] irq: irq 2 on host /pci@f2000000/mac-io@17/interrupt-con=
troller@40000 mapped to virtual irq 31
[   78.904795] irq: irq 61 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 61
[   78.904829] irq: irq 60 on host /pci@f2000000/mac-io@17/interrupt-co=
ntroller@40000 mapped to virtual irq 60
[   79.357614] input: PowerMac Beep as /devices/pci0001:10/0001:10:17.0=
/input/input6
[   81.315598] kjournald starting.  Commit interval 5 seconds
[   81.316041] EXT3-fs (dm-3): using internal journal
[   81.316068] EXT3-fs (dm-3): mounted filesystem with writeback data m=
ode
[   81.349079] REISERFS (device dm-4): found reiserfs format "3.6" with=
 standard journal
[   81.354555] REISERFS (device dm-4): using ordered data mode
[   81.371434] REISERFS (device dm-4): journal params: device dm-4, siz=
e 8192, journal first block 18, max trans len 1024, max batch 900, max =
commit age 30, max trans age 30
[   81.379302] REISERFS (device dm-4): checking transaction log (dm-4)
[   81.421064] REISERFS (device dm-4): Using r5 hash to sort names
[   81.511192] Adding 1048568k swap on /dev/mapper/power--group-swap_1.=
  Priority:-1 extents:1 across:1048568k=20
[   84.616253] fuse init (API version 7.13)
[   85.790696] eth0: Link is up at 100 Mbps, full-duplex.
[   85.790901] eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632=
)

More information about kernel:

andrey@power-debian:~/tmp$ cat /proc/version=20
Linux version 2.6.33 (andrey@power-debian) (gcc version 4.4.3 20100108
(prerelease) (Debian 4.4.2-9) ) #8 SMP PREEMPT Thu Feb 25 23:30:24 MSK =
2010

=2Econfig file:

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.33
# Thu Feb 25 22:52:26 2010
#
# CONFIG_PPC64 is not set

#
# Processor support
#
CONFIG_PPC_BOOK3S_32=3Dy
# CONFIG_PPC_85xx is not set
# CONFIG_PPC_8xx is not set
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_E200 is not set
CONFIG_PPC_BOOK3S=3Dy
CONFIG_6xx=3Dy
CONFIG_PPC_FPU=3Dy
CONFIG_ALTIVEC=3Dy
CONFIG_PPC_STD_MMU=3Dy
CONFIG_PPC_STD_MMU_32=3Dy
# CONFIG_PPC_MM_SLICES is not set
CONFIG_PPC_HAVE_PMU_SUPPORT=3Dy
CONFIG_PPC_PERF_CTRS=3Dy
CONFIG_SMP=3Dy
CONFIG_NR_CPUS=3D2
CONFIG_PPC32=3Dy
CONFIG_WORD_SIZE=3D32
# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
CONFIG_MMU=3Dy
CONFIG_GENERIC_CMOS_UPDATE=3Dy
CONFIG_GENERIC_TIME=3Dy
CONFIG_GENERIC_TIME_VSYSCALL=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=3Dy
# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
# CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK is not set
CONFIG_IRQ_PER_CPU=3Dy
CONFIG_NR_IRQS=3D128
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_LOCKBREAK=3Dy
CONFIG_ARCH_HAS_ILOG2_U32=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_GENERIC_FIND_NEXT_BIT=3Dy
# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
CONFIG_PPC=3Dy
CONFIG_EARLY_PRINTK=3Dy
CONFIG_GENERIC_NVRAM=3Dy
CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_PPC_OF=3Dy
CONFIG_OF=3Dy
CONFIG_PPC_UDBG_16550=3Dy
CONFIG_GENERIC_TBSYNC=3Dy
CONFIG_AUDIT_ARCH=3Dy
CONFIG_GENERIC_BUG=3Dy
CONFIG_DTC=3Dy
# CONFIG_DEFAULT_UIMAGE is not set
CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
# CONFIG_PPC_DCR_NATIVE is not set
# CONFIG_PPC_DCR_MMIO is not set
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
CONFIG_CONSTRUCTORS=3Dy

#
# General setup
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_LOCK_KERNEL=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32
CONFIG_LOCALVERSION=3D""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_SYSVIPC_SYSCTL=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_BSD_PROCESS_ACCT_V3=3Dy
CONFIG_TASKSTATS=3Dy
CONFIG_TASK_DELAY_ACCT=3Dy
CONFIG_TASK_XACCT=3Dy
CONFIG_TASK_IO_ACCOUNTING=3Dy
# CONFIG_AUDIT is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=3Dy
# CONFIG_TREE_PREEMPT_RCU is not set
# CONFIG_TINY_RCU is not set
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_FANOUT=3D32
# CONFIG_RCU_FANOUT_EXACT is not set
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
CONFIG_LOG_BUF_SHIFT=3D17
CONFIG_GROUP_SCHED=3Dy
CONFIG_FAIR_GROUP_SCHED=3Dy
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_USER_SCHED=3Dy
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUPS is not set
# CONFIG_SYSFS_DEPRECATED_V2 is not set
# CONFIG_RELAY is not set
CONFIG_NAMESPACES=3Dy
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
# CONFIG_NET_NS is not set
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_RD_GZIP=3Dy
CONFIG_RD_BZIP2=3Dy
CONFIG_RD_LZMA=3Dy
CONFIG_RD_LZO=3Dy
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=3Dy
CONFIG_ANON_INODES=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_SYSCTL_SYSCALL=3Dy
CONFIG_KALLSYMS=3Dy
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_PCSPKR_PLATFORM=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SIGNALFD=3Dy
CONFIG_TIMERFD=3Dy
CONFIG_EVENTFD=3Dy
CONFIG_SHMEM=3Dy
CONFIG_AIO=3Dy
CONFIG_HAVE_PERF_EVENTS=3Dy

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=3Dy
CONFIG_EVENT_PROFILE=3Dy
CONFIG_PERF_COUNTERS=3Dy
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=3Dy
CONFIG_PCI_QUIRKS=3Dy
CONFIG_SLUB_DEBUG=3Dy
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=3Dy
# CONFIG_SLOB is not set
CONFIG_PROFILING=3Dy
CONFIG_TRACEPOINTS=3Dy
CONFIG_OPROFILE=3Dm
CONFIG_HAVE_OPROFILE=3Dy
# CONFIG_KPROBES is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
CONFIG_HAVE_IOREMAP_PROT=3Dy
CONFIG_HAVE_KPROBES=3Dy
CONFIG_HAVE_KRETPROBES=3Dy
CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
CONFIG_HAVE_DMA_ATTRS=3Dy
CONFIG_USE_GENERIC_SMP_HELPERS=3Dy
CONFIG_HAVE_DMA_API_DEBUG=3Dy

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
# CONFIG_SLOW_WORK is not set
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=3Dy
CONFIG_RT_MUTEXES=3Dy
CONFIG_BASE_SMALL=3D0
CONFIG_MODULES=3Dy
CONFIG_MODULE_FORCE_LOAD=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_MODVERSIONS=3Dy
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_STOP_MACHINE=3Dy
CONFIG_BLOCK=3Dy
# CONFIG_LBDAF is not set
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_BLK_DEV_INTEGRITY is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_DEADLINE=3Dm
CONFIG_IOSCHED_CFQ=3Dy
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=3Dy
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"cfq"
# CONFIG_INLINE_SPIN_TRYLOCK is not set
# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
# CONFIG_INLINE_SPIN_LOCK is not set
# CONFIG_INLINE_SPIN_LOCK_BH is not set
# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
# CONFIG_INLINE_SPIN_UNLOCK is not set
# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
# CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set
# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
# CONFIG_INLINE_READ_TRYLOCK is not set
# CONFIG_INLINE_READ_LOCK is not set
# CONFIG_INLINE_READ_LOCK_BH is not set
# CONFIG_INLINE_READ_LOCK_IRQ is not set
# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
# CONFIG_INLINE_READ_UNLOCK is not set
# CONFIG_INLINE_READ_UNLOCK_BH is not set
# CONFIG_INLINE_READ_UNLOCK_IRQ is not set
# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
# CONFIG_INLINE_WRITE_TRYLOCK is not set
# CONFIG_INLINE_WRITE_LOCK is not set
# CONFIG_INLINE_WRITE_LOCK_BH is not set
# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
# CONFIG_INLINE_WRITE_UNLOCK is not set
# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
# CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set
# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
# CONFIG_FREEZER is not set

#
# Platform support
#
CONFIG_PPC_CHRP=3Dy
# CONFIG_MPC5121_ADS is not set
# CONFIG_MPC5121_GENERIC is not set
# CONFIG_PPC_MPC52xx is not set
CONFIG_PPC_PMAC=3Dy
# CONFIG_PPC_CELL is not set
# CONFIG_PPC_CELL_NATIVE is not set
# CONFIG_PPC_82xx is not set
# CONFIG_PQ2ADS is not set
# CONFIG_PPC_83xx is not set
# CONFIG_PPC_86xx is not set
CONFIG_PPC_NATIVE=3Dy
CONFIG_PPC_OF_BOOT_TRAMPOLINE=3Dy
# CONFIG_UDBG_RTAS_CONSOLE is not set
# CONFIG_IPIC is not set
CONFIG_MPIC=3Dy
# CONFIG_MPIC_WEIRD is not set
CONFIG_PPC_I8259=3Dy
CONFIG_PPC_RTAS=3Dy
CONFIG_RTAS_ERROR_LOGGING=3Dy
CONFIG_PPC_RTAS_DAEMON=3Dy
CONFIG_RTAS_PROC=3Dy
# CONFIG_MMIO_NVRAM is not set
CONFIG_PPC_MPC106=3Dy
# CONFIG_PPC_970_NAP is not set
# CONFIG_PPC_INDIRECT_IO is not set
# CONFIG_GENERIC_IOMAP is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_PPC601_SYNC_FIX is not set
CONFIG_TAU=3Dy
# CONFIG_TAU_INT is not set
# CONFIG_TAU_AVERAGE is not set
# CONFIG_FSL_ULI1575 is not set
# CONFIG_SIMPLE_GPIO is not set

#
# Kernel options
#
CONFIG_HIGHMEM=3Dy
CONFIG_TICK_ONESHOT=3Dy
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=3Dy
CONFIG_HZ=3D1000
CONFIG_SCHED_HRTICK=3Dy
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=3Dm
# CONFIG_IOMMU_HELPER is not set
# CONFIG_SWIOTLB is not set
CONFIG_HOTPLUG_CPU=3Dy
CONFIG_ARCH_CPU_PROBE_RELEASE=3Dy
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
CONFIG_ARCH_HAS_WALK_MEMORY=3Dy
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_IRQ_ALL_CPUS=3Dy
# CONFIG_SPARSE_IRQ is not set
CONFIG_MAX_ACTIVE_REGIONS=3D32
CONFIG_ARCH_FLATMEM_ENABLE=3Dy
CONFIG_ARCH_POPULATES_NODE_MAP=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_FLATMEM_MANUAL=3Dy
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
CONFIG_PAGEFLAGS_EXTENDED=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D4
# CONFIG_MIGRATION is not set
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_ZONE_DMA_FLAG=3D1
CONFIG_BOUNCE=3Dy
CONFIG_VIRT_TO_BUS=3Dy
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=3D32768
CONFIG_PPC_4K_PAGES=3Dy
# CONFIG_PPC_16K_PAGES is not set
# CONFIG_PPC_64K_PAGES is not set
# CONFIG_PPC_256K_PAGES is not set
CONFIG_FORCE_MAX_ZONEORDER=3D11
CONFIG_PROC_DEVICETREE=3Dy
# CONFIG_CMDLINE_BOOL is not set
CONFIG_EXTRA_TARGETS=3D""
CONFIG_ARCH_WANTS_FREEZER_CONTROL=3Dy
# CONFIG_PM is not set
CONFIG_SECCOMP=3Dy
CONFIG_ISA_DMA_API=3Dy

#
# Bus options
#
# CONFIG_ISA is not set
CONFIG_ZONE_DMA=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_PPC_INDIRECT_PCI=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_DOMAINS=3Dy
CONFIG_PCI_SYSCALL=3Dy
# CONFIG_PCIEPORTBUS is not set
CONFIG_ARCH_SUPPORTS_MSI=3Dy
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_LEGACY is not set
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_IOV is not set
# CONFIG_PCCARD is not set
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HAS_RAPIDIO is not set

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used
#
CONFIG_LOWMEM_SIZE=3D0x30000000
CONFIG_PAGE_OFFSET=3D0xc0000000
CONFIG_KERNEL_START=3D0xc0000000
CONFIG_PHYSICAL_START=3D0x00000000
CONFIG_TASK_SIZE=3D0xc0000000
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
CONFIG_UNIX=3Dy
CONFIG_XFRM=3Dy
CONFIG_XFRM_USER=3Dm
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=3Dm
CONFIG_NET_KEY=3Dm
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_INET=3Dy
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=3Dy
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_INET_AH=3Dm
CONFIG_INET_ESP=3Dm
CONFIG_INET_IPCOMP=3Dm
CONFIG_INET_XFRM_TUNNEL=3Dm
CONFIG_INET_TUNNEL=3Dm
CONFIG_INET_XFRM_MODE_TRANSPORT=3Dm
CONFIG_INET_XFRM_MODE_TUNNEL=3Dm
CONFIG_INET_XFRM_MODE_BEET=3Dm
CONFIG_INET_LRO=3Dy
CONFIG_INET_DIAG=3Dm
CONFIG_INET_TCP_DIAG=3Dm
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=3Dm
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=3Dy
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
CONFIG_IRDA=3Dm

#
# IrDA protocols
#
# CONFIG_IRLAN is not set
CONFIG_IRCOMM=3Dm
CONFIG_IRDA_ULTRA=3Dy

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=3Dy
CONFIG_IRDA_FAST_RR=3Dy
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=3Dm

#
# Dongle support
#
# CONFIG_DONGLE is not set
CONFIG_KINGSUN_DONGLE=3Dm
CONFIG_KSDAZZLE_DONGLE=3Dm
CONFIG_KS959_DONGLE=3Dm

#
# FIR device drivers
#
CONFIG_USB_IRDA=3Dm
# CONFIG_SIGMATEL_FIR is not set
CONFIG_NSC_FIR=3Dm
CONFIG_WINBOND_FIR=3Dm
# CONFIG_TOSHIBA_FIR is not set
CONFIG_SMC_IRCC_FIR=3Dm
CONFIG_ALI_FIR=3Dm
# CONFIG_VLSI_FIR is not set
CONFIG_VIA_FIR=3Dm
CONFIG_MCS_FIR=3Dm
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
# CONFIG_DEVTMPFS is not set
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dy
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=3D""
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
CONFIG_CONNECTOR=3Dy
CONFIG_PROC_EVENTS=3Dy
# CONFIG_MTD is not set
CONFIG_OF_DEVICE=3Dy
CONFIG_OF_I2C=3Dy
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=3Dy
# CONFIG_BLK_DEV_FD is not set
# CONFIG_MAC_FLOPPY is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dy
CONFIG_BLK_DEV_CRYPTOLOOP=3Dm
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D8192
# CONFIG_BLK_DEV_XIP is not set
CONFIG_CDROM_PKTCDVD=3Dm
CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_MISC_DEVICES is not set
CONFIG_HAVE_IDE=3Dy
CONFIG_IDE=3Dy

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=3Dy
CONFIG_IDE_TIMINGS=3Dy
CONFIG_IDE_ATAPI=3Dy
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=3Dy
CONFIG_IDE_GD_ATA=3Dy
# CONFIG_IDE_GD_ATAPI is not set
CONFIG_BLK_DEV_IDECD=3Dm
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=3Dy
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_PROC_FS=3Dy

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_PLATFORM is not set
CONFIG_BLK_DEV_IDEDMA_SFF=3Dy

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=3Dy
# CONFIG_IDEPCI_PCIBUS_ORDER is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=3Dy
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SL82C105 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set
CONFIG_BLK_DEV_IDE_PMAC=3Dy
CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=3Dm
CONFIG_SCSI_DMA=3Dy
CONFIG_SCSI_TGT=3Dm
# CONFIG_SCSI_NETLINK is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dm
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dm
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dm
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_WAIT_SCAN=3Dm

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
# CONFIG_ATA is not set
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dm
CONFIG_MD_LINEAR=3Dm
CONFIG_MD_RAID0=3Dm
CONFIG_MD_RAID1=3Dm
CONFIG_MD_RAID10=3Dm
CONFIG_MD_RAID456=3Dm
CONFIG_MULTICORE_RAID456=3Dy
CONFIG_MD_RAID6_PQ=3Dm
CONFIG_ASYNC_RAID6_TEST=3Dm
CONFIG_MD_MULTIPATH=3Dm
CONFIG_MD_FAULTY=3Dm
CONFIG_BLK_DEV_DM=3Dy
# CONFIG_DM_DEBUG is not set
CONFIG_DM_CRYPT=3Dy
CONFIG_DM_SNAPSHOT=3Dy
CONFIG_DM_MIRROR=3Dy
# CONFIG_DM_LOG_USERSPACE is not set
CONFIG_DM_ZERO=3Dm
CONFIG_DM_MULTIPATH=3Dm
# CONFIG_DM_MULTIPATH_QL is not set
# CONFIG_DM_MULTIPATH_ST is not set
# CONFIG_DM_DELAY is not set
# CONFIG_DM_UEVENT is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#

#
# You can enable one or both FireWire driver stacks.
#

#
# The newer stack is recommended.
#
CONFIG_FIREWIRE=3Dm
CONFIG_FIREWIRE_OHCI=3Dm
CONFIG_FIREWIRE_OHCI_DEBUG=3Dy
CONFIG_FIREWIRE_SBP2=3Dm
# CONFIG_FIREWIRE_NET is not set
# CONFIG_IEEE1394 is not set
# CONFIG_I2O is not set
CONFIG_MACINTOSH_DRIVERS=3Dy
# CONFIG_ADB is not set
# CONFIG_ADB_CUDA is not set
CONFIG_ADB_PMU=3Dy
# CONFIG_ADB_PMU_LED is not set
# CONFIG_PMAC_MEDIABAY is not set
# CONFIG_PMAC_BACKLIGHT is not set
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_THERM_WINDTUNNEL=3Dy
# CONFIG_THERM_ADT746X is not set
CONFIG_WINDFARM=3Dm
# CONFIG_PMAC_RACKMETER is not set
CONFIG_NETDEVICES=3Dy
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
# CONFIG_ARCNET is not set
# CONFIG_PHYLIB is not set
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dm
# CONFIG_MACE is not set
# CONFIG_BMAC is not set
# CONFIG_HAPPYMEAL is not set
CONFIG_SUNGEM=3Dy
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_ETHOC is not set
# CONFIG_DNET is not set
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
# CONFIG_NET_PCI is not set
# CONFIG_B44 is not set
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_ATL2 is not set
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_NETDEV_1000 is not set
# CONFIG_NETDEV_10000 is not set
# CONFIG_TR is not set
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_VMXNET3 is not set
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=3Dy
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=3Dy
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ATKBD=3Dm
# CONFIG_QT2160 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=3Dy
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_ATI_REMOTE is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_UINPUT=3Dm

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dm
# CONFIG_SERIO_I8042 is not set
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=3Dm
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_XILINX_XPS_PS2 is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_CONSOLE_TRANSLATIONS=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_DEVKMEM=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_SERIAL_8250_PCI=3Dy
CONFIG_SERIAL_8250_NR_UARTS=3D32
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
CONFIG_SERIAL_PMACZILOG=3Dy
# CONFIG_SERIAL_PMACZILOG_TTYS is not set
CONFIG_SERIAL_PMACZILOG_CONSOLE=3Dy
CONFIG_SERIAL_JSM=3Dm
# CONFIG_SERIAL_OF_PLATFORM is not set
# CONFIG_SERIAL_GRLIB_GAISLER_APBUART is not set
CONFIG_UNIX98_PTYS=3Dy
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
# CONFIG_LEGACY_PTYS is not set
# CONFIG_BRIQ_PANEL is not set
# CONFIG_HVC_RTAS is not set
# CONFIG_HVC_UDBG is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=3Dm
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_NVRAM=3Dy
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
CONFIG_DEVPORT=3Dy
CONFIG_I2C=3Dy
CONFIG_I2C_BOARDINFO=3Dy
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=3Dy
CONFIG_I2C_HELPER_AUTO=3Dy
CONFIG_I2C_ALGOBIT=3Dy

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# Mac SMBus host controller drivers
#
# CONFIG_I2C_HYDRA is not set
CONFIG_I2C_POWERMAC=3Dy

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_MPC is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_SIMTEC is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_STUB is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set
# CONFIG_SPI is not set

#
# PPS support
#
# CONFIG_PPS is not set
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=3Dy

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_AB3100_CORE is not set
# CONFIG_MFD_88PM8607 is not set
# CONFIG_REGULATOR is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=3Dy
CONFIG_AGP_UNINORTH=3Dy
CONFIG_VGA_ARB=3Dy
CONFIG_DRM=3Dm
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_VGASTATE=3Dy
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
CONFIG_FB=3Dy
CONFIG_FIRMWARE_EDID=3Dy
CONFIG_FB_DDC=3Dy
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
# CONFIG_FB_SYS_FILLRECT is not set
# CONFIG_FB_SYS_COPYAREA is not set
# CONFIG_FB_SYS_IMAGEBLIT is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_SYS_FOPS is not set
# CONFIG_FB_SVGALIB is not set
CONFIG_FB_MACMODES=3Dy
CONFIG_FB_BACKLIGHT=3Dy
CONFIG_FB_MODE_HELPERS=3Dy
CONFIG_FB_TILEBLITTING=3Dy

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_OF=3Dy
CONFIG_FB_CONTROL=3Dy
CONFIG_FB_PLATINUM=3Dy
CONFIG_FB_VALKYRIE=3Dy
# CONFIG_FB_CT65550 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=3Dy
CONFIG_FB_NVIDIA_I2C=3Dy
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=3Dy
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
CONFIG_LCD_CLASS_DEVICE=3Dm
# CONFIG_LCD_ILI9320 is not set
CONFIG_LCD_PLATFORM=3Dm
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
# CONFIG_BACKLIGHT_GENERIC is not set

#
# Display device support
#
CONFIG_DISPLAY_SUPPORT=3Dm

#
# Display hardware drivers
#

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
CONFIG_LOGO=3Dy
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=3Dy
CONFIG_LOGO_LINUX_CLUT224=3Dy
CONFIG_SOUND=3Dy
CONFIG_SOUND_OSS_CORE=3Dy
CONFIG_SOUND_OSS_CORE_PRECLAIM=3Dy
CONFIG_SND=3Dy
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_SEQUENCER=3Dm
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_PCM_OSS_PLUGINS=3Dy
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_HRTIMER=3Dm
CONFIG_SND_SEQ_HRTIMER_DEFAULT=3Dy
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=3Dy
CONFIG_SND_VERBOSE_PROCFS=3Dy
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=3Dy
CONFIG_SND_RAWMIDI_SEQ=3Dm
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
# CONFIG_SND_EMU10K1_SEQ is not set
CONFIG_SND_MPU401_UART=3Dm
CONFIG_SND_AC97_CODEC=3Dm
CONFIG_SND_DRIVERS=3Dy
# CONFIG_SND_DUMMY is not set
CONFIG_SND_VIRMIDI=3Dm
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_AC97_POWER_SAVE is not set
CONFIG_SND_PCI=3Dy
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
CONFIG_SND_AU8830=3Dm
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_HIFIER is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set
CONFIG_SND_PPC=3Dy
CONFIG_SND_POWERMAC=3Dm
# CONFIG_SND_POWERMAC_AUTO_DRC is not set
CONFIG_SND_AOA=3Dm
CONFIG_SND_AOA_FABRIC_LAYOUT=3Dm
CONFIG_SND_AOA_ONYX=3Dm
CONFIG_SND_AOA_TAS=3Dm
# CONFIG_SND_AOA_TOONIE is not set
CONFIG_SND_AOA_SOUNDBUS=3Dm
CONFIG_SND_AOA_SOUNDBUS_I2S=3Dm
# CONFIG_SND_USB is not set
# CONFIG_SND_SOC is not set
# CONFIG_SOUND_PRIME is not set
CONFIG_AC97_BUS=3Dm
CONFIG_HID_SUPPORT=3Dy
CONFIG_HID=3Dy
CONFIG_HIDRAW=3Dy

#
# USB Input Devices
#
CONFIG_USB_HID=3Dy
CONFIG_HID_PID=3Dy
CONFIG_USB_HIDDEV=3Dy

#
# Special HID drivers
#
CONFIG_HID_A4TECH=3Dy
CONFIG_HID_APPLE=3Dy
CONFIG_HID_BELKIN=3Dy
CONFIG_HID_CHERRY=3Dy
CONFIG_HID_CHICONY=3Dy
CONFIG_HID_CYPRESS=3Dy
CONFIG_HID_DRAGONRISE=3Dy
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EZKEY=3Dy
CONFIG_HID_KYE=3Dy
CONFIG_HID_GYRATION=3Dy
CONFIG_HID_TWINHAN=3Dy
CONFIG_HID_KENSINGTON=3Dy
CONFIG_HID_LOGITECH=3Dy
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_HID_MICROSOFT=3Dy
CONFIG_HID_MONTEREY=3Dy
CONFIG_HID_NTRIG=3Dy
CONFIG_HID_PANTHERLORD=3Dy
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=3Dy
CONFIG_HID_SAMSUNG=3Dy
CONFIG_HID_SONY=3Dy
CONFIG_HID_SUNPLUS=3Dy
CONFIG_HID_GREENASIA=3Dy
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=3Dy
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TOPSEED=3Dy
CONFIG_HID_THRUSTMASTER=3Dy
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_ZEROPLUS=3Dy
# CONFIG_ZEROPLUS_FF is not set
CONFIG_USB_SUPPORT=3Dy
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB_ARCH_HAS_EHCI=3Dy
CONFIG_USB=3Dy
# CONFIG_USB_DEBUG is not set
CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_DEVICE_CLASS is not set
CONFIG_USB_DYNAMIC_MINORS=3Dy
# CONFIG_USB_OTG is not set
CONFIG_USB_MON=3Dy
# CONFIG_USB_WUSB is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
# CONFIG_XPS_USB_HCD_XILINX is not set
CONFIG_USB_EHCI_HCD_PPC_OF=3Dy
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1760_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_OHCI_HCD=3Dy
CONFIG_USB_OHCI_HCD_PPC_OF_BE=3Dy
CONFIG_USB_OHCI_HCD_PPC_OF_LE=3Dy
CONFIG_USB_OHCI_HCD_PPC_OF=3Dy
CONFIG_USB_OHCI_HCD_PCI=3Dy
CONFIG_USB_OHCI_BIG_ENDIAN_DESC=3Dy
CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=3Dy
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_UHCI_HCD=3Dy
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
# CONFIG_USB_HWA_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=3Dm
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_BERRY_CHARGE is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_VST is not set
# CONFIG_USB_GADGET is not set

#
# OTG and related infrastructure
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_UWB is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=3Dy
CONFIG_RTC_CLASS=3Dy
CONFIG_RTC_HCTOSYS=3Dy
CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=3Dy
CONFIG_RTC_INTF_PROC=3Dy
CONFIG_RTC_INTF_DEV=3Dy
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set

#
# SPI RTC drivers
#

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_GENERIC=3Dy
# CONFIG_DMADEVICES is not set
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=3Dy
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_SMX is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set

#
# TI VLYNQ
#
# CONFIG_STAGING is not set

#
# File systems
#
CONFIG_EXT2_FS=3Dy
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT2_FS_SECURITY=3Dy
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=3Dy
# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_SECURITY=3Dy
CONFIG_EXT4_FS=3Dm
CONFIG_EXT4_FS_XATTR=3Dy
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
CONFIG_JBD2=3Dm
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
CONFIG_REISERFS_FS=3Dy
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=3Dy
CONFIG_REISERFS_FS_POSIX_ACL=3Dy
CONFIG_REISERFS_FS_SECURITY=3Dy
CONFIG_JFS_FS=3Dm
CONFIG_JFS_POSIX_ACL=3Dy
CONFIG_JFS_SECURITY=3Dy
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_XFS_FS=3Dm
CONFIG_XFS_QUOTA=3Dy
CONFIG_XFS_POSIX_ACL=3Dy
CONFIG_XFS_RT=3Dy
# CONFIG_XFS_DEBUG is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
CONFIG_FILE_LOCKING=3Dy
CONFIG_FSNOTIFY=3Dy
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=3Dy
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=3Dm
# CONFIG_CUSE is not set
CONFIG_GENERIC_ACL=3Dy

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_UDF_FS=3Dm
CONFIG_UDF_NLS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_FAT_DEFAULT_CODEPAGE=3D866
CONFIG_FAT_DEFAULT_IOCHARSET=3D"utf8"
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=3Dy

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_PROC_SYSCTL=3Dy
CONFIG_PROC_PAGE_MONITOR=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
# CONFIG_HUGETLB_PAGE is not set
CONFIG_CONFIGFS_FS=3Dm
# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_EXPORTFS=3Dm

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=3Dy
CONFIG_MSDOS_PARTITION=3Dy
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"utf8"
CONFIG_NLS_CODEPAGE_437=3Dm
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=3Dm
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ASCII=3Dm
CONFIG_NLS_ISO8859_1=3Dm
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=3Dm
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=3Dm
# CONFIG_DLM is not set
CONFIG_BINARY_PRINTF=3Dy

#
# Library routines
#
CONFIG_BITREVERSE=3Dy
CONFIG_GENERIC_FIND_LAST_BIT=3Dy
CONFIG_CRC_CCITT=3Dm
CONFIG_CRC16=3Dm
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=3Dm
CONFIG_CRC32=3Dy
CONFIG_CRC7=3Dm
CONFIG_LIBCRC32C=3Dm
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy
CONFIG_LZO_COMPRESS=3Dm
CONFIG_LZO_DECOMPRESS=3Dy
CONFIG_DECOMPRESS_GZIP=3Dy
CONFIG_DECOMPRESS_BZIP2=3Dy
CONFIG_DECOMPRESS_LZMA=3Dy
CONFIG_DECOMPRESS_LZO=3Dy
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT=3Dy
CONFIG_HAS_DMA=3Dy
CONFIG_HAVE_LMB=3Dy
CONFIG_NLATTR=3Dy
CONFIG_GENERIC_ATOMIC64=3Dy

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=3Dy
CONFIG_ENABLE_WARN_DEPRECATED=3Dy
CONFIG_ENABLE_MUST_CHECK=3Dy
CONFIG_FRAME_WARN=3D1024
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_STRIP_ASM_SYMS=3Dy
CONFIG_UNUSED_SYMBOLS=3Dy
CONFIG_DEBUG_FS=3Dy
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=3Dy
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
CONFIG_DETECT_HUNG_TASK=3Dy
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
CONFIG_SCHED_DEBUG=3Dy
# CONFIG_SCHEDSTATS is not set
CONFIG_TIMER_STATS=3Dy
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_PREEMPT=3Dy
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_STACKTRACE=3Dy
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_WRITECOUNT is not set
CONFIG_DEBUG_MEMORY_INIT=3Dy
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_CPU_STALL_DETECTOR is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_SYSCTL_SYSCALL_CHECK=3Dy
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_NOP_TRACER=3Dy
CONFIG_HAVE_FUNCTION_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
CONFIG_RING_BUFFER=3Dy
CONFIG_EVENT_TRACING=3Dy
CONFIG_CONTEXT_SWITCH_TRACER=3Dy
CONFIG_RING_BUFFER_ALLOW_SWAP=3Dy
CONFIG_TRACING=3Dy
CONFIG_TRACING_SUPPORT=3Dy
# CONFIG_FTRACE is not set
# CONFIG_FIREWIRE_OHCI_REMOTE_DMA is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=3Dy
# CONFIG_KGDB is not set
# CONFIG_PPC_DISABLE_WERROR is not set
CONFIG_PPC_WERROR=3Dy
CONFIG_PRINT_STACK_DEPTH=3D64
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_PPC_EMULATED_STATS is not set
# CONFIG_CODE_PATCHING_SELFTEST is not set
# CONFIG_FTR_FIXUP_SELFTEST is not set
# CONFIG_MSI_BITMAP_SELFTEST is not set
CONFIG_XMON=3Dy
# CONFIG_XMON_DEFAULT is not set
CONFIG_XMON_DISASSEMBLY=3Dy
CONFIG_DEBUGGER=3Dy
# CONFIG_IRQSTACKS is not set
# CONFIG_VIRQ_DEBUG is not set
# CONFIG_BDI_SWITCH is not set
CONFIG_BOOTX_TEXT=3Dy
# CONFIG_PPC_EARLY_DEBUG is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_DEFAULT_SECURITY_SELINUX is not set
# CONFIG_DEFAULT_SECURITY_SMACK is not set
# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
CONFIG_DEFAULT_SECURITY_DAC=3Dy
CONFIG_DEFAULT_SECURITY=3D""
CONFIG_XOR_BLOCKS=3Dm
CONFIG_ASYNC_CORE=3Dm
CONFIG_ASYNC_MEMCPY=3Dm
CONFIG_ASYNC_XOR=3Dm
CONFIG_ASYNC_PQ=3Dm
CONFIG_ASYNC_RAID6_RECOV=3Dm
CONFIG_CRYPTO=3Dy

#
# Crypto core or helper
#
CONFIG_CRYPTO_FIPS=3Dy
CONFIG_CRYPTO_ALGAPI=3Dy
CONFIG_CRYPTO_ALGAPI2=3Dy
CONFIG_CRYPTO_AEAD=3Dm
CONFIG_CRYPTO_AEAD2=3Dy
CONFIG_CRYPTO_BLKCIPHER=3Dy
CONFIG_CRYPTO_BLKCIPHER2=3Dy
CONFIG_CRYPTO_HASH=3Dy
CONFIG_CRYPTO_HASH2=3Dy
CONFIG_CRYPTO_RNG=3Dy
CONFIG_CRYPTO_RNG2=3Dy
CONFIG_CRYPTO_PCOMP=3Dy
CONFIG_CRYPTO_MANAGER=3Dy
CONFIG_CRYPTO_MANAGER2=3Dy
CONFIG_CRYPTO_GF128MUL=3Dm
CONFIG_CRYPTO_NULL=3Dm
CONFIG_CRYPTO_WORKQUEUE=3Dy
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=3Dm
CONFIG_CRYPTO_TEST=3Dm

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=3Dm
CONFIG_CRYPTO_GCM=3Dm
CONFIG_CRYPTO_SEQIV=3Dm

#
# Block modes
#
CONFIG_CRYPTO_CBC=3Dy
CONFIG_CRYPTO_CTR=3Dm
CONFIG_CRYPTO_CTS=3Dm
CONFIG_CRYPTO_ECB=3Dm
CONFIG_CRYPTO_LRW=3Dm
CONFIG_CRYPTO_PCBC=3Dm
CONFIG_CRYPTO_XTS=3Dm

#
# Hash modes
#
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_XCBC=3Dm
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=3Dm
CONFIG_CRYPTO_GHASH=3Dm
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_MICHAEL_MIC=3Dm
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=3Dm
CONFIG_CRYPTO_SHA256=3Dm
CONFIG_CRYPTO_SHA512=3Dm
CONFIG_CRYPTO_TGR192=3Dm
CONFIG_CRYPTO_WP512=3Dm

#
# Ciphers
#
CONFIG_CRYPTO_AES=3Dy
CONFIG_CRYPTO_ANUBIS=3Dm
CONFIG_CRYPTO_ARC4=3Dm
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_CAMELLIA=3Dm
CONFIG_CRYPTO_CAST5=3Dm
CONFIG_CRYPTO_CAST6=3Dm
CONFIG_CRYPTO_DES=3Dm
CONFIG_CRYPTO_FCRYPT=3Dm
CONFIG_CRYPTO_KHAZAD=3Dm
CONFIG_CRYPTO_SALSA20=3Dm
CONFIG_CRYPTO_SEED=3Dm
CONFIG_CRYPTO_SERPENT=3Dm
CONFIG_CRYPTO_TEA=3Dm
CONFIG_CRYPTO_TWOFISH=3Dm
CONFIG_CRYPTO_TWOFISH_COMMON=3Dm

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=3Dm
CONFIG_CRYPTO_ZLIB=3Dy
CONFIG_CRYPTO_LZO=3Dm

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=3Dy
CONFIG_CRYPTO_HW=3Dy
CONFIG_CRYPTO_DEV_HIFN_795X=3Dm
CONFIG_CRYPTO_DEV_HIFN_795X_RNG=3Dy
# CONFIG_PPC_CLOCK is not set
# CONFIG_VIRTUALIZATION is not set

Information about environment:

andrey@power-debian:~/build/kernel/linux-2.6.33/scripts$ ./ver_linux=20
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux power-debian 2.6.33 #8 SMP PREEMPT Thu Feb 25 23:30:24 MSK 2010 p=
pc GNU/Linux
=20
Gnu C                  4.4.3
Gnu make               3.81
binutils               2.20
util-linux             ./ver_linux: 23: fdformat: not found
mount                  support
module-init-tools      found
Linux C Library        2.10.2
Dynamic linker (ldd)   2.10.2
Procps                 3.2.8
Console-tools          0.2.3
Sh-utils               7.4
Modules Loaded         nls_utf8 nls_cp866 vfat fat sd_mod usb_storage
fuse snd_powermac firewire_sbp2 scsi_mod sha256_generic snd_au8830
snd_ac97_codec snd_pcm snd_page_alloc ac97_bus snd_mpu401_uart
snd_seq_midi snd_seq_midi_event snd_seq snd_timer firewire_ohci
snd_rawmidi firewire_core crc_itu_t snd_seq_device

andrey@power-debian:~/build/kernel/linux-2.6.33/scripts$ dpkg-query -s =
util-linux
Version: 2.16.2-0

More about my system:

andrey@power-debian:~/build/kernel/linux-2.6.33/scripts$ cat /proc/cpui=
nfo=20
processor	: 0
cpu		: 7455, altivec supported
clock		: 866.666664MHz
revision	: 2.1 (pvr 8001 0201)
bogomips	: 66.60

processor	: 1
cpu		: 7455, altivec supported
clock		: 866.666664MHz
revision	: 2.1 (pvr 8001 0201)
bogomips	: 66.60

total bogomips	: 133.21
timebase	: 33304558
platform	: PowerMac
model		: PowerMac3,6
machine		: PowerMac3,6
motherboard	: PowerMac3,6 MacRISC2 MacRISC Power Macintosh
detected as	: 129 (PowerMac G4 Windtunnel)
pmac flags	: 00000010
L2 cache	: 256K unified
pmac-generation	: NewWorld
Memory		: 1536 MB


andrey@power-debian:~/build/kernel/linux-2.6.33/scripts$ cat /proc/modu=
les=20
nls_utf8 1100 0 - Live 0xf535d000
nls_cp866 4093 0 - Live 0xf5354000
vfat 10288 0 - Live 0xf5348000
fat 51132 1 vfat, Live 0xf532d000
sd_mod 25714 0 - Live 0xf530a000
usb_storage 37847 0 - Live 0xf52f0000
fuse 63437 1 - Live 0xf50d7000
snd_powermac 52736 0 - Live 0xf4c49000
firewire_sbp2 14005 0 - Live 0xf4c28000
scsi_mod 86466 3 sd_mod,usb_storage,firewire_sbp2, Live 0xf4bf9000
sha256_generic 9369 2 - Live 0xf477e000
snd_au8830 47059 1 - Live 0xf4697000
snd_ac97_codec 95460 1 snd_au8830, Live 0xf4663000
snd_pcm 68816 3 snd_powermac,snd_au8830,snd_ac97_codec, Live 0xf4620000
snd_page_alloc 5997 1 snd_pcm, Live 0xf43fa000
ac97_bus 673 1 snd_ac97_codec, Live 0xf43ee000
snd_mpu401_uart 6847 1 snd_au8830, Live 0xf43e4000
snd_seq_midi 5472 0 - Live 0xf43d7000
snd_seq_midi_event 5216 1 snd_seq_midi, Live 0xf41f3000
snd_seq 57663 2 snd_seq_midi,snd_seq_midi_event, Live 0xf41d6000
snd_timer 20281 2 snd_pcm,snd_seq, Live 0xf41b3000
firewire_ohci 24664 0 - Live 0xf419b000
snd_rawmidi 20781 2 snd_mpu401_uart,snd_seq_midi, Live 0xf4182000
firewire_core 47752 2 firewire_sbp2,firewire_ohci, Live 0xf215d000
crc_itu_t 1091 1 firewire_core, Live 0xf2142000
snd_seq_device 5653 3 snd_seq_midi,snd_seq,snd_rawmidi, Live 0xf2138000

andrey@power-debian:~/build/kernel/linux-2.6.33/scripts$ cat /proc/iopo=
rts=20
00000000-007fffff : /pci@f2000000
  00000400-00000407 : 0001:10:15.0
    00000400-00000407 : au8830
  00000410-00000417 : 0001:10:15.0
    00000410-00000417 : au8830
00802000-01001fff : /pci@f0000000
  00802000-00802fff : Legacy IO
ff7fe000-ffffdfff : /pci@f4000000
  ff7fe000-ff7fefff : Legacy IO

andrey@power-debian:~/build/kernel/linux-2.6.33/scripts$ cat /proc/iome=
m=20
80000000-8fffffff : /pci@f2000000
  80000000-8007ffff : 0001:10:17.0
    80000000-8007ffff : 0.80000000:mac-io
      80000050-8000007f : 0.00000050:gpio
      80008000-800080ff : 0.00010000:i2s
        80008000-800080ff : Sound Tx DMA
      80008100-800081ff : 0.00010000:i2s
        80008100-800081ff : Sound Rx DMA
      80008200-800082ff : 0.00010000:i2s
      80008300-800083ff : 0.00010000:i2s
      80008a00-80008aff : 0.0001f000:ata-4
        80008a00-80008aff : ide-pmac (dma)
      80008b00-80008bff : 0.00020000:ata-3
        80008b00-80008bff : ide-pmac (dma)
      80010000-80010fff : 0.00010000:i2s
        80010000-80010fff : Sound Control
      80013000-80013000 : 0.00013000:ch-b
        80013000-80013000 : pmac_zilog
      80013010-80013010 : 0.00013000:ch-b
        80013010-80013010 : pmac_zilog
      80013020-80013020 : 0.00013020:ch-a
        80013020-80013020 : pmac_zilog
      80013030-80013030 : 0.00013020:ch-a
        80013030-80013030 : pmac_zilog
      80013040-80013040 : 0.00013000:ch-b
        80013040-80013040 : pmac_zilog
      80013050-80013050 : 0.00013020:ch-a
        80013050-80013050 : pmac_zilog
      80015000-80015fff : 0.00015000:timer
      80016000-80017fff : 0.00016000:via-pmu
      80018000-80018fff : 0.00018000:i2c
      8001f000-8001ffff : 0.0001f000:ata-4
        8001f000-8001ffff : ide-pmac (ports)
      80020000-80020fff : 0.00020000:ata-3
        80020000-80020fff : ide-pmac (ports)
      80040000-8007ffff : 0.00040000:interrup
  80080000-80080fff : 0001:10:19.0
    80080000-80080fff : ohci_hcd
  80081000-80081fff : 0001:10:18.0
    80081000-80081fff : ohci_hcd
  800c0000-800fffff : 0001:10:15.0
    800c0000-800fffff : au8830
90000000-afffffff : /pci@f0000000
  90000000-9001ffff : 0000:00:10.0
  91000000-91ffffff : 0000:00:10.0
    91000000-91ffffff : nvidiafb
  98000000-9fffffff : 0000:00:10.0
    98000000-9fffffff : nvidiafb
f1000000-f1ffffff : /pci@f0000000
  f1000000-f107ffff : 0000:00:10.0
    f1000000-f107ffff : nvidiafb
f3000000-f3ffffff : /pci@f2000000
f5000000-f5ffffff : /pci@f4000000
  f5000000-f5000fff : 0002:20:0e.0
    f5000000-f5000fff : firewire_ohci
  f5004000-f5007fff : 0002:20:0d.0
    f5004000-f5007fff : Kauai ATA
  f5100000-f51fffff : 0002:20:0f.0
  f5200000-f53fffff : 0002:20:0f.0
    f5200000-f53fffff : sungem

0000:00:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 AGP
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 16, Cache Line Size: 32 bytes
	Capabilities: [80] AGP version 1.0
		Status: RQ=3D8 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 64=
bit- FW+ AGP3- Rate=3Dx1,x2,x4
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- Rate=3D=
<none>
	Kernel driver in use: agpgart-uninorth

0000:00:10.0 VGA compatible controller: nVidia Corporation NV17 [GeForc=
e4 MX 420] (rev a3) (prog-if 00 [VGA controller])
	Subsystem: nVidia Corporation Device 0008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 48
	Region 0: Memory at 91000000 (32-bit, non-prefetchable) [size=3D16M]
	Region 1: Memory at 98000000 (32-bit, prefetchable) [size=3D128M]
	Region 2: Memory at f1000000 (32-bit, prefetchable) [size=3D512K]
	Expansion ROM at 90000000 [disabled] [size=3D128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA- ITACoh- GART64- HTrans- 6=
4bit- FW+ AGP3- Rate=3Dx1,x2,x4
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- Rate=3D=
<none>
	Kernel driver in use: nvidiafb

0001:10:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 PCI
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 16, Cache Line Size: 32 bytes

0001:10:15.0 Multimedia audio controller: Aureal Semiconductor Vortex 2=
 (rev fe)
	Subsystem: Diamond Multimedia Systems Monster Sound II
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 16 (1000ns min, 3000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 58
	Region 0: Memory at 800c0000 (32-bit, non-prefetchable) [size=3D256K]
	Region 1: I/O ports at 0410 [size=3D8]
	Region 2: I/O ports at 0400 [size=3D8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: au8830

0001:10:17.0 Class ff00: Apple Computer Inc. KeyLargo Mac I/O (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 16, Cache Line Size: 32 bytes
	Region 0: Memory at 80000000 (32-bit, non-prefetchable) [size=3D512K]
	Kernel driver in use: macio

0001:10:18.0 USB Controller: Apple Computer Inc. KeyLargo USB (prog-if =
10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 16 (750ns min, 21500ns max)
	Interrupt: pin A routed to IRQ 27
	Region 0: Memory at 80081000 (32-bit, non-prefetchable) [size=3D4K]
	Kernel driver in use: ohci_hcd

0001:10:19.0 USB Controller: Apple Computer Inc. KeyLargo USB (prog-if =
10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 16 (750ns min, 21500ns max)
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at 80080000 (32-bit, non-prefetchable) [size=3D4K]
	Kernel driver in use: ohci_hcd

0002:20:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 Internal PCI
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 16, Cache Line Size: 32 bytes

0002:20:0d.0 Class ff00: Apple Computer Inc. UniNorth 2 ATA/100
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR+ INTx-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin ? routed to IRQ 39
	Region 0: Memory at f5004000 (32-bit, non-prefetchable) [size=3D16K]
	Kernel driver in use: ide-pmac

0002:20:0e.0 FireWire (IEEE 1394): Apple Computer Inc. UniNorth 2 FireW=
ire (rev 01) (prog-if 10 [OHCI])
	Subsystem: Apple Computer Inc. iBook G4 2004
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (3000ns min, 6000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 40
	Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME+
	Kernel driver in use: firewire_ohci

0002:20:0f.0 Ethernet controller: Apple Computer Inc. UniNorth 2 GMAC (=
Sun GEM)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dslow >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR+ INTx-
	Latency: 16 (16000ns min, 16000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 41
	Region 0: Memory at f5200000 (32-bit, non-prefetchable) [size=3D2M]
	Expansion ROM at f5100000 [disabled] [size=3D1M]
	Kernel driver in use: gem


andrey@power-debian:/sys/bus/i2c/devices$ ls -l
=D0=B8=D1=82=D0=BE=D0=B3=D0=BE 0
lrwxrwxrwx 1 root root 0 =D0=A4=D0=B5=D0=B2 27 00:02 5-0035 -> ../../..=
/devices/platform/i2c-powermac.2/i2c-5/5-0035
lrwxrwxrwx 1 root root 0 =D0=A4=D0=B5=D0=B2 27 00:02 7-002c -> ../../..=
/devices/platform/i2c-powermac.4/i2c-7/7-002c
lrwxrwxrwx 1 root root 0 =D0=A4=D0=B5=D0=B2 27 00:02 7-0049 -> ../../..=
/devices/platform/i2c-powermac.4/i2c-7/7-0049
lrwxrwxrwx 1 root root 0 =D0=A4=D0=B5=D0=B2 27 00:02 i2c-0 -> ../../../=
devices/pci0000:00/0000:00:10.0/i2c-0
lrwxrwxrwx 1 root root 0 =D0=A4=D0=B5=D0=B2 27 00:02 i2c-1 -> ../../../=
devices/pci0000:00/0000:00:10.0/i2c-1
lrwxrwxrwx 1 root root 0 =D0=A4=D0=B5=D0=B2 27 00:02 i2c-2 -> ../../../=
devices/pci0000:00/0000:00:10.0/i2c-2
lrwxrwxrwx 1 root root 0 =D0=A4=D0=B5=D0=B2 27 00:02 i2c-3 -> ../../../=
devices/platform/i2c-powermac.0/i2c-3
lrwxrwxrwx 1 root root 0 =D0=A4=D0=B5=D0=B2 27 00:02 i2c-4 -> ../../../=
devices/platform/i2c-powermac.1/i2c-4
lrwxrwxrwx 1 root root 0 =D0=A4=D0=B5=D0=B2 27 00:02 i2c-5 -> ../../../=
devices/platform/i2c-powermac.2/i2c-5
lrwxrwxrwx 1 root root 0 =D0=A4=D0=B5=D0=B2 27 00:02 i2c-6 -> ../../../=
devices/platform/i2c-powermac.3/i2c-6
lrwxrwxrwx 1 root root 0 =D0=A4=D0=B5=D0=B2 27 00:02 i2c-7 -> ../../../=
devices/platform/i2c-powermac.4/i2c-7


Hope my message is useful,

Andrey
