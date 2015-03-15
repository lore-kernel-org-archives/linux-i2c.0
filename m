From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: designware: fixup return handling of
 wait_for_completion_timeout
Date: Sun, 15 Mar 2015 10:23:57 +0100
Message-ID: <20150315092356.GE3393@katana>
References: <1423555874-19650-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423555874-19650-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Du Wenkai <wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2015 at 03:11:14AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int, rath=
er
> than introducing a new variable the wait_for_completion_timeout is moved
> into the if condition as the return value is only used to detect timeout.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>

Applied to for-next, thanks!


--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBU+sAAoJEBQN5MwUoCm2swkQALKEJ8vzM8l1t/3Dswvm+WNO
nSHiprwJ3J6HNG1kHwxKvFTNsjjRqav2Bwk5yH5e4+u5hQESd4L7yRfNsOG9rcWI
zn4Qu5QgMmhrtNIW1/XmQkMiFR1ZmCdgKK1zwqaP/3O8uatCk9cIacrlFFfhc7Of
ShwMCjXkMxX4ZLwT/1WGlldLf5gwWIcc5Z6pVl3JEMKybndqsEYF01p819Lfss8z
gmSYoqzQ8XNZuJHDIhHvtDMX5e3NUV+ayv0653KfhrT8USEZuSdNze6PooAC8i5n
Gdlh1utRhSyX1E7nwX2VNysOA+e5uTwBbfQ8/aFCdSPOPV8Vjs/F5aIWBgE46bIH
sx2ZeSZC3HK6TdxhhNSO5YVcCOokBsNzza/rGZuCC/U3EIPYVwwGKFYaMBWSFoU0
/T+ike5cCfIXOotTR1tb2Gac7w3LI+D1+vnRQ0HtQskspKWJ1yNVDVC8Hd/C3DB2
5pVUsRA2ZgjFCTa37r1T2v5XdUG1d4aD2ykgVave8OQLqeLuvZ0rIPFM0UgviN0g
qhsA5FzKAF+1GXUMM5VD1CTbYWunMX6DV1p7uhRG+Ox9ULZs1KhIZm/rgfxT+gJ5
AsQHC9rzy89fp8JA9lCuQHT+LPaDwxaQzpwVZTB2jQHrqP9BHvJPr4047fZrAe8/
PcE9SAJGn/QNKCBIUYSK
=rddI
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--
