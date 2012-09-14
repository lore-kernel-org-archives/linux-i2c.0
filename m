From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: Wait for STOP to hit the bus
Date: Fri, 14 Sep 2012 16:02:34 +0200
Message-ID: <20120914140234.GH2630@pengutronix.de>
References: <1346323204-19210-1-git-send-email-Joakim.Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1346323204-19210-1-git-send-email-Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2012 at 12:40:04PM +0200, Joakim Tjernlund wrote:
> mpc_i2c_stop() only initiates STOP but does not wait for it to
> hit the I2C bus. This is a problem when using I2C devices which
> uses fairly long clock stretching just before STOP if you also
> have an i2c-mux which may switch to another bus before STOP has
> been processed.
>=20
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>

Patch didn't apply, because it was a p0-patch. Checkpatch would have
warned you.

Fixed that and applied to -next, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBTOPoACgkQD27XaX1/VRvYVwCgqsbfnjBfL/VGJVtGxZhkWAPY
1pQAnRbLUcqXArSYnDeQLiRWNs7KQkdl
=5Al6
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--
