From: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 01/11] dma: imx-sdma: make channel0 operations atomic
Date: Fri, 27 Apr 2012 17:17:17 +0800
Message-ID: <20120427091716.GR28063@b20223-02.ap.freescale.net>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-2-git-send-email-richard.zhao@freescale.com>
 <20120427075544.GV17184@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120427075544.GV17184-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 27, 2012 at 09:55:44AM +0200, Sascha Hauer wrote:
> On Fri, Apr 27, 2012 at 03:02:55PM +0800, Richard Zhao wrote:
> > device_prep_dma_cyclic may be call in audio trigger function which =
is
> > atomic context, so we make it atomic too.
> >=20
> >  - change channel0 lock to spinlock.
> >  - Use polling to wait for channel0 finish running.
> >=20
> > Signed-off-by: Lothar Wa=DFmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
> > Signed-off-by: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >  drivers/dma/imx-sdma.c |   57 +++++++++++++++++++++++++++---------=
-----------
> >  1 files changed, 33 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index fddccae..fc49ffa 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -24,7 +24,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/clk.h>
> > -#include <linux/wait.h>
> > +#include <linux/delay.h>
> >  #include <linux/sched.h>
> >  #include <linux/semaphore.h>
> >  #include <linux/spinlock.h>
> > @@ -324,7 +324,7 @@ struct sdma_engine {
> >  	struct dma_device		dma_device;
> >  	struct clk			*clk_ipg;
> >  	struct clk			*clk_ahb;
> > -	struct mutex			channel_0_lock;
> > +	spinlock_t		channel_0_lock;
> >  	struct sdma_script_start_addrs	*script_addrs;
> >  };
> > =20
> > @@ -402,19 +402,31 @@ static void sdma_enable_channel(struct sdma_e=
ngine *sdma, int channel)
> >  }
> > =20
> >  /*
> > - * sdma_run_channel - run a channel and wait till it's done
> > + * sdma_run_channel0 - run a channel and wait till it's done
> >   */
> > -static int sdma_run_channel(struct sdma_channel *sdmac)
> > +static int sdma_run_channel0(struct sdma_channel *sdmac)
>=20
> Renaming this to sdma_run_channel0 is fine, but then the argument sho=
uld
> be changed to struct sdma_engine. It makes no sense to say in the
> function name that this function is channel 0 only and at the same ti=
me
> allow to pass in an arbitrary other channel.
Correct. Thanks.

Richard
>=20
> Sascha
>=20
>=20
> --=20
> Pengutronix e.K.                           |                         =
    |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0=
    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5=
555 |
>=20
