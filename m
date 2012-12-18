From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] driver i2c-nforce2: fix pointer CodingStyle issues
Date: Tue, 18 Dec 2012 11:30:37 +0100
Message-ID: <20121218103037.GC2612@pengutronix.de>
References: <1355778259-8445-1-git-send-email-laurent.navet@gmail.com>
 <20121218105223.0184d4a3@endymion.delvare>
 <CAH7P7Nhz2FpBct4afvAXU2Zgi-yA4TkJj7CtYMaW7pXr6weZig@mail.gmail.com>
 <20121218100906.GB2612@pengutronix.de>
 <20121218112355.69369ee1@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121218112355.69369ee1-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Are you also able to build-test the changes?
>=20
> Most certainly yes, this driver has almost no dependencies. I will
> build-test it anyway.

Me too :) I just wanted to express that I would love to see a compile
test before submission, even for checkpatch thingies. Can save some
hazzle for all of us.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlDQRc0ACgkQD27XaX1/VRuVKwCgt/rjkHZ6aKRst3EsaOIoSMhV
D/YAoJe2IoxOZJ84CiXmH8e9fTo0a9V/
=XeWT
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
