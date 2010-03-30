From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 14/24] misc: fix dangling pointers
Date: Tue, 30 Mar 2010 14:44:37 +0200
Message-ID: <20100330124437.GK29472@pengutronix.de>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de> <1269094385-16114-15-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mZBmBd1ZkdwT1ny"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1269094385-16114-15-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--5mZBmBd1ZkdwT1ny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 20, 2010 at 03:12:55PM +0100, Wolfram Sang wrote:
> Fix I2C-drivers which missed setting clientdata to NULL before freeing the
> structure it points to. Also fix drivers which do this _after_ the struct=
ure
> was freed already.
>=20
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Uhm, Greg should know by now to drop these patches? ;)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--5mZBmBd1ZkdwT1ny
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkux8jUACgkQD27XaX1/VRvw3ACeJdUw4g3j9ryrCfKfhasJts46
vCkAn2uE6RskzqmIesUePl8HeOwGwQVs
=bD9C
-----END PGP SIGNATURE-----

--5mZBmBd1ZkdwT1ny--
