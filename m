From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Velleman K8000
Date: Sat, 12 Sep 2009 20:42:02 +0200
Message-ID: <20090912204202.4b684722@hyperion.delvare>
References: <61452b690909120939kcc61779vfb7e686a40276ef7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <61452b690909120939kcc61779vfb7e686a40276ef7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kari Laine <klaine8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Kari,

On Sat, 12 Sep 2009 19:39:25 +0300, Kari Laine wrote:
> thank you very much for good information.
>=20
> Hopefully you can answer these questions as well because I am totally=
 lost.
>=20
> On Sat, Sep 12, 2009 at 12:12 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> w=
rote:
> > You didn't tell which kernel you are using, but kernel 2.6.17 and l=
ater
> > wouldn't let you load i2c-parport without a type parameter.
> The kernel is 2.6.27
>=20
> > It doesn't matter. i2c-core gets loaded automatically when any othe=
r
> > module needs it.
> it indeed is.
>=20
> > You should install i2c-tools and use the command "i2cdetect -l". Th=
is
> > will tell you what each i2c bus on your system is.
> >
> > Then you can try "i2cdetect <n>" where <n> is a bus number, to scan=
 the
> > bus in question. This is a good way to test whether the driver and
> > device are working properly.
> it gives this. So it seems to find all four chips on Velleman K8000 .
>=20
> =A0 =A0 0 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c=
 =A0d =A0e =A0f
> 00: =A0 =A0 =A0 =A0 =A0-- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: 20 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- 38 39 -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- 48 -- -- -- -- -- -- --
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --

Looks good.

> >> If these devices probably refer to Velleman - then how I can refer
> >> different i2c-devices on the board.
> >
> > Depends on the device. In the case of the Philips PCF8591, which
> > apparently you are using, sysfs attributes will be created somewher=
e
> > under /sys/bus/i2c/drivers/pcf8591. Each device has a name of the f=
orm
> > <bus number>-<device address>, for example "1-0048" for a PCF8591.
> When I now do
>=20
> modprobe pcf8591
>=20
> In
>=20
> linux-1fyv:/sys/bus/i2c/devices =A0directory
>=20
> comes 1-0048
>=20
> Now I have to figure out how to use this device. Any comments.

Have you read the driver's documentation?
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
blob_plain;f=3DDocumentation/hwmon/pcf8591;hb=3DHEAD

> The Velleman K8000 card has three other chips which show up in
> I2C-bus. Two PCF8574A which are I/O-chips and TDA8444-chip which is
> DA-chip. I don't find any modules for them. Does it mean that they ar=
e
> not supported as of yet or anymore?

The PCF8574A is supported by the pcf8574 driver (or pcf857x on recent
kernels.) I am not aware of a driver for the TDA8444.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html
