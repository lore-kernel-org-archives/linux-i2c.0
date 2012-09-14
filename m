From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: (algo-pca) Fix chip reset function for PCA9665
Date: Fri, 14 Sep 2012 14:51:46 +0200
Message-ID: <20120914125146.GG2630@pengutronix.de>
References: <1347507591-32352-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1347507591-32352-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>, Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 12, 2012 at 08:39:50PM -0700, Guenter Roeck wrote:
> From: Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
>=20
> The parameter passed to pca9665_reset is adap->data, not adap. Unless
> adap->data happens to point back to adap, this can result in a kernel pan=
ic.

Can you please update this paragraph with a short explanation of what we
discussed (i.e. why exactly the kernel can crash)?

>=20
> Fix re-factoring pca_reset() from a macro to a function to handle chip
> specific code, and only call adap->reset_chip() if the chip is not PCA966=
5.
>=20
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
> Signed-off-by: Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>

Patch itself is good.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBTKGIACgkQD27XaX1/VRvzXACgyF75k02dO8LgO5Gl11sktJeM
kEsAoJHb1B0DnVxp04D/pSMSFcuEnZiY
=fzty
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--
