From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c: Convert to DEFINE_PCI_DEVICE_TABLE
Date: Tue, 27 Dec 2011 16:17:43 +0100
Message-ID: <20111227151743.GA3605@pengutronix.de>
References: <1324956897.9775.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1324956897.9775.2.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Rudolf Marek <r.marek@assembler.cz>, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Olof Johansson <olof@lixom.net>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>, Feng Tang <feng.tang@intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 27, 2011 at 11:34:57AM +0800, Axel Lin wrote:
> Convert static struct pci_device_id *[] to static DEFINE_PCI_DEVICE_TABLE
> tables.

Please not only describe what the patch does but also why it is needed or a
good idea. People looking up stuff later on might not know.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk754ZcACgkQD27XaX1/VRuHngCdEoilO9/t9kcSWxQdEOeKv4zM
Fd0AoL8mhIhxJTjEw9uacYs4qG0l4UQH
=bKvr
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
