From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 RESEND] i2c: (algo-pca) Fix chip reset function for
 PCA9665
Date: Sat, 6 Oct 2012 12:27:24 +0200
Message-ID: <20121006102724.GA25375@pengutronix.de>
References: <1348197646-5864-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348197646-5864-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>, Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 20, 2012 at 08:20:46PM -0700, Guenter Roeck wrote:
> From: Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
>=20
> The parameter passed to pca9665_reset is adap->data (which is bus driver
> specific), not i2c_algp_pca_data *adap. pca9665_reset expects it to be
> i2c_algp_pca_data *adap. All other wrappers from the algo call back to
> the bus driver, which knows to handle its custom data. Only pca9665_reset
> resides inside the algorithm code and does not know how to handle a custom
> data structure. This can result in a kernel crash.
>=20
> Fix by re-factoring pca_reset() from a macro to a function handling chip
> specific code, and only call adap->reset_chip() if the chip is not PCA966=
5.
>=20
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
> Signed-off-by: Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>

Applied to next, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBwB4wACgkQD27XaX1/VRuvKQCfb2yVWbugTt4DP143DKrJ2fPX
W1YAnjgpWSNBUW8kw18VuJVbG42msZO0
=yGi/
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
