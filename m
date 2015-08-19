From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [Patch v2] i2c: imx: implement bus recovery
Date: Wed, 19 Aug 2015 09:52:01 +0200
Message-ID: <20150819075201.GH9999@pengutronix.de>
References: <1437100605-28047-1-git-send-email-b54642@freescale.com>
 <20150813081528.GA9999@pengutronix.de>
 <CY1PR0301MB0858E4EEEC54C81BC4E7A621CF670@CY1PR0301MB0858.namprd03.prod.outlook.com>
 <20150819070218.GE9999@pengutronix.de>
 <CY1PR0301MB0858A807E83F5B1665A99EB9CF670@CY1PR0301MB0858.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CY1PR0301MB0858A807E83F5B1665A99EB9CF670-YrwGdl+PljlUWoKpOwApjpwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Wed, Aug 19, 2015 at 07:43:51AM +0000, Gao Pandy wrote:
> > On Wed, Aug 19, 2015 at 03:44:49AM +0000, Gao Pandy wrote:
> > > > >  	/* Set up adapter data */
> > > > >  	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
> > > > >
> > > > > +	/* Init recover pins */
> > > > > +	i2c_imx->pins.sda =3D
> > > > > +		devm_gpiod_get_optional(&pdev->dev, "sda-gpio", 0);
> > > > > +	i2c_imx->pins.scl =3D
> > > > > +		devm_gpiod_get_optional(&pdev->dev, "scl-gpio", 0);
> > > >
> > > > 0 is wrong here, better use GPIOD_ASIS. Is there a reason not t=
o
> > > > configure the direction as input already here?
> > >
> > > Thanks, 0 is inappropriate here. Actually, we should use
> > > GPIOD_OUT_HIGH to set the gpios high.
> >=20
> > Are you sure? Consider the bus is blocked and you switch to gpio mo=
de to
> > do recovery you have a device pulling SDA to 0 and the imx pulling =
it to
> > 1. That's wrong, isn't it?
>=20
> Yes, you are right. The gpios should be set low. Thanks.
Then on switching to the gpio function from an idle bus (which should b=
e
the normal case) you pull both lines low which depending on the timing
might even be recognised as a start condition. I'm convinced the right
thing to select here is GPIOD_IN.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
