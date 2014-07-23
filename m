From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH v5 1/2] i2c: add DMA support for freescale i2c driver
Date: Wed, 23 Jul 2014 14:11:41 +0200
Message-ID: <20140723141141.6ac64f85@ipc1.ka-ro>
References: <1406103883-3572-1-git-send-email-yao.yuan@freescale.com>
	<1406103883-3572-2-git-send-email-yao.yuan@freescale.com>
	<20140723114834.411f6bb4@ipc1.ka-ro>
	<b1778af62e7b42b39381fb2699b34eb1@BL2PR03MB338.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b1778af62e7b42b39381fb2699b34eb1-AZ66ij2kwaZYLYlmg7qx2OO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

Yao Yuan wrote:
> Hi,
>=20
> Thanks for your review.
>=20
> Lothar Wa=C3=9Fmann wrote:
> > Yuan Yao wrote:
> > > Add dma support for i2c. This function depend on DMA driver.
> > > You can turn on it by write both the dmas and dma-name properties=
 in dts node.
> > >
> > > Signed-off-by: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > ---
> > >  drivers/i2c/busses/i2c-imx.c | 377
> [...]
> > > +
> > > +fail_rx:
> > > +	dma_release_channel(dma->chan_rx);
> > > +fail_tx:
> > > +	dma_release_channel(dma->chan_tx);
> > > +fail_al:
> > > +	devm_kfree(dev, dma);
> > >
> > No need for this one (that's the whole point of using devm_kzalloc(=
))!
> >=20
>=20
> When DMA request failed, I2C will switch to PIO mode. So if the faile=
d reason is just like DMA channel request failed. At this time the DMA =
should free by devm_kfree(). Is it?
>=20
OK. I didn't notice that failing DMA support wasn't a showstopper for
the whole driver.
In this case I would remove the 'failed' from the messages inside=20
i2c_imx_dma_request() to make them more benign looking and output them
with dev_dbg(), so they can be en-/disabled with CONFIG_I2C_DEBUG_BUS.

What about returning -EPROBE_DEFER in appropriate cases (when there is
a chance that the DMA driver will be probed later than the I2C driver)?


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
___________________________________________________________
