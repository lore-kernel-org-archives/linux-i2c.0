From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/2] MXS: Implement DMA support into mxs-i2c
Date: Fri, 29 Jun 2012 11:30:16 +0200
Message-ID: <201206291130.17060.marex@denx.de>
References: <1340958243-2332-1-git-send-email-marex@denx.de> <1340958243-2332-2-git-send-email-marex@denx.de> <20120629091900.GJ5844@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120629091900.GJ5844-Fb7DQEYuewWctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng-B29396 <B29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Estevam Fabio-R49496 <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Dong Aisheng,

> On Fri, Jun 29, 2012 at 04:24:03PM +0800, Marek Vasut wrote:
> > This patch implements DMA support into mxs-i2c. DMA transfers are n=
ow
> > enabled via DT. The DMA operation is enabled by default.
> >=20
> > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>
> > CC: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Cc: Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
> > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > CC: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > CC: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
> > CC: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >=20
> >  Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    4 +
> >  arch/arm/boot/dts/imx28.dtsi                      |    2 +
> >  drivers/i2c/busses/i2c-mxs.c                      |  267
> >  +++++++++++++++++++-- 3 files changed, 251 insertions(+), 22
> >  deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt index
> > d2bf750..9497ee0 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> >=20
> > @@ -5,6 +5,10 @@ Required properties:
> >  - reg: Should contain registers location and length
> >  - interrupts: Should contain ERROR and DMA interrupts
> >  - clock-frequency: desired I2C bus clock frequency in Hz.
> >=20
> > +- fsl,i2c-dma-channel: APBX DMA channel for the I2C
>=20
> Shoundn't this be optional?

DMA channel? No, why?

>=20
> > +	/*
> > +	 * The last descriptor must have this callback,
> > +	 * to finish the DMA transaction.
> > +	 */
> > +	desc->callback =3D mxs_i2c_dma_irq_callback;
> > +	desc->callback_param =3D i2c;
> > +
> > +	/* Start the transfer. */
> > +	dmaengine_submit(desc);
> > +	dma_async_issue_pending(i2c->dmach);
> > +	return 0;
> > +
> > +/* Read failpath. */
> > +read_init_dma_fail:
> > +	dma_unmap_sg(i2c->dev, &i2c->sg_io[1], 1, DMA_FROM_DEVICE);
> > +select_init_dma_fail:
> > +	dma_unmap_sg(i2c->dev, &i2c->sg_io[0], 1, DMA_TO_DEVICE);
> > +select_init_pio_fail:
> > +	return 1;
>=20
> look strange why return 1;

Because it failed. -Esomething might be better ?

> > +
> > +
>=20
> One more unnecessary line?
>=20
> > +/* Write failpath. */
> > +write_init_dma_fail:
> > +	dma_unmap_sg(i2c->dev, i2c->sg_io, 2, DMA_TO_DEVICE);
> > +write_init_pio_fail:
> > +	return 1;
> > +}
> > +
>=20
> ..
>=20
> > @@ -291,6 +459,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter =
*adap,
> > struct i2c_msg *msg,
> >=20
> >  timeout:
> >  	dev_dbg(i2c->dev, "Timeout!\n");
> >=20
> > +	mxs_i2c_dma_finish(i2c);
>=20
> Shared with pio?

Doesn't dma_unmap_sg() call check if the buffer is there or not? Theref=
ore it=20
shouldn't have any effect on PIO ops. But it can be indeed if-ed.

> >  	mxs_i2c_reset(i2c);
> >  	return -ETIMEDOUT;
> > =20
> >  }
>=20
> Regards
> Dong Aisheng

Best regards,
Marek Vasut
