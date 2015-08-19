From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 6/7] i2c: img-scb: Clear line and interrupt status
 before starting a transfer
Date: Wed, 19 Aug 2015 22:58:03 +0100
Message-ID: <20150819215803.GF8443@jhogan-linux.le.imgtec.org>
References: <1439567424-8094-1-git-send-email-sifan.naeem@imgtec.com>
 <1439567424-8094-7-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kR3zbvD4cgoYnS/6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1439567424-8094-7-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--kR3zbvD4cgoYnS/6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 04:50:23PM +0100, Sifan Naeem wrote:
> Clear line status and all generated interrupts from the interrupt
> status register before starting a transfer, as we may have
> unserviced interrupts from previous transfers that might be
> handled in the context of the new transfer.
>=20
> Fixes: commit 27bce457d588 ("i2c: img-scb: Add Imagination Technologies I=
2C SCB driver")
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

I think it could have done with some more explanation about when this
happens and whether between messages in the transfer or between
transfers, but it does look safe and reasonable, so:

Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Cheers
James

> ---
>  drivers/i2c/busses/i2c-img-scb.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-im=
g-scb.c
> index 200108dbd194..6c21a7bd9a66 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -1068,6 +1068,15 @@ static int img_i2c_xfer(struct i2c_adapter *adap, =
struct i2c_msg *msgs,
>  		i2c->last_msg =3D (i =3D=3D num - 1);
>  		reinit_completion(&i2c->msg_complete);
> =20
> +		/*
> +		 * Clear line status and all interrupts before starting a
> +		 * transfer, as we may have unserviced interrupts from
> +		 * previous transfers that might be handled in the context
> +		 * of the new transfer.
> +		 */
> +		img_i2c_writel(i2c, SCB_INT_CLEAR_REG, ~0);
> +		img_i2c_writel(i2c, SCB_CLEAR_REG, ~0);
> +
>  		if (atomic)
>  			img_i2c_atomic_start(i2c);
>  		else if (msg->flags & I2C_M_RD)
> --=20
> 1.7.9.5
>=20

--kR3zbvD4cgoYnS/6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJV1PvrAAoJEGwLaZPeOHZ6a08P/3R4Sy9v4Xepc1FvRqxCLKr+
uKxvCzErBIxayde2+5EAHgIPfqYGdcrEBaqfbE+w7FRhaRj24HDt4ZLIcMqgqJwI
hdyuLXJ1EXilFeqnGwmJlrkemIA0fhBsM6/JNG5RWkgDUNmOPjmUm6Ylej6XjQhi
t2Dc9KInnnhJnsPO3Q0L+YdDixv6CovpQJuR4uqXTbA72Hs6cfQuqwoCKfsCyxQs
AsLQ62PCZwHthNlKnBNIJfYO/WCA37lZIJFGtobigFm7U/TxIlgbHHVXbrhLr+6C
CqnBs0NtnU3yk88f3CZ6Jz/IdCLfaePcrrTBZ4OMsTPpdMH5WO5Ojv8ptbfeblrY
mxxdVLkrqsM3eiuZhylHKI+yxYrzGS4ZhuBSuRw/2ppAQOjtfcqkaMUAbUetKZmW
yqcvYikdE7WoJmRH1R2Z1yjRUh8hyvxLKrfGEqyLcL6g0HY1usHl9BxgkVRBMdGt
W+Fz/nPqgsVE4f0lQ+EFonr1CxcwL9N3tCW03+UOsASSxm7NXj00Z5HX/v6moaWJ
GY5U8+wMNSEhzS4OYY/KUyxh7Kor7c9X3TkurWCZ4bkq6WP6374Rsy/xbu25wwr0
l2+CQSFnalbmhutleZNmN07uQLt0tkwRg0EcrDqvz3xSvIQjk9CyLCCNJnMJyfpi
HuULgPpUqJre6yOnH4pB
=T9bu
-----END PGP SIGNATURE-----

--kR3zbvD4cgoYnS/6--
