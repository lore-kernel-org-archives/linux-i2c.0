From: Lee Jones <lee.jones@linaro.org>
Subject: Re: Need some guidance on i2c-ocores driver
Date: Mon, 20 Apr 2015 19:16:51 +0100
Message-ID: <20150420181651.GF3447@x1>
References: <55304D8E.8070204@freescale.com>
 <55312AF7.7070504@freescale.com>
 <20150420064231.GE3447@x1>
 <55352839.70905@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55352839.70905@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: York Sun <yorksun@freescale.com>
Cc: Julia.Lawall@lip6.fr, linux-i2c@vger.kernel.org, wolfram@the-dreams.de, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 20 Apr 2015, York Sun wrote:

>=20
>=20
> On 04/19/2015 11:42 PM, Lee Jones wrote:
> > On Fri, 17 Apr 2015, York Sun wrote:
> >=20
> >> Resend to LKML
> >>
> >> Lee,
> >>
> >> This question is actually more about MFD. Can you point me to the =
possible
> >> causes for my failure below?
> >=20
> > It's hard to tell exactly without code, but it looks like you're
> > trying to allocate overlapping memory regions.  Double check all of
> > your addresses.  For DT you need to take a look at your 'reg'
> > properties, for traditional platform data it's best to grep for
> > IORESOURCE_MEM.
> >=20
> Lee,
>=20
> It _is_ overlapping. How could it not be? The resource for the I2C is=
 mapped to
> BAR2. So the resource is overlapping with BAR2. It is alway the case,=
 isn't it?
> What I don't understand is how MFD works with the resources if it is =
guaranteed
> overlapping. Did I get something wrong?
>=20
> Look at the reference code I took, drivers/mfd/timberdale.c, when
> mfd_add_devices() is called, it uses &dev->resource as the base. So t=
he BAR will
> be the parent. Check the code in mfd-core.c, mfd_add_device(),
>=20
> if ((cell->resources[r].flags & IORESOURCE_MEM) && mem_base) {
> 	res[r].parent =3D mem_base;
> 	res[r].start =3D mem_base->start + cell->resources[r].start;
> 	res[r].end =3D mem_base->start + cell->resources[r].end;
> }
>=20
> So the MFD resource is within its parent. When later the device drive=
r request a
> region, will it get conflict with the parent?

I doubt you'll want to map the same memory area in both the parent and
the child device drivers.  Only map the registers you plan to use in
the driver you plan to use them.  If you need multiple devices to
access the same registers then you need to create an API, complete
with locking, in the MFD parent device.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
