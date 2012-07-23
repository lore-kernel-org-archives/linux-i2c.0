From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] I2C: MV64XYZ: Add Device Tree support
Date: Mon, 23 Jul 2012 22:03:59 +0200
Message-ID: <20120723200359.GB31645@pengutronix.de>
References: <1342954295-13279-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1342954295-13279-1-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, sebastian.hesselbarth-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2012 at 12:51:35PM +0200, Andrew Lunn wrote:
> Extends the driver to get properties from device tree. Rather than
> pass the N & M factors in DT, use the more standard clock-frequency
> property. Calculate N & M at run time. In order to do this, we need to
> know tclk. So the driver uses clk_get() etc in order to get the clock
> and clk_get_rate() to determine the tclk rate. Not all platforms
> however have CLK, so some #ifdefery is needed to ensure the driver
> still compiles when CLK is not available.
>=20
> Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>

Sparse complained about this:

drivers/i2c/busses/i2c-mv64xxx.c:584:54: warning: incorrect type in argumen=
t 3 (different signedness)
drivers/i2c/busses/i2c-mv64xxx.c:584:54:    expected unsigned int [usertype=
] *out_value
drivers/i2c/busses/i2c-mv64xxx.c:584:54:    got int *<noident>
drivers/i2c/busses/i2c-mv64xxx.c:586:41: warning: incorrect type in argumen=
t 3 (different signedness)
drivers/i2c/busses/i2c-mv64xxx.c:586:41:    expected int *best_n
drivers/i2c/busses/i2c-mv64xxx.c:586:41:    got unsigned int *<noident>
drivers/i2c/busses/i2c-mv64xxx.c:586:60: warning: incorrect type in argumen=
t 4 (different signedness)
drivers/i2c/busses/i2c-mv64xxx.c:586:60:    expected int *best_m
drivers/i2c/busses/i2c-mv64xxx.c:586:60:    got unsigned int *<noident>

I applied your patch with the following fix to -next. Let me know if you ag=
ree
with that.

Regards,

   Wolfram

--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -537,8 +537,8 @@ mv64xxx_calc_freq(const int tclk, const int n, const in=
t m)
 }
=20
 static bool __devinit
-mv64xxx_find_baud_factors(const int req_freq, const int tclk, int *best_n,
-                         int *best_m)
+mv64xxx_find_baud_factors(const u32 req_freq, const u32 tclk, u32 *best_n,
+                         u32 *best_m)
 {
        int freq, delta, best_delta =3D INT_MAX;
        int m, n;
@@ -564,8 +564,7 @@ static int __devinit
 mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
                  struct device_node *np)
 {
-       int bus_freq;
-       int tclk;
+       u32 bus_freq, tclk;
        int rc =3D 0;
=20
        /* CLK is mandatory when using DT to describe the i2c bus. We

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlANri8ACgkQD27XaX1/VRtg5wCeOr/tI3H9krEcoL6lPxmudan5
/KsAoL8eL9BwfcG++3VrEeiA/SJWRp0z
=29Yk
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
