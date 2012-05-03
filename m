From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-mux-gpio: Rename platform data structure
Date: Thu, 3 May 2012 11:32:50 +0200
Message-ID: <20120503093250.GB9574@pengutronix.de>
References: <20120428153206.00c1e226@endymion.delvare>
 <20120428153551.64d4d200@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120428153551.64d4d200-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 28, 2012 at 03:35:51PM +0200, Jean Delvare wrote:
> Align the name of i2c-mux-gpio's data structure on the new driver name.
> Also change one define and adjust function names, even if they aren't
> part of the public interface, for consistency.
>=20
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
> I made this a separate patch for easier testing/review/bisection.
> Wolfram, feel free to merge into the first patch if you prefer a
> single patch.

Applied both, squashed them (was still readable IMO) and fixed it up
because of the recent i2c_add_mux_adapter() rework.

Thanks a lot!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+iUMIACgkQD27XaX1/VRskhgCgnKyr0euhFGuB+S2L4OPgAvtC
wLAAnROIysqqP7IVSNSHIZyRdk/ukcxu
=Gfmj
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
