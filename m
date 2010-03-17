From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: PCA9564: "bus is not idle" issue
Date: Wed, 17 Mar 2010 14:52:23 +0100
Message-ID: <20100317135223.GD4153@pengutronix.de>
References: <f69abfc31003170559y3c0a5a6fi91c1ae7692700c66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g7w8+K/95kPelPD2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f69abfc31003170559y3c0a5a6fi91c1ae7692700c66-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 17, 2010 at 01:59:03PM +0100, Yegor Yefremov wrote:

> Could this be the reason for such behavior? Any idea?

Can you set the algo-module parameter i2c_debug to 3 and post the log for t=
he
transfer that failed, please?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkug3pcACgkQD27XaX1/VRsQwACeMTaKpBvJp47oBryIyIeT5DDP
WOIAni/hCg2YPe8ipF2dQCsEa3R8q0RP
=nXst
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--
