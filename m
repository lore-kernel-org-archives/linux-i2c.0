From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] at24: use timeout also for read
Date: Mon, 16 Nov 2009 19:50:30 +0100
Message-ID: <20091116185030.GB21491@pengutronix.de>
References: <20091106131524.76ae52b9@hyperion.delvare> <1257711297-19927-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1257711297-19927-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 08, 2009 at 09:14:57PM +0100, Wolfram Sang wrote:
> Writes may take some time on EEPROMs, so for consecutive writes, we alrea=
dy
> have a loop waiting for the EEPROM to become ready. Use such a loop for r=
eads,
> too, in case somebody wants to immediately read after a write. Detailed b=
ug
> report and test case can be found here:
>=20
> http://article.gmane.org/gmane.linux.drivers.i2c/4660
>=20
> Reported-by: Aleksandar Ivanov <ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Jean, you are probably busy, just a short note will do: Is this scheduled f=
or
2.6.33?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksBnvYACgkQD27XaX1/VRsxywCfVi2Z60XlcXLU3rVk5IipR9Xm
60wAn1QghPoV1x0oBI/yCXxmkcNo69ZK
=36Cw
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
