From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] assign a default class to MPC adapter
Date: Thu, 16 Apr 2009 13:47:01 +0200
Message-ID: <20090416114701.GD3052@pengutronix.de>
References: <49E6F4F9.3060705@gmx.de> <20090416092012.GB3052@pengutronix.de> <49E7101E.6070806@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49E7101E.6070806-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Could you please elaborate?

Instead of probing you specify the devices on the i2c-bus in the dts. Examp=
le
for the pcm032 looks like this (from the kernel-tree):

i2c@3d40 {
	#address-cells =3D <1>;
	#size-cells =3D <0>;
	compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
	reg =3D <0x3d40 0x40>;
	interrupts =3D <2 16 0>;
	fsl5200-clocking;

	rtc@51 {
		compatible =3D "nxp,pcf8563";
		reg =3D <0x51>;
	};
	eeprom@52 {
		compatible =3D "at24,24c32";
		reg =3D <0x52>;
	};
};

Boards which relied on probing need to have such child nodes added.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknnGrUACgkQD27XaX1/VRv/bQCePBLd2TmxpQnG16Iry0CK1b9N
bJ0AoMvKcaxrJNw57m2nYsX1CTQhI1MG
=moUt
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
