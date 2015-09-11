From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 7/8] mfd: 88pm860x: Move over to new I2C device
 .probe() call
Date: Fri, 11 Sep 2015 10:29:21 +0100
Message-ID: <20150911092921.GM3260@x1>
References: <1441823627-6227-1-git-send-email-kieranbingham@gmail.com>
 <1441823627-6227-8-git-send-email-kieranbingham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441823627-6227-8-git-send-email-kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kieran Bingham <kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 09 Sep 2015, Kieran Bingham wrote:

> From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> As part of an effort to rid the mostly unused second parameter for I2=
C
> related .probe() functions and to conform to other existing framework=
s
> we're moving over to a temporary replacement .probe() call-back.
>=20
> Acked-by: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

SoB?

> ---
>  drivers/mfd/88pm860x-core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.=
c
> index 3269a99..a499d70 100644
> --- a/drivers/mfd/88pm860x-core.c
> +++ b/drivers/mfd/88pm860x-core.c
> @@ -1130,8 +1130,7 @@ static int pm860x_dt_init(struct device_node *n=
p,
>  	return 0;
>  }
> =20
> -static int pm860x_probe(struct i2c_client *client,
> -				  const struct i2c_device_id *id)
> +static int pm860x_probe(struct i2c_client *client)
>  {
>  	struct pm860x_platform_data *pdata =3D dev_get_platdata(&client->de=
v);
>  	struct device_node *node =3D client->dev.of_node;
> @@ -1257,7 +1256,7 @@ static struct i2c_driver pm860x_driver =3D {
>  		.pm     =3D &pm860x_pm_ops,
>  		.of_match_table	=3D pm860x_dt_ids,
>  	},
> -	.probe		=3D pm860x_probe,
> +	.probe2		=3D pm860x_probe,
>  	.remove		=3D pm860x_remove,
>  	.id_table	=3D pm860x_id_table,
>  };

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
