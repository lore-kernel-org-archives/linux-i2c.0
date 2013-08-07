From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mpc: Define unique I2C adapter names
Date: Wed, 7 Aug 2013 17:34:44 +0200
Message-ID: <20130807153444.GI2978@katana>
References: <1373483001-24951-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TKDEsImF70pdVIl+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1373483001-24951-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--TKDEsImF70pdVIl+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2013 at 12:03:21PM -0700, Guenter Roeck wrote:
> The I2C adapters on Freescale MPC107/824x/85xx/512x/52xx/83xx/86xx all
> have the same name "MPC adapter". Since I2C adapter numbers can change
> across reboots and even after loading/unloading an I2C bus master driver,
> adapter names have to be used to identify adapters and thus should be
> unique and well defined. Since this is not the case with this driver,
> it is difficult if not impossible to identify a specific adapter from
> user space on affected platforms.
>=20
> To remedy the problem, use the adapter memory address as part of the
> adapter name.
>=20
> With this patch, adapter names are:
> On P2020:
> MPC adapter at 0xfff703000
> MPC adapter at 0xfff703100
>=20
> On P5040:
> MPC adapter at 0xffe118000
> MPC adapter at 0xffe118100
> MPC adapter at 0xffe119000
> MPC adapter at 0xffe119100
>=20
> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

Applied to for-next, thanks!


--TKDEsImF70pdVIl+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSAmkUAAoJEBQN5MwUoCm2xpAP/0v+nUVmhR1OHei0GrWgHCVQ
iy5QxPp7++4iMG7/Wxy3VvhKCLGysU2q1k466J6kGncd9bDte5YyOROmCm7Jy3I6
mUB/UO7LI47HxCXdBZPTYmsdPXbA2V7D5bKyOye9MFPZivxFUSX/UYA+qXe1r0ML
Uqtqq4r7R2YXwp9HpTBTtX4UAUlOJxEmvlk+F+Mt7lDnSVF2SHkkTQUgfvMk9vD3
JQfT06RhO0a5NBm13YG2kR8TE5IaNYCeA6Y6h74jpgKEa1ZlzNhoScKOV8zvj/w4
OBYMiARpl295xlQBvzl6SN8xTaJmT1CXRMRQxczpy93VFMW3d/8nVtDLt36Rzf1X
MUo8FbOTeU5S6JWpi06I6Xa/T9MSjQTPntrCP9+9f4cZW5n2wHzaTKZavl/ErVgJ
O5pAqYpdcNu2wUAo1/0F5QF17U1HIq+PmfyAQ9+ZjsgRhkscjTbrd2+QGRN69u0I
SgGOwDjZ7CyWX5jUegsNBW0UhuXvki3CGSgJb5VLyHu77KriMwkKpvnHyx+dM2b8
+5FMme8Ni7nm9EH3m7Eq2TZsyoSRcmCpojDqd6QqHwauXyk92moTcNWv6wtT75Sw
0+DBp9a/SwQ9mB0Mv0tQppWgppxUddb8m/f2N8bxCRJUXx9qKwtxf1iU8rbSiZRj
ViV3BBmqserbo6g2nFH3
=ca0u
-----END PGP SIGNATURE-----

--TKDEsImF70pdVIl+--
