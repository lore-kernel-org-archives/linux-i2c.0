From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 3/5] i2c: recovery: change input parameter to i2c_adapter
 for prepare/unprepare_recovery
Date: Thu, 12 Mar 2015 12:32:19 +0100
Message-ID: <55017943.6040603@nokia.com>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com> <1417448047-15236-4-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417448047-15236-4-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi!

On 01/12/14 16:34, Grygorii Strashko wrote:
> This patch changes type of input parameter for .prepare/unprepare_rec=
overy()
> callbacks from struct i2c_bus_recovery_info * to struct i2c_adapter *=
=2E
> This allows to simplify implementation of these callbacks and avoid
> type conversations from i2c_bus_recovery_info to i2c_adapter.
> The i2c_bus_recovery_info can be simply retrieved from struct i2c_ada=
pter
> which contains pointer on it.
>=20
> CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c | 4 ++--
>  include/linux/i2c.h    | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 2f90ac6..72b6e34 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -563,7 +563,7 @@ static int i2c_generic_recovery(struct i2c_adapte=
r *adap)
>  	int i =3D 0, val =3D 1, ret =3D 0;
> =20
>  	if (bri->prepare_recovery)
> -		bri->prepare_recovery(bri);
> +		bri->prepare_recovery(adap);
> =20
>  	/*
>  	 * By this time SCL is high, as we need to give 9 falling-rising ed=
ges
> @@ -588,7 +588,7 @@ static int i2c_generic_recovery(struct i2c_adapte=
r *adap)
>  	}
> =20
>  	if (bri->unprepare_recovery)
> -		bri->unprepare_recovery(bri);
> +		bri->unprepare_recovery(adap);
> =20
>  	return ret;
>  }
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index b556e0a..cf9380f 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -404,8 +404,8 @@ struct i2c_bus_recovery_info {
>  	void (*set_scl)(struct i2c_adapter *, int val);
>  	int (*get_sda)(struct i2c_adapter *);
> =20
> -	void (*prepare_recovery)(struct i2c_bus_recovery_info *bri);
> -	void (*unprepare_recovery)(struct i2c_bus_recovery_info *bri);
> +	void (*prepare_recovery)(struct i2c_adapter *);
> +	void (*unprepare_recovery)(struct i2c_adapter *);
> =20
>  	/* gpio recovery */
>  	int scl_gpio;
>=20

Acked-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

--=20
Best regards,
Alexander Sverdlin.
Sent from my pdp-11
