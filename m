From: Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 2/2] MXS: Implement DMA support into mxs-i2c
Date: Fri, 29 Jun 2012 20:05:13 +0800
Message-ID: <20120629120512.GP5844@shlinux2.ap.freescale.net>
References: <1340958243-2332-1-git-send-email-marex@denx.de>
 <201206291130.17060.marex@denx.de>
 <20120629093806.GL5844@shlinux2.ap.freescale.net>
 <201206291202.46986.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201206291202.46986.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Dong Aisheng-B29396 <B29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Estevam Fabio-R49496 <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 29, 2012 at 06:02:46PM +0800, Marek Vasut wrote:
> Dear Dong Aisheng,
>=20
> > On Fri, Jun 29, 2012 at 05:30:16PM +0800, Marek Vasut wrote:
> > > Dear Dong Aisheng,
> > >=20
> > > > On Fri, Jun 29, 2012 at 04:24:03PM +0800, Marek Vasut wrote:
> > > > > This patch implements DMA support into mxs-i2c. DMA transfers=
 are now
> > > > > enabled via DT. The DMA operation is enabled by default.
> > > > >=20
> > > > > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > > > > Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>
> > > > > CC: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > > > CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > > > Cc: Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
> > > > > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > > CC: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > > > CC: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > > > Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
> > > > > CC: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > > > Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
> > > > > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > > > ---
> > > > >=20
> > > > >  Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    4 +
> > > > >  arch/arm/boot/dts/imx28.dtsi                      |    2 +
> > > > >  drivers/i2c/busses/i2c-mxs.c                      |  267
> > > > >  +++++++++++++++++++-- 3 files changed, 251 insertions(+), 22
> > > > >  deletions(-)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.tx=
t
> > > > > b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt index
> > > > > d2bf750..9497ee0 100644
> > > > > --- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > > > > +++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > > > >=20
> > > > > @@ -5,6 +5,10 @@ Required properties:
> > > > >  - reg: Should contain registers location and length
> > > > >  - interrupts: Should contain ERROR and DMA interrupts
> > > > >  - clock-frequency: desired I2C bus clock frequency in Hz.
> > > > >=20
> > > > > +- fsl,i2c-dma-channel: APBX DMA channel for the I2C
> > > >=20
> > > > Shoundn't this be optional?
> > >=20
> > > DMA channel? No, why?
> >=20
> > User can use pio mode, so actually it's optional.
> > Is it reasonable?
>=20
> PIO mode is something that should not be used unless it's to be used =
for=20
> debugging purposes. The ultimate goal then is to use PIO for small tr=
ansfers and=20
> DMA for large transfers. But that's not implemented yet and DMA is de=
fault.
>=20
Because DMA channel is not the minimum required properties to make HW w=
ork,
so i had that question.
Anyway, i think it's not a big issue.
If you really like it to be mandatory required for default dma mode, i'=
m ok with it.

> > > > > +	/*
> > > > > +	 * The last descriptor must have this callback,
> > > > > +	 * to finish the DMA transaction.
> > > > > +	 */
> > > > > +	desc->callback =3D mxs_i2c_dma_irq_callback;
> > > > > +	desc->callback_param =3D i2c;
> > > > > +
> > > > > +	/* Start the transfer. */
> > > > > +	dmaengine_submit(desc);
> > > > > +	dma_async_issue_pending(i2c->dmach);
> > > > > +	return 0;
> > > > > +
> > > > > +/* Read failpath. */
> > > > > +read_init_dma_fail:
> > > > > +	dma_unmap_sg(i2c->dev, &i2c->sg_io[1], 1, DMA_FROM_DEVICE);
> > > > > +select_init_dma_fail:
> > > > > +	dma_unmap_sg(i2c->dev, &i2c->sg_io[0], 1, DMA_TO_DEVICE);
> > > > > +select_init_pio_fail:
> > > > > +	return 1;
> > > >=20
> > > > look strange why return 1;
> > >=20
> > > Because it failed. -Esomething might be better ?
> >=20
> > i think yes.
>=20
> And -Ewhat do you suggest ? :)
>=20
I checked mxs-dma driver, it seems both EBUSY or EINVAL are ok.
You can choose one. :)

Regards
Dong Aisheng
