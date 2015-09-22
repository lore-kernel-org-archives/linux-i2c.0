From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 8/8] pwm-pca9685: enable ACPI device found on Galileo
 Gen2
Date: Tue, 22 Sep 2015 16:37:14 +0200
Message-ID: <20150922143714.GA9235@ulmo.nvidia.com>
References: <1442916619-140607-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1442916619-140607-9-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442916619-140607-9-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2015 at 01:10:19PM +0300, Andy Shevchenko wrote:
> There is a chip connected to i2c bus on Intel Galileo Gen2 board. Enable =
it via
> ACPI ID INT3492.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/Kconfig       |  2 +-
>  drivers/pwm/pwm-pca9685.c | 14 +++++++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 062630a..bb114ef 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -242,7 +242,7 @@ config PWM_MXS
> =20
>  config PWM_PCA9685
>  	tristate "NXP PCA9685 PWM driver"
> -	depends on OF && I2C
> +	depends on I2C
>  	select REGMAP_I2C
>  	help
>  	  Generic PWM framework driver for NXP PCA9685 LED controller.
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 70448a6..38ea28b 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -26,6 +26,8 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
> +#include <linux/acpi.h>
> +#include <linux/property.h>

These should be kept sorted. I know that delay.h isn't properly ordered
either, I missed that during patch review. Please keep new ones ordered
alphabetically and I'll sort out the delay.h via a separate patch.

> =20
>  /*
>   * Because the PCA9685 has only one prescaler per chip, changing the per=
iod of
> @@ -297,7 +299,6 @@ static const struct regmap_config pca9685_regmap_i2c_=
config =3D {
>  static int pca9685_pwm_probe(struct i2c_client *client,
>  				const struct i2c_device_id *id)
>  {
> -	struct device_node *np =3D client->dev.of_node;
>  	struct pca9685 *pca;
>  	int ret;
>  	int mode2;
> @@ -320,12 +321,12 @@ static int pca9685_pwm_probe(struct i2c_client *cli=
ent,
> =20
>  	regmap_read(pca->regmap, PCA9685_MODE2, &mode2);
> =20
> -	if (of_property_read_bool(np, "invert"))
> +	if (device_property_read_bool(&client->dev, "invert"))
>  		mode2 |=3D MODE2_INVRT;
>  	else
>  		mode2 &=3D ~MODE2_INVRT;
> =20
> -	if (of_property_read_bool(np, "open-drain"))
> +	if (device_property_read_bool(&client->dev, "open-drain"))
>  		mode2 &=3D ~MODE2_OUTDRV;
>  	else
>  		mode2 |=3D MODE2_OUTDRV;
> @@ -363,6 +364,12 @@ static const struct i2c_device_id pca9685_id[] =3D {
>  };
>  MODULE_DEVICE_TABLE(i2c, pca9685_id);
> =20
> +static const struct acpi_device_id pca9685_acpi_ids[] =3D {
> +	{ "INT3492", 0 },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(acpi, pca9685_acpi_ids);
> +
>  static const struct of_device_id pca9685_dt_ids[] =3D {
>  	{ .compatible =3D "nxp,pca9685-pwm", },
>  	{ /* sentinel */ }
> @@ -372,6 +379,7 @@ MODULE_DEVICE_TABLE(of, pca9685_dt_ids);
>  static struct i2c_driver pca9685_i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D "pca9685-pwm",
> +		.acpi_match_table =3D ACPI_PTR(pca9685_acpi_ids),

I think you now need #ifdef protection for the ACPI ID table, otherwise
the compiler will warn that the table is unused for !ACPI.

>  		.of_match_table =3D pca9685_dt_ids,

Similarly to the above, this should use of_match_ptr(), which in turn
will require #ifdef protection for the table to avoid warnings.

Thierry

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWAWeYAAoJEN0jrNd/PrOhzPIQALBB2kf/SyQhjNRGoaZgx3U8
QdU4SnBH4oEcIGVPbtNaEPV/3+w+pXQT6g5KmRtxm1ed15T63TyMSyyxerRMiAKe
BZuVIC8HsLIUvvluLkc+gO0RdweFJzntLrm9xSY3RztfDTq9D6pTvMwlWwdftssw
hCTfZONlfasotzXN17LV80ogPAd81G7z5meZxZhoLcpdlya9iDbBZeeLzajltDbH
SleOxd9vDFpfSGVTNKHReVKCakpDBlgghbjm1WX5VsqgLARmFT7th9QilBA5GXEx
kpKmsH//ekm1IstmJbSvnaRFsGWjCEuVMQ23v3tov4PyNXvwXPJ4ymqT4rEE2bP1
RulazUnaJzb8jgq+lGophegjhdyX6ZmWpRVaqQqi8UeZ3JPTCUHXFvLnDS5iUN84
iQ86MF2L9fq1L6pi7aHZpidqe/oc+Wyz+m8QOgyZsb68Z63megS7wo09hDcB/iLR
t1EXzkB9MC6u9wQVN/9ktpVh59A0LEwP55NcPRQAOq84ks+mMLJUVPdGMhw8hWEK
bqXzFcJceXV8kzpi0KaYlpWFJl9hxOUiyu9bEAkjLpWbwkMcesFRnfq7ZKmKW+iG
VMin9ldm4eW6PEZeUltnxoCLRd3Jtq18IMoAnbyZm5G/o7wDC5enDbCbdj8psLl6
doDO3iQC1ERP7DjxCS+H
=GTCk
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
