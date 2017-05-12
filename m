From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c-designware: add i2c gpio recovery option
Date: Fri, 12 May 2017 13:17:53 +0300
Message-ID: <1494584273.6967.36.camel@linux.intel.com>
References: <2259005.m0altzP21Z@dabox> <1966782.aCEMFj2YWU@virgo>
         <4a84d6b1-2bba-6f01-8286-49661ef45576@electromag.com.au>
         <32490844.DoY2McpBxU@dabox> <1494421981.16411.7.camel@linux.intel.com>
         <0aafcff1-6970-e99e-5b93-b0877ebf8579@electromag.com.au>
         <1494510791.6967.9.camel@linux.intel.com>
         <b136aa47-da70-57c7-03fd-b581cd9b7ce8@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:30618 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbdELKTb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 12 May 2017 06:19:31 -0400
In-Reply-To: <b136aa47-da70-57c7-03fd-b581cd9b7ce8@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, Tim Sander <tim@krieglstein.org>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2017-05-12 at 09:49 +0800, Phil Reid wrote:
> On 11/05/2017 21:53, Andy Shevchenko wrote:
> > > > > +static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev,
> > > > > +                                    struct i2c_adapter *adap)
> > > > > +{
> > > > > +       struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
> > > > > +
> > > > > +       dev->gpio_scl = devm_gpiod_get_optional(dev->dev,
> > > > > +                                               "scl",
> > > > > +                                               GPIOD_OUT_HIGH
> > > > > );
> > > > > +       if (IS_ERR_OR_NULL(dev->gpio_scl))
> > > > 
> > > > This is wrong. You should not use this macro in most cases. And
> > > > especially it breaks the logic behind _optional().
> > > 
> > > My logic here was that if the gpio is optional return null we
> > > return
> > > 0.
> > 
> > Why?!
> > 
> > _optional()*implies*  that all rest calls will go fine and do
> > nothing.
> > 
> > > which is an okay status.
> > > But this breaks if !CONFIG_GPIOLIB, which I keep forgetting. I've
> > > never
> > > quite wrapped my head around why that's the case.
> > > 
> > > But the probe function only bails out if this returns
> > > EPROBE_DEFER.
> > > Not sure that's the best approach
> > 
> > You need something like
> > 
> > desc = devm_gpiod_get_optional(...);
> > if (IS_ERR(desc))
> >   return PTR_ERR(desc);
> > 
> 
> I found that continuing without the check on null results in a kernel
> panic for a dereferenced null pointer.
> So something in the gpiolib doesn't treat a null desc as optional.
> 
> It was probably this code:
> int desc_to_gpio(const struct gpio_desc *desc)
> {
> 	return desc->gdev->base + (desc - &desc->gdev->descs[0]);
> }
> 
> So perhaps this should return an invalid gpio number when desc == null
> 
> I don't know what the intents are, so don't know if its a "bug" or  by
> design.

No, it doesn't seem like a bug to me. If you don't use legacy API it
would be fine.

Summarize this discussion, I would rather go this way:
1) introduce gpiod_ based API in I2C core for recovering;
2) rebase your patch on top of that change.

It would be beneficial in a long term for everyone.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
