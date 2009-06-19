From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] MFD: Add U300 AB3100 core support v3
Date: Fri, 19 Jun 2009 10:42:22 +0200
Message-ID: <63386a3d0906190142k1cfa608agfe1a81f05058cc6e@mail.gmail.com>
References: <63386a3d0905190736q574d0379hb529aaa105aa36f3@mail.gmail.com>
	 <20090519230601.GF23114@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090519230601.GF23114-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I was revisiting this in my mind:

2009/5/20 Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>:
> On Tue, May 19, 2009 at 04:36:50PM +0200, Linus Walleij wrote:
(...)
>> +/*
>> + * Here we define all the platform devices that appear
>> + * as children of the AB3100. These are regular platform
>> + * devices with the IORESOURCE_IO .start and .end set
>> + * to correspond to the internal AB3100 register range
>> + * mapping to the corresponding subdevice.
>> + */
>> +
>> +#define AB3100_DEVICE(devname, devid, regstart, regend) =A0 =A0 =A0=
 =A0 =A0 =A0 =A0\
>> +static struct resource ab3100_##devname##_resource[] =3D { =A0 =A0 =
\
>> + =A0 =A0 { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D regstart, =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D regend, =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IO, =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 } =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>
> is IORESOURCE_IO a good idea here, we may need to add some form of
> flag to say 'generic data' and for the driver core to not try and
> register it with any of the ioport or iomem structures.

I face the issue of adding sub-drivers to the AB3100 which will likely
be the same for other chips in the same series, so that say
drivers/rtc-ab3100.c will be used for all AB3xxx chips.
Register X thru X+size-1 (maps to .start and .end) will be
used for a certain subdevice.

So naturally I want these drivers to be relative to some base I2C
register adress and this needs to be passed down as a resource.
(Each I2C device has max 256 registers only for natural resons,
but may still contain several functions.)

Type, as defined in ioport.h is only four unique bits and all four
are taken:

#define IORESOURCE_TYPE_BITS    0x00000f00      /* Resource type */
#define IORESOURCE_IO           0x00000100
#define IORESOURCE_MEM          0x00000200
#define IORESOURCE_IRQ          0x00000400
#define IORESOURCE_DMA          0x00000800

(Pretty generic.)

There is no space for any IORESOURCE_GENERIC or so.

So putting in a resource of type IORESOURCE_IO is still the
best thing I can think of here, any other suggestions?
(I can think of kludgy things like using the bus-specific bits 7-0.)

Yours,
Linus Walleij
