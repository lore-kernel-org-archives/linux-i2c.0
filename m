From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] i2c: Make I2C ID tables non-mandatory for DT'ed and/or
 ACPI'ed devices
Date: Mon, 2 Jun 2014 14:26:19 +0100
Message-ID: <20140602132619.GA4146@lee--X1>
References: <1401452797-29521-1-git-send-email-lee.jones@linaro.org>
 <1401452797-29521-2-git-send-email-lee.jones@linaro.org>
 <20140530123656.GC2742@katana>
 <20140530133405.GB29731@lee--X1>
 <20140530174800.GA4917@katana>
 <20140530192516.GA4319@lee--X1>
 <20140531134805.GA3287@katana>
 <CACRpkdZvyfA0aaJe3YuevXfA2pTZLRPZ3mQpitL6qD7=qE0Xyg@mail.gmail.com>
 <20140602123851.GB2654@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140602123851.GB2654@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 02 Jun 2014, Wolfram Sang wrote:

> On Mon, Jun 02, 2014 at 02:16:59PM +0200, Linus Walleij wrote:
> > On Sat, May 31, 2014 at 3:48 PM, Wolfram Sang <wsa@the-dreams.de> w=
rote:
> > >
> > >> Right, I read the function which provides the functionality, but=
 my
> > >> point is; I don't think my patch changes the semantics in a way =
which
> > >> would adversely affect this option.  If you think that it does, =
can you
> > >> specify how please?
> > >
> > > Currently, if a driver would be DT only and does not provide a se=
perate
> > > i2c_device_id table, then the driver is unusable with method 4. I=
 don't
> > > like to have some drivers being capable of it and some not.
> > >
> > >> Does the sysfs method create a i2c_device_id table?  If not, how=
 does
> > >> it probe successfully pre-patch?
> > >
> > > The sysfs method creates a device. Its name is matched against
> > > i2c_device_ids only since it does not have a node pointer for DT =
to be
> > > matched against.
> >=20
> > Is this really so useful on embedded systems?
>=20
> Well, this feature is at least nice with embedded:
>=20
> ---
>=20
> * You are developing a driver on a test board, where you soldered the=
 I2C
>   device yourself.
>=20
> ---
>=20
> Or during HW bringup, you this or that driver for a device (out-of-tr=
ee
> vs. in-kernel), and hey, the RTC even has an EEPROM at another addres=
s,
> let's try. Such things are the use cases I have mostly seen and those
> customers liked it.
>=20
> The problem is that we are talking about matching against I2C slave
> drivers. I can't see a line between embedded and non-embedded when it
> comes to slaves. They are just slaves and could be on any hardware.
> Keeping the bigger picture in mind, IMO it is cumbersome if some driv=
ers
> support user-space instantiation and some not.
>=20
> Though, I wouldn't mind if compatible entries could be passed to the
> 'new_device' file, in addition to i2c_device_ids. Yet, this needs som=
e
> extra handling I haven't found the time for, yet.

Actually, I'm just about to submit a new set.

Hopefully we cover some bases.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
