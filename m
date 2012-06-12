From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c: use module_pci_driver
Date: Tue, 12 Jun 2012 17:34:32 +0200
Message-ID: <20120612153432.GA24753@pengutronix.de>
References: <1339505279.12492.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1339505279.12492.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Rudolf Marek <r.marek@assembler.cz>, Olof Johansson <olof@lixom.net>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2012 at 08:47:59PM +0800, Axel Lin wrote:
> This patch converts the drivers in drivers/i2c/buses/* to use
> module_pci_driver() macro which makes the code smaller and a bit simpler.
>=20
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
> Cc: "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
> Cc: "Wolfram Sang (embedded platforms)" <w.sang@pengutronix.de>
> Cc: Rudolf Marek <r.marek@assembler.cz>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>
> Cc: Tomoya MORINAGA <tomoya.rohm@gmail.com>

Looks good to me

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Jean, let me know if you think this is embedded realm.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/XYYgACgkQD27XaX1/VRveTACfStCoXYHxsy148ZEojnVQM2vB
8GIAn1+3BOuiJdVAZ56iz3Lo19nB9smE
=+GT0
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
