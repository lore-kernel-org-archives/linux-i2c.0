From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/8] i2c: Add pointer dereference protection to
 i2c_match_id()
Date: Fri, 11 Sep 2015 10:31:54 +0100
Message-ID: <20150911093154.GQ3260@x1>
References: <1441823627-6227-1-git-send-email-kieranbingham@gmail.com>
 <1441823627-6227-2-git-send-email-kieranbingham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441823627-6227-2-git-send-email-kieranbingham@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieranbingham@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, grant.likely@linaro.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 09 Sep 2015, Kieran Bingham wrote:

> From: Lee Jones <lee.jones@linaro.org>
>=20
> Here we're providing dereference protection for i2c_match_id(), which
> saves us having to do it each time it's called.  We're also stripping
> out the (now) needless checks in i2c_device_match().  This patch pave=
s
> the way for other, similar code trimming.
>=20
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

SoB?

> ---
>  drivers/i2c/i2c-core.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index c83e4d1..30d8a77 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -450,6 +450,9 @@ static inline int acpi_i2c_install_space_handler(=
struct i2c_adapter *adapter)
>  static const struct i2c_device_id *i2c_match_id(const struct i2c_dev=
ice_id *id,
>  						const struct i2c_client *client)
>  {
> +	if (!(id && client))
> +		return NULL;
> +
>  	while (id->name[0]) {
>  		if (strcmp(client->name, id->name) =3D=3D 0)
>  			return id;
> @@ -463,8 +466,6 @@ static int i2c_device_match(struct device *dev, s=
truct device_driver *drv)
>  	struct i2c_client	*client =3D i2c_verify_client(dev);
>  	struct i2c_driver	*driver;
> =20
> -	if (!client)
> -		return 0;
> =20
>  	/* Attempt an OF style match */
>  	if (of_driver_match_device(dev, drv))
> @@ -475,9 +476,10 @@ static int i2c_device_match(struct device *dev, =
struct device_driver *drv)
>  		return 1;
> =20
>  	driver =3D to_i2c_driver(drv);
> -	/* match on an id table if there is one */
> -	if (driver->id_table)
> -		return i2c_match_id(driver->id_table, client) !=3D NULL;
> +
> +	/* Finally an I2C match */
> +	if (i2c_match_id(driver->id_table, client))
> +		return 1;
> =20
>  	return 0;
>  }

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
