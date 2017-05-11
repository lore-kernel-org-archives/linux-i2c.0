From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c-designware: add i2c gpio recovery option
Date: Thu, 11 May 2017 16:53:11 +0300
Message-ID: <1494510791.6967.9.camel@linux.intel.com>
References: <2259005.m0altzP21Z@dabox> <1966782.aCEMFj2YWU@virgo>
         <4a84d6b1-2bba-6f01-8286-49661ef45576@electromag.com.au>
         <32490844.DoY2McpBxU@dabox> <1494421981.16411.7.camel@linux.intel.com>
         <0aafcff1-6970-e99e-5b93-b0877ebf8579@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0aafcff1-6970-e99e-5b93-b0877ebf8579@electromag.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, Tim Sander <tim@krieglstein.org>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 2017-05-11 at 09:24 +0800, Phil Reid wrote:
> G'day Andy,
> 
> Thanks for the review.

You're welcome, just don't forget to remove the parts that are out of
scope and/or you agree with.

> On 10/05/2017 21:13, Andy Shevchenko wrote:
> > On Wed, 2017-05-10 at 13:57 +0200, Tim Sander wrote:

> > > +static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev,
> > > +                                    struct i2c_adapter *adap)
> > > +{
> > > +       struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
> > > +
> > > +       dev->gpio_scl = devm_gpiod_get_optional(dev->dev,
> > > +                                               "scl",
> > > +                                               GPIOD_OUT_HIGH);
> > > +       if (IS_ERR_OR_NULL(dev->gpio_scl))
> > 
> > This is wrong. You should not use this macro in most cases. And
> > especially it breaks the logic behind _optional().
> 
> My logic here was that if the gpio is optional return null we return
> 0.

Why?!

_optional() *implies* that all rest calls will go fine and do nothing.

> which is an okay status.
> But this breaks if !CONFIG_GPIOLIB, which I keep forgetting. I've
> never
> quite wrapped my head around why that's the case.
> 
> But the probe function only bails out if this returns EPROBE_DEFER.
> Not sure that's the best approach

You need something like

desc = devm_gpiod_get_optional(...);
if (IS_ERR(desc))
 return PTR_ERR(desc);

> > > +               return PTR_ERR(dev->gpio_sda);
> > > +       rinfo->scl_gpio = desc_to_gpio(dev->gpio_scl);
> > > +       rinfo->sda_gpio = desc_to_gpio(dev->gpio_sda);
> > 
> > Why?!
> 
>  From my first attempt, didn't remove it from the example I sent.
> 
> We could change i2c_init_recovery to something like the following
> then the gpio set / getter could use the default functions.
> Not sure the code is completely correct but hopefully you get the
> concept.
> 
> static void i2c_init_recovery(struct i2c_adapter *adap)
> {
> 	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
> 	char *err_str;
> 
> 	if (!bri)
> 		return;
> 
> 	if (!bri->recover_bus) {
> 		err_str = "no recover_bus() found";
> 		goto err;
> 	}
> 
> 	/* bail out if either no gpio or no set/get callback. */
> 	if (!gpio_is_valid(bri->scl_gpio) && (!bri->set_scl || !bri-
> >get_scl)) {
> 		if (!gpio_is_valid(bri->scl_gpio))
> 			err_str = "invalid SCL gpio";
> 		else
> 			err_str = "no {get|set}_scl() found";
> 		goto err;
> 	}
> 
> 	if (gpio_is_valid(bri->sda_gpio))
> 		bri->get_sda = get_sda_gpio_value;
> 
> 	if (gpio_is_valid(bri->scl_gpio)) {
> 		bri->get_scl = get_scl_gpio_value;
> 		bri->set_scl = set_scl_gpio_value;
> 	}
> 
> 	return;
>   err:
> 	dev_err(&adap->dev, "Not using recovery: %s\n", err_str);
> 	adap->bus_recovery_info = NULL;
> }


I have briefly looked at the current code. 
So, my suggestion is to switch to gpio descriptors in current code and
then rebase your stuff on top.

I wouldn't encourage people to continue using legacy GPIO API.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
