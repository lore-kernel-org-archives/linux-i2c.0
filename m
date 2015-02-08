From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: axxia: match return type of
 wait_for_completion_timeout
Date: Sun, 8 Feb 2015 15:39:39 +0100
Message-ID: <20150208143939.GA6033@katana>
References: <1423391485-30367-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423391485-30367-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Cc: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 08, 2015 at 05:31:25AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. as r=
et
> is only used for wait_for_completion_timeout here the type is simply chan=
ged
> unsigned long.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
> ---
>=20
> Patch was only compile tested with axm55xx_defconfig
> (implies CONFIG_I2C_AXXIA=3Dy)
>=20
> Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)
>=20
>  drivers/i2c/busses/i2c-axxia.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxi=
a.c
> index 1decc88..9434824 100644
> --- a/drivers/i2c/busses/i2c-axxia.c
> +++ b/drivers/i2c/busses/i2c-axxia.c
> @@ -408,7 +408,7 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *i=
dev, struct i2c_msg *msg)
>  static int axxia_i2c_stop(struct axxia_i2c_dev *idev)
>  {
>  	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SCC;
> -	int ret;
> +	unsigned long ret;

'ret' being an int is kind of an idiom, so I'd rather see the variable
renamed, too, like the other patches do.

Also, please combine the two axxia patches into one.


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU13UrAAoJEBQN5MwUoCm2HbgQAJPZJNRGwPSvy0sq4Xmr3Png
FOJ+IF5G0n29gd7zW63jsDHxD91+W2kEyK70U3aVs+MFOYVfjtawVtWhQ4bOgcV1
TjepfdlID5OrYXAbo/UdJZaOUZRP2p/Jb4wUTQ/cGyLXHA19AiHzPFCuXPfnD85z
EcCYfGb2/5Ir7mo+9nbPIUv8dAgST96OaCSXMwCZEHEVbiwbIJHkDLQwogei35ok
DWvRadMUC24GV4JavcgEbWFU4wH22TI9nTM/QhHSUbzXwsRXTJwBVgbPW0LSi4ne
97mCdzNhIfAeA6+/O8yp5QUwuQZVvZAJxgfQrir7oDdCeQfVEMJmgEj4GPmnQNXb
lB0kljQqpj5VbnBBb3Zttkw4httlnzn9hFuZEH5ZUd+cMPxeZQDWIwaNV/JgPEcO
1gidqfIPbCC9cxqYbc9C2EZfvnmgREE7waFPp0tWtNfkwGZ3O2K+zWvaufPENSwr
0MUAOrHDJsWoDs6L+X1b5wXfwpU897tjI8m2bODG11sbj7wOkKhSg2e5/0lur6Fq
A5xbo66JH7NLdt8ex5S7auKsjpqzUzqOHAPl38Apz8vKTx+6jrUkedlOqQKzM0SF
olzourCxEvIHN1hI6yEUfWxk4279HsHNJeSSGGhaloVhG+VYzX9Y5xN/i2lqqwv9
02VTcVCbKZZ73u+xrdYG
=7LkR
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
