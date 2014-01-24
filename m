From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Standardize log messages
Date: Fri, 24 Jan 2014 17:51:54 +0100
Message-ID: <20140124165154.GC2629@katana>
References: <20140123165938.493ea62c@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eqp4TxRxnD4KrmFZ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140123165938.493ea62c-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2014 at 04:59:38PM +0100, Jean Delvare wrote:
> Use exactly the same log messages in the legacy setup function and the
> SB800+ setup function. This way strings can be reused, which saves
> some bytes in the generated binary.
>=20
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>

Subject is wrong. This is about piix4, not i801.
Fixed and applied to for-current, thanks!


--eqp4TxRxnD4KrmFZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS4poqAAoJEBQN5MwUoCm2BXwQAJFa6wxZ4SsbUkBsMakJr+s9
8LnREMdQ3KzSaDUi2tjI7xa+7raG3IW6iDtXlyjHMKV93NWLBek6cq+qFyrGLhVt
madQgneQ5Kc0VV5exx0/Y5k/wYqAVng7N5aF1Riecdjh8DSBuix27Ycow7tD90hH
goiR3FO0tmoyJi6wAxMLGuOCJBc/Wc5/Hg/+RHwCtPUwY1udvsNuxVhq5U10YDVH
XuqhEpAruQG3t8Df8jCWCC4g6PPJukFfTdEWHZB25zN6z6Hnkx75dn6YDjvDRN67
qD7dXYVEH9CYZ8DuB8iaBJjgzooS/iJoADs2O7HaOXGeYmmHVGvkGsYIsrA6V6xQ
fsmgMKnJUaH+pOJIAyLKLyCRXETYGqojBSPYe6WgltXaNruhJcaGAgwPWWgIgtVR
cLdORMfJjbKZ5KgV86HIWSoMmFD2+StdPfjiIZhV+doh0T6DFbT/GkmgOGloccrb
JPFUH/V2qKqLJxsJlNYjNd0cI2Tdcz+z2Z/rTDFiSTKtzdfyGEKDcl1j26wYqDI/
0ITQYsv2ka51ocpL/7+cfBo+nNh6+zuefN1DgJz4KwSJEr6gVN3YLjgYw8xMWyJ7
DBjEWOBQkIzmoudKL9DShN8DiOf3emM1UxU940DVzUv0MnXgxoA0DLC2ALnrV1Ix
IaQYqu8adkrs70DBJxYY
=g8/z
-----END PGP SIGNATURE-----

--eqp4TxRxnD4KrmFZ--
