From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 8/8] mfd: as3722: Rid driver of superfluous I2C device
 ID structure
Date: Fri, 11 Sep 2015 10:29:04 +0100
Message-ID: <20150911092904.GL3260@x1>
References: <1441823627-6227-1-git-send-email-kieranbingham@gmail.com>
 <1441823627-6227-9-git-send-email-kieranbingham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441823627-6227-9-git-send-email-kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kieran Bingham <kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 09 Sep 2015, Kieran Bingham wrote:

> From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> Also remove unused second probe() parameter 'i2c_device_id'.
>=20
> Acked-by: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

SoB?

> ---
>  drivers/mfd/as3722.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
> index 924ea90..6ac4be3 100644
> --- a/drivers/mfd/as3722.c
> +++ b/drivers/mfd/as3722.c
> @@ -354,8 +354,7 @@ static int as3722_i2c_of_probe(struct i2c_client =
*i2c,
>  	return 0;
>  }
> =20
> -static int as3722_i2c_probe(struct i2c_client *i2c,
> -			const struct i2c_device_id *id)
> +static int as3722_i2c_probe(struct i2c_client *i2c)
>  {
>  	struct as3722 *as3722;
>  	unsigned long irq_flags;
> @@ -428,20 +427,13 @@ static const struct of_device_id as3722_of_matc=
h[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, as3722_of_match);
> =20
> -static const struct i2c_device_id as3722_i2c_id[] =3D {
> -	{ "as3722", 0 },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(i2c, as3722_i2c_id);
> -
>  static struct i2c_driver as3722_i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D "as3722",
>  		.of_match_table =3D as3722_of_match,
>  	},
> -	.probe =3D as3722_i2c_probe,
> +	.probe2 =3D as3722_i2c_probe,
>  	.remove =3D as3722_i2c_remove,
> -	.id_table =3D as3722_i2c_id,
>  };
> =20
>  module_i2c_driver(as3722_i2c_driver);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
