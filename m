From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: fix Kconfig dependency
Date: Mon, 7 Apr 2014 08:56:57 +0200
Message-ID: <20140407065657.GO29751@pengutronix.de>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <20140407063100.GN29751@pengutronix.de>
 <1396852656.682914397@f273.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396852656.682914397-OsTKtXgVMwVsdVUOrk1QfQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Cc: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Mon, Apr 07, 2014 at 10:37:36AM +0400, Alexander Shiyan wrote:
> Mon, 7 Apr 2014 08:31:00 +0200 =D0=BE=D1=82 Uwe Kleine-K=C3=B6nig <u.=
kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
> > Hello,
> >=20
> > On Sun, Apr 06, 2014 at 09:07:07PM +0200, Wolfram Sang wrote:
> > > During development, the driver first really needed to depend on
> > > COMMON_CLK only. Later, it was switched to writel_relaxed, but it=
 was
> > > forgotten to update the dependencies, so build errors occured:
> > >=20
> > > config: make ARCH=3Di386 allyesconfig
> > >=20
> > > All error/warnings:
> > >=20
> > >    drivers/i2c/busses/i2c-cadence.c: In function 'cdns_i2c_clear_=
bus_hold':
> > > >> drivers/i2c/busses/i2c-cadence.c:168:3: error: implicit declar=
ation
> > > >> of function 'writel_relaxed' [-Werror=3Dimplicit-function-decl=
aration]
> > >=20
> > > Use a very safe dependency for now.
> > >=20
> > > Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> > > ---
> > >  drivers/i2c/busses/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kcon=
fig
> > > index 93165ff453ab..3d3b9b3577c5 100644
> > > --- a/drivers/i2c/busses/Kconfig
> > > +++ b/drivers/i2c/busses/Kconfig
> > > @@ -378,7 +378,7 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
> > > =20
> > >  config I2C_CADENCE
> > >  	tristate "Cadence I2C Controller"
> > > -	depends on COMMON_CLK
> > > +	depends on ARCH_ZYNQ
> > I'd suggest:
> >=20
> > 	depends on ARM && (ARCH_ZYNC || COMPILE_TEST)
>=20
> ARCH_ZYNC || (ARM && COMPILE_TEST)
>=20
> Same, but more clear.
"more clear" might be subjective, at least for me I don't see a benefit
from one over the other.

hmm, considering a (hypothetical) driver that depends on I2C and is
available on Zync but compiles on ARM, it would need either:=20

	ARM && I2C && (ZYNC || COMPILE_TEST)

or

	ZYNC && I2C || (ARM && I2C && COMPILE_TEST)

or

	I2C && (ARCH_ZYNC || (ARM && COMPILE_TEST))

In this case the first variant is the best, isn't it? Is this a reason
to stick to this scheme even if there in the simpler case that is in
question here? Probably not?!

But anyhow, my main concern was the introduction of COMPILE_TEST, I
don't care much about the actual expression used. So use whatever you
want.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
