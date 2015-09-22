From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 3/8] mfd: intel_quark_i2c_gpio: load gpio driver first
Date: Tue, 22 Sep 2015 23:23:40 +0100
Message-ID: <20150922222340.GC9317@x1>
References: <1442916619-140607-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1442916619-140607-4-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442916619-140607-4-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 22 Sep 2015, Andy Shevchenko wrote:

> On Intel Galileo boards the GPIO expander is connected to i2c bus. Mo=
reover it
> is able to generate interrupt, but interrupt line is connected to GPI=
O. That's
> why we have to have GPIO driver in place when we will probe i2c host =
with
> device connected to it.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_quark_i2c_gpio.c | 48 +++++++++++++++++++++-------=
----------
>  1 file changed, 27 insertions(+), 21 deletions(-)

--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -28,8 +28,8 @@
 #include <linux/platform_data/i2c-designware.h>
=20
 /* PCI BAR for register base address */
-#define MFD_I2C_BAR            0
-#define MFD_GPIO_BAR           1
+#define MFD_GPIO_BAR           0
+#define MFD_I2C_BAR            1
=20
 /* The base GPIO number under GPIOLIB framework */
 #define INTEL_QUARK_MFD_GPIO_BASE      8

?

> diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_q=
uark_i2c_gpio.c
> index 1ce1603..89bd4bf 100644
> --- a/drivers/mfd/intel_quark_i2c_gpio.c
> +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> @@ -82,27 +82,26 @@ static struct resource intel_quark_i2c_res[] =3D =
{
>  	},
>  };
> =20
> +static struct mfd_cell intel_quark_mfd_i2c_cell =3D {
> +	.id =3D MFD_I2C_BAR,
> +	.name =3D "i2c_designware",
> +	.num_resources =3D ARRAY_SIZE(intel_quark_i2c_res),
> +	.resources =3D intel_quark_i2c_res,
> +	.ignore_resource_conflicts =3D true,
> +};
> +
>  static struct resource intel_quark_gpio_res[] =3D {
>  	[INTEL_QUARK_IORES_MEM] =3D {
>  		.flags =3D IORESOURCE_MEM,
>  	},
>  };
> =20
> -static struct mfd_cell intel_quark_mfd_cells[] =3D {
> -	{
> -		.id =3D MFD_I2C_BAR,
> -		.name =3D "i2c_designware",
> -		.num_resources =3D ARRAY_SIZE(intel_quark_i2c_res),
> -		.resources =3D intel_quark_i2c_res,
> -		.ignore_resource_conflicts =3D true,
> -	},
> -	{
> -		.id =3D MFD_GPIO_BAR,
> -		.name =3D "gpio-dwapb",
> -		.num_resources =3D ARRAY_SIZE(intel_quark_gpio_res),
> -		.resources =3D intel_quark_gpio_res,
> -		.ignore_resource_conflicts =3D true,
> -	},
> +static struct mfd_cell intel_quark_mfd_gpio_cell =3D {
> +	.id =3D MFD_GPIO_BAR,
> +	.name =3D "gpio-dwapb",
> +	.num_resources =3D ARRAY_SIZE(intel_quark_gpio_res),
> +	.resources =3D intel_quark_gpio_res,
> +	.ignore_resource_conflicts =3D true,
>  };
> =20
>  static const struct pci_device_id intel_quark_mfd_ids[] =3D {
> @@ -248,18 +247,25 @@ static int intel_quark_mfd_probe(struct pci_dev=
 *pdev,
> =20
>  	dev_set_drvdata(&pdev->dev, quark_mfd);
> =20
> -	ret =3D intel_quark_i2c_setup(pdev, &intel_quark_mfd_cells[MFD_I2C_=
BAR]);
> +	ret =3D intel_quark_i2c_setup(pdev, &intel_quark_mfd_i2c_cell);
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D intel_quark_gpio_setup(pdev,
> -				     &intel_quark_mfd_cells[MFD_GPIO_BAR]);
> +	ret =3D intel_quark_gpio_setup(pdev, &intel_quark_mfd_gpio_cell);
>  	if (ret)
>  		return ret;
> =20
> -	return mfd_add_devices(&pdev->dev, 0, intel_quark_mfd_cells,
> -			       ARRAY_SIZE(intel_quark_mfd_cells), NULL, 0,
> -			       NULL);
> +	ret =3D mfd_add_devices(&pdev->dev, 0, &intel_quark_mfd_gpio_cell, =
1,
> +			      NULL, 0, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mfd_add_devices(&pdev->dev, 0, &intel_quark_mfd_i2c_cell, 1=
,
> +			      NULL, 0, NULL);
> +	if (ret)
> +		mfd_remove_devices(&pdev->dev);
> +
> +	return ret;
>  }
> =20
>  static void intel_quark_mfd_remove(struct pci_dev *pdev)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
