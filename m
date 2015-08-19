From: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [Patch v2] i2c: imx: implement bus recovery
Date: Wed, 19 Aug 2015 07:43:51 +0000
Message-ID: <CY1PR0301MB0858A807E83F5B1665A99EB9CF670@CY1PR0301MB0858.namprd03.prod.outlook.com>
References: <1437100605-28047-1-git-send-email-b54642@freescale.com>
 <20150813081528.GA9999@pengutronix.de>
 <CY1PR0301MB0858E4EEEC54C81BC4E7A621CF670@CY1PR0301MB0858.namprd03.prod.outlook.com>
 <20150819070218.GE9999@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150819070218.GE9999-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <mailto:linux-i2c-owner-fy+rA21nqHI@public.gmane.org=
rnel.org> Sent: Wednesday, August 19, 2015 3:02 PM
> To: Gao Pan-B54642
> Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Li Frank-B20596; Du=
an
> Fugang-B38611; Linus Walleij
> Subject: Re: [Patch v2] i2c: imx: implement bus recovery
>=20
> Hello,
>=20
> Cc +=3D Linus Walleij
>=20
> On Wed, Aug 19, 2015 at 03:44:49AM +0000, Gao Pandy wrote:
> > From: Uwe Kleine-K=F6nig <mailto:u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> Se=
nt:
> > Thursday, August 13, 2015 4:15 PM
> > > > +static void i2c_imx_prepare_recovery(struct i2c_adapter *adap)=
 {
> > > > +	struct imx_i2c_struct *i2c_imx;
> > > > +
> > > > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter=
);
> > > > +	if (i2c_imx->pins.sda && i2c_imx->pins.scl) {
> > > > +		pinctrl_pm_select_sleep_state(&adap->dev);
> > >
> > > Your requirement that the sleep state should configure the pins a=
s
> > > gpio is strange. Maybe better introduce a dedicated state for
> > > recovery? At least you should document this requirement.
> >
> > In general, pinctrl sleep mode is gpio function. I will add this in
> binding doc. Thanks.
>=20
> Linus, do you have to say something here? It might be right to have t=
he
> gpio function as configuration for sleep mode, but it doesn't look ri=
ght
> for me to use this for recovery purposes.

Thanks for your precise review.

> > >
> > > > @@ -1004,12 +1073,13 @@ static int i2c_imx_probe(struct
> > > > platform_device *pdev)
> > > >
> > > >  	/* Setup i2c_imx driver structure */
> > > >  	strlcpy(i2c_imx->adapter.name, pdev->name, sizeof(i2c_imx-
> > > >adapter.name));
> > > > -	i2c_imx->adapter.owner		=3D THIS_MODULE;
> > > > -	i2c_imx->adapter.algo		=3D &i2c_imx_algo;
> > > > -	i2c_imx->adapter.dev.parent	=3D &pdev->dev;
> > > > -	i2c_imx->adapter.nr		=3D pdev->id;
> > > > -	i2c_imx->adapter.dev.of_node	=3D pdev->dev.of_node;
> > > > -	i2c_imx->base			=3D base;
> > > > +	i2c_imx->adapter.owner =3D THIS_MODULE;
> > > > +	i2c_imx->adapter.algo =3D &i2c_imx_algo;
> > > > +	i2c_imx->adapter.dev.parent =3D &pdev->dev;
> > > > +	i2c_imx->adapter.nr =3D pdev->id;
> > > > +	i2c_imx->adapter.dev.of_node =3D pdev->dev.of_node;
> > > > +	i2c_imx->adapter.bus_recovery_info =3D
> &i2c_imx_bus_recovery_info;
> > >
> > > What happens if the device tree only specifies a gpio for sda but=
 not
> scl?
> > > The recovery stuff is still hooked up, right? What about only doi=
ng
> > > that if both properties are valid? This would also get rid of the
> > > tests for validity in the recovery callbacks.
> >
> > It requires device tree to specify gpio for sda and scl in both. On=
ce
> > only sda is defined, the driver doesn't carry out the recovery proc=
ess.
>=20
> Right, and still it is convinced it is able to recover the bus, right=
?
> Can you please change this?
=20
Yes, you are right, will change it in the next version.
=20
> > >
> > > > @@ -1037,6 +1107,24 @@ static int i2c_imx_probe(struct
> > > > platform_device
> > > *pdev)
> > > >  	/* Set up adapter data */
> > > >  	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
> > > >
> > > > +	/* Init recover pins */
> > > > +	i2c_imx->pins.sda =3D
> > > > +		devm_gpiod_get_optional(&pdev->dev, "sda-gpio", 0);
> > > > +	i2c_imx->pins.scl =3D
> > > > +		devm_gpiod_get_optional(&pdev->dev, "scl-gpio", 0);
> > >
> > > 0 is wrong here, better use GPIOD_ASIS. Is there a reason not to
> > > configure the direction as input already here?
> >
> > Thanks, 0 is inappropriate here. Actually, we should use
> > GPIOD_OUT_HIGH to set the gpios high.
>=20
> Are you sure? Consider the bus is blocked and you switch to gpio mode=
 to
> do recovery you have a device pulling SDA to 0 and the imx pulling it=
 to
> 1. That's wrong, isn't it?

Yes, you are right. The gpios should be set low. Thanks.
