From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-ismt: Use minimum descriptor size
Date: Sat, 20 Sep 2014 14:55:01 +0200
Message-ID: <20140920125501.GG3850@katana>
References: <1410859264-7118-1-git-send-email-fan.du@intel.com>
 <1410859264-7118-2-git-send-email-fan.du@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tvOENZuN7d6HfOWU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410859264-7118-2-git-send-email-fan.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fan Du <fan.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org, fengyuleidian0615-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2014 at 05:21:03PM +0800, Fan Du wrote:
> Software is allowed to allocate number of descriptor size from 2 to 256,
> this i2c controller could process more descriptor, but for i2c core soft
> ware layer, only one i2c transaction is allowed each time.
>=20
> So here switch to minimum 2 descriptor when initialization.
>=20
> Signed-off-by: Fan Du <fan.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--tvOENZuN7d6HfOWU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHXkkAAoJEBQN5MwUoCm2I6IP/jYU8uSexmphhxe7FuAYBY8c
oazs6VnIiO8SlArrp6vBjHpNiGbPasY5hRlTM6THjZvm72wK2QNRa9SiJFcv5Hzb
XU0KR6wAzrTB6LjYAWK+mUWZHmmPo0YJFgw9TcLru2sQSLzVGSmgXrwvcz9yR2+q
wGVLf7ugEIscndp3xwhbewUiATGVR5+RaI9RgzMDEh0/ZGRjo64gngSTeaDkOQHW
PgMcyzwzQFM6JCYFFXNJHvcchE0vWoeCDL0eWjdzN25qDnwDKNc6/MCkholEY2JM
krldNwfzIkV16+e+gNVMI0Pi3D7h2US0lAXn6GlL22gmAHUO4R0u4Ma6I3JvopbD
K4PNHNZYR+DVg+bRPjBIexqs+HkoBkiKvjTfO8yKTEut6fbVpJr32hzmdbYo1YmA
lPvAwmSf9uLxEIuLQGOLblNpgj4aSFSmUQku48L3oXmrekPwxBr/Yj+NUbrJFqzk
lt/rd3XZWLWSGBCnxJ+b/wBOc01yHSOf6T37/MFCYyNwAJKLv+HtLYiHe0WfOR+d
QnLgWKKc89LUAG6jIT1jjTD8HZ4wknIxxXcptNZgezUeSmr1fqM0Y63Z66XPTsKy
OtTX2VqWEddDUYhnSoM+ROtTjfv6SAt8VYMMa6NHxi6RZnmPGTB/ybnp+wYqOX/C
Vn3oy/0+K7Qon2IfjN/S
=+0sT
-----END PGP SIGNATURE-----

--tvOENZuN7d6HfOWU--
