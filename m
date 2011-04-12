From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH -next reresend] i2c: designware-pcidrv depends on PCI
Date: Tue, 12 Apr 2011 11:47:22 +0200
Message-ID: <20110412114722.0f2e67d6@endymion.delvare>
References: <20110408083215.6b3b0bfe.randy.dunlap@oracle.com>
	<BANLkTikX_rG+6Eg4owary1YRGRG8NzyrGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <BANLkTikX_rG+6Eg4owary1YRGRG8NzyrGQ@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Ben Dooks <ben-linux@fluff.org>
Cc: Baruch Siach <baruch@tkos.co.il>, linux-i2c@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Geert, Randy,

On Sat, 9 Apr 2011 13:34:49 +0200, Geert Uytterhoeven wrote:
> On Fri, Apr 8, 2011 at 17:32, Randy Dunlap <randy.dunlap@oracle.com> =
wrote:
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> >
> > i2c-designware-pcidrv is a PCI driver and should depend on PCI.
> > Fixes these build errors:
> >
> > drivers/i2c/busses/i2c-designware-pcidrv.c:256: error: implicit dec=
laration of function 'pci_request_region'
> > drivers/i2c/busses/i2c-designware-pcidrv.c:338: error: implicit dec=
laration of function 'pci_release_region'
> >
> > Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> > Cc: Baruch Siach <baruch@tkos.co.il>
> > ---
> > =A0drivers/i2c/busses/Kconfig | =A0 =A01 +
> > =A01 file changed, 1 insertion(+)
> >
> > Does anybody merge i2c patches???
>=20
> Yes please, it's been there since Mar 17, reported several times, and=
 probably
> masking other build failures.

This bug only exists in linux-next, as the code in question wasn't
merged in Linus's tree yet. It is drawn into linux-next from Ben
Dooks's next-i2c branch:
  http://git.fluff.org/gitweb?p=3Dbjdooks/linux.git;a=3Dshortlog;h=3Dre=
fs/heads/next-i2c

This is where it has to be fixed, so only Ben can do it. Ben, please?

Meanwhile, it should be possible to apply a hot fix to linux-next
directly, Stephen does it pretty often. Stephen, could you please apply
this fix temporarily until Ben wakes up and applies it to his tree?

> > --- linux-next-20110316.orig/drivers/i2c/busses/Kconfig
> > +++ linux-next-20110316/drivers/i2c/busses/Kconfig
> > @@ -359,6 +359,7 @@ config I2C_DESIGNWARE_PLATFORM
> >
> > =A0config I2C_DESIGNWARE_PCI
> > =A0 =A0 =A0 =A0tristate "Synopsys DesignWare PCI"
> > + =A0 =A0 =A0 depends on PCI
> > =A0 =A0 =A0 =A0help
> > =A0 =A0 =A0 =A0 =A0If you say yes to this option, support will be i=
ncluded for the
> > =A0 =A0 =A0 =A0 =A0Synopsys DesignWare I2C adapter. Only master mod=
e is supported.

--=20
Jean Delvare
