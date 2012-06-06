From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] MXS: Set I2C timing registers for mxs-i2c
Date: Wed, 6 Jun 2012 10:53:32 +0800
Message-ID: <20120606025328.GB2667@S2101-09.ap.freescale.net>
References: <1338084656-11961-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1338084656-11961-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Welcome to mxs device tree, Marek :)

On Sun, May 27, 2012 at 04:10:55AM +0200, Marek Vasut wrote:
> This patch configures the I2C bus timing registers according
> to information passed via DT. Currently, 100kHz and 400kHz
> modes are supported.
>=20
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>
> CC: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> CC: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> CC: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
> CC: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    1 +
>  arch/arm/boot/dts/imx28.dtsi                      |    2 +
>  drivers/i2c/busses/i2c-mxs.c                      |   64 +++++++++++=
++++++++++
>  3 files changed, 67 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt b/Docu=
mentation/devicetree/bindings/i2c/i2c-mxs.txt
> index 1bfc02d..790b5c6 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> @@ -4,6 +4,7 @@ Required properties:
>  - compatible: Should be "fsl,<chip>-i2c"
>  - reg: Should contain registers location and length
>  - interrupts: Should contain ERROR and DMA interrupts
> +- speed: Speed of the bus in kHz (400 or 100 are supported)
> =20
>  Examples:
> =20
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.d=
tsi
> index 4634cb8..d927155 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -381,6 +381,7 @@
>  				compatible =3D "fsl,imx28-i2c";
>  				reg =3D <0x80058000 2000>;
>  				interrupts =3D <111 68>;
> +				fsl,speed =3D <400>;
>  				status =3D "disabled";
>  			};
> =20
> @@ -390,6 +391,7 @@
>  				compatible =3D "fsl,imx28-i2c";
>  				reg =3D <0x8005a000 2000>;
>  				interrupts =3D <110 69>;
> +				fsl,speed =3D <400>;
>  				status =3D "disabled";
>  			};
> =20
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mx=
s.c
> index 04eb441..fff0a09 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -46,6 +46,10 @@
>  #define MXS_I2C_CTRL0_DIRECTION			0x00010000
>  #define MXS_I2C_CTRL0_XFER_COUNT(v)		((v) & 0x0000FFFF)
> =20
> +#define MXS_I2C_TIMING0		(0x10)
> +#define MXS_I2C_TIMING1		(0x20)
> +#define MXS_I2C_TIMING2		(0x30)
> +
>  #define MXS_I2C_CTRL1		(0x40)
>  #define MXS_I2C_CTRL1_SET	(0x44)
>  #define MXS_I2C_CTRL1_CLR	(0x48)
> @@ -97,6 +101,24 @@
>  #define MXS_CMD_I2C_READ	(MXS_I2C_CTRL0_SEND_NAK_ON_LAST | \
>  				 MXS_I2C_CTRL0_MASTER_MODE)
> =20
> +struct mxs_i2c_speed_config {
> +	uint32_t	timing0;
> +	uint32_t	timing1;
> +	uint32_t	timing2;
> +};
> +
> +const struct mxs_i2c_speed_config mxs_i2c_95kHz_config =3D {
> +	.timing0	=3D 0x00780030,
> +	.timing1	=3D 0x00800030,
> +	.timing2	=3D 0x0015000d,
> +};
> +
> +const struct mxs_i2c_speed_config mxs_i2c_400kHz_config =3D {
> +	.timing0	=3D 0x000f0007,
> +	.timing1	=3D 0x001f000f,
> +	.timing2	=3D 0x0015000d,
> +};
> +
>  /**
>   * struct mxs_i2c_dev - per device, private MXS-I2C data
>   *
> @@ -112,11 +134,17 @@ struct mxs_i2c_dev {
>  	struct completion cmd_complete;
>  	u32 cmd_err;
>  	struct i2c_adapter adapter;
> +	const struct mxs_i2c_speed_config *speed;
>  };
> =20
>  static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
>  {
>  	stmp_reset_block(i2c->regs);
> +
> +	writel(i2c->speed->timing0, i2c->regs + MXS_I2C_TIMING0);
> +	writel(i2c->speed->timing1, i2c->regs + MXS_I2C_TIMING1);
> +	writel(i2c->speed->timing2, i2c->regs + MXS_I2C_TIMING2);
> +
>  	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
>  	writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
>  			i2c->regs + MXS_I2C_QUEUECTRL_SET);
> @@ -319,6 +347,38 @@ static const struct i2c_algorithm mxs_i2c_algo =3D=
 {
>  	.functionality =3D mxs_i2c_func,
>  };
> =20
> +#ifdef CONFIG_OF

We already force ARCH_MXS to select USE_OF while I2C_MXS only depends
on SOC_IMX28, so this #ifdef is not really needed?

> +static int mxs_i2c_get_ofdata(struct platform_device *pdev,
> +				struct mxs_i2c_dev *i2c)
> +{
> +	const __be32 *speed;
> +	uint32_t speed_khz;
> +	struct device_node *node =3D pdev->dev.of_node;
> +
> +	if (!node)
> +		return -EINVAL;
> +
> +	i2c->speed =3D &mxs_i2c_95kHz_config;
> +	speed =3D of_get_property(node, "fsl,speed", NULL);
> +	if (!speed)
> +		dev_warn(&pdev->dev,
> +			"No I2C speed selected, using 100kHz\n");
> +
> +	speed_khz =3D be32_to_cpup(speed);

You may want to try of_property_read_u32().

> +	if (speed_khz =3D=3D 400)
> +		i2c->speed =3D &mxs_i2c_400kHz_config;
> +	else if (speed_khz !=3D 100)
> +		dev_warn(&pdev->dev,
> +			"Invalid I2C speed selected, using 100kHz\n");
> +
> +	return 0;
> +}
> +#else
> +static int mxs_i2c_get_ofdata(struct platform_device *pdev,
> +				struct mxs_i2c_dev *i2c)
> +{ }
> +#endif /* CONFIG_OF */
> +
>  static int __devinit mxs_i2c_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> @@ -357,6 +417,10 @@ static int __devinit mxs_i2c_probe(struct platfo=
rm_device *pdev)
>  	if (err)
>  		return err;
> =20
> +	err =3D mxs_i2c_get_ofdata(pdev, i2c);
> +	if (err)
> +		return err;
> +

If we have this block put after the following line, we can save pdev
parameter of mxs_i2c_get_ofdata()?

>  	i2c->dev =3D dev;
>  	platform_set_drvdata(pdev, i2c);
> =20
> --=20
> 1.7.10
>=20

--=20
Regards,
Shawn
