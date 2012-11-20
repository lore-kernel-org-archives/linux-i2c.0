From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: mxs: Handle i2c DMA failure properly
Date: Tue, 20 Nov 2012 09:39:46 +0100
Message-ID: <20121120083946.GB14722@pengutronix.de>
References: <1353216308-7338-1-git-send-email-marex@denx.de>
 <20121119092531.GE7775@pengutronix.de>
 <201211191500.32205.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201211191500.32205.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> btw. I guess we won't be able to squeeze these into 3.7 anymore, right? E=
ven if=20
> I'd say these are fixes.

After the outcoming of the discussion with Tim, I will apply the single
patch. But I won't apply Fabio's patch to enable I2C for MX23 since
there seem to be issues.

Since the driver currently advertises properly that it cannot do
SMBUS_QUICK, the addition of that is not a bugfix but a feature
addition, so I'll apply it to for-next.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCrQdIACgkQD27XaX1/VRvRcQCeIYnIaAEyh572pOG+dGg0tpoJ
OuEAoLNaeO4ZA/kB4yle5myIjSZ94bTi
=1BI/
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
