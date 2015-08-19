From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [Patch v2] i2c: imx: implement bus recovery
Date: Wed, 19 Aug 2015 09:02:18 +0200
Message-ID: <20150819070218.GE9999@pengutronix.de>
References: <1437100605-28047-1-git-send-email-b54642@freescale.com>
 <20150813081528.GA9999@pengutronix.de>
 <CY1PR0301MB0858E4EEEC54C81BC4E7A621CF670@CY1PR0301MB0858.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CY1PR0301MB0858E4EEEC54C81BC4E7A621CF670-YrwGdl+PljlUWoKpOwApjpwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

Cc +=3D Linus Walleij

On Wed, Aug 19, 2015 at 03:44:49AM +0000, Gao Pandy wrote:
> From: Uwe Kleine-K=F6nig <mailto:u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> Sent=
: Thursday, August 13, 2015 4:15 PM
> > > +static void i2c_imx_prepare_recovery(struct i2c_adapter *adap) {
> > > +	struct imx_i2c_struct *i2c_imx;
> > > +
> > > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> > > +	if (i2c_imx->pins.sda && i2c_imx->pins.scl) {
> > > +		pinctrl_pm_select_sleep_state(&adap->dev);
> >=20
> > Your requirement that the sleep state should configure the pins as =
gpio
> > is strange. Maybe better introduce a dedicated state for recovery? =
At
> > least you should document this requirement.
>=20
> In general, pinctrl sleep mode is gpio function. I will add this in b=
inding doc. Thanks.

Linus, do you have to say something here? It might be right to have the
gpio function as configuration for sleep mode, but it doesn't look righ=
t
for me to use this for recovery purposes.

=20
> >=20
> > > @@ -1004,12 +1073,13 @@ static int i2c_imx_probe(struct
> > > platform_device *pdev)
> > >
> > >  	/* Setup i2c_imx driver structure */
> > >  	strlcpy(i2c_imx->adapter.name, pdev->name, sizeof(i2c_imx-
> > >adapter.name));
> > > -	i2c_imx->adapter.owner		=3D THIS_MODULE;
> > > -	i2c_imx->adapter.algo		=3D &i2c_imx_algo;
> > > -	i2c_imx->adapter.dev.parent	=3D &pdev->dev;
> > > -	i2c_imx->adapter.nr		=3D pdev->id;
> > > -	i2c_imx->adapter.dev.of_node	=3D pdev->dev.of_node;
> > > -	i2c_imx->base			=3D base;
> > > +	i2c_imx->adapter.owner =3D THIS_MODULE;
> > > +	i2c_imx->adapter.algo =3D &i2c_imx_algo;
> > > +	i2c_imx->adapter.dev.parent =3D &pdev->dev;
> > > +	i2c_imx->adapter.nr =3D pdev->id;
> > > +	i2c_imx->adapter.dev.of_node =3D pdev->dev.of_node;
> > > +	i2c_imx->adapter.bus_recovery_info =3D &i2c_imx_bus_recovery_in=
fo;
> >=20
> > What happens if the device tree only specifies a gpio for sda but n=
ot scl?
> > The recovery stuff is still hooked up, right? What about only doing=
 that
> > if both properties are valid? This would also get rid of the tests =
for
> > validity in the recovery callbacks.
>=20
> It requires device tree to specify gpio for sda and scl in both. Once=
 only sda is defined,=20
> the driver doesn't carry out the recovery process.

Right, and still it is convinced it is able to recover the bus, right?
Can you please change this?

> >=20
> > > @@ -1037,6 +1107,24 @@ static int i2c_imx_probe(struct platform_d=
evice
> > *pdev)
> > >  	/* Set up adapter data */
> > >  	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
> > >
> > > +	/* Init recover pins */
> > > +	i2c_imx->pins.sda =3D
> > > +		devm_gpiod_get_optional(&pdev->dev, "sda-gpio", 0);
> > > +	i2c_imx->pins.scl =3D
> > > +		devm_gpiod_get_optional(&pdev->dev, "scl-gpio", 0);
> >=20
> > 0 is wrong here, better use GPIOD_ASIS. Is there a reason not to
> > configure the direction as input already here?
> =20
> Thanks, 0 is inappropriate here. Actually, we should use GPIOD_OUT_HI=
GH
> to set the gpios high.=20

Are you sure? Consider the bus is blocked and you switch to gpio mode t=
o
do recovery you have a device pulling SDA to 0 and the imx pulling it t=
o
1. That's wrong, isn't it?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
