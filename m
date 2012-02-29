From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c/imx: fix imx driver to work though signal is pending
Date: Wed, 29 Feb 2012 20:06:21 +0100
Message-ID: <20120229190621.GD30545@pengutronix.de>
References: <1329999551-32171-1-git-send-email-oskar@scara.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wtrm9ATX0sn6fFKv"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1329999551-32171-1-git-send-email-oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oskar Schirmer <oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2012 at 12:19:11PM +0000, Oskar Schirmer wrote:
> Interrupt a test application for I2C based mc13xxx driven
> touch panel, SIGINT, causes open event file descriptor to be
> closed, which in turn causes I2C activity to mask PMIC local
> interrupts. This eventually ends up in i2c_imx_bus_busy to
> wait for some busy flag to toggle, but while waiting it would
> find a signal pending and break. The final symptom is the
> device is not closed down cleanly and thus not reopenable.
>=20
> Do without check for pending signal.
>=20
> Signed-off-by: Oskar Schirmer <oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org>

Thanks. Picked to my for-3.4 branch. I'd like to have some more test covera=
ge,
then we can send it back via a stable-release. If you think it should go in=
to
3.3 directly, please let me know.

Oh, and it got acked by Marc Kleine-Budde via phone :)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Wtrm9ATX0sn6fFKv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk9Ody0ACgkQD27XaX1/VRthOwCfaoVTegQZx4qonG84FybCC6Bm
r9IAoMLr8dPBmqfsZuyNHB8mXR6hV1Gc
=pzem
-----END PGP SIGNATURE-----

--Wtrm9ATX0sn6fFKv--
