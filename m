From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v5 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Mon, 30 Mar 2015 19:23:09 +0200
Message-ID: <20150330172309.GB9742@pengutronix.de>
References: <1426917922-61356-1-git-send-email-eddie.huang@mediatek.com>
 <1426917922-61356-3-git-send-email-eddie.huang@mediatek.com>
 <20150323084237.GG9742@pengutronix.de>
 <1427703252.26464.14.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427703252.26464.14.camel@mtksdaap41>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel@li
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 30, 2015 at 04:14:12PM +0800, Eddie Huang wrote:
> Hi Sascha,
> 
> > 
> > [...]
> > 
> > > +	if (i2c->speed_hz > 400000)
> > > +		control_reg |= I2C_CONTROL_RS;
> > > +	if (i2c->op == I2C_MASTER_WRRD)
> > > +		control_reg |= I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS;
> > > +	mtk_i2c_writew(control_reg, i2c, OFFSET_CONTROL);
> > > +
> > > +	/* set start condition */
> > > +	if (i2c->speed_hz <= 100000)
> > > +		mtk_i2c_writew(I2C_ST_START_CON, i2c, OFFSET_EXT_CONF);
> > > +	else
> > > +		mtk_i2c_writew(I2C_FS_START_CON, i2c, OFFSET_EXT_CONF);
> > > +
> > > +	if (~control_reg & I2C_CONTROL_RS)
> > > +		mtk_i2c_writew(I2C_DELAY_LEN, i2c, OFFSET_DELAY_LEN);
> > 
> > speed <= 400000 here to make this more obvious?
> There are two cases, not only speed<=400000, but I2C_MASTER_WRRD. I tend
> to keep it.

Still it looks strange. You only ever write this default value to the
register. Putting this register write under an if() seems bogus since
the same value will be in the register the next time this code is
executed. It looks like you should move this register write to some
initialization function.

> > > +
> > > +	/* Enable interrupt */
> > > +	mtk_i2c_writew(I2C_HS_NACKERR | I2C_ACKERR | I2C_TRANSAC_COMP,
> > > +		i2c, OFFSET_INTR_MASK);
> > 
> > Why do you enable/disable interrupts for each transfer? Enabling them
> > once and just acknowledge them in the interrupt handler should be
> > enough.
> This can avoid unwanted I2C interrupt. For example, I2C transfer error,
> and cause timeout, I2C driver report error to caller. Then I2C error
> interrupt happen.

So isn't the same unwanted interrupt then just delayed until you enable
the interrupts again? Is this something that really happens or just
something you think that might happen?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
