From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [Patch V5] i2c: imx: implement bus recovery
Date: Mon, 21 Sep 2015 08:33:23 +0200
Message-ID: <20150921063323.GA754@pengutronix.de>
References: <1441968155-10918-1-git-send-email-b54642@freescale.com>
 <20150918075457.GT5327@pengutronix.de>
 <CY1PR0301MB0858E1C589215DBAFBE9E35ECF460@CY1PR0301MB0858.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56945 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbbIUGd0 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 21 Sep 2015 02:33:26 -0400
Content-Disposition: inline
In-Reply-To: <CY1PR0301MB0858E1C589215DBAFBE9E35ECF460@CY1PR0301MB0858.namprd03.prod.outlook.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pandy <gaopan@freescale.com>
Cc: Li Frank <Frank.Li@freescale.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Duan Andy <fugang.duan@freescale.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello,

On Mon, Sep 21, 2015 at 04:29:20AM +0000, Gao Pandy wrote:
> > On Fri, Sep 11, 2015 at 06:42:34PM +0800, Gao Pan wrote:
> > > V5:
> > >  -introduce a dedicated gpio state for bus recovery.
> > >  -assign adapter.bus_recovery_info after the two gpios were aquir=
ed
> > >   successfully.
> >=20
> > You also do this if the gpios were not acquired successfully.
> =20
> Thanks. If the gpios are not acquired successfully, the context goes
> to label clk_disable. So the assignment is skipped.
> Please see the following code.
>=20
>       ......
>  =20
> 	if (IS_ERR(i2c_imx->pins.sda)) {
> 		ret =3D PTR_ERR(i2c_imx->pins.sda);
> 		goto clk_disable;
> 	}
> 	if (IS_ERR(i2c_imx->pins.scl)) {
> 		ret =3D PTR_ERR(i2c_imx->pins.scl);
> 		goto clk_disable;
> 	}
> =09
> 	i2c_imx->adapter.bus_recovery_info =3D &i2c_imx_bus_recovery_info;
>=20
> 	......

Right, if devm_gpiod_get_optional returns an error probing fails and
everything is right. If however devm_gpiod_get_optional returns NULL
(i.e. the dt doesn't contain an scl-gpios property) you happily use the=
m
even though gpio_set_value are stubs in this case.
=20
> > IMHO pinctrl_lookup_state returning an error is enough to not try a
> > recovery.
> =20
> Thanks, you are right. How about the following logic.
>=20
> 	if (!(IS_ERR(i2c_imx->pinctrl_pins_default)) && !(IS_ERR(i2c_imx->pi=
nctrl_pins_gpio))) {

After the ! you don't need a (, but apart from this the logic is fine.

>                 i2c_imx->pins.sda =3D
>                         devm_gpiod_get_optional(&pdev->dev, "sda-gpio=
s", GPIOD_IN);
>                 i2c_imx->pins.scl =3D
>                         devm_gpiod_get_optional(&pdev->dev, "scl-gpio=
s", GPIOD_IN);
>=20
>                 if (IS_ERR(i2c_imx->pins.sda)) {
>                         ret =3D PTR_ERR(i2c_imx->pins.sda);
>                         goto clk_disable;
>                 }
>=20
>                 if (IS_ERR(i2c_imx->pins.scl)) {
>                         ret =3D PTR_ERR(i2c_imx->pins.scl);
>                         goto clk_disable;
>                 }

As said above, here you need an

		if (i2c_imx->pins.scl && i2c_imx->pins.sda)
>                 i2c_imx->adapter.bus_recovery_info =3D &i2c_imx_bus_r=
ecovery_info;
> 	}=20

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
