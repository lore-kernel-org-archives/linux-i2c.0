From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V3 RESEND4] i2c-imx: do not allow interruptions when
 waiting for I2C to complete
Date: Tue, 28 Sep 2010 11:05:44 +0200
Message-ID: <20100928090544.GC4441@pengutronix.de>
References: <4C1F0FC7.60605@pengutronix.de>
 <4C9CBAA1.5040202@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4C9CBAA1.5040202-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 24, 2010 at 04:50:09PM +0200, Marc Kleine-Budde wrote:
> Hello Ben,
>=20
> what about this patch?

Ben, any reason you did not pick up this one while you were picking up
other patches?

>=20
> cheers, Marc
>=20
> --------8<--------8<--------8<--------8<--------8<--------8<--------
>=20
> The i2c_imx_trx_complete() function is using
> wait_event_interruptible_timeout() to wait for the I2C controller to
> signal that it has completed an I2C bus operation. If the process that
> causes the I2C operation receives a signal, the wait will be
> interrupted, returning an error. It is better to let the I2C operation
> finished before handling the signal (i.e. returning into userspace).
>=20
> It is safe to use wait_event_timeout() instead, because the timeout
> will allow the process to exit if the I2C bus hangs. It's also better
> to allow the I2C operation to finish, because unacknowledged I2C
> operations can cause the I2C bus to hang.
>=20
> Signed-off-by: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Reviewed-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>=20
> V2: Remove check for "result < 0" as commented by Wolfram Sang.
> V3: Remove "result" entirely.
>=20
>  drivers/i2c/busses/i2c-imx.c |   12 +++---------
>  1 files changed, 3 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index d1ff940..4c2a62b 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -159,15 +159,9 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct
> *i2c_imx, int for_busy)
>=20
>  static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx)
>  {
> -	int result;
> -
> -	result =3D wait_event_interruptible_timeout(i2c_imx->queue,
> -		i2c_imx->i2csr & I2SR_IIF, HZ / 10);
> +	wait_event_timeout(i2c_imx->queue, i2c_imx->i2csr & I2SR_IIF, HZ / 10);
>=20
> -	if (unlikely(result < 0)) {
> -		dev_dbg(&i2c_imx->adapter.dev, "<%s> result < 0\n", __func__);
> -		return result;
> -	} else if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
> +	if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
>  		dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
>  		return -ETIMEDOUT;
>  	}
> @@ -295,7 +289,7 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
>  		i2c_imx->i2csr =3D temp;
>  		temp &=3D ~I2SR_IIF;
>  		writeb(temp, i2c_imx->base + IMX_I2C_I2SR);
> -		wake_up_interruptible(&i2c_imx->queue);
> +		wake_up(&i2c_imx->queue);
>  		return IRQ_HANDLED;
>  	}
>=20
> --=20
> 1.7.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
>=20
>=20
>=20
>=20



--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyhr+gACgkQD27XaX1/VRsNUQCfSU23O4O0LY8f4rD7w+OxKKsC
bbEAnj1YvfntPO7GizyhJ4IlhaldtNNJ
=BkpU
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
