From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: at24.c: Need support for i2c byte read
Date: Thu, 28 Jan 2010 20:18:10 +0100
Message-ID: <20100128191810.GB7765@pengutronix.de>
References: <569050.22972.qm@web81304.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <569050.22972.qm-rPku/wkwbl+vuULXzWHTWIglqE1Y4D90QQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Konstantin Lazarev <klazarev-rphTv4pjVZMJGwgDXS7ZQA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

>    It was not an issue with old i2c EEPROM driver because it checked i2c
>    adapter functionality and used word read instead of block read is not
>    supported.

The old driver is still there if it works for you.

>    Could you please correct this issue and add support for adapters witho=
ut
>    block read support.

Well, I added this to my todo-list, but don't hold your breath, it is not
top-priority right now. Hint: I will happily review a patch.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkth4vIACgkQD27XaX1/VRv5LACfaHblWEdGhyb4joIbRoQsg+pn
s7cAoJwpVwDQAuS5j1fyA0DyZGkfB5+D
=O19w
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
