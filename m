From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: reorganize muxes to a standard pattern
Date: Mon, 28 Nov 2011 10:38:35 +0100
Message-ID: <20111128093835.GA4243@pengutronix.de>
References: <1321220474-11378-1-git-send-email-w.sang@pengutronix.de>
 <20111127214847.547542fb@endymion.delvare>
 <87sjl9gtcv.fsf@macbook.be.48ers.dk>
 <20111128092227.3d5d6a25@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111128092227.3d5d6a25-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > http://thread.gmane.org/gmane.linux.drivers.i2c/7171/focus=3D7244
>=20
> Ah, yes, that's the discussion I was looking for, thanks for digging it
> out. My point wasn't totally wrong back then, but Wolfram's is simply
> better, I admit.

I agree :) Okay, so I'll update the documentation as well. What about
include/linux/gpio-i2cmux.h and its users? I'd like consistency, but
renaming header files is not too nice...

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7TVpsACgkQD27XaX1/VRvoywCgpEId8VQC/L/vsa0MsUcXCXDy
KfgAoIzdwx6h4bmisKwn94Q44UANwaH/
=M3GK
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
