From: Gao Pandy <gaopan@freescale.com>
Subject: RE: [Patch V5] i2c: imx: implement bus recovery
Date: Mon, 21 Sep 2015 08:13:37 +0000
Message-ID: <CY1PR0301MB085882BC97E7AA60F2BA7F0ECF460@CY1PR0301MB0858.namprd03.prod.outlook.com>
References: <1441968155-10918-1-git-send-email-b54642@freescale.com>
 <20150918075457.GT5327@pengutronix.de>
 <CY1PR0301MB0858E1C589215DBAFBE9E35ECF460@CY1PR0301MB0858.namprd03.prod.outlook.com>
 <20150921063323.GA754@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0111.outbound.protection.outlook.com ([207.46.100.111]:12704
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752069AbbIUINk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 21 Sep 2015 04:13:40 -0400
In-Reply-To: <20150921063323.GA754@pengutronix.de>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Li Frank <Frank.Li@freescale.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Duan Andy <fugang.duan@freescale.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

=46rom: Uwe Kleine-K=F6nig <mailto:u.kleine-koenig@pengutronix.de> Sent=
: Monday, September 21, 2015 2:33 PM
> To: Gao Pan-B54642
> Cc: Li Frank-B20596; wsa@the-dreams.de; linux-i2c@vger.kernel.org;
> kernel@pengutronix.de; Duan Fugang-B38611; shawnguo@kernel.org; linux=
-
> arm-kernel@lists.infradead.org
> Subject: Re: [Patch V5] i2c: imx: implement bus recovery
>=20
> Hello,
>=20
> On Mon, Sep 21, 2015 at 04:29:20AM +0000, Gao Pandy wrote:
> > > On Fri, Sep 11, 2015 at 06:42:34PM +0800, Gao Pan wrote:
> > > > V5:
> > > >  -introduce a dedicated gpio state for bus recovery.
> > > >  -assign adapter.bus_recovery_info after the two gpios were aqu=
ired
> > > >   successfully.
> > >
> > > You also do this if the gpios were not acquired successfully.
> >
> > Thanks. If the gpios are not acquired successfully, the context goe=
s
> > to label clk_disable. So the assignment is skipped.
> > Please see the following code.
> >
> >       ......
> >
> > 	if (IS_ERR(i2c_imx->pins.sda)) {
> > 		ret =3D PTR_ERR(i2c_imx->pins.sda);
> > 		goto clk_disable;
> > 	}
> > 	if (IS_ERR(i2c_imx->pins.scl)) {
> > 		ret =3D PTR_ERR(i2c_imx->pins.scl);
> > 		goto clk_disable;
> > 	}
> >
> > 	i2c_imx->adapter.bus_recovery_info =3D &i2c_imx_bus_recovery_info;
> >
> > 	......
>=20
> Right, if devm_gpiod_get_optional returns an error probing fails and
> everything is right. If however devm_gpiod_get_optional returns NULL =
(i.e.
> the dt doesn't contain an scl-gpios property) you happily use them ev=
en
> though gpio_set_value are stubs in this case.
=20
Thanks, you are right.

> > > IMHO pinctrl_lookup_state returning an error is enough to not try=
 a
> > > recovery.
> >
> > Thanks, you are right. How about the following logic.
> >
> > 	if (!(IS_ERR(i2c_imx->pinctrl_pins_default)) &&
> > !(IS_ERR(i2c_imx->pinctrl_pins_gpio))) {
>=20
> After the ! you don't need a (, but apart from this the logic is fine=
=2E
>=20
> >                 i2c_imx->pins.sda =3D
> >                         devm_gpiod_get_optional(&pdev->dev, "sda-gp=
ios",
> GPIOD_IN);
> >                 i2c_imx->pins.scl =3D
> >                         devm_gpiod_get_optional(&pdev->dev,
> > "scl-gpios", GPIOD_IN);
> >
> >                 if (IS_ERR(i2c_imx->pins.sda)) {
> >                         ret =3D PTR_ERR(i2c_imx->pins.sda);
> >                         goto clk_disable;
> >                 }
> >
> >                 if (IS_ERR(i2c_imx->pins.scl)) {
> >                         ret =3D PTR_ERR(i2c_imx->pins.scl);
> >                         goto clk_disable;
> >                 }
>=20
> As said above, here you need an
>=20
> 		if (i2c_imx->pins.scl && i2c_imx->pins.sda)
> >                 i2c_imx->adapter.bus_recovery_info =3D
> &i2c_imx_bus_recovery_info;
> > 	}
=20
Thank you very much, will fix it in next version.

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/
