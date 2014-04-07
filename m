From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: fix Kconfig dependency
Date: Mon, 7 Apr 2014 08:36:29 -0700
Message-ID: <dfab53fa-8b3c-4eb0-90b8-7df779ce68da@TX2EHSMHS036.ehs.local>
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
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 2014-04-07 at 10:37AM +0400, Alexander Shiyan wrote:
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

Why would you add Zynq to the dependencies? This driver should work on
all ARM platforms (more or less, given that the IP is implemented
similarly). I think ARM, if it selects COMMON_CLK, is enough. Otherwise
ARM && COMMON_CLK. I don't see a good reason to restrict the driver to
Zynq only.

	S=C3=B6ren
