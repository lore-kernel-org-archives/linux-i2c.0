From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH V2] i2c-imx: do not allow interruptions when waiting for I2C
 to complete (resend)
Date: Tue, 15 Jun 2010 12:20:38 +0200
Message-ID: <4C1753F6.3080106@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3D1DC01A74CB43C625E9F994"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sascha Hauer <sha-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3D1DC01A74CB43C625E9F994
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The i2c_imx_trx_complete() function is using
wait_event_interruptible_timeout() to wait for the I2C controller to
signal that it has completed an I2C bus operation. If the process that
causes the I2C operation receives a signal, the wait will be
interrupted, returning an error. It is better to let the I2C operation
finished before handling the signal (i.e. returning into userspace).

It is safe to use wait_event_timeout() instead, because the timeout
will allow the process to exit if the I2C bus hangs. It's also better
to allow the I2C operation to finish, because unacknowledged I2C
operations can cause the I2C bus to hang.

Signed-off-by: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Reviewed-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---

V2: Remove check for "result < 0" as commented by Wolfram Sang.

 drivers/i2c/busses/i2c-imx.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index d1ff940..58df809 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -161,13 +161,10 @@ static int i2c_imx_trx_complete(struct
imx_i2c_struct *i2c_imx)
 {
 	int result;

-	result =3D wait_event_interruptible_timeout(i2c_imx->queue,
+	result =3D wait_event_timeout(i2c_imx->queue,
 		i2c_imx->i2csr & I2SR_IIF, HZ / 10);

-	if (unlikely(result < 0)) {
-		dev_dbg(&i2c_imx->adapter.dev, "<%s> result < 0\n", __func__);
-		return result;
-	} else if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
+	if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
 		dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
 		return -ETIMEDOUT;
 	}
@@ -295,7 +292,7 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)=

 		i2c_imx->i2csr =3D temp;
 		temp &=3D ~I2SR_IIF;
 		writeb(temp, i2c_imx->base + IMX_I2C_I2SR);
-		wake_up_interruptible(&i2c_imx->queue);
+		wake_up(&i2c_imx->queue);
 		return IRQ_HANDLED;
 	}

--=20
1.7.1


--------------enig3D1DC01A74CB43C625E9F994
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkwXU/sACgkQjTAFq1RaXHOY2gCdEu745+5db/OFd2wvoWW0AFzp
ejEAn0QA+T5EqPgHpDUMPnhMb0fJ56sY
=m7zX
-----END PGP SIGNATURE-----

--------------enig3D1DC01A74CB43C625E9F994--
