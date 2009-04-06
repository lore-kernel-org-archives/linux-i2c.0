From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH RESEND] imx/i2c: Make disable_delay a per-device variable
Date: Mon, 6 Apr 2009 16:27:45 +0200
Message-ID: <20090406142745.GD3044@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, g.liakhovetski-Mmb7MZpHnFY@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


'disable_delay' was static which is wrong as it is calculated using the per=
-device
bus speed. This patch turns 'disable_delay' into a per-device variable.

Reported-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Acked-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Acked-by: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

Ben, can you pick it up? Any plans when pushing your patches for 2.6.30?

 drivers/i2c/busses/i2c-imx.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: .kernel/drivers/i2c/busses/i2c-imx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- .kernel.orig/drivers/i2c/busses/i2c-imx.c
+++ .kernel/drivers/i2c/busses/i2c-imx.c
@@ -86,8 +86,6 @@
 /** Variables ************************************************************=
******
 **************************************************************************=
*****/
=20
-static unsigned int disable_delay;	/* Dummy delay */
-
 /*
  * sorted list of clock divider, register value pairs
  * taken from table 26-5, p.26-9, Freescale i.MX
@@ -121,6 +119,7 @@ struct imx_i2c_struct {
 	int			irq;
 	wait_queue_head_t	queue;
 	unsigned long		i2csr;
+	unsigned int 		disable_delay;
 };
=20
 /** Functions for IMX I2C adapter driver *********************************=
******
@@ -212,7 +211,7 @@ static void i2c_imx_stop(struct imx_i2c_
 	 * This delay caused by an i.MXL hardware bug.
 	 * If no (or too short) delay, no "STOP" bit will be generated.
 	 */
-	udelay(disable_delay);
+	udelay(i2c_imx->disable_delay);
 	/* Disable I2C controller */
 	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
 }
@@ -243,7 +242,7 @@ static void __init i2c_imx_set_clk(struc
 	 * This delay is used in I2C bus disable function
 	 * to fix chip hardware bug.
 	 */
-	disable_delay =3D (500000U * i2c_clk_div[i][0]
+	i2c_imx->disable_delay =3D (500000U * i2c_clk_div[i][0]
 		+ (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
=20
 	/* dev_dbg() can't be used, because adapter is not yet registered */
--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknaEWEACgkQD27XaX1/VRvlEwCfX7wUkycg8n2Z1Er+JSbQPAfj
X+AAn2WNwpxyvnfBy7Y7KKP2pDiNQMnE
=dAiv
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
