From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: mxs: Handle i2c DMA failure properly
Date: Tue, 20 Nov 2012 09:54:53 +0100
Message-ID: <20121120085453.GC14722@pengutronix.de>
References: <1353216308-7338-1-git-send-email-marex@denx.de>
 <201211191500.32205.marex@denx.de>
 <20121120083946.GB14722@pengutronix.de>
 <201211200947.36430.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201211200947.36430.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Since the driver currently advertises properly that it cannot do
> > SMBUS_QUICK, the addition of that is not a bugfix but a feature
> > addition, so I'll apply it to for-next.
>=20
> Actually, I'd say apply the DMA termination fix to stable and the SMBUS_Q=
UICK=20
> enabling to -next if you want to be completely correct. You're right, one=
 part=20
> of the patch is a bugfix, the rest if feature addition.

OK then.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCrRV0ACgkQD27XaX1/VRvM+QCgq3C1cTHAeA3gTUUWLrngFrHB
EcIAoKoabI8K5AeNNFLbx8oBTlYPvvrg
=tOtN
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
