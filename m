From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/2] MXS: Set I2C timing registers for mxs-i2c
Date: Fri, 29 Jun 2012 11:33:09 +0200
Message-ID: <201206291133.09379.marex@denx.de>
References: <1340958243-2332-1-git-send-email-marex@denx.de> <20120629090602.GI5844@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120629090602.GI5844-Fb7DQEYuewWctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng-B29396 <B29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Estevam Fabio-R49496 <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Dong Aisheng,

> Hi Marek,
>=20
> On Fri, Jun 29, 2012 at 04:24:02PM +0800, Marek Vasut wrote:
> > This patch configures the I2C bus timing registers according
> > to information passed via DT. Currently, 100kHz and 400kHz
> > modes are supported.
> >=20
> > The TIMING2 register value is wrong in the documentation for
> >=20
> > i.MX28! This was found and fixed by:
> >   Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >=20
> > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>
> > CC: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Cc: Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
> > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > CC: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > CC: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
> > CC: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >=20
> >  Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    1 +
> >  arch/arm/boot/dts/imx28.dtsi                      |    2 +
> >  drivers/i2c/busses/i2c-mxs.c                      |   56
> >  +++++++++++++++++++++ 3 files changed, 59 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt index
> > 1bfc02d..d2bf750 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> >=20
> > @@ -4,6 +4,7 @@ Required properties:
> >  - compatible: Should be "fsl,<chip>-i2c"
> >  - reg: Should contain registers location and length
> >  - interrupts: Should contain ERROR and DMA interrupts
> >=20
> > +- clock-frequency: desired I2C bus clock frequency in Hz.
>=20
> Is this required properties?
> If yes, it may be good to also update examples.

Good point

>=20
> >  Examples:
> > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28=
=2Edtsi
> > index ee3778a..832d30a 100644
> > --- a/arch/arm/boot/dts/imx28.dtsi
> > +++ b/arch/arm/boot/dts/imx28.dtsi
> > @@ -419,6 +419,7 @@
> >=20
> >  				compatible =3D "fsl,imx28-i2c";
> >  				reg =3D <0x80058000 2000>;
> >  				interrupts =3D <111 68>;
> >=20
> > +				clock-frequency =3D <400000>;
> >=20
> >  				status =3D "disabled";
> >  		=09
> >  			};
> >=20
> > @@ -428,6 +429,7 @@
> >=20
> >  				compatible =3D "fsl,imx28-i2c";
> >  				reg =3D <0x8005a000 2000>;
> >  				interrupts =3D <110 69>;
> >=20
> > +				clock-frequency =3D <400000>;
> >=20
> >  				status =3D "disabled";
> >  		=09
> >  			};
> >=20
> > diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-=
mxs.c
> > index 04eb441..cdcfd3f 100644
> > --- a/drivers/i2c/busses/i2c-mxs.c
> > +++ b/drivers/i2c/busses/i2c-mxs.c
> > @@ -46,6 +46,10 @@
> >=20
> >  #define MXS_I2C_CTRL0_DIRECTION			0x00010000
> >  #define MXS_I2C_CTRL0_XFER_COUNT(v)		((v) & 0x0000FFFF)
> >=20
> > +#define MXS_I2C_TIMING0		(0x10)
> > +#define MXS_I2C_TIMING1		(0x20)
> > +#define MXS_I2C_TIMING2		(0x30)
> > +
> >=20
> >  #define MXS_I2C_CTRL1		(0x40)
> >  #define MXS_I2C_CTRL1_SET	(0x44)
> >  #define MXS_I2C_CTRL1_CLR	(0x48)
> >=20
> > @@ -97,6 +101,25 @@
> >=20
> >  #define MXS_CMD_I2C_READ	(MXS_I2C_CTRL0_SEND_NAK_ON_LAST | \
> > =20
> >  				 MXS_I2C_CTRL0_MASTER_MODE)
> >=20
> > +struct mxs_i2c_speed_config {
> > +	uint32_t	timing0;
> > +	uint32_t	timing1;
> > +	uint32_t	timing2;
> > +};
> > +
> > +/* Timing values for the default 24MHz clock supplied into the i2c
> > block. */
>=20
> I did not check spec,
> is it possible the supplied clock changed?

It's possible indeed ... Shawn?

> > +const struct mxs_i2c_speed_config mxs_i2c_95kHz_config =3D {
>=20
> Do we need static for it?

MX28 datasheet 27.5.2 - 27.5.4 ... there was a discussion about these i=
n the=20
thread under older patches. Those shall explain your questions below.

> > +	.timing0	=3D 0x00780030,
> > +	.timing1	=3D 0x00800030,
> > +	.timing2	=3D 0x00300030,
> > +};
> > +
> > +const struct mxs_i2c_speed_config mxs_i2c_400kHz_config =3D {
>=20
> ditto
>=20
> > +	.timing0	=3D 0x000f0007,
> > +	.timing1	=3D 0x001f000f,
> > +	.timing2	=3D 0x00300030,
> > +};
> > +
> >=20
> >  /**
> > =20
> >   * struct mxs_i2c_dev - per device, private MXS-I2C data
> >   *
> >=20
> > @@ -112,11 +135,17 @@ struct mxs_i2c_dev {
> >=20
> >  	struct completion cmd_complete;
> >  	u32 cmd_err;
> >  	struct i2c_adapter adapter;
> >=20
> > +	const struct mxs_i2c_speed_config *speed;
> >=20
> >  };
> > =20
> >  static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
> >  {
> > =20
> >  	stmp_reset_block(i2c->regs);
> >=20
> > +
> > +	writel(i2c->speed->timing0, i2c->regs + MXS_I2C_TIMING0);
> > +	writel(i2c->speed->timing1, i2c->regs + MXS_I2C_TIMING1);
> > +	writel(i2c->speed->timing2, i2c->regs + MXS_I2C_TIMING2);
> > +
> >=20
> >  	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
> >  	writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
> >  =09
> >  			i2c->regs + MXS_I2C_QUEUECTRL_SET);
> >=20
> > @@ -319,6 +348,28 @@ static const struct i2c_algorithm mxs_i2c_algo=
 =3D {
> >=20
> >  	.functionality =3D mxs_i2c_func,
> > =20
> >  };
> >=20
> > +static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
> > +{
> > +	uint32_t speed;
> > +	struct device *dev =3D i2c->dev;
> > +	struct device_node *node =3D dev->of_node;
> > +	int ret;
> > +
> > +	if (!node)
> > +		return -EINVAL;
> > +
> > +	i2c->speed =3D &mxs_i2c_95kHz_config;
>=20
> Can you explain why here is 95khz rather than 100kh?
> It seems this is for 100khz below.
>=20
> > +	ret =3D of_property_read_u32(node, "clock-frequency", &speed);
> > +	if (ret)
> > +		dev_warn(dev, "No I2C speed selected, using 100kHz\n");
> > +	else if (speed =3D=3D 400000)
> > +		i2c->speed =3D &mxs_i2c_400kHz_config;
> > +	else if (speed !=3D 100000)
> > +		dev_warn(dev, "Invalid I2C speed selected, using 100kHz\n");
> > +
> > +	return 0;
> > +}
> > +
> >=20
> >  static int __devinit mxs_i2c_probe(struct platform_device *pdev)
> >  {
> > =20
> >  	struct device *dev =3D &pdev->dev;
> >=20
> > @@ -358,6 +409,11 @@ static int __devinit mxs_i2c_probe(struct
> > platform_device *pdev)
> >=20
> >  		return err;
> >  =09
> >  	i2c->dev =3D dev;
> >=20
> > +
> > +	err =3D mxs_i2c_get_ofdata(i2c);
> > +	if (err)
> > +		return err;
> > +
> >=20
> >  	platform_set_drvdata(pdev, i2c);
> >  =09
> >  	/* Do reset to enforce correct startup after pinmuxing */
>=20
> Regards
> Dong Aisheng
