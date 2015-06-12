From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] i2c: mux: pca954x: Use __i2c_transfer because of quirks
Date: Fri, 12 Jun 2015 22:28:50 +0300
Message-ID: <5785070.TUTkzzfkHR@avalon>
References: <557AD35C.2070406@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <557AD35C.2070406-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?B?xYF1a2Fzeg==?= Gemborowski <lukasz.gemborowski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Lawnick, Michael (Nokia - DE/Ulm)" <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Alexander,

Thank you for the patch.

On Friday 12 June 2015 14:41:00 Alexander Sverdlin wrote:
> pca9541 and pca954x are calling master_xfer() of the parent adapter d=
irectly
> thus bypassing the quirks checks of the adapter. Use __i2c_transfer()
> instead.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Tested-by: =C5=81ukasz Gemborowski <lukasz.gemborowski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
>  drivers/i2c/muxes/i2c-mux-pca9541.c |    4 ++--
>  drivers/i2c/muxes/i2c-mux-pca954x.c |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c
> b/drivers/i2c/muxes/i2c-mux-pca9541.c index cb77277..0c8d4d2 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
> @@ -104,7 +104,7 @@ static int pca9541_reg_write(struct i2c_client *c=
lient,
> u8 command, u8 val) buf[0] =3D command;
>  		buf[1] =3D val;
>  		msg.buf =3D buf;
> -		ret =3D adap->algo->master_xfer(adap, &msg, 1);
> +		ret =3D __i2c_transfer(adap, &msg, 1);
>  	} else {
>  		union i2c_smbus_data data;
>=20
> @@ -144,7 +144,7 @@ static int pca9541_reg_read(struct i2c_client *cl=
ient,
> u8 command) .buf =3D &val
>  			}
>  		};
> -		ret =3D adap->algo->master_xfer(adap, msg, 2);
> +		ret =3D __i2c_transfer(adap, msg, 2);
>  		if (ret =3D=3D 2)
>  			ret =3D val;
>  		else if (ret >=3D 0)
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c
> b/drivers/i2c/muxes/i2c-mux-pca954x.c index bea0d2d..ea4aa9d 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -134,7 +134,7 @@ static int pca954x_reg_write(struct i2c_adapter *=
adap,
>  		msg.len =3D 1;
>  		buf[0] =3D val;
>  		msg.buf =3D buf;
> -		ret =3D adap->algo->master_xfer(adap, &msg, 1);
> +		ret =3D __i2c_transfer(adap, &msg, 1);
>  	} else {
>  		union i2c_smbus_data data;
>  		ret =3D adap->algo->smbus_xfer(adap, client->addr,

--=20
Regards,

Laurent Pinchart
