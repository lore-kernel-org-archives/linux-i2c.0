From: Biwen Li <biwen.li@nxp.com>
Subject: RE: [v2] ACPI: support for NXP i2c controller
Date: Wed, 11 Sep 2019 06:25:47 +0000
Message-ID: <DB7PR04MB4490390AC5331280CDF012E38FB10@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20190906075319.21244-1-biwen.li@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190906075319.21244-1-biwen.li@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Biwen Li <biwen.li@nxp.com>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "rafael@kernel.org" <rafael@kernel.org>, Leo Li <leoyang.li@nxp.com>, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, Udit Kumar <udit.kumar@nxp.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: Chuanhua Han <chuanhua.han@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Hi rafael, wolfram
	Any comments about this?
>=20
> Enable NXP i2c controller to boot with ACPI
>=20
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Signed-off-by: Udit Kumar <udit.kumar@nxp.com>
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
> Change in v2:
> 	- Simplify code
> 	- Adjust header file order
> 	- Not use ACPI_PTR()
>=20
>  drivers/acpi/acpi_apd.c      |  7 +++++++
>  drivers/i2c/busses/i2c-imx.c | 17 +++++++++++++----
>  2 files changed, 20 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c index
> 7cd0c9ac71ea..71511ae2dfcd 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -160,11 +160,17 @@ static const struct apd_device_desc hip08_i2c_desc
> =3D {
>  	.setup =3D acpi_apd_setup,
>  	.fixed_clk_rate =3D 250000000,
>  };
> +
>  static const struct apd_device_desc thunderx2_i2c_desc =3D {
>  	.setup =3D acpi_apd_setup,
>  	.fixed_clk_rate =3D 125000000,
>  };
>=20
> +static const struct apd_device_desc nxp_i2c_desc =3D {
> +	.setup =3D acpi_apd_setup,
> +	.fixed_clk_rate =3D 350000000,
> +};
> +
>  static const struct apd_device_desc hip08_spi_desc =3D {
>  	.setup =3D acpi_apd_setup,
>  	.fixed_clk_rate =3D 250000000,
> @@ -238,6 +244,7 @@ static const struct acpi_device_id acpi_apd_device_id=
s[]
> =3D {
>  	{ "HISI02A1", APD_ADDR(hip07_i2c_desc) },
>  	{ "HISI02A2", APD_ADDR(hip08_i2c_desc) },
>  	{ "HISI0173", APD_ADDR(hip08_spi_desc) },
> +	{ "NXP0001", APD_ADDR(nxp_i2c_desc) },
>  #endif
>  	{ }
>  };
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c =
index
> 15f6cde6452f..a3b61336fe55 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -20,6 +20,7 @@
>   *
>   */
>=20
> +#include <linux/acpi.h>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
> @@ -255,6 +256,12 @@ static const struct of_device_id i2c_imx_dt_ids[] =
=3D
> {  };  MODULE_DEVICE_TABLE(of, i2c_imx_dt_ids);
>=20
> +static const struct acpi_device_id i2c_imx_acpi_ids[] =3D {
> +	{"NXP0001", .driver_data =3D (kernel_ulong_t)&vf610_i2c_hwdata},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, i2c_imx_acpi_ids);
> +
>  static inline int is_imx1_i2c(struct imx_i2c_struct *i2c_imx)  {
>  	return i2c_imx->hwdata->devtype =3D=3D IMX1_I2C; @@ -1048,14 +1055,13
> @@ static const struct i2c_algorithm i2c_imx_algo =3D {
>=20
>  static int i2c_imx_probe(struct platform_device *pdev)  {
> -	const struct of_device_id *of_id =3D of_match_device(i2c_imx_dt_ids,
> -							   &pdev->dev);
>  	struct imx_i2c_struct *i2c_imx;
>  	struct resource *res;
>  	struct imxi2c_platform_data *pdata =3D dev_get_platdata(&pdev->dev);
>  	void __iomem *base;
>  	int irq, ret;
>  	dma_addr_t phy_addr;
> +	const struct imx_i2c_hwdata *match;
>=20
>  	dev_dbg(&pdev->dev, "<%s>\n", __func__);
>=20
> @@ -1075,8 +1081,9 @@ static int i2c_imx_probe(struct platform_device
> *pdev)
>  	if (!i2c_imx)
>  		return -ENOMEM;
>=20
> -	if (of_id)
> -		i2c_imx->hwdata =3D of_id->data;
> +	match =3D device_get_match_data(&pdev->dev);
> +	if (match)
> +		i2c_imx->hwdata =3D match;
>  	else
>  		i2c_imx->hwdata =3D (struct imx_i2c_hwdata *)
>  				platform_get_device_id(pdev)->driver_data;
> @@ -1089,6 +1096,7 @@ static int i2c_imx_probe(struct platform_device
> *pdev)
>  	i2c_imx->adapter.nr		=3D pdev->id;
>  	i2c_imx->adapter.dev.of_node	=3D pdev->dev.of_node;
>  	i2c_imx->base			=3D base;
> +	ACPI_COMPANION_SET(&i2c_imx->adapter.dev,
> ACPI_COMPANION(&pdev->dev));
>=20
>  	/* Get I2C clock */
>  	i2c_imx->clk =3D devm_clk_get(&pdev->dev, NULL); @@ -1247,6 +1255,7
> @@ static struct platform_driver i2c_imx_driver =3D {
>  		.name =3D DRIVER_NAME,
>  		.pm =3D &i2c_imx_pm_ops,
>  		.of_match_table =3D i2c_imx_dt_ids,
> +		.acpi_match_table =3D i2c_imx_acpi_ids,
>  	},
>  	.id_table =3D imx_i2c_devtype,
>  };
> --
> 2.17.1
