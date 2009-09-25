From: Jon Ringle <jon-7zJyie9iPacdnm+yROfE0A@public.gmane.org>
Subject: Re: [rtc-linux] Re: i2c/rtc init dependency problem
Date: Fri, 25 Sep 2009 10:49:42 -0400
Message-ID: <152584230909250749w305b5202tba55bfedd742fea9@mail.gmail.com>
References: <152584230909240758h674ffe3cw4d5e6baef5efc9b8@mail.gmail.com>
	 <20090924151953.GD3154@pengutronix.de>
	 <8b192c78-6ebf-42ec-b334-756f56cc5400@g6g2000vbr.googlegroups.com>
	 <20090925065843.GA4125@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090925065843.GA4125-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 25, 2009 at 2:58 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> w=
rote:
> Looking at the probe-routine, this means request_irq failed? Is there=
 something
> else needed to get that irq?

Sorry about that. I had inadvertently removed CONFIG_CPU_IXP46X
causing NR_IRQS to be set to low.

However, it still does not work with your patch. In the dump below I se=
e:
[    0.250000] i2c-core: driver [dummy] registered
=2E..
[    0.290000] i2c-adapter i2c-0: adapter [IOP3xx-I2C] registered
=2E..
[    3.780000] i2c-core: driver [rtc-m41t80] registered
[    3.790000] i2c /dev entries driver
[    3.790000] i2c-core: driver [dev_driver] registered
[    3.800000] i2c-dev: adapter [IOP3xx-I2C] registered as minor 0
[    3.800000] i2c-core: driver [lm75] registered
[    3.830000] i2c-adapter i2c-0: found normal entry for adapter 0, add=
r 0x48
=2E..
[    4.050000] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)



=46ull dump:
[    0.000000] Linux version 2.6.31-isc (ringlej-QuOWvOcGbXPmgbJ3gnzNPw@public.gmane.org) (gcc
version 4.3.2 (OSELAS.Toolchain-1.99.3) ) #4 PREEMPT Fri Sep 25
10:35:53 EDT 2009
[    0.000000] CPU: XScale-IXP46x Family [69054202] revision 2
(ARMv5TE), cr=3D000039ff
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Vertical RSC4 board
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 65536
[    0.000000] free_area_init_node: node 0, pgdat c0557a8c,
node_mem_map c4000000
[    0.000000]   DMA zone: 128 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 16256 pages, LIFO batch:3
[    0.000000]   Normal zone: 384 pages used for memmap
[    0.000000]   Normal zone: 48768 pages, LIFO batch:15
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 65024
[    0.000000] Kernel command line: console=3DttyS0,115200
maclist_ids=3D00:10:f4:04:09:b4 boot=3Djffs2 loglevel=3D8 dynamic_print=
k
[    0.000000] maclist_setup(00:10:f4:04:09:b4)
[    0.000000] maclist_add(00:10:f4:04:09:b4)
[    0.000000] PID hash table entries: 1024 (order: 10, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072=
 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 b=
ytes)
[    0.000000] Memory: 256MB =3D 256MB total
[    0.000000] Memory: 253756KB available (3796K code, 301K data,
1404K init, 0K highmem)
[    0.000000] SLUB: Genslabs=3D11, HWalign=3D32, Order=3D0-3, MinObjec=
ts=3D0,
CPUs=3D1, Nodes=3D1
[    0.000000] NR_IRQS:64
[    0.000000] Calibrating delay loop... 532.48 BogoMIPS (lpj=3D2662400=
)
[    0.250000] Security Framework initialized
[    0.250000] Mount-cache hash table entries: 512
[    0.250000] CPU: Testing write buffer coherency: ok
[    0.250000] NET: Registered protocol family 16
[    0.250000] i2c-core: driver [dummy] registered
[    0.250000] IXP4xx: Using 32MiB expansion bus window size
[    0.260000] PCI: IXP4xx is target - No bus scan performed
[    0.270000] PCI: IXP4xx Using direct access for memory space
[    0.290000] bio: create slab <bio-0> at 0
[    0.290000] usbcore: registered new interface driver usbfs
[    0.290000] usbcore: registered new interface driver hub
[    0.290000] usbcore: registered new device driver usb
[    0.290000] i2c-adapter i2c-0: adapter [IOP3xx-I2C] registered
[    0.300000] Switched to high resolution mode on CPU 0
[    0.300000] NET: Registered protocol family 2
[    0.300000] IP route cache hash table entries: 2048 (order: 1, 8192 =
bytes)
[    0.300000] TCP established hash table entries: 8192 (order: 4, 6553=
6 bytes)
[    0.300000] TCP bind hash table entries: 8192 (order: 3, 32768 bytes=
)
[    0.300000] TCP: Hash tables configured (established 8192 bind 8192)
[    0.300000] TCP reno registered
[    0.300000] NET: Registered protocol family 1
[    2.850000] IXP4xx Queue Manager initialized.
[    2.860000] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    2.860000] JFFS2 version 2.2. (NAND) =A9 2001-2006 Red Hat, Inc.
[    2.860000] aufs 2-31
[    2.860000] msgmni has been set to 496
[    2.860000] alg: No test for cipher_null (cipher_null-generic)
[    2.860000] alg: No test for ecb(cipher_null) (ecb-cipher_null)
[    2.860000] alg: No test for digest_null (digest_null-generic)
[    2.860000] alg: No test for compress_null (compress_null-generic)
[    2.870000] alg: No test for stdrng (krng)
[    2.870000] io scheduler noop registered (default)
[    3.380000] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    3.390000] serial8250.0: ttyS0 at MMIO 0xc8000000 (irq =3D 15) is a=
 XScale
[    3.390000] console [ttyS0] enabled
[    3.720000] serial8250.0: ttyS1 at MMIO 0xc8001000 (irq =3D 13) is a=
 XScale
[    3.740000] IXP4xx MII Bus: probed
[    3.740000] eth0: MII PHY 3 on NPE-B
[    3.750000] usbcore: registered new interface driver usbserial
[    3.750000] USB Serial support registered for generic
[    3.760000] usbcore: registered new interface driver usbserial_gener=
ic
[    3.760000] usbserial: USB Serial Driver core
[    3.770000] pxa25x_udc: version 30-June-2007
[    3.770000] pxa25x_udc: unrecognized processor: 69054202
[    3.780000] i2c-core: driver [rtc-m41t80] registered
[    3.790000] i2c /dev entries driver
[    3.790000] i2c-core: driver [dev_driver] registered
[    3.800000] i2c-dev: adapter [IOP3xx-I2C] registered as minor 0
[    3.800000] i2c-core: driver [lm75] registered
[    3.830000] i2c-adapter i2c-0: found normal entry for adapter 0, add=
r 0x48
[    3.840000] i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x48, len=3D=
0
[    3.840000] i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x48, len=3D=
1
[    3.850000] i2c-adapter i2c-0: master_xfer[1] R, addr=3D0x48, len=3D=
2
[    3.850000] i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x48, len=3D=
1
[    3.860000] i2c-adapter i2c-0: master_xfer[1] R, addr=3D0x48, len=3D=
1
[    3.870000] i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x48, len=3D=
1
[    3.870000] i2c-adapter i2c-0: master_xfer[1] R, addr=3D0x48, len=3D=
2
[    3.880000] i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x48, len=3D=
1
[    3.890000] i2c-adapter i2c-0: master_xfer[1] R, addr=3D0x48, len=3D=
2
[    3.890000] i2c-adapter i2c-0: found normal entry for adapter 0, add=
r 0x49
[    3.900000] i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x49, len=3D=
0
[    3.910000] i2c-adapter i2c-0: found normal entry for adapter 0, add=
r 0x4a
[    3.910000] i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x4a, len=3D=
0
[    3.920000] i2c-adapter i2c-0: found normal entry for adapter 0, add=
r 0x4b
[    3.930000] i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x4b, len=3D=
0
[    3.930000] i2c-adapter i2c-0: found normal entry for adapter 0, add=
r 0x4c
[    3.940000] i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x4c, len=3D=
0
[    3.950000] i2c-adapter i2c-0: found normal entry for adapter 0, add=
r 0x4d
[    3.950000] i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x4d, len=3D=
0
[    3.960000] i2c-adapter i2c-0: found normal entry for adapter 0, add=
r 0x4e
[    3.970000] i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x4e, len=3D=
0
[    3.970000] i2c-adapter i2c-0: found normal entry for adapter 0, add=
r 0x4f
[    3.980000] i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x4f, len=3D=
0
[    3.990000] IXP4xx Watchdog Timer: heartbeat 60 sec
[    3.990000] TCP cubic registered
[    3.990000] NET: Registered protocol family 10
[    4.000000] lo: Disabled Privacy Extensions
[    4.000000] NET: Registered protocol family 17
[    4.010000] Bridge firewalling registered
[    4.010000] RPC: Registered udp transport module.
[    4.020000] RPC: Registered tcp transport module.
[    4.020000] 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech=
=2Ecom>
[    4.030000] All bugs added by David S. Miller <davem-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
[    4.040000] XScale DSP coprocessor detected.
[    4.040000] start led_timer
[    4.050000] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    4.050000] Freeing init memory: 1404K
