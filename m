From: Ben Dooks <ben-i2c@fluff.org>
Subject: Re: [PATCH -next] i2c: i2c-pxa-pci.c needs module.h
Date: Sun, 31 Jul 2011 17:42:08 +0100
Message-ID: <20110731164208.GP15795@trinity.fluff.org>
References: <20110729173827.716f57ff6e00095a3efc6449@canb.auug.org.au> <20110729211430.6c4830bd.rdunlap@xenotime.net> <CAP=VYLrtumuSM_ncO6sEr7=HciiKcOsB=yN4NZnAxesjSSOgMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP=VYLrtumuSM_ncO6sEr7=HciiKcOsB=yN4NZnAxesjSSOgMw@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@gmail.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-i2c@vger.kernel.org, akpm <akpm@linux-foundation.org>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, khali@linux-fr.org, ben-linux@fluff.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jul 30, 2011 at 03:09:32PM -0400, Paul Gortmaker wrote:
> On Sat, Jul 30, 2011 at 12:14 AM, Randy Dunlap <rdunlap@xenotime.net>=
 wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> >
> > i2c-pxa-pci.c uses interfaces from linux/module.h, so it should
> > include that file. =A0This fixes build errors.
>=20
> Applied to module.h-split, thanks.

ok, so I don't need to apply this one?
Acked-by: Ben Dooks <ben-linux@fluff.org>
=20
> P.
>=20
> >
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > ---
> > =A0drivers/i2c/busses/i2c-pxa-pci.c | =A0 =A01 +
> > =A01 file changed, 1 insertion(+)
> >
> > --- linux-next-20110729.orig/drivers/i2c/busses/i2c-pxa-pci.c
> > +++ linux-next-20110729/drivers/i2c/busses/i2c-pxa-pci.c
> > @@ -3,6 +3,7 @@
> > =A0* It does not support slave mode, the register slightly moved. T=
his PCI
> > =A0* device provides three bars, every contains a single I2C contro=
ller.
> > =A0*/
> > +#include <linux/module.h>
> > =A0#include <linux/pci.h>
> > =A0#include <linux/platform_device.h>
> > =A0#include <linux/i2c/pxa-i2c.h>
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-nex=
t" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disapp=
ear.
