From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: 10-bit address support
Date: Fri, 11 Nov 2011 11:43:35 +0100
Message-ID: <20111111104335.GC2493@pengutronix.de>
References: <20111110160739.540cda37@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111110160739.540cda37-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Jeffrey (Sheng-Hui) Chu" <jeffchu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> I can think of 2 different ways of addressing the problem.
>=20
> First way is to use a different device name format for 10-bit address
> devices, for example %d-10bit-%04x. This has the drawback that some
> user-space applications and libraries may not recognize these as valid
> i2c device names. libsensors and sensors-detect would be amongst these.

Wouldn't the cleanest solution be

"%d-%02x" for 7 bit
"%d-%04x" for 10 bit?

Yeah, I know that would really break userspace.

> I'd rather go with a larger offset such as 0x1000. This translates 0x2d
> to 0x102d which is more obviously "10-bit address 0x2d". We have 16
> bits to store the address so it shouldn't be an issue. Another possible
> offset would be 0xa000 (as 0xa is 10.)

I like 0xa000 a tad better than 0x1000, but well... Then again, those
devices are probably rare enough to take a non-intrusive approach.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk68/FcACgkQD27XaX1/VRs0kACgzM9nPIju91JfTxbVxr4rsgji
yYoAn13aZBPE9F0lwd2P0AgcK9pqh4Iq
=whei
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
