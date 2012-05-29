From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/2] MXS: Set I2C timing registers for mxs-i2c
Date: Tue, 29 May 2012 08:46:53 +0200
Message-ID: <201205290846.53960.marex@denx.de>
References: <1338084656-11961-1-git-send-email-marex@denx.de> <4FC359BC.8080606@codethink.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FC359BC.8080606-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Ben Dooks,

> On 27/05/12 03:10, Marek Vasut wrote:
> > This patch configures the I2C bus timing registers according
> > to information passed via DT. Currently, 100kHz and 400kHz
> > modes are supported.
> >=20
> > Signed-off-by: Marek Vasut<marex-ynQEQJNshbs@public.gmane.org>
> > Cc: Detlev Zundel<dzu-ynQEQJNshbs@public.gmane.org>
> > CC: Dong Aisheng<b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > CC: Fabio Estevam<fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Cc: Linux ARM kernel<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
> > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > CC: Sascha Hauer<s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > CC: Shawn Guo<shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Stefano Babic<sbabic-ynQEQJNshbs@public.gmane.org>
> > CC: Uwe Kleine-K=F6nig<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Wolfgang Denk<wd-ynQEQJNshbs@public.gmane.org>
> > Cc: Wolfram Sang<w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >=20
> >   Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    1 +
> >   arch/arm/boot/dts/imx28.dtsi                      |    2 +
> >   drivers/i2c/busses/i2c-mxs.c                      |   64
> >   +++++++++++++++++++++ 3 files changed, 67 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt index
> > 1bfc02d..790b5c6 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> >=20
> > @@ -4,6 +4,7 @@ Required properties:
> >   - compatible: Should be "fsl,<chip>-i2c"
> >   - reg: Should contain registers location and length
> >   - interrupts: Should contain ERROR and DMA interrupts
> >=20
> > +- speed: Speed of the bus in kHz (400 or 100 are supported)
> >=20
> >   Examples:
> > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28=
=2Edtsi
> > index 4634cb8..d927155 100644
> > --- a/arch/arm/boot/dts/imx28.dtsi
> > +++ b/arch/arm/boot/dts/imx28.dtsi
> > @@ -381,6 +381,7 @@
> >=20
> >   				compatible =3D "fsl,imx28-i2c";
> >   				reg =3D<0x80058000 2000>;
> >   				interrupts =3D<111 68>;
> >=20
> > +				fsl,speed =3D<400>;
> >=20
> >   				status =3D "disabled";
> >   		=09
> >   			};
> >=20
> > @@ -390,6 +391,7 @@
> >=20
> >   				compatible =3D "fsl,imx28-i2c";
> >   				reg =3D<0x8005a000 2000>;
> >   				interrupts =3D<110 69>;
> >=20
> > +				fsl,speed =3D<400>;
> >=20
> >   				status =3D "disabled";
> >   		=09
> >   			};
>=20
> Is there not a standard speed setting in the i2c binding?

Not that I know of, but if someone hinted one to me, I'd gladly rework =
the=20
patches :)

Best regards,
Marek Vasut
