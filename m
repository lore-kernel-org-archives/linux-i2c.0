From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: fix Kconfig dependency
Date: Mon, 7 Apr 2014 09:14:08 -0700
Message-ID: <144e5c25-abd4-4a5f-85b5-79e6c3d8181e@AM1EHSMHS012.ehs.local>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <20140407063100.GN29751@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140407063100.GN29751-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2014-04-07 at 08:31AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Sun, Apr 06, 2014 at 09:07:07PM +0200, Wolfram Sang wrote:
> > During development, the driver first really needed to depend on
> > COMMON_CLK only. Later, it was switched to writel_relaxed, but it w=
as
> > forgotten to update the dependencies, so build errors occured:
> >=20
> > config: make ARCH=3Di386 allyesconfig
> >=20
> > All error/warnings:
> >=20
> >    drivers/i2c/busses/i2c-cadence.c: In function 'cdns_i2c_clear_bu=
s_hold':
> > >> drivers/i2c/busses/i2c-cadence.c:168:3: error: implicit declarat=
ion
> > >> of function 'writel_relaxed' [-Werror=3Dimplicit-function-declar=
ation]
> >=20
> > Use a very safe dependency for now.
> >=20
> > Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> > ---
> >  drivers/i2c/busses/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfi=
g
> > index 93165ff453ab..3d3b9b3577c5 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -378,7 +378,7 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
> > =20
> >  config I2C_CADENCE
> >  	tristate "Cadence I2C Controller"
> > -	depends on COMMON_CLK
> > +	depends on ARCH_ZYNQ
> I'd suggest:
>=20
> 	depends on ARM && (ARCH_ZYNC || COMPILE_TEST)

This misses COMMON_CLK in the COMPILE_TEST case.

	S=C3=B6ren
