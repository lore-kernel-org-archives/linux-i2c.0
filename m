From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/7] OF/ACPI/I2C: Add generic match function for the
 aforementioned systems
Date: Thu, 05 Jun 2014 11:32:09 +0100
Message-ID: <20140605103209.C8F10C40A4D@trevor.secretlab.ca>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
	<1401883796-17841-8-git-send-email-lee.jones@linaro.org>
	<5769487.6cMQUCkisu@vostro.rjw.lan>
	<20140604125141.GB5214@lahna.fi.intel.com>
	<20140604132820.GA19550@lee--X1>
	<20140605080000.GE5214@lahna.fi.intel.com>
	<20140605082008.GC19550@lee--X1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140605082008.GC19550@lee--X1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 5 Jun 2014 09:20:08 +0100, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wro=
te:
> On Thu, 05 Jun 2014, Mika Westerberg wrote:
> > On Wed, Jun 04, 2014 at 02:28:20PM +0100, Lee Jones wrote:
> > > On Wed, 04 Jun 2014, Mika Westerberg wrote:
> > > > On Wed, Jun 04, 2014 at 02:37:42PM +0200, Rafael J. Wysocki wro=
te:
> > > > > On Wednesday, June 04, 2014 01:09:56 PM Lee Jones wrote:
> > > > > > Currently this is a helper function for the I2C subsystem t=
o aid the
> > > > > > matching of non-standard compatible strings and devices whi=
ch use DT
> > > > > > and/or ACPI, but do not supply any nodes (see: [1] Method 4=
).  However,
> > > > > > it has been made more generic as it can be used to only mak=
e one call
> > > > > > for drivers which support any mixture of OF, ACPI and/or I2=
C matching.
> > > > > >=20
> > > > > > The initial aim is for of_match_device() to be replaced by =
this call
> > > > > > in all I2C device drivers.
> > > > > >=20
> > > > > > [1] Documentation/i2c/instantiating-devices
> > > > > >=20
> > > > > > Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > > >=20
> > > > > Mika, can you please have a look at this, please?
> > > >=20
> > > > I don't see any fundamental problems with this wrt. ACPI.
> > > >=20
> > > > That said, I find it kind of weird to have generic function tha=
t then
> > > > has knowledge of how different buses do their matching.
> > > >=20
> > > > I would rather see something like firmware_device_match(dev) th=
at goes
> > > > and matches from DT/ACPI and leave bus specific match to happen=
 internal
> > > > to that bus.
> > >=20
> > > Unfortunately that completely defeats the object of the patch.  W=
hen a
> > > of_match_device() is invoked it solely looks up devices based on =
OF
> > > matching, but I2C is special in that devices can be registered vi=
a
> > > sysfs, thus will no have device node.  If of_match_device() is ca=
lled
> > > in one of these instances it will fail.  The idea of this patch i=
s to
> > > generify the matching into something does has the knowledge to fi=
rstly
> > > attempt a traditional match, and if that fails will fall back to =
a
> > > special i2c_{of,acpi}_match_device() which knows how to deal with
> > > node-less registration.
> >=20
> > OK, then but since this is now I2C specific, why call it device_mat=
ch()
> > instead of something like i2c_device_match()? Or do you have plans =
to
>=20
> So in an early incarnation of the patch I did just that, and it might
> not actually be such a bad idea still - I'm open to other people's
> opinions on this.
>=20
> > add there more knowledge about other buses like SPI and PCI to name=
 few?
>=20
> ... but yes, this is the new idea - that it can be expanded as requir=
ed.

The whole point of this series is to deal with a special use case of i2=
c
that we don't need to support for the other bus types. We're having to
just through special hoops to make it work and I don't want to expand i=
t
to other bus types if at all possible.

g.

> --=20
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
