From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: at24 driver - a possible problem
Date: Fri, 6 Nov 2009 13:49:05 +0100
Message-ID: <20091106124905.GA3980@pengutronix.de>
References: <533f29860911050810w4d939b39x2ad11c189f13c977@mail.gmail.com> <20091105172537.GA3332@pengutronix.de> <20091106131524.76ae52b9@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091106131524.76ae52b9-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Aleksandar Ivanov <ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> This makes a lot of sense. When a write operation is in progress, the
> EEPROM is busy and may not ack its address. Whether the request is
> another write or a read probably doesn't make a difference, a nack is a
> nack. So the same waiting loop that we have for writes, is certainly
> needed for reads as well. Shouldn't be too difficult. Any volunteer? I
> can review the patch when it's done.

If nobody is faster ;), I will do it this weekend.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkr0G0EACgkQD27XaX1/VRsWPgCgr43owCqfBvtuQHtCz5bY9nZg
rT0An26MIi9s6NobqIAeKgDKWvky9/pp
=0Jrc
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
