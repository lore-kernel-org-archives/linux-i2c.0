From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 3/8] mfd: intel_quark_i2c_gpio: load gpio driver first
Date: Thu, 1 Oct 2015 15:54:01 +0100
Message-ID: <20151001145401.GC3214@x1>
References: <1443698430-74415-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1443698430-74415-4-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33535 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbbJAOyG (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 1 Oct 2015 10:54:06 -0400
Received: by wiclk2 with SMTP id lk2so37613169wic.0
        for <linux-i2c@vger.kernel.org>; Thu, 01 Oct 2015 07:54:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443698430-74415-4-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org

On Thu, 01 Oct 2015, Andy Shevchenko wrote:

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
>  drivers/mfd/intel_quark_i2c_gpio.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

Are there build dependancies in this set?  Or can all patches filter
through their own subsystems?

> diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_q=
uark_i2c_gpio.c
> index 1ce1603..958c134 100644
> --- a/drivers/mfd/intel_quark_i2c_gpio.c
> +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> @@ -90,19 +90,19 @@ static struct resource intel_quark_gpio_res[] =3D=
 {
> =20
>  static struct mfd_cell intel_quark_mfd_cells[] =3D {
>  	{
> -		.id =3D MFD_I2C_BAR,
> -		.name =3D "i2c_designware",
> -		.num_resources =3D ARRAY_SIZE(intel_quark_i2c_res),
> -		.resources =3D intel_quark_i2c_res,
> -		.ignore_resource_conflicts =3D true,
> -	},
> -	{
>  		.id =3D MFD_GPIO_BAR,
>  		.name =3D "gpio-dwapb",
>  		.num_resources =3D ARRAY_SIZE(intel_quark_gpio_res),
>  		.resources =3D intel_quark_gpio_res,
>  		.ignore_resource_conflicts =3D true,
>  	},
> +	{
> +		.id =3D MFD_I2C_BAR,
> +		.name =3D "i2c_designware",
> +		.num_resources =3D ARRAY_SIZE(intel_quark_i2c_res),
> +		.resources =3D intel_quark_i2c_res,
> +		.ignore_resource_conflicts =3D true,
> +	},
>  };
> =20
>  static const struct pci_device_id intel_quark_mfd_ids[] =3D {
> @@ -248,12 +248,11 @@ static int intel_quark_mfd_probe(struct pci_dev=
 *pdev,
> =20
>  	dev_set_drvdata(&pdev->dev, quark_mfd);
> =20
> -	ret =3D intel_quark_i2c_setup(pdev, &intel_quark_mfd_cells[MFD_I2C_=
BAR]);
> +	ret =3D intel_quark_i2c_setup(pdev, &intel_quark_mfd_cells[1]);
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D intel_quark_gpio_setup(pdev,
> -				     &intel_quark_mfd_cells[MFD_GPIO_BAR]);
> +	ret =3D intel_quark_gpio_setup(pdev, &intel_quark_mfd_cells[0]);
>  	if (ret)
>  		return ret;
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
