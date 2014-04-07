From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: fix Kconfig dependency
Date: Mon, 7 Apr 2014 09:18:10 -0700
Message-ID: <4c4d2ba5-f5f6-4589-8a48-6a88d1c16098@VA3EHSMHS046.ehs.local>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <1396852656.682914397@f273.i.mail.ru>
 <20140407065657.GO29751@pengutronix.de>
 <1396854155.872298456@f287.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396854155.872298456-PhO68MlTG7BsdVUOrk1QfQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 2014-04-07 at 11:02AM +0400, Alexander Shiyan wrote:
> Mon, 7 Apr 2014 08:56:57 +0200 =D0=BE=D1=82 Uwe Kleine-K=C3=B6nig <u.=
kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
> > Hello,
> ...
> > > > On Sun, Apr 06, 2014 at 09:07:07PM +0200, Wolfram Sang wrote:
> > > > > During development, the driver first really needed to depend =
on
> > > > > COMMON_CLK only. Later, it was switched to writel_relaxed, bu=
t it was
> > > > > forgotten to update the dependencies, so build errors occured=
:
> > > > >=20
> > > > > config: make ARCH=3Di386 allyesconfig
> > > > >=20
> > > > > All error/warnings:
> > > > >=20
> > > > >    drivers/i2c/busses/i2c-cadence.c: In function 'cdns_i2c_cl=
ear_bus_hold':
> > > > > >> drivers/i2c/busses/i2c-cadence.c:168:3: error: implicit de=
claration
> > > > > >> of function 'writel_relaxed' [-Werror=3Dimplicit-function-=
declaration]
> > > > >=20
> > > > > Use a very safe dependency for now.
> > > > >=20
> > > > > Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> > > > > ---
> > > > >  drivers/i2c/busses/Kconfig | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/=
Kconfig
> > > > > index 93165ff453ab..3d3b9b3577c5 100644
> > > > > --- a/drivers/i2c/busses/Kconfig
> > > > > +++ b/drivers/i2c/busses/Kconfig
> > > > > @@ -378,7 +378,7 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
> > > > > =20
> > > > >  config I2C_CADENCE
> > > > >  	tristate "Cadence I2C Controller"
> > > > > -	depends on COMMON_CLK
> > > > > +	depends on ARCH_ZYNQ
> > > > I'd suggest:
> > > >=20
> > > > 	depends on ARM && (ARCH_ZYNC || COMPILE_TEST)
> > >=20
> > > ARCH_ZYNC || (ARM && COMPILE_TEST)
> > >=20
> > > Same, but more clear.
> > "more clear" might be subjective, at least for me I don't see a ben=
efit
> > from one over the other.
> >=20
> > hmm, considering a (hypothetical) driver that depends on I2C and is
> > available on Zync but compiles on ARM, it would need either:=20
>=20
> No. Look at drivers/i2c/Kconfig:

I'd propose the below fix. The relaxed IO helpers are currently
available on ARM only and the clock notifier used, depends on
COMMON_CLK. I2C-related dependencies should be okay due to the location=
 in
Kconfig of this option.

	Thanks,
	S=C3=B6ren

---------------8<---------------8<----------------8<-----------------8<=
-----------8<-------
Date: Sun, 6 Apr 2014 15:19:34 -0700
Subject: [PATCH] i2c: cadence: Add dependency on ARM

Due to switching to the (read|write)l_relaxed IO helpers, building this
driver fails on non-ARM architectures, which don't provide these helper=
s
with the following error:
  All error/warnings:

     drivers/i2c/busses/i2c-cadence.c: In function 'cdns_i2c_clear_bus_=
hold':
  >> drivers/i2c/busses/i2c-cadence.c:168:3: error: implicit declaratio=
n of function 'writel_relaxed' [-Werror=3Dimplicit-function-declaration=
]
        cdns_i2c_writereg(reg & ~CDNS_I2C_CR_HOLD, CDNS_I2C_CR_OFFSET);
        ^
     cc1: some warnings being treated as errors

Make the driver additionally depend on CONFIG_ARM to fix this.

Reported-by: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 66e68e48218f..9f546eecd322 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -377,7 +377,7 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
=20
 config I2C_CADENCE
 	tristate "Cadence I2C Controller"
-	depends on COMMON_CLK
+	depends on ARM && COMMON_CLK
 	help
 	  Say yes here to select Cadence I2C Host Controller. This controller=
 is
 	  e.g. used by Xilinx Zynq.
--=20
1.9.1.1.gbb9f595
