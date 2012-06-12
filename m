From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C
 driver
Date: Tue, 12 Jun 2012 10:57:41 +0200
Message-ID: <20120612085741.GD9230@pengutronix.de>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <20120611190550.GK3887@pengutronix.de>
 <4FD70357.9060905@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FD70357.9060905-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2012 at 09:52:39AM +0100, Lee Jones wrote:
> From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Date: Tue, 17 Apr 2012 16:04:13 +0100
> Subject: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C dr=
iver
>=20
> Here we move the i2c-nomadik's default settings into the driver
> rather than specifying them from platform code. At the time of
> this writing we only have one user, the u8500. As new users are
> added, it is expected that they will be Device Tree compliant.
> If this is the case, we will look up their initialisation values
> by compatible entry, then apply them forthwith.
>=20
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Did you use checkpatch?

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Applying: i2c: Add Device Tree support to the Nomadik I2C driver
  CHECKPATCH
WARNING: please, no space before tabs
#37: FILE: drivers/i2c/busses/i2c-nomadik.c:909:
+^I.tft            =3D 1, ^I  /* Tx FIFO threshold */$

WARNING: please, no space before tabs
#38: FILE: drivers/i2c/busses/i2c-nomadik.c:910:
+^I.rft            =3D 8, ^I  /* Rx FIFO threshold */$

WARNING: please, no space before tabs
#40: FILE: drivers/i2c/busses/i2c-nomadik.c:912:
+^I.timeout        =3D 200, ^I  /* Slave response timeout(ms) */$

ERROR: code indent should use tabs where possible
#56: FILE: drivers/i2c/busses/i2c-nomadik.c:927:
+        const struct of_device_id *of_id =3D$

WARNING: please, no spaces at the start of a line
#56: FILE: drivers/i2c/busses/i2c-nomadik.c:927:
+        const struct of_device_id *of_id =3D$

ERROR: code indent should use tabs where possible
#57: FILE: drivers/i2c/busses/i2c-nomadik.c:928:
+                        of_match_device(nmk_gpio_match, &pdev->dev);$

WARNING: please, no spaces at the start of a line
#57: FILE: drivers/i2c/busses/i2c-nomadik.c:928:
+                        of_match_device(nmk_gpio_match, &pdev->dev);$

total: 2 errors, 5 warnings, 0 checks, 59 lines checked

NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
      scripts/cleanfile

Your patch has style problems, please review.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/XBIUACgkQD27XaX1/VRtX7ACeLrWCDbmZFmbviuoP+kGCJHdT
24YAoMSHs4mWg7w62UfA8HPUsdg4eVAL
=+Sjt
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
