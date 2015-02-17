From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] i2c: pca954x: improve usage of gpiod API
Date: Tue, 17 Feb 2015 22:06 +0200
Message-ID: <11044377.oGGMZ6UzhB@avalon>
References: <1424164328-28534-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424164328-28534-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

Thank you for the patch.

On Tuesday 17 February 2015 10:12:08 Uwe Kleine-K=F6nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() function=
s)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additio=
nal
> parameter that allows to specify direction and initial value for
> outputs.
>=20
> Also there is an *_optional variant that serves well here.  The semat=
ics
> is slightly changed here by using it. Now if a reset gpio is specifie=
d
> and getting hold on it fails, pca954x_probe fails, too.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
>  drivers/i2c/muxes/i2c-mux-pca954x.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c
> b/drivers/i2c/muxes/i2c-mux-pca954x.c index ec11b404b433..0042cf3d77d=
b
> 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -201,9 +201,9 @@ static int pca954x_probe(struct i2c_client *clien=
t,
>  	i2c_set_clientdata(client, data);
>=20
>  	/* Get the mux out of reset if a reset GPIO is specified. */
> -	gpio =3D devm_gpiod_get(&client->dev, "reset");
> -	if (!IS_ERR(gpio))
> -		gpiod_direction_output(gpio, 0);
> +	gpio =3D devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_L=
OW);
> +	if (IS_ERR(gpio))
> +		return PTR_ERR(gpio);
>=20
>  	/* Write the mux register at addr to verify
>  	 * that the mux is in fact present. This also

--=20
Regards,

Laurent Pinchart
