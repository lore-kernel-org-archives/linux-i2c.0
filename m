From: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [Patch V7] i2c: imx: add runtime pm support to improve the
 performance
Date: Fri, 18 Sep 2015 09:21:00 +0000
Message-ID: <CY1PR0301MB0858997BAAD2518138B21EC6CF590@CY1PR0301MB0858.namprd03.prod.outlook.com>
References: <1441764739-23086-1-git-send-email-b54642@freescale.com>
 <20150918081358.GU5327@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150918081358.GU5327-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Uwe Kleine-K=F6nig <mailto:u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> Sent=
: Friday, September 18, 2015 4:14 PM
> To: Gao Pan-B54642
> Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; Li Frank-B20596; Duan Fugang-B38611; linux-
> i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> Subject: Re: [Patch V7] i2c: imx: add runtime pm support to improve t=
he
> performance
>=20
> Hello,
>=20
> On Wed, Sep 09, 2015 at 10:12:19AM +0800, Gao Pan wrote:
> >  static irqreturn_t i2c_imx_isr(int irq, void *dev_id) @@ -894,6
> > +893,10 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
> >
> >  	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> >
> > +	result =3D pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
> > +	if (result < 0)
> > +		goto out;
> > +
> >  	/* Start I2C transfer */
> >  	result =3D i2c_imx_start(i2c_imx);
> >  	if (result)
> > @@ -950,6 +953,10 @@ fail0:
> >  	/* Stop I2C transfer */
> >  	i2c_imx_stop(i2c_imx);
> >
> > +out:
> > +	pm_runtime_mark_last_busy(i2c_imx->adapter.dev.parent);
> > +	pm_runtime_put_autosuspend(i2c_imx->adapter.dev.parent);
> > +
>=20
> I doubt that it's correct to call these two functions if
> pm_runtime_get_sync failed. Shouldn't the out label be after the two
> calls?
=20
Thanks, will change it in next version.
=20
> Other than that I assume you tested your patch with and without CONFI=
G_PM?

Thanks, I have tested the patch. The function is ok without CONFIG_PM.
The patch uses clk_prepare_enable in the probe. Even if CONFIG_PM is di=
sabled, it still can work.
=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/
