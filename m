From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] gpiolib: Defer on non-DT find_chip_by_name() failure
Date: Thu, 5 Jul 2018 07:23:46 +0200
Message-ID: <20180705052346.6iwanz5kx3ive42a@pengutronix.de>
References: <20180703172635.32508-1-jmkrzyszt@gmail.com>
 <20180703193141.747fa950@bbrezillon>
 <7058252.SGNltMTCCa@z50>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7058252.SGNltMTCCa@z50>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Fabio Estevam <fabio.estevam@nxp.com>, Phil Reid <preid@electromag.com.au>, Lucas Stach <l.stach@pengutronix.de>, Clemens Gruber <clemens.gruber@pqgruber.com>, Peter Rosin <peda@axentia.se>, patches@opensource.cirrus.com, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Wed, Jul 04, 2018 at 09:13:42PM +0200, Janusz Krzysztofik wrote:
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

TL;DR: Either I don't understand the implication for
drivers/i2c/busses/i2c-imx.c or everything is fine.

Given that only i2c_imx_init_recovery_info() uses gpio functions I assume
you mean:

        rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda", GPIOD_IN);
        rinfo->scl_gpiod = devm_gpiod_get(&pdev->dev, "scl", GPIOD_OUT_HIGH);

        if (PTR_ERR(rinfo->sda_gpiod) == -EPROBE_DEFER ||
            PTR_ERR(rinfo->scl_gpiod) == -EPROBE_DEFER) {
                return -EPROBE_DEFER;
        } else if (IS_ERR(rinfo->sda_gpiod) ||
                   IS_ERR(rinfo->scl_gpiod) ||
                   IS_ERR(i2c_imx->pinctrl_pins_default) ||
                   IS_ERR(i2c_imx->pinctrl_pins_gpio)) {
                dev_dbg(&pdev->dev, "recovery information incomplete\n");
                return 0;
        }

So if a patch changes devm_gpiod_get() to return -EPROBE_DEFER in more
cases that doesn't seem to hurt. Moreover TTBOMK this driver should only
be used by dt-machines today such that changing gpio* for non-DT users
shouldn't affect it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
