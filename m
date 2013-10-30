From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: Include linux/of.h header
Date: Wed, 30 Oct 2013 16:49:51 +0100
Message-ID: <20131030154950.GD3663@katana>
References: <1381917393-4499-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1381917393-4499-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2013 at 03:26:33PM +0530, Sachin Kamat wrote:
> 'of_match_ptr' is defined in linux/of.h. Include it explicitly to
> avoid build breakage in the future.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-next, thanks!


--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJScSqeAAoJEBQN5MwUoCm2YcEQAJrEc5RcDaGCEvHaacbIXBQz
IJFF2RfZ8Ik8oxCaPXm0PPNROyYnMrH8n1bDYp2FeamWFspz1YLcSgMiO0t2OHOy
GciZvhIvIe+awLd14jY1C8Ur29AelKd8rch1HPW/BHb8e5F6lbaGq+p83R/bFoiE
qel+qTNOHuAfFXsM0r/hHWzCm9bHYEODDLV9lnYff/lLnNwRw+cy2Mi1a4SBiqql
Yo527EfbRoNFaOoRDn7+91KiUNFADkMKwcXfSW1EL0DENBYqXvlbnM1njR4o9YQH
A+/e7e2AUpSXNjuke6DC8V0Ev0Ldn6TlYYiQJs3CtrBzWFw1rnzuuN8ZdPzzVjyx
1llW/AvUxdyUsRxDZuup8JktLsxVZxblvNvX61cR5YnkKBnchHn4BYT75ZiptIvJ
gxQuWKqoOglMHSn0TRswYqChNMPXd8VJRY7F0mcvDyeLKtQ+dRVCPIm7f/Iz+AF8
PhfWNJqYfq2DkrTVCIewpcKJE6rLBfX3UWao49Bwt93RF0jT0fmHCXzEBsHGWbvt
d8PF3uUUclTCNYnKUAWDnGJf5ly3OIeWJoiFfRb0KBOIoJNi5LQDxeGYqycRsB39
L/XJCBC2hTXlGZtxx/9LoTJgPijHMJobbiPnPqQO25Mt+Vx/x1JJ0dRIFrgdAeIM
klu7ieGx1fXfWQo8MfsF
=ObJp
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
