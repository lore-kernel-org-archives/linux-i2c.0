From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-stub: Avoid an array overrun on I2C block transfers
Date: Thu, 17 Jul 2014 19:27:20 +0200
Message-ID: <20140717172720.GE2901@katana>
References: <20140713171717.25497712@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140713171717.25497712-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2014 at 05:17:17PM +0200, Jean Delvare wrote:
> I2C block transfers can have a size up to 32 bytes. If starting close

Shouldn't that be "256 bytes"? 32 is SMBUS transfer size? Otherwise I
don't understand the patch.

> to the end of the address space, there may not be enough room to write
> that many bytes (on I2C block writes) or not enough bytes to be read
> (on I2C block reads.) In that case, we must shorten the transfer so
> that it does not exceed the address space.
>=20
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> ---
>  drivers/i2c/i2c-stub.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> --- linux-3.16-rc4.orig/drivers/i2c/i2c-stub.c	2014-07-12 11:56:30.933096=
483 +0200
> +++ linux-3.16-rc4/drivers/i2c/i2c-stub.c	2014-07-13 17:01:02.891235856 +=
0200
> @@ -220,6 +220,8 @@ static s32 stub_xfer(struct i2c_adapter
>  		 * We ignore banks here, because banked chips don't use I2C
>  		 * block transfers
>  		 */
> +		if (data->block[0] > 256 - command)	/* Avoid overrun */
> +			data->block[0] =3D 256 - command;
>  		len =3D data->block[0];
>  		if (read_write =3D=3D I2C_SMBUS_WRITE) {
>  			for (i =3D 0; i < len; i++) {
>=20
>=20
> --=20
> Jean Delvare
> SUSE L3 Support

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTyAd4AAoJEBQN5MwUoCm2r1QP/0YFraDPEt+4Xb402gfvhFvi
uyYB1N9D7cHQMa6oJ7mk+Bx6GM3ZKTUdRg3CRJ6aICB46ek+AEwyMk55v6rTk/gI
AIoInskuDhlgNlmbsLSPnkcmZ+g5fdG3i4QKABvnYIJxzLf2SJ54EMnjqWrNeH63
6OZqnk1mBVqKqoFOq+j0mEI4UMQ7jX/ONJb1zzuHAmtIaIyzD9QsAA6wGA+pTta1
JHw95BcBLWJokolUu126FqfYseR/jKEUvAFBKBWJYItkKH2yxvptQECjXoJFfI1p
vv9XgHjSZYQJJPvQFeYz0OXwILwxqW0SuTqmqzjSCNLTIK+oax6anhcYZkiNpgC9
g7kZM7AqsVoh6phfvWnE9o3gIwLo6TI9xbNOvUWKlokmCApwdfKV7X0VwdinXDAt
x9jajiWLfZnuOt9TVp11Q76MgTbN+U+sEVppl8g4ph0q1UJei4YREbvYc2iqoV/E
szRI8pkfDWV+MW/NEV7YKnvsMlVIrTkf4qOvXfxbi+vkE8pWfchlivWWU2sG5oVI
g5gtSLjrkiwsFi86N1w1SXgS4XkYnSyon7UV/WotlJtcc8dqB1n3hB4wCYymN02S
0UyNyb6Ui/tFytWdLmF1YcY5KVW6v3u8J4+nHI3f5dEkhH2pImsltyetFBwHonbA
GMZOhLTwKICcJyJdzcNM
=ZH8Q
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--
