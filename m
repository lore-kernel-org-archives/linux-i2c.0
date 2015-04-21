From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Need some guidance on i2c-ocores driver
Date: Tue, 21 Apr 2015 08:35:34 +0100
Message-ID: <20150421073534.GK3447@x1>
References: <55304D8E.8070204@freescale.com>
 <55312AF7.7070504@freescale.com>
 <20150420064231.GE3447@x1>
 <55352839.70905@freescale.com>
 <20150420181651.GF3447@x1>
 <5535460B.2060309@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5535460B.2060309-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Julia.Lawall-L2FTfq7BK8M@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> >> mfd_add_devices() is called, it uses &dev->resource as the base. S=
o the BAR will
> >> be the parent. Check the code in mfd-core.c, mfd_add_device(),
> >>
> >> if ((cell->resources[r].flags & IORESOURCE_MEM) && mem_base) {
> >> 	res[r].parent =3D mem_base;
> >> 	res[r].start =3D mem_base->start + cell->resources[r].start;
> >> 	res[r].end =3D mem_base->start + cell->resources[r].end;
> >> }
> >>
> >> So the MFD resource is within its parent. When later the device dr=
iver request a
> >> region, will it get conflict with the parent?
> >=20
> > I doubt you'll want to map the same memory area in both the parent =
and
> > the child device drivers.  Only map the registers you plan to use i=
n
> > the driver you plan to use them.  If you need multiple devices to
> > access the same registers then you need to create an API, complete
> > with locking, in the MFD parent device.
>=20
> Thanks for pointing out. I thought at first the conflict was due to m=
y
> pci_ioremap_bar(). I went ahead to remove the mapping but still not w=
orking.
> Your email inspired me to take a deeper look at my code and I found m=
y error. I
> have called pci_request_regions() which reserves all BARs. I think th=
at's my
> root cause. Thanks for helping me.

You are welcome.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
