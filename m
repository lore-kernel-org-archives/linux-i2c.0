From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: 10-bit address support
Date: Wed, 16 Nov 2011 16:04:49 +0100
Message-ID: <20111116150449.GG2596@pengutronix.de>
References: <20111110160739.540cda37@endymion.delvare>
 <20111111104335.GC2493@pengutronix.de>
 <20111116155610.6b02aab6@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5L6AZ1aJH5mDrqCQ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111116155610.6b02aab6-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Jeffrey (Sheng-Hui) Chu" <jeffchu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--5L6AZ1aJH5mDrqCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> > Wouldn't the cleanest solution be
> >=20
> > "%d-%02x" for 7 bit
> > "%d-%04x" for 10 bit?
>=20
> I'd rather use %03x for 10-bit then, for consistency.

Yup, I realized this a few hours later, too. This would leave the
possibility to add true 16-bit addressing of the next to be i2c standard
;)

> internally), but unfortunately it would have had to be implemented in
> the early days, not 8 years later.

Yes, and hopefully we can live with this drawback well enough.

> 0xa000 is not more intrusive than 0x1000, so if the majority - i.e.
> you ;) - is in favor of this, that's fine with me. I'll send a patch
> later today.

You can already add my:

Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--5L6AZ1aJH5mDrqCQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7D0REACgkQD27XaX1/VRvoyACff2gchWyHtv6WeG4kHB9E8z5a
yAMAn04llnbBrxHlb5aY3dmlxbtsxAQC
=sOln
-----END PGP SIGNATURE-----

--5L6AZ1aJH5mDrqCQ--
