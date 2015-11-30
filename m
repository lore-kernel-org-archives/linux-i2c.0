From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 16/16] i2c: designware: Convert to use unified device
 property API
Date: Mon, 30 Nov 2015 20:58:58 +0100
Message-ID: <20151130195858.GB16446@katana>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1448896304-87928-17-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37330 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478AbbK3T7E (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 14:59:04 -0500
Content-Disposition: inline
In-Reply-To: <1448896304-87928-17-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2015 at 05:11:44PM +0200, Andy Shevchenko wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>=20
> With ACPI _DSD (introduced in ACPI v5.1) it is now possible to pass device
> configuration information from ACPI in addition to DT. In order to support
> this, convert the driver to use the unified device property accessors
> instead of DT specific.
>=20
> Change to ordering a bit so that we first try platform data and if that's
> not available look from device properties. ACPI *CNT methods are then used
> as last resort to override everything else.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

What is the bug fix here described in the cover letter?

And shall this go via I2C or via the rest of the series?

> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 50 +++++++++++++----------=
------
>  1 file changed, 23 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/bu=
sses/i2c-designware-platdrv.c
> index 809579e..06061b5 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -36,6 +36,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> @@ -129,10 +130,10 @@ static inline int dw_i2c_acpi_configure(struct plat=
form_device *pdev)
> =20
>  static int dw_i2c_plat_probe(struct platform_device *pdev)
>  {
> +	struct dw_i2c_platform_data *pdata =3D dev_get_platdata(&pdev->dev);
>  	struct dw_i2c_dev *dev;
>  	struct i2c_adapter *adap;
>  	struct resource *mem;
> -	struct dw_i2c_platform_data *pdata;
>  	int irq, r;
>  	u32 clk_freq, ht =3D 0;
> =20
> @@ -156,33 +157,28 @@ static int dw_i2c_plat_probe(struct platform_device=
 *pdev)
>  	/* fast mode by default because of legacy reasons */
>  	clk_freq =3D 400000;
> =20
> -	if (has_acpi_companion(&pdev->dev)) {
> -		dw_i2c_acpi_configure(pdev);
> -	} else if (pdev->dev.of_node) {
> -		of_property_read_u32(pdev->dev.of_node,
> -					"i2c-sda-hold-time-ns", &ht);
> -
> -		of_property_read_u32(pdev->dev.of_node,
> -				     "i2c-sda-falling-time-ns",
> -				     &dev->sda_falling_time);
> -		of_property_read_u32(pdev->dev.of_node,
> -				     "i2c-scl-falling-time-ns",
> -				     &dev->scl_falling_time);
> -
> -		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> -				     &clk_freq);
> -
> -		/* Only standard mode at 100kHz and fast mode at 400kHz
> -		 * are supported.
> -		 */
> -		if (clk_freq !=3D 100000 && clk_freq !=3D 400000) {
> -			dev_err(&pdev->dev, "Only 100kHz and 400kHz supported");
> -			return -EINVAL;
> -		}
> +	if (pdata) {
> +		clk_freq =3D pdata->i2c_scl_freq;
>  	} else {
> -		pdata =3D dev_get_platdata(&pdev->dev);
> -		if (pdata)
> -			clk_freq =3D pdata->i2c_scl_freq;
> +		device_property_read_u32(&pdev->dev, "i2c-sda-hold-time-ns",
> +					 &ht);
> +		device_property_read_u32(&pdev->dev, "i2c-sda-falling-time-ns",
> +					 &dev->sda_falling_time);
> +		device_property_read_u32(&pdev->dev, "i2c-scl-falling-time-ns",
> +					 &dev->scl_falling_time);
> +		device_property_read_u32(&pdev->dev, "clock-frequency",
> +					 &clk_freq);
> +	}
> +
> +	if (has_acpi_companion(&pdev->dev))
> +		dw_i2c_acpi_configure(pdev);
> +
> +	/*
> +	 * Only standard mode at 100kHz and fast mode at 400kHz are supported.
> +	 */
> +	if (clk_freq !=3D 100000 && clk_freq !=3D 400000) {
> +		dev_err(&pdev->dev, "Only 100kHz and 400kHz supported");
> +		return -EINVAL;
>  	}
> =20
>  	r =3D i2c_dw_eval_lock_support(dev);
> --=20
> 2.6.2
>=20

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXKqCAAoJEBQN5MwUoCm240QQAK5PTY22ZFlP5ap1RElBVtXi
rI1fMcqSu3m7zmiGB75cflwSQd2b+wsTMHwuQ1LQEBl7xsRo8XRn9+9iD99qh7yz
018m/zOFWMxlik55JMkNlcpI4npu/M+A4Gf8Cm2vlQXRQ4n0/Frpmt5CXfP64eMt
BLY9M154vEeDEI2Vt9rcGZiV4s3mjgpj4xlHHYgQddsExqNeAti5Tr11OTEvG8eF
AW3VZB3L1Ow2kbJPdByQLGaP8a3TTUsr/I6GXskjQvlZMWwYtfzourDeBuJqZLgB
JfDYIzRIwUh9TBVh7SfcIpOgQkjXCrJk2K6jMr+L/756qjpTvUK1Hb0fAjEDcy3k
yweCccwjfVVHlRunAw1GJB5NKY+PrTKqdUny8qH9kFiTAwqZONGzS8qOBl9fUO48
XGpkCJEfkWE4w1wkW/5QQh7YLu5kZiV0PhetzNMwa8tUpMrPsK6mnr8/3bv626OW
3YtxaSovn+w6IevwXFQIea13ml2ngF5ToG6oCxJvzG9taIhyYGbuOSNSTbsWNmuZ
VgjNpaj9QjAKlMtTukwpByw3uZrM9nsqgb1N4OxhfHzZrQl/nKIG8EFQFqI3gFBg
ByZrDJmB4D0yzR4Zs6lOiM87GI52NcO3MOiGowDuW54OastNGkEYHkqm/9mxOsgy
fcVkAAgdwyib016ReANg
=M2LO
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
