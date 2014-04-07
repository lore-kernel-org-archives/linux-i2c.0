From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: fix Kconfig dependency
Date: Mon, 7 Apr 2014 08:37:28 -0700
Message-ID: <ee442030-88af-4cad-ab5c-fa7ec2b51ac2@TX2EHSMHS037.ehs.local>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <20140407063100.GN29751@pengutronix.de>
 <5342481B.6020600@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5342481B.6020600-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2014-04-07 at 08:39AM +0200, Michal Simek wrote:
> On 04/07/2014 08:31 AM, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >=20
> > On Sun, Apr 06, 2014 at 09:07:07PM +0200, Wolfram Sang wrote:
> >> During development, the driver first really needed to depend on
> >> COMMON_CLK only. Later, it was switched to writel_relaxed, but it =
was
> >> forgotten to update the dependencies, so build errors occured:
> >>
> >> config: make ARCH=3Di386 allyesconfig
> >>
> >> All error/warnings:
> >>
> >>    drivers/i2c/busses/i2c-cadence.c: In function 'cdns_i2c_clear_b=
us_hold':
> >>>> drivers/i2c/busses/i2c-cadence.c:168:3: error: implicit declarat=
ion
> >>>> of function 'writel_relaxed' [-Werror=3Dimplicit-function-declar=
ation]
> >>
> >> Use a very safe dependency for now.
> >>
> >> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> >> ---
> >>  drivers/i2c/busses/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconf=
ig
> >> index 93165ff453ab..3d3b9b3577c5 100644
> >> --- a/drivers/i2c/busses/Kconfig
> >> +++ b/drivers/i2c/busses/Kconfig
> >> @@ -378,7 +378,7 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
> >> =20
> >>  config I2C_CADENCE
> >>  	tristate "Cadence I2C Controller"
> >> -	depends on COMMON_CLK
> >> +	depends on ARCH_ZYNQ
> > I'd suggest:
> >=20
> > 	depends on ARM && (ARCH_ZYNC || COMPILE_TEST)
> >=20
> > This way it's available for compile testing but still it doesn't ap=
pear
> > when configuring a kernel for a real machine.
>=20
> I would suggest to add relaxed IO helper function to asm-generic/io.h
> to be available for all archs. Then we can avoid this type of errors.

ACK

	S=C3=B6ren
