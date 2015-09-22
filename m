From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 4/8] mfd: intel_quark_i2c_gpio: support devices behind
 i2c bus
Date: Tue, 22 Sep 2015 23:25:00 +0100
Message-ID: <20150922222500.GD9317@x1>
References: <1442916619-140607-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1442916619-140607-5-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33177 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934878AbbIVWZD (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 22 Sep 2015 18:25:03 -0400
Received: by pacex6 with SMTP id ex6so21103866pac.0
        for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2015 15:25:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1442916619-140607-5-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org

On Tue, 22 Sep 2015, Andy Shevchenko wrote:

> On Intel Galileo Gen2 the GPIO expanders are connected to the i2c bus=
=2E For
> those devices the ACPI table has specific parameters that refer to an=
 actual
> i2c host controller. Since MFD now copes with that specific configura=
tion we
> have to provide a necessary information how to distinguish devices in=
 ACPI
> namespace. Here the _ADR values are provided.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_quark_i2c_gpio.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_q=
uark_i2c_gpio.c
> index 89bd4bf..e9fd33b 100644
> --- a/drivers/mfd/intel_quark_i2c_gpio.c
> +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> @@ -31,6 +31,10 @@
>  #define MFD_I2C_BAR		0
>  #define MFD_GPIO_BAR		1
> =20
> +/* ACPI _ADR value to match the child node */
> +#define MFD_ACPI_MATCH_GPIO	0ULL
> +#define MFD_ACPI_MATCH_I2C	1ULL
> +
>  /* The base GPIO number under GPIOLIB framework */
>  #define INTEL_QUARK_MFD_GPIO_BASE	8
> =20
> @@ -82,9 +86,14 @@ static struct resource intel_quark_i2c_res[] =3D {
>  	},
>  };
> =20
> +static struct mfd_cell_acpi_match intel_quark_acpi_match_i2c =3D {
> +	.adr =3D MFD_ACPI_MATCH_I2C,
> +};
> +
>  static struct mfd_cell intel_quark_mfd_i2c_cell =3D {
>  	.id =3D MFD_I2C_BAR,
>  	.name =3D "i2c_designware",
> +	.acpi_match =3D &intel_quark_acpi_match_i2c,
>  	.num_resources =3D ARRAY_SIZE(intel_quark_i2c_res),
>  	.resources =3D intel_quark_i2c_res,
>  	.ignore_resource_conflicts =3D true,
> @@ -96,9 +105,14 @@ static struct resource intel_quark_gpio_res[] =3D=
 {
>  	},
>  };
> =20
> +static struct mfd_cell_acpi_match intel_quark_acpi_match_gpio =3D {
> +	.adr =3D MFD_ACPI_MATCH_GPIO,
> +};
> +
>  static struct mfd_cell intel_quark_mfd_gpio_cell =3D {
>  	.id =3D MFD_GPIO_BAR,
>  	.name =3D "gpio-dwapb",
> +	.acpi_match =3D &intel_quark_acpi_match_gpio,
>  	.num_resources =3D ARRAY_SIZE(intel_quark_gpio_res),
>  	.resources =3D intel_quark_gpio_res,
>  	.ignore_resource_conflicts =3D true,

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
