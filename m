From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: s3c2410: Use devm_clk_get() and
 devm_request_irq()
Date: Thu, 24 Jan 2013 13:10:02 +0100
Message-ID: <20130124121002.GE12933@pengutronix.de>
References: <007201cdeed6$b76453b0$262cfb10$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <007201cdeed6$b76453b0$262cfb10$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Ben Dooks' <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2013 at 11:03:42AM +0900, Jingoo Han wrote:
> Use devm_clk_get() and devm_request_irq() rather than clk_get() and
> request_irq() to make cleanup paths more simple.
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

I applied a similar patchset sent earlier doing the same.

Thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlEBJJoACgkQD27XaX1/VRtMoQCeKVGrIGubDDc+WvK++3bxmr7z
WYoAnjytwAzT8d3PxEXDHR3IxL7418+x
=LC20
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
