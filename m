From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c-at91: fix data-loss issue
Date: Wed, 18 Apr 2012 16:39:20 +0200
Message-ID: <20120418143920.GA19802@pengutronix.de>
References: <20120413103937.GH7154@arwen.pp.htv.fi>
 <1334317476-10044-1-git-send-email-h.feurstein@gmail.com>
 <EF2E73589CA71846A15D0B2CDF79505D0905D5A1AA@wm021.weinmann.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D0905D5A1AA@wm021.weinmann.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Voss, Nikolaus" <N.Voss@weinmann.de>
Cc: 'Hubert Feurstein' <h.feurstein@gmail.com>, "'rmallon@gmail.com'" <rmallon@gmail.com>, "'nicolas.ferre@atmel.com'" <nicolas.ferre@atmel.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'balbi@ti.com'" <balbi@ti.com>, "'linux-i2c@vger.kernel.org'" <linux-i2c@vger.kernel.org>, "'ben-linux@fluff.org'" <ben-linux@fluff.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I'll repost the driver with your fix on positive feedback from you.
> Thanks for tracking this down.
>=20
> Ben, is there any chance to get this driver into next?

I think sending a new series would be good. It depends a bit on the amount
of donated tags (Tested-by, especially) if it will make it into 3.5.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+O0hgACgkQD27XaX1/VRuGVwCfbCS5QH55EkuCi1We072O4Wet
1H8AnRYNi+NoqQhdyENB66VTVwGdcko5
=GF9j
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
