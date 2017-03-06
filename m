From: Simon Horman <horms@verge.net.au>
Subject: Possible Regression caused by "[PATCH] i2c: riic: correctly finish
 transfers"
Date: Mon, 6 Mar 2017 12:16:41 +0100
Message-ID: <20170306111637.GA28805@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:50068 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbdCFL0h (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 6 Mar 2017 06:26:37 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

Hi,

I have noticed a regression in v4.11-rc1 since v4.10 on r7s72100/Genmai.

With some assistance from Geert I have isolated the problem as being
caused by 71ccea095ea1 ("i2c: riic: correctly finish transfers").

In a nutshell the problem is that shmobile_defconfig does not boot to
user-space. Boot log is as follows:

## Booting kernel from Legacy Image at 0c000000 ...
   Image Name:   Linux-4.11.0-rc1
   Created:      2017-03-06  11:14:51 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4886408 Bytes = 4.7 MiB
   Load Address: 08008000
   Entry Point:  08008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 0bf00000
   Booting using the fdt blob at 0x0bf00000
   Loading Kernel Image ... OK
OK
   Loading Device Tree to 0feea000, end 0feef843 ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.11.0-rc1 (horms@ayumi.horms.jp) (gcc version 4.6.3 (GCC) ) #1193 SMP Mon Mar 6 20:14:42 JST 2017
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Genmai
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] cma: Reserved 64 MiB at 0x0bc00000
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 32768
[    0.000000] free_area_init_node: node 0, pgdat c0b41f80, node_mem_map c7dea000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32768 pages, LIFO batch:7
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] percpu: Embedded 14 pages/cpu @c7fc2000 s33280 r0 d24064 u57344
[    0.000000] pcpu-alloc: s33280 r0 d24064 u57344 alloc=14*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: ignore_loglevel rw root=/dev/nfs ip=dhcp
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 53316K/131072K available (6144K kernel code, 269K rwdata, 1496K rodata, 2048K init, 301K bss, 12220K reserved, 65536K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0700000   (7136 kB)
[    0.000000]       .init : 0xc0900000 - 0xc0b00000   (2048 kB)
[    0.000000]       .data : 0xc0b00000 - 0xc0b434c0   ( 270 kB)
[    0.000000]        .bss : 0xc0b45000 - 0xc0b904fc   ( 302 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU debugfs-based tracing is enabled.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] clocksource_probe: no matching clocksources found
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836475000000ns
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty0] enabled
[    0.000000] Calibrating delay loop (skipped) preset value.. 800.00 BogoMIPS (lpj=4000000)
[    0.000000] pid_max: default: 32768 minimum: 301
[    0.000000] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] CPU: Testing write buffer coherency: ok
[    0.000000] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.000000] Setting up static identity map for 0x8100000 - 0x8100058
[    0.000000] smp: Bringing up secondary CPUs ...
[    0.000000] smp: Brought up 1 node, 1 CPU
[    0.000000] SMP: Total of 1 processors activated (800.00 BogoMIPS).
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] devtmpfs: initialized
[    0.000000] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.000000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.000000] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.000000] pinctrl core: initialized pinctrl subsystem
[    0.000000] Detected Renesas RZ/A r7s72100 
[    0.000000] NET: Registered protocol family 16
[    0.000000] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.000000] No ATAGs?
[    0.000000] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.000000] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.000000] vgaarb: loaded
[    0.000000] SCSI subsystem initialized
[    0.000000] libata version 3.00 loaded.
[    0.000000] usbcore: registered new interface driver usbfs
[    0.000000] usbcore: registered new interface driver hub
[    0.000000] usbcore: registered new device driver usb
[    0.000000] media: Linux media interface: v0.10
[    0.000000] Linux video capture interface: v2.00
[    0.000000] sh_mtu2 fcff0000.timer: ch0: used for clock events
[    0.000000] sh_mtu2 fcff0000.timer: ch0: used for periodic clock events
[    0.000000] Advanced Linux Sound Architecture Driver Initialized.
[    0.690000] NET: Registered protocol family 2
[    0.700000] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.700000] TCP bind hash table entries: 1024 (order: 1, 8192 bytes)
[    0.700000] TCP: Hash tables configured (established 1024 bind 1024)
[    0.700000] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.700000] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.700000] NET: Registered protocol family 1
[    0.710000] RPC: Registered named UNIX socket transport module.
[    0.710000] RPC: Registered udp transport module.
[    0.710000] RPC: Registered tcp transport module.
[    0.710000] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.710000] PCI: CLS 0 bytes, default 64
[    1.400000] workingset: timestamp_bits=30 max_order=15 bucket_order=0
[    1.410000] NFS: Registering the id_resolver key type
[    1.410000] Key type id_resolver registered
[    1.410000] Key type id_legacy registered
[    1.410000] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.410000] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    1.440000] jitterentropy: Initialization failed with host not compliant with requirements: 2
[    1.440000] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    1.440000] io scheduler noop registered
[    1.440000] io scheduler deadline registered
[    1.440000] io scheduler cfq registered (default)
[    1.440000] io scheduler mq-deadline registered
[    1.480000] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.510000] SuperH (H)SCI(F) driver initialized
[    1.510000] e8008000.serial: ttySC0 at MMIO 0xe8008000 (irq = 17, base_baud = 0) is a scif
[    2.060000] console [ttySC0] enabled
[    2.090000] renesas_spi e800e800.spi: dma_request_slave_channel_compat failed
[    2.100000] renesas_spi e800e800.spi: DMA not available, using PIO
[    2.120000] renesas_spi e800e800.spi: probed
[    2.130000] libphy: Fixed MDIO Bus: probed
[    2.140000] CAN device driver interface
[    2.150000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.150000] ehci-pci: EHCI PCI platform driver
[    2.160000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.170000] ohci-pci: OHCI PCI platform driver
[    2.170000] udc-core: couldn't find an available UDC - added [g_ether] to list of pending drivers
[    2.190000] i2c /dev entries driver
[    2.260000] random: fast init done
[    2.290000] random: crng init done
[   23.270000] INFO: rcu_sched detected stalls on CPUs/tasks:
[   23.270000]  (detected by 0, t=2102 jiffies, g=-80, c=-81, q=120)
[   23.270000] All QSes seen, last rcu_sched kthread activity 2102 (-27673--29775), jiffies_till_next_fqs=1, root ->qsmask 0x0
[   23.270000] swapper/0       D    0     1      0 0x00000002
[   23.270000] Backtrace: 
[   23.270000] [<c010a0d8>] (dump_backtrace) from [<c010a310>] (show_stack+0x18/0x1c)
[   23.270000]  r6:c0b03cc0 r5:00000002 r4:c381f640 r3:00200140
[   23.270000] [<c010a2f8>] (show_stack) from [<c0142800>] (sched_show_task+0xb0/0xcc)
[   23.270000] [<c0142750>] (sched_show_task) from [<c016d99c>] (rcu_check_callbacks+0x50c/0x6dc)
[   23.270000]  r5:c7fc9d40 r4:c0b0d380
[   23.270000] [<c016d490>] (rcu_check_callbacks) from [<c01712ec>] (update_process_times+0x38/0x64)
[   23.270000]  r10:00000000 r9:7fffffff r8:ffffffff r7:07562000 r6:c3960040 r5:00000000
[   23.270000]  r4:c381f640
[   23.270000] [<c01712b4>] (update_process_times) from [<c017e124>] (tick_periodic+0xa4/0xbc)
[   23.270000]  r5:00000000 r4:c0b02d40
[   23.270000] [<c017e080>] (tick_periodic) from [<c017e16c>] (tick_handle_periodic+0x30/0xa4)
[   23.270000]  r4:c7fc8e80 r3:c3820000
[   23.270000] [<c017e13c>] (tick_handle_periodic) from [<c017ee70>] (tick_handle_periodic_broadcast+0xd8/0xf4)
[   23.270000]  r9:c0b0efee r8:c3895300 r7:07562000 r6:c3960040 r5:00000001 r4:c0a65748
[   23.270000] [<c017ed98>] (tick_handle_periodic_broadcast) from [<c0518514>] (sh_mtu2_interrupt+0x3c/0x44)
[   23.270000]  r9:c0b0efee r8:c3895300 r7:0000001f r6:c3821894 r5:c881e300 r4:c3960000
[   23.270000] [<c05184d8>] (sh_mtu2_interrupt) from [<c0161170>] (__handle_irq_event_percpu+0x3c/0x114)
[   23.270000]  r5:c3895300 r4:c399a340
[   23.270000] [<c0161134>] (__handle_irq_event_percpu) from [<c016126c>] (handle_irq_event_percpu+0x24/0x60)
[   23.270000]  r10:00000000 r9:c3820000 r8:c0a64400 r7:00000001 r6:c3807000 r5:c3895300
[   23.270000]  r4:c3895300
[   23.270000] [<c0161248>] (handle_irq_event_percpu) from [<c01612f4>] (handle_irq_event+0x4c/0x70)
[   23.270000]  r5:c3895360 r4:c3895300
[   23.270000] [<c01612a8>] (handle_irq_event) from [<c0164930>] (handle_fasteoi_irq+0xac/0x138)
[   23.270000]  r6:c3807000 r5:c0b03f30 r4:c3895300 r3:00000000
[   23.270000] [<c0164884>] (handle_fasteoi_irq) from [<c0160980>] (generic_handle_irq+0x20/0x30)
[   23.270000]  r5:00000000 r4:00000000
[   23.270000] [<c0160960>] (generic_handle_irq) from [<c0160a1c>] (__handle_domain_irq+0x8c/0xb4)
[   23.270000] [<c0160990>] (__handle_domain_irq) from [<c0101414>] (gic_handle_irq+0x5c/0x9c)
[   23.270000]  r7:000003eb r6:c3821938 r5:c0b14c00 r4:c8802000
[   23.270000] [<c01013b8>] (gic_handle_irq) from [<c010aecc>] (__irq_svc+0x6c/0x90)
[   23.270000] Exception stack(0xc3821938 to 0xc3821980)
[   23.270000] 1920:                                                       c7fc6400 60000053
[   23.270000] 1940: 10c00000 000002ef c7fc6400 ffff8c16 ffff8bb2 c7fc6400 c0a64400 00000002
[   23.270000] 1960: 00000000 c3821994 c3821998 c3821988 c0681db0 c0682a90 60000053 ffffffff
[   23.270000]  r7:c382196c r6:ffffffff r5:60000053 r4:c0682a90
[   23.270000] [<c0682a68>] (_raw_spin_unlock_irqrestore) from [<c0681db0>] (schedule_timeout+0x1d4/0x210)
[   23.270000] [<c0681bdc>] (schedule_timeout) from [<c067f444>] (wait_for_common+0xf0/0x194)
[   23.270000]  r10:00000000 r8:00000000 r7:c316b42c r6:00000002 r5:00000064 r4:c316b428
[   23.270000] [<c067f354>] (wait_for_common) from [<c067f66c>] (wait_for_completion_timeout+0x14/0x18)
[   23.270000]  r10:ffffffff r8:00000001 r7:00000002 r6:c3821ac0 r5:00000000 r4:c316b410
[   23.270000] [<c067f658>] (wait_for_completion_timeout) from [<c04b7f10>] (riic_xfer+0xd0/0x13c)
[   23.270000] [<c04b7e40>] (riic_xfer) from [<c04b3c88>] (__i2c_transfer+0x1dc/0x238)
[   23.270000]  r10:00000002 r9:00000001 r8:c0b02d00 r7:ffff8bb2 r6:00000000 r5:c3821ab4
[   23.270000]  r4:c316b438 r3:c04b7e40
[   23.270000] [<c04b3aac>] (__i2c_transfer) from [<c04b3d74>] (i2c_transfer+0x90/0xb8)
[   23.270000]  r10:c3a39c10 r8:c3a39c30 r7:c3143000 r6:00000002 r5:c3821ab4 r4:c316b438
[   23.270000] [<c04b3ce4>] (i2c_transfer) from [<c03fb6d8>] (at24_eeprom_read_i2c+0xd0/0x11c)
[   23.270000]  r6:00000001 r5:ffff8bb5 r4:c0b02d00 r3:00000000
[   23.270000] [<c03fb608>] (at24_eeprom_read_i2c) from [<c03fadc0>] (at24_read+0x44/0x7c)
[   23.270000]  r7:c3821b3f r6:00000000 r5:c3a39c10 r4:00000001
[   23.270000] [<c03fad7c>] (at24_read) from [<c03fb1ac>] (at24_probe+0x3b4/0x570)
[   23.270000]  r10:c3a39c10 r8:c3143020 r7:00000000 r6:00000001 r5:c3143000 r4:c3a39c10
[   23.270000] [<c03fadf8>] (at24_probe) from [<c04b3458>] (i2c_device_probe+0x1ec/0x24c)
[   23.270000]  r10:c0b80cec r9:00000000 r8:00000000 r7:c0b2e96c r6:c3143000 r5:c03fadf8
[   23.270000]  r4:c3143020
[   23.270000] [<c04b326c>] (i2c_device_probe) from [<c03da27c>] (driver_probe_device+0x148/0x2d0)
[   23.270000]  r7:c0b2e96c r6:00000000 r5:00000000 r4:c3143020
[   23.270000] [<c03da134>] (driver_probe_device) from [<c03da584>] (__device_attach_driver+0xa4/0xb0)
[   23.270000]  r10:c0b34794 r8:c316b478 r7:00000000 r6:c3821c00 r5:c0b2e96c r4:c3143020
[   23.270000] [<c03da4e0>] (__device_attach_driver) from [<c03d8d4c>] (bus_for_each_drv+0x58/0x94)
[   23.270000]  r6:c03da4e0 r5:c3821bd8 r4:c3821c00 r3:c386246c
[   23.270000] [<c03d8cf4>] (bus_for_each_drv) from [<c03d9fec>] (__device_attach+0x8c/0x104)
[   23.270000]  r7:00000000 r6:00000001 r5:c3143054 r4:c3143020
[   23.270000] [<c03d9f60>] (__device_attach) from [<c03da5bc>] (device_initial_probe+0x14/0x18)
[   23.270000]  r7:00000000 r6:c3143020 r5:c0b347e0 r4:c3143020
[   23.270000] [<c03da5a8>] (device_initial_probe) from [<c03d8f00>] (bus_probe_device+0x30/0x88)
[   23.270000] [<c03d8ed0>] (bus_probe_device) from [<c03d768c>] (device_add+0x38c/0x514)
[   23.270000]  r6:00000000 r5:c3143028 r4:c3143020 r3:000001c2
[   23.270000] [<c03d7300>] (device_add) from [<c03d7998>] (device_register+0x1c/0x20)
[   23.270000]  r10:c3143004 r8:00000000 r7:c3143020 r6:c316b438 r5:c3821cd8 r4:c3143020
[   23.270000] [<c03d797c>] (device_register) from [<c04b2358>] (i2c_new_device+0x144/0x1cc)
[   23.270000]  r4:c3143000 r3:00000050
[   23.270000] [<c04b2214>] (i2c_new_device) from [<c04b26e0>] (of_i2c_register_device+0x178/0x1a0)
[   23.270000]  r10:c7fd77e4 r8:c7fd7aa8 r7:c7fd7a58 r6:c316b478 r5:c316b438 r4:c7fd7a58
[   23.270000] [<c04b2568>] (of_i2c_register_device) from [<c04b29a4>] (i2c_register_adapter+0x29c/0x430)
[   23.270000]  r5:00000000 r4:c316b438
[   23.270000] [<c04b2708>] (i2c_register_adapter) from [<c04b2ba8>] (__i2c_add_numbered_adapter+0x70/0x94)
[   23.270000]  r10:c3147600 r8:00000000 r7:c3877600 r6:c3147600 r5:00000002 r4:c316b438
[   23.270000] [<c04b2b38>] (__i2c_add_numbered_adapter) from [<c04b358c>] (i2c_add_adapter+0x3c/0xc8)
[   23.270000]  r5:c3877610 r4:c316b438
[   23.270000] [<c04b3550>] (i2c_add_adapter) from [<c04b82a8>] (riic_i2c_probe+0x2d4/0x390)
[   23.270000]  r5:c3877610 r4:c316b410
[   23.270000] [<c04b7fd4>] (riic_i2c_probe) from [<c03db9e8>] (platform_drv_probe+0x58/0xa0)
[   23.270000]  r10:c0b80cec r9:c0951e08 r8:00000000 r7:c0b34a3c r6:c0b34a3c r5:c3877610
[   23.270000]  r4:c04b7fd4
[   23.270000] [<c03db990>] (platform_drv_probe) from [<c03da27c>] (driver_probe_device+0x148/0x2d0)
[   23.270000]  r6:00000000 r5:00000000 r4:c3877610 r3:c03db990
[   23.270000] [<c03da134>] (driver_probe_device) from [<c03da48c>] (__driver_attach+0x88/0xac)
[   23.270000]  r10:c0900680 r8:00000000 r7:00000000 r6:c0b34a3c r5:c3877644 r4:c3877610
[   23.270000] [<c03da404>] (__driver_attach) from [<c03d8984>] (bus_for_each_dev+0x5c/0x94)
[   23.270000]  r6:c03da404 r5:c3821e50 r4:c0b34a3c r3:c3805d58
[   23.270000] [<c03d8928>] (bus_for_each_dev) from [<c03da5e0>] (driver_attach+0x20/0x28)
[   23.270000]  r7:00000000 r6:c0b2df00 r5:c3146600 r4:c0b34a3c
[   23.270000] [<c03da5c0>] (driver_attach) from [<c03d911c>] (bus_add_driver+0xd4/0x1e4)
[   23.270000] [<c03d9048>] (bus_add_driver) from [<c03dae5c>] (driver_register+0xa4/0xe8)
[   23.270000]  r7:c0b45000 r6:c0924338 r5:c093f858 r4:c0b34a3c
[   23.270000] [<c03dadb8>] (driver_register) from [<c03dc360>] (__platform_driver_register+0x38/0x4c)
[   23.270000]  r5:c093f858 r4:00000006
[   23.270000] [<c03dc328>] (__platform_driver_register) from [<c0924350>] (riic_i2c_driver_init+0x18/0x20)
[   23.270000] [<c0924338>] (riic_i2c_driver_init) from [<c0900e10>] (do_one_initcall+0xb0/0x154)
[   23.270000] [<c0900d60>] (do_one_initcall) from [<c0900fd8>] (kernel_init_freeable+0x124/0x1f4)
[   23.270000]  r8:000000c1 r7:c0b45000 r6:c093f838 r5:c093f858 r4:00000006
[   23.270000] [<c0900eb4>] (kernel_init_freeable) from [<c067cb78>] (kernel_init+0x10/0x114)
[   23.270000]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c067cb68
[   23.270000]  r4:00000000
[   23.270000] [<c067cb68>] (kernel_init) from [<c0106ff8>] (ret_from_fork+0x14/0x3c)
[   23.270000]  r4:00000000 r3:ffffffff
[   23.270000] rcu_sched kthread starved for 2102 jiffies! g4294967216 c4294967215 f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0
[   23.270000] rcu_sched       R  running task        0     7      2 0x00000000
[   23.270000] Backtrace: 
[   23.270000] [<c067e3a0>] (__schedule) from [<c067e9ec>] (schedule+0x98/0xb4)
[   23.270000]  r10:00000000 r9:00000001 r8:c0a64400 r7:c7fc6400 r6:ffff8bb1 r5:ffff8bb2
[   23.270000]  r4:c7fc6400
[   23.270000] [<c067e954>] (schedule) from [<c0681db4>] (schedule_timeout+0x1d8/0x210)
[   23.270000] [<c0681bdc>] (schedule_timeout) from [<c016c89c>] (rcu_gp_kthread+0x45c/0x850)
[   23.270000]  r10:00000001 r8:c0b02d00 r7:00000000 r6:0000019e r5:00000001 r4:c0b0d380
[   23.270000] [<c016c440>] (rcu_gp_kthread) from [<c0139530>] (kthread+0x118/0x134)
[   23.270000]  r7:c3821e50
[   23.270000] [<c0139418>] (kthread) from [<c0106ff8>] (ret_from_fork+0x14/0x3c)
[   23.270000]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0139418
[   23.270000]  r4:c3818740 r3:ffffffff
