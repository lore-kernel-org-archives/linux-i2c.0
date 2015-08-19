From: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [Patch v2] i2c: imx: implement bus recovery
Date: Wed, 19 Aug 2015 03:44:49 +0000
Message-ID: <CY1PR0301MB0858E4EEEC54C81BC4E7A621CF670@CY1PR0301MB0858.namprd03.prod.outlook.com>
References: <1437100605-28047-1-git-send-email-b54642@freescale.com>
 <20150813081528.GA9999@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150813081528.GA9999-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Uwe Kleine-K=F6nig <mailto:u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> Sent=
: Thursday, August 13, 2015 4:15 PM
> To: Gao Pan-B54642
> Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Li Frank-B20596; Du=
an Fugang-B38611
> Subject: Re: [Patch v2] i2c: imx: implement bus recovery
>=20
> Hello,
>=20
> On Fri, Jul 17, 2015 at 10:36:45AM +0800, Gao Pan wrote:
> > Implement bus recovery methods for i2c-imx so we can recover from
> > situations where SCL/SDA are stuck low.
> >
> > Once i2c bus SCL/SDA are stuck low during transfer, config the i2c
> > pinctrl to gpio mode by calling pinctrl sleep set function, and the=
n
> > use GPIO to emulate the i2c protocol to send nine dummy clock to
> > recover i2c device. After recovery, set i2c pinctrl to default grou=
p
> setting.
> >
> > V2:
> > As Uwe Kleine-K=F6nig's suggestion, the version do below changes:
> >  -replace of_get_named_gpio() with devm_gpiod_get_optional()  -move
> > gpio_direction_input() and gpio_direction_output() call to the
> >   prepare callback
> >  -use 0 and 1 as return value for the get_scl and get_sda callbacks
>=20
> this section usally goes after the triple-dash below. Otherwise this =
is
> included in the commit log which it shouldn't.

Thanks, will change it in the next version.
=20
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> > b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> > index ce4311d..a9fe525 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> > @@ -14,6 +14,8 @@ Optional properties:
> >    The absence of the propoerty indicates the default frequency 100=
 kHz.
> >  - dmas: A list of two dma specifiers, one for each entry in dma-na=
mes.
> >  - dma-names: should contain "tx" and "rx".
> > +- scl-gpio: specify the gpio related to SCL pin
> > +- sda-gpio: specify the gpio related to SDA pin
>=20
> In the meantime I learned that "...-gpios" is the recommended name fo=
r
> such properties, even if conceptually there can only be a single gpio
> here. (You might want to help to change that?!)

Thanks, will change it in the next version.
=20
> > @@ -436,7 +444,7 @@ static int i2c_imx_bus_busy(struct imx_i2c_stru=
ct
> *i2c_imx, int for_busy)
> >  		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500)))
> {
> >  			dev_dbg(&i2c_imx->adapter.dev,
> >  				"<%s> I2C bus is busy\n", __func__);
> > -			return -ETIMEDOUT;
> > +			return i2c_recover_bus(&i2c_imx->adapter);
> >  		}
> >  		schedule();
> >  	}
> > @@ -450,7 +458,7 @@ static int i2c_imx_trx_complete(struct
> > imx_i2c_struct *i2c_imx)
> >
> >  	if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
> >  		dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
> > -		return -ETIMEDOUT;
> > +		return i2c_recover_bus(&i2c_imx->adapter);
>=20
> I'm still not convinced that doing that here unconditionally is a goo=
d
> idea. Wolfram will know for sure.
=20
Thanks, I will remove this change in next version.
=20
> > +static void i2c_imx_prepare_recovery(struct i2c_adapter *adap) {
> > +	struct imx_i2c_struct *i2c_imx;
> > +
> > +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> > +	if (i2c_imx->pins.sda && i2c_imx->pins.scl) {
> > +		pinctrl_pm_select_sleep_state(&adap->dev);
>=20
> Your requirement that the sleep state should configure the pins as gp=
io
> is strange. Maybe better introduce a dedicated state for recovery? At
> least you should document this requirement.

In general, pinctrl sleep mode is gpio function. I will add this in bin=
ding doc. Thanks.

>=20
> > @@ -1004,12 +1073,13 @@ static int i2c_imx_probe(struct
> > platform_device *pdev)
> >
> >  	/* Setup i2c_imx driver structure */
> >  	strlcpy(i2c_imx->adapter.name, pdev->name, sizeof(i2c_imx-
> >adapter.name));
> > -	i2c_imx->adapter.owner		=3D THIS_MODULE;
> > -	i2c_imx->adapter.algo		=3D &i2c_imx_algo;
> > -	i2c_imx->adapter.dev.parent	=3D &pdev->dev;
> > -	i2c_imx->adapter.nr		=3D pdev->id;
> > -	i2c_imx->adapter.dev.of_node	=3D pdev->dev.of_node;
> > -	i2c_imx->base			=3D base;
> > +	i2c_imx->adapter.owner =3D THIS_MODULE;
> > +	i2c_imx->adapter.algo =3D &i2c_imx_algo;
> > +	i2c_imx->adapter.dev.parent =3D &pdev->dev;
> > +	i2c_imx->adapter.nr =3D pdev->id;
> > +	i2c_imx->adapter.dev.of_node =3D pdev->dev.of_node;
> > +	i2c_imx->adapter.bus_recovery_info =3D &i2c_imx_bus_recovery_info=
;
>=20
> What happens if the device tree only specifies a gpio for sda but not=
 scl?
> The recovery stuff is still hooked up, right? What about only doing t=
hat
> if both properties are valid? This would also get rid of the tests fo=
r
> validity in the recovery callbacks.

It requires device tree to specify gpio for sda and scl in both. Once o=
nly sda is defined,=20
the driver doesn't carry out the recovery process.

>=20
> > @@ -1037,6 +1107,24 @@ static int i2c_imx_probe(struct platform_dev=
ice
> *pdev)
> >  	/* Set up adapter data */
> >  	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
> >
> > +	/* Init recover pins */
> > +	i2c_imx->pins.sda =3D
> > +		devm_gpiod_get_optional(&pdev->dev, "sda-gpio", 0);
> > +	i2c_imx->pins.scl =3D
> > +		devm_gpiod_get_optional(&pdev->dev, "scl-gpio", 0);
>=20
> 0 is wrong here, better use GPIOD_ASIS. Is there a reason not to
> configure the direction as input already here?
=20
Thanks, 0 is inappropriate here. Actually, we should use GPIOD_OUT_HIGH
to set the gpios high.=20

> > +
> > +	if (IS_ERR(i2c_imx->pins.sda)) {
> > +		ret =3D PTR_ERR(i2c_imx->pins.sda);
> > +		dev_err(&pdev->dev, "Failed to get sda gpio: %d\n", ret);
> > +		i2c_imx->pins.sda =3D NULL;
> > +	}
>=20
> As you're using devm_gpiod_get_optional there is no justification to
> ignore the error code.

Thanks, will change it in next version.
