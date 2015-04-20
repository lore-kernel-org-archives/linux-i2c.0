From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Need some guidance on i2c-ocores driver
Date: Mon, 20 Apr 2015 07:42:31 +0100
Message-ID: <20150420064231.GE3447@x1>
References: <55304D8E.8070204@freescale.com>
 <55312AF7.7070504@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55312AF7.7070504-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Julia.Lawall-L2FTfq7BK8M@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 17 Apr 2015, York Sun wrote:

> Resend to LKML
>=20
> Lee,
>=20
> This question is actually more about MFD. Can you point me to the pos=
sible
> causes for my failure below?

It's hard to tell exactly without code, but it looks like you're
trying to allocate overlapping memory regions.  Double check all of
your addresses.  For DT you need to take a look at your 'reg'
properties, for traditional platform data it's best to grep for
IORESOURCE_MEM.

> Thanks.
>=20
> York
>=20
>=20
> On 04/16/2015 05:02 PM, York Sun wrote:
> > Julia and other experts,
> >=20
> > I am seeking for help on my device driver.
> >=20
> > I am working on a module driver for a FPGA design with open core I2=
C controller
> > memory-mapped to BAR2. I have searched up and down and found only o=
ne driver
> > (drivers/mfd/timberdale.c) with similar implementation. Following t=
imberdale
> > driver, I am able to load the driver, but blocked by devm_ioremap_r=
esource(). It
> > is always in conflict with my BAR2. I wonder if I did something wro=
ng. Here is
> > the flow I tracked so far. (By the way, I am using an older kernel =
3.12. The new
> > 4.0 kernel crashes when booting on my platform. I plan to move to n=
ewer kernel
> > later).
> >=20
> > mfd_add_devices()
> > |
> > |--mfd_add_device()
> >     |
> >     |--platform_device_add()
> >         |
> >         |--insert_resource()  /* this passed */
> >         |   |
> >         |   |--insert_resource_conflict()
> >         |
> >         |--device_add()
> >             |
> >             |--bus_probe_device()
> >                 |
> >                 |--devm_ioremap_resource()
> >                     |
> >                     |--devm_request_mem_region()
> >                         |
> >                         |--__request_region() /* this always confli=
cts */
> >                             |
> >                             |--__request_resource()
> >=20
> > My driver is called RedStone DMA. Here is my debug output
> >=20
> >> root@p1022ds:~# insmod redstone_mfd.ko=20
> >> RedStone DMA 0002:05:00.0: pci_enable_device() successful
> >> RedStone DMA 0002:05:00.0: MSI-X init successful
> >> York kernel: Calling devm_ioremap_resource()
> >> York kernel kernel/resource.c __request_region 977: conflict=3D[??=
? 0xc00080000-0xc00087fff flags 0x80000000]
> >> ocores-i2c ocores-i2c: can't request region for resource [mem 0xc0=
0086000-0xc0008601f]
> >> ocores-i2c: probe of ocores-i2c failed with error -16
> >> RedStone DMA 0002:05:00.0: BAR[0] 0x0000000c00000000-0x0000000c000=
7ffff flags 0x0014220c, length 524288
> >> RedStone DMA 0002:05:00.0: BAR[1] 0x0000000000000000-0x00000000000=
00000 flags 0x00000000, length 0
> >> RedStone DMA 0002:05:00.0: BAR[2] 0x0000000c00080000-0x0000000c000=
87fff flags 0x00040200, length 32768
> >> RedStone DMA 0002:05:00.0: BAR[3] 0x0000000000000000-0x00000000000=
00000 flags 0x00000000, length 0
> >> RedStone DMA 0002:05:00.0: BAR[4] 0x0000000000000000-0x00000000000=
00000 flags 0x00000000, length 0
> >> RedStone DMA 0002:05:00.0: BAR[5] 0x0000000000000000-0x00000000000=
00000 flags 0x00000000, length 0
> >> RedStone DMA 0002:05:00.0: Version 1.4, built on 4-16-15, id 0
> >> root@p1022ds:~#=20
> >=20
> > Can you shed some light on this?
> >=20
> > Thanks.
> >=20
> > York
> >=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
