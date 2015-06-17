From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: remove unreachable signal case handling
Date: Wed, 17 Jun 2015 15:00:30 +0200
Message-ID: <20150617130030.GG13393@katana>
References: <1434036453-23336-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nhYGnrYv1PEJ5gA2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434036453-23336-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--nhYGnrYv1PEJ5gA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2015 at 05:27:33PM +0200, Nicholas Mc Guire wrote:
> 'commit d295a86eab20 ("i2c: mv64xxx: work around signals causing I2C
> transactions to be aborted")' removed the wait_event_interruptible_timeou=
t=20
> to prevent half/mixed i2c messages from being sent/received but forgot to
> drop the signal received cases in the return handling. This just removes
> this dead code and simplifies the error message as "time_left" only can b=
e=20
> 0 here and thus it conveys no additional information.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
> ---
>=20
> Patch was compile tested with multi_v7_defconfig=20
> (implies CONFIG_I2C_MV64XXX=3Dy)
>=20
> Patch is against 4.1-rc7 (localversion-next is -next-20150611)

Hmm, IMO this patch is too intrusive to be applied without actual
testing.

>=20
>  drivers/i2c/busses/i2c-mv64xxx.c |   15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv=
64xxx.c
> index 30059c1..a4f8ece 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -534,7 +534,6 @@ mv64xxx_i2c_wait_for_completion(struct mv64xxx_i2c_da=
ta *drv_data)
>  {
>  	long		time_left;
>  	unsigned long	flags;
> -	char		abort =3D 0;
> =20
>  	time_left =3D wait_event_timeout(drv_data->waitq,
>  		!drv_data->block, drv_data->adapter.timeout);
> @@ -542,25 +541,17 @@ mv64xxx_i2c_wait_for_completion(struct mv64xxx_i2c_=
data *drv_data)
>  	spin_lock_irqsave(&drv_data->lock, flags);
>  	if (!time_left) { /* Timed out */
>  		drv_data->rc =3D -ETIMEDOUT;
> -		abort =3D 1;
> -	} else if (time_left < 0) { /* Interrupted/Error */
> -		drv_data->rc =3D time_left; /* errno value */
> -		abort =3D 1;
> -	}
> -
> -	if (abort && drv_data->block) {
>  		drv_data->aborting =3D 1;
>  		spin_unlock_irqrestore(&drv_data->lock, flags);
> =20
>  		time_left =3D wait_event_timeout(drv_data->waitq,
>  			!drv_data->block, drv_data->adapter.timeout);
> =20
> -		if ((time_left <=3D 0) && drv_data->block) {

I am especially unsure about the drv_data->block removal. Did you double
check if we can do this?

> +		if (time_left =3D=3D 0) {
>  			drv_data->state =3D MV64XXX_I2C_STATE_IDLE;
>  			dev_err(&drv_data->adapter.dev,
> -				"mv64xxx: I2C bus locked, block: %d, "
> -				"time_left: %d\n", drv_data->block,
> -				(int)time_left);
> +				"mv64xxx: I2C bus locked, block: %d\n",
> +				drv_data->block);

And if so, shouldn't that also be always 1 in the output here?

>  			mv64xxx_i2c_hw_init(drv_data);
>  		}
>  	} else

Maybe (not sure) it also helps to split the patch into everything
dealing with time_left as patch 1) and simplifying by drv_data->block
removal as patch2?

Thanks,

   Wolfram


--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgW9uAAoJEBQN5MwUoCm2a00P/jwGcyWY4wy+1KqBojeG8K8H
iObBgBVFPwSFTJWGj/sUyNUwmRsa46pd5DZORQ4VHO/lCkfN8C+/cOSzvheoPH2V
b/IWtHkKtfHsJaTQ8WmkHvGBh8U+iRLqx5yvmm0wQlVnDyGxHgSPfH7pL+WlYnmN
EGzKYo+u3W0W7mL1pokObS2bwZyiHa3uEzmZHIyLcFeaoRBsyYOMCV+PIYtkHuUj
QCBA+QboUETY2rPSOf53LJo2EyEY9A0x76KHwDg9m4//AmoSNwKvnIxYPK7pcAH3
JqBV8zJmG32yApA4QDBvhbJbi7gHSz+PLLgHFCBKKNfBMeaLvI/asd8kFTvPWqDU
6aY5ku4Fer/RDv3oAg2+mcW/I5uYU0fvQFmzlUzHtWMmFs/tOjz590Ny4nhgJV0S
EhXP3NE+SSUpqsl+gAg/PyvU67aEfaj5VqrStkzG5gc3naS258HizyMq1dl/xhCR
ay8o76gUZr6JPMf34RT7daaO/0XyI5f5l2+KKwr/5WJZo5B8BivwkUAt8B+1Qn2x
u7c/bcIgWE/ycn//2pzxhn1ZRS1dRknsQQAGCr9F+mH2kPukmodLiVU7O2Rz+RL7
Cj2fKUlyl3HDo+LbAHWiPlfI+Yk1NkTmRh3XSz4fZl8Jq9R07w4QqRCSZIKbak9X
8zlJVTnCytHFVoSP9eCX
=ClWW
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--
