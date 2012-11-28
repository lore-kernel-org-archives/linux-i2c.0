From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv2] i2c: omap: Remove the
 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE flag
Date: Wed, 28 Nov 2012 11:38:49 +0100
Message-ID: <20121128103849.GA14238@pengutronix.de>
References: <1353923711-9615-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353923711-9615-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, balbi@ti.com
List-Id: linux-i2c@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2012 at 03:25:11PM +0530, Shubhrajyoti D wrote:
> The OMAP_I2C_FLAG_RESET_REGS_POSTIDLE is not used anymore
> in the i2c driver. Remove the flag.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Trivial enough to still go into 3.8. Applied to -next, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlC16bkACgkQD27XaX1/VRuscQCcC335ehOYDB6RNeCxhKzDKibO
6D8An1i4KKHlom7bVW/80fijpQHV+pbL
=okLM
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
