From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
Date: Thu, 14 May 2009 10:34:53 +0200
Message-ID: <20090514083453.GB3043@pengutronix.de>
References: <4A0BD1DB.4090305@doredevelopment.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A0BD1DB.4090305-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2009 at 10:10:03AM +0200, Esben Haabendal wrote:
> This fixes MAL (arbitration lost) bug caused by illegal use of
> RSTA (repeated START) after STOP condition generated after last byte
> of reads.
>

Could you elaborate a bit, please? Like an example when the original bug
occured (so I could reproduce easily) and how this patch actually solves
the problem.


> Signed-off-by: Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-mpc.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index 4af5c09..9fe05d9 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -456,17 +456,22 @@ static int mpc_xfer(struct i2c_adapter *adap, =20
> struct i2c_msg *msgs, int num)
>  	}
>
>  	for (i =3D 0; ret >=3D 0 && i < num; i++) {
> +		int restart =3D i;
>  		pmsg =3D &msgs[i];
>  		dev_dbg(i2c->dev,
>  			"Doing %s %d bytes to 0x%02x - %d of %d messages\n",
>  			pmsg->flags & I2C_M_RD ? "read" : "write",
>  			pmsg->len, pmsg->addr, i + 1, num);
> +		if (i > 0 && ((pmsg-1)->flags & I2C_M_RD))

CodingStyle: Spaces around '-'

> +			restart =3D 0;
>  		if (pmsg->flags & I2C_M_RD)
>  			ret =3D
> -			    mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
> +			    mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len,
> +				     restart);
>  		else
>  			ret =3D
> -			    mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
> +			    mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len,
> +				      restart);
>  	}
>  	mpc_i2c_stop(i2c);
>  	return (ret < 0) ? ret : num;
> --=20
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoL160ACgkQD27XaX1/VRuJDgCgisyi0B0tl9tcTxRbm5I/N3m9
FyoAniFIsuZu/YKJzV2IH06Je5nsqZa6
=TWS7
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
