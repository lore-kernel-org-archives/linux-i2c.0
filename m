From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 3/3] I2C: mediatek: Add driver for MediaTek I2C controller
Date: Mon, 3 Nov 2014 09:11:05 +0100
Message-ID: <20141103081105.GD14482@pengutronix.de>
References: <1414561058-23803-1-git-send-email-xudong.chen@mediatek.com>
 <1414561058-23803-4-git-send-email-xudong.chen@mediatek.com>
 <CABuKBe+RXboBEZD7Bu_kSbVwiapJJcAuuw_wo=xw67osJWJ20w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CABuKBe+RXboBEZD7Bu_kSbVwiapJJcAuuw_wo=xw67osJWJ20w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Nathan Chung <nathan.chung-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, YH Chen <yh.chen@media>
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 30, 2014 at 02:16:04PM +0100, Matthias Brugger wrote:
> 2014-10-29 6:37 GMT+01:00 Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>:
> > +static int mt_i2c_do_transfer(struct mt_i2c *i2c)
> > +{
> > +       u16 addr_reg;
> > +       u16 control_reg;
> > +       int tmo = i2c->adap.timeout;
> > +
> > +       i2c->trans_stop = false;
> > +       i2c->irq_stat = 0;
> > +
> > +       /* If use i2c pin from PMIC mt6397 side, need set PATH_DIR first */
> > +       if (i2c->have_pmic)
> > +               i2c_writew(I2C_CONTROL_WRAPPER, i2c, OFFSET_PATH_DIR);
> 
> So this is some sort of multiplexer bit, right?
> I think in this case we need to build a multi function device (mfd)
> where the pmic driver will set this bit.

This bit is in the i2c controller register space, so it shouldn't be
controlled by some other driver. I think the configuration of this
register is already in the correct place. What I could think of is that
the PMIC could implement a pinctrl driver and the i2c controller driver
gets the pins from the PMIC. Anyway, the controlling of this bit would
still be in the i2c driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
