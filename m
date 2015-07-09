From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-parport: use dev_*
Date: Thu, 9 Jul 2015 22:02:54 +0200
Message-ID: <20150709200254.GJ4744@katana>
References: <1434632627-18955-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NgG1H2o5aFKkgPy/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434632627-18955-1-git-send-email-sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--NgG1H2o5aFKkgPy/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2015 at 06:33:46PM +0530, Sudip Mukherjee wrote:
> Now parport is using device model so use dev_* macros instead of printk.
>=20
> Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>

Applied to for-next, thanks!


--NgG1H2o5aFKkgPy/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVntNuAAoJEBQN5MwUoCm2rTgQAKuLFG9G/tS9KLlqFm+8tF1K
Cz8OhVXZv68nID3yActJVCkVow2CKgeRVoA0DQZEJjOeUOOxz5KDhYnZf2XNkQj0
PXAifQNHVd0x19Ju9/9cULv4uiNTWTpAb1BTp6wRITHVxgcuKjVkfWZ+rdQK6WoB
WcS5kCnWvv5F7KJ+M5PMBAsuA1eI7A3oRXguvGyjUWCz2TI9Fr8GqbEfZ8A4WVPP
XRGN+Cgj9y4NTmhH3p8VeGMBhqjp1tzuzizWrIKxf+9whxpkhVFZ80khde8NzoV4
Z1IFQQFjtr1QDVdXUGESHh+OO2tdUTXwyhn1EB/tdNT+ZSNOiEHOFvDUtFo4RJT7
GwF+UkwBOfBwaSKDzk535VIgmai1GPrRG76KaYvuDGYyHJt/BMa05gRru+wG2dOO
1GunmHZdS1ZWRNQT/A2ZaTIJVZ0+IFNj760skDcrfhRY8ADsottgnB/zjXN4AkLE
XQGKKW2PLsIcos3slerQTl0pxnXo0aa/QcsCfCpIiaRbjVizI0zvZWgw52k4LD4W
K3nP6lcsRQKIer+9otC96/+TPJrlJen8/MhkvRhwuu9NJQlHpU5DetDqxOILVwSy
xPTyGNloWVvGW+JHWULDDOrq4as0axoQiuNOU/gfn3O0okdZ+2DkNZLFqPD9pCx0
ChOrZX5YFFskJs6XBCap
=QxJL
-----END PGP SIGNATURE-----

--NgG1H2o5aFKkgPy/--
