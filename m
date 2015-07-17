From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [Patch v1] i2c: imx: implement bus recovery
Date: Fri, 17 Jul 2015 11:05:28 +0200
Message-ID: <1437123928.3498.69.camel@pengutronix.de>
References: <1436839486-11110-1-git-send-email-b54642@freescale.com>
	 <20150714064832.GY1426@pengutronix.de>
	 <CY1PR0301MB0858C32968C39EA0E60E2904CF9B0@CY1PR0301MB0858.namprd03.prod.outlook.com>
	 <1437051462.3344.140.camel@pengutronix.de>
	 <CY1PR0301MB085871D1FF9A9CF52F452E99CF980@CY1PR0301MB0858.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CY1PR0301MB085871D1FF9A9CF52F452E99CF980-YrwGdl+PljlUWoKpOwApjpwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, devicetree-discuss <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fr, 2015-07-17 at 02:26 +0000, Gao Pandy wrote:
> From: Jan L=C3=BCbbe <mailto:jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> Sent: Thursday, July=
 16, 2015 8:58 PM
> > To: Gao Pan-B54642
> > Cc: Uwe Kleine-K=C3=B6nig; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; linux-i2c-u79uwXL29TZUIDd8j+nm9g@public.gmane.org=
=2Eorg; Li
> > Frank-B20596; Duan Fugang-B38611
> > Subject: Re: [Patch v1] i2c: imx: implement bus recovery
> >=20
> > On Di, 2015-07-14 at 08:12 +0000, Gao Pandy wrote:
> > > > > --- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> > > > > +++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> > > > > @@ -14,6 +14,8 @@ Optional properties:
> > > > >    The absence of the propoerty indicates the default frequen=
cy
> > > 100 kHz.
> > > > >  - dmas: A list of two dma specifiers, one for each entry in
> > > dma-names.
> > > > >  - dma-names: should contain "tx" and "rx".
> > > > > +- recover-scl: specify the gpio related to SCL pin
> > > > > +- recover-sda: specify the gpio related to SDA pin
> > > > I don't like the naming here. That the gpios are used for recov=
ery
> > > isn't
> > > > a hardware description. What about "scl-gpio" and "sda-gpio"?
> > >
> > > Thanks. I will change it in the next version.
> >=20
> > There is already a binding for i2c-gpio:
> > Documentation/devicetree/bindings/i2c/i2c-gpio.txt
> >=20
> > We should be able to reuse those properties as-is, instead of defin=
ing
> > something for each i2c controller binding.
>=20
> Thanks. The hardware description in i2c-gpio.txt describes the case o=
f=20
> i2c gpio. However, in our patch, we just want the sda and scl pins ch=
ange
> to gpio mode for bus recovery, after recovery, we set the two pins to=
 i2c function,
> i2c host controller will take over the transfer. So it's a different =
case.

Please note that the devicetree binding should describe the hardware,
not what Linux is doing with the hardware. And on the HW-level I2C
recovery with GPIOs is basically the same as using the GPIOs for normal
I2C.

We don't want to have different DT bindings for every I2C controller
which needs to use GPIOs for recovery. We already know that the existin=
g
i2c-gpio bindings are enough to do normal I2C transfers, so they should
also be good for the recovery case.

You also need to add devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org to CC for patches
changing DT bindings.

> Once we use the hardware description in i2c-gpio.txt, additional gpio=
s should
> be applied. Correspondingly, it also need plentiful code support.

Which additional GPIOs do you mean?

By having a common binding for recovery (based on or identical to
i2c-gpios), we can have common setup code for GPIO recovery instead of
duplicating the DT parsing and setup code in each driver. We probably
should define the pinmux state name which is used for GPIO mode as
well.=20

Regards,
Jan
--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
