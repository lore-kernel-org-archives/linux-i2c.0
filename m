From: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v6 1/2] i2c: imx: add DMA support for freescale i2c driver
Date: Wed, 6 Aug 2014 02:26:07 +0000
Message-ID: <30487e0abf4b4564af296d17f5cebf49@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1407232563-10856-1-git-send-email-yao.yuan@freescale.com>
 <1407232563-10856-2-git-send-email-yao.yuan@freescale.com>
 <53E0C498.6070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53E0C498.6070608-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>
Cc: "LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org" <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Thanks for your review.

Varka Bhadram wrote:
> On 08/05/2014 03:26 PM, Yuan Yao wrote:
>=20
> (...)
> > +fail_rx:
> > +	dma_release_channel(dma->chan_rx);
> > +fail_tx:
> > +	dma_release_channel(dma->chan_tx);
> > +fail_al:
> > +	devm_kfree(dev, dma);
>=20
> no need to use devm_kfree() if we use devm_kzalloc()...
>=20
We have discussed it before.
As Lothar Wa=DFmann said:
"The devm_kfree() is not in the failure path of the driver's probe() fu=
nction, but in the function that tries to initialize the optional DMA s=
upport."
So It seems need to use devm_kfree().
Do you have some other opinions?

> > +	dev_info(dev, "can't use DMA\n");
> > +
> > +	return ret;
> > +}

(...)

> > +static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
> > +					struct i2c_msg *msgs)
>=20
> static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
> 			     struct i2c_msg *msgs)
>=20
> run checkpatch.pl on this patch...

Sorry for my code style. I will match open parenthesis in this case.

I had run this script before, just one warning.


> --
> Regards,
> Varka Bhadram.
