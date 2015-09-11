From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 4/8] i2c: Make I2C ID tables non-mandatory for DT'ed
 devices
Date: Fri, 11 Sep 2015 10:31:14 +0100
Message-ID: <20150911093114.GO3260@x1>
References: <1441823627-6227-1-git-send-email-kieranbingham@gmail.com>
 <1441823627-6227-5-git-send-email-kieranbingham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441823627-6227-5-git-send-email-kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kieran Bingham <kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 09 Sep 2015, Kieran Bingham wrote:

> From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> Currently the I2C framework insists on devices supplying an I2C ID
> table.  Many of the devices which do so unnecessarily adding quite a
> few wasted lines to kernel code.  This patch allows drivers a means
> to 'not' supply the aforementioned table and match on DT match tables
> instead.
>=20
> Acked-by: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

SoB?

> ---
>  drivers/i2c/i2c-core.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 94ca76e..2ebc64d 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -468,7 +468,7 @@ static int i2c_device_match(struct device *dev, s=
truct device_driver *drv)
> =20
> =20
>  	/* Attempt an OF style match */
> -	if (of_driver_match_device(dev, drv))
> +	if (i2c_of_match_device(drv->of_match_table, client))
>  		return 1;
> =20
>  	/* Then ACPI style match */
> @@ -657,7 +657,15 @@ static int i2c_device_probe(struct device *dev)
>  	}
> =20
>  	driver =3D to_i2c_driver(dev->driver);
> -	if (!driver->probe || !driver->id_table)
> +	if (!driver->probe)
> +		return -EINVAL;
> +
> +	/*
> +	 * An I2C ID table is not mandatory, if and only if, a suitable Dev=
ice
> +	 * Tree match table entry is supplied for the probing device.
> +	 */
> +	if (!driver->id_table &&
> +	    !i2c_of_match_device(dev->driver->of_match_table, client))
>  		return -ENODEV;
> =20
>  	if (!device_can_wakeup(&client->dev))

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
