From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 5/5] pwm-pca9685: enable ACPI device found on Galileo
 Gen2
Date: Mon, 09 Nov 2015 15:53:36 +0200
Message-ID: <1447077216.31665.73.camel@linux.intel.com>
References: <1445591805-28886-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1445591805-28886-6-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1445591805-28886-6-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, linux-kernel@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, 2015-10-23 at 12:16 +0300, Andy Shevchenko wrote:
> There is a chip connected to i2c bus on Intel Galileo Gen2 board.
> Enable it via
> ACPI ID INT3492.

Thierry, ping?

>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> =C2=A0drivers/pwm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A02 +-
> =C2=A0drivers/pwm/pwm-pca9685.c | 20 ++++++++++++++++----
> =C2=A02 files changed, 17 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 062630a..bb114ef 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -242,7 +242,7 @@ config PWM_MXS
> =C2=A0
> =C2=A0config PWM_PCA9685
> =C2=A0	tristate "NXP PCA9685 PWM driver"
> -	depends on OF && I2C
> +	depends on I2C
> =C2=A0	select REGMAP_I2C
> =C2=A0	help
> =C2=A0	=C2=A0=C2=A0Generic PWM framework driver for NXP PCA9685 LED
> controller.
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 70448a6..117fccf 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -19,9 +19,11 @@
> =C2=A0 * this program.=C2=A0=C2=A0If not, see <http://www.gnu.org/lic=
enses/>.
> =C2=A0 */
> =C2=A0
> +#include <linux/acpi.h>
> =C2=A0#include <linux/i2c.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/platform_device.h>
> +#include <linux/property.h>
> =C2=A0#include <linux/pwm.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/slab.h>
> @@ -297,7 +299,6 @@ static const struct regmap_config
> pca9685_regmap_i2c_config =3D {
> =C2=A0static int pca9685_pwm_probe(struct i2c_client *client,
> =C2=A0				const struct i2c_device_id *id)
> =C2=A0{
> -	struct device_node *np =3D client->dev.of_node;
> =C2=A0	struct pca9685 *pca;
> =C2=A0	int ret;
> =C2=A0	int mode2;
> @@ -320,12 +321,12 @@ static int pca9685_pwm_probe(struct i2c_client
> *client,
> =C2=A0
> =C2=A0	regmap_read(pca->regmap, PCA9685_MODE2, &mode2);
> =C2=A0
> -	if (of_property_read_bool(np, "invert"))
> +	if (device_property_read_bool(&client->dev, "invert"))
> =C2=A0		mode2 |=3D MODE2_INVRT;
> =C2=A0	else
> =C2=A0		mode2 &=3D ~MODE2_INVRT;
> =C2=A0
> -	if (of_property_read_bool(np, "open-drain"))
> +	if (device_property_read_bool(&client->dev, "open-drain"))
> =C2=A0		mode2 &=3D ~MODE2_OUTDRV;
> =C2=A0	else
> =C2=A0		mode2 |=3D MODE2_OUTDRV;
> @@ -363,16 +364,27 @@ static const struct i2c_device_id pca9685_id[]
> =3D {
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(i2c, pca9685_id);
> =C2=A0
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id pca9685_acpi_ids[] =3D {
> +	{ "INT3492", 0 },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(acpi, pca9685_acpi_ids);
> +#endif
> +
> +#ifdef CONFIG_OF
> =C2=A0static const struct of_device_id pca9685_dt_ids[] =3D {
> =C2=A0	{ .compatible =3D "nxp,pca9685-pwm", },
> =C2=A0	{ /* sentinel */ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, pca9685_dt_ids);
> +#endif
> =C2=A0
> =C2=A0static struct i2c_driver pca9685_i2c_driver =3D {
> =C2=A0	.driver =3D {
> =C2=A0		.name =3D "pca9685-pwm",
> -		.of_match_table =3D pca9685_dt_ids,
> +		.acpi_match_table =3D ACPI_PTR(pca9685_acpi_ids),
> +		.of_match_table =3D of_match_ptr(pca9685_dt_ids),
> =C2=A0	},
> =C2=A0	.probe =3D pca9685_pwm_probe,
> =C2=A0	.remove =3D pca9685_pwm_remove,

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
