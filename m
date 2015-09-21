From: Gao Pandy <gaopan@freescale.com>
Subject: RE: [Patch V5] i2c: imx: implement bus recovery
Date: Mon, 21 Sep 2015 04:29:20 +0000
Message-ID: <CY1PR0301MB0858E1C589215DBAFBE9E35ECF460@CY1PR0301MB0858.namprd03.prod.outlook.com>
References: <1441968155-10918-1-git-send-email-b54642@freescale.com>
 <20150918075457.GT5327@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0110.outbound.protection.outlook.com ([207.46.100.110]:32852
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750889AbbIUE3Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 21 Sep 2015 00:29:24 -0400
In-Reply-To: <20150918075457.GT5327@pengutronix.de>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Li Frank <Frank.Li@freescale.com>, Duan Andy <fugang.duan@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

=46rom: linux-i2c-owner@vger.kernel.org <mailto:linux-i2c-owner@vger.ke=
rnel.org> Sent: Friday, September 18, 2015 3:55 PM
> To: Gao Pan-B54642
> Cc: wsa@the-dreams.de; shawnguo@kernel.org; kernel@pengutronix.de; li=
nux-
> i2c@vger.kernel.org; Li Frank-B20596; Duan Fugang-B38611; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [Patch V5] i2c: imx: implement bus recovery
>=20
> Hello,
>=20
> On Fri, Sep 11, 2015 at 06:42:34PM +0800, Gao Pan wrote:
> > V5:
> >  -introduce a dedicated gpio state for bus recovery.
> >  -assign adapter.bus_recovery_info after the two gpios were aquired
> successfully.
>=20
> You also do this if the gpios were not acquired successfully.
=20
Thanks. If the gpios are not acquired successfully, the context goes to=
 label clk_disable. So the assignment is skipped.
Please see the following code.

      ......
 =20
	if (IS_ERR(i2c_imx->pins.sda)) {
		ret =3D PTR_ERR(i2c_imx->pins.sda);
		goto clk_disable;
	}
	if (IS_ERR(i2c_imx->pins.scl)) {
		ret =3D PTR_ERR(i2c_imx->pins.scl);
		goto clk_disable;
	}
=09
	i2c_imx->adapter.bus_recovery_info =3D &i2c_imx_bus_recovery_info;

	......


>=20
> > +	if (IS_ERR(i2c_imx->pinctrl_pins_default))
> > +		dev_warn(&pdev->dev, "could not get default state\n");
> > +	else {
> > +		i2c_imx->pinctrl_pins_gpio =3D pinctrl_lookup_state(i2c_imx-
> >pinctrl,
> > +						I2C_PINCTRL_STATE_GPIO);
> > +		if (IS_ERR(i2c_imx->pinctrl_pins_gpio))
> > +			dev_warn(&pdev->dev, "could not get gpio state\n");
>=20
> IMHO pinctrl_lookup_state returning an error is enough to not try a
> recovery.
=20
Thanks, you are right. How about the following logic.

	if (!(IS_ERR(i2c_imx->pinctrl_pins_default)) && !(IS_ERR(i2c_imx->pinc=
trl_pins_gpio))) {
                i2c_imx->pins.sda =3D
                        devm_gpiod_get_optional(&pdev->dev, "sda-gpios"=
, GPIOD_IN);
                i2c_imx->pins.scl =3D
                        devm_gpiod_get_optional(&pdev->dev, "scl-gpios"=
, GPIOD_IN);

                if (IS_ERR(i2c_imx->pins.sda)) {
                        ret =3D PTR_ERR(i2c_imx->pins.sda);
                        goto clk_disable;
                }

                if (IS_ERR(i2c_imx->pins.scl)) {
                        ret =3D PTR_ERR(i2c_imx->pins.scl);
                        goto clk_disable;
                }

                i2c_imx->adapter.bus_recovery_info =3D &i2c_imx_bus_rec=
overy_info;
	}=20


>=20
> > +	}
> > +
> >  	/* Request IRQ */
> >  	ret =3D devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
> >  				pdev->name, i2c_imx);
> > @@ -1057,6 +1146,24 @@ static int i2c_imx_probe(struct platform_dev=
ice
> *pdev)
> >  	if (ret < 0)
> >  		goto rpm_disable;
> >
> > +	/* Init recover pins */
> > +	i2c_imx->pins.sda =3D
> > +		devm_gpiod_get_optional(&pdev->dev, "sda-gpios", GPIOD_IN);
> > +	i2c_imx->pins.scl =3D
> > +		devm_gpiod_get_optional(&pdev->dev, "scl-gpios", GPIOD_IN);
> > +
> > +	if (IS_ERR(i2c_imx->pins.sda)) {
> > +		ret =3D PTR_ERR(i2c_imx->pins.sda);
> > +		goto clk_disable;
> > +	}
> > +
> > +	if (IS_ERR(i2c_imx->pins.scl)) {
> > +		ret =3D PTR_ERR(i2c_imx->pins.scl);
> > +		goto clk_disable;
> > +	}
> > +
>=20
> if (i2c_imx->pins.sda && i2c_imx->pins.scl)
>=20
> > +	i2c_imx->adapter.bus_recovery_info =3D &i2c_imx_bus_recovery_info=
;
> > +
> >  	/* Set up clock divider */
> >  	i2c_imx->bitrate =3D IMX_I2C_BIT_RATE;
> >  	ret =3D of_property_read_u32(pdev->dev.of_node,
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/
> |
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at
> http://vger.kernel.org/majordomo-info.html
