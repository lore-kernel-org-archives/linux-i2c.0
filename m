From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] gpiolib: Defer on non-DT find_chip_by_name() failure
Date: Thu, 5 Jul 2018 06:50:37 +0100
Message-ID: <20180705055037.GI496@dell>
References: <20180703172635.32508-1-jmkrzyszt@gmail.com>
 <20180703193141.747fa950@bbrezillon>
 <7058252.SGNltMTCCa@z50>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7058252.SGNltMTCCa@z50>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Phil Reid <preid@electromag.com.au>, Lucas Stach <l.stach@pengutronix.de>, Clemens Gruber <clemens.gruber@pqgruber.com>, Peter Rosin <peda@axentia.se>, patches@opensource.cirrus.com, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 04 Jul 2018, Janusz Krzysztofik wrote:

> On Tuesday, July 3, 2018 7:31:41 PM CEST Boris Brezillon wrote:
> > Hi Janusz,
> > 
> > On Tue,  3 Jul 2018 19:26:35 +0200
> > 
> > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> > > Avoid replication of error code conversion in non-DT GPIO consumers'
> > > code by returning -EPROBE_DEFER from gpiod_find() in case a chip
> > > identified by its label in a registered lookup table is not ready.
> > > 
> > > See https://lkml.org/lkml/2018/5/30/176 for example case.
> > > 
> > > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > > ---
> > > If accepted, please add
> > > 
> > > 	Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > 
> > > if Boris doesn't mind.
> > > 
> > > Thanks,
> > > Janusz
> > > 
> > >  drivers/gpio/gpiolib.c | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > index e11a3bb03820..15dc77c80328 100644
> > > --- a/drivers/gpio/gpiolib.c
> > > +++ b/drivers/gpio/gpiolib.c
> > > @@ -3639,9 +3639,16 @@ static struct gpio_desc *gpiod_find(struct device
> > > *dev, const char *con_id,> 
> > >  		chip = find_chip_by_name(p->chip_label);
> > >  		
> > >  		if (!chip) {
> > > 
> > > -			dev_err(dev, "cannot find GPIO chip %s\n",
> > > -				p->chip_label);
> > > -			return ERR_PTR(-ENODEV);
> > > +			/*
> > > +			 * As the lookup table indicates a chip with
> > > +			 * p->chip_label should exist, assume it may
> > > +			 * still appear latar and let the interested
> > 
> > 					^ later
> > 
> > > +			 * consumer be probed again or let the Deferred
> > > +			 * Probe infrastructure handle the error.
> > > +			 */
> > > +			dev_warn(dev, "cannot find GPIO chip %s, deferring\n",
> > > +				 p->chip_label);
> > > +			return ERR_PTR(-EPROBE_DEFER);
> > > 
> > >  		}
> > >  		
> > >  		if (chip->ngpio <= p->chip_hwnum) {
> > 
> > Looks good otherwise. Let's hope we're not breaking implementations
> > testing for -ENODEV...
> 
> I've reviewed them all and found two which I think may be affected:
> - drivers/mfd/arizona-core.c,
> - drivers/i2c/busses/i2c-imx.c.
> As far as I can understand the code, both depend on error != -EPROBE_DEFER in 
> order to continue in degraded mode. I'm adding their maintainers to the loop.

>From a quick glance, the -EPROBE_DEFER handing in Arizona Core appears
to be correct.  Would you mind explaining what your concerns are in
more detail please?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
