From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: davinci: Refactor i2c_davinci_wait_bus_not_busy()
Date: Wed, 3 Jun 2015 00:53:45 +0900
Message-ID: <20150602155344.GE2661@katana>
References: <55534BA0.3000506@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55534BA0.3000506-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Lawnick Michael 61283229 <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Mastalski Bartosz <bartosz.mastalski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 03:03:28PM +0200, Alexander Sverdlin wrote:
> There are several problems in the function:
> - "to_cnt" variable does nothing
> - schedule_timeout() call without setting current state does nothing
> - "allow_sleep" parameter is not really used
>=20
> Refactor the function so that it really tries to wait. In case of timeout=
 try
> to recover the bus.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Don't you get a build warning?

drivers/i2c/busses/i2c-davinci.c: In function 'i2c_davinci_wait_bus_not_bus=
y':
drivers/i2c/busses/i2c-davinci.c:364:18: warning: passing argument 1 of 'i2=
c_recover_bus' from incompatible pointer type
  i2c_recover_bus(dev);
                  ^
In file included from drivers/i2c/busses/i2c-davinci.c:26:0:
include/linux/i2c.h:446:5: note: expected 'struct i2c_adapter *' but argume=
nt is of type 'struct davinci_i2c_dev *'
 int i2c_recover_bus(struct i2c_adapter *adap);

Or sparse complains, too:

drivers/i2c/busses/i2c-davinci.c:364:25: warning: incorrect type in argumen=
t 1 (different base types)
drivers/i2c/busses/i2c-davinci.c:364:25:    expected struct i2c_adapter *ad=
ap
drivers/i2c/busses/i2c-davinci.c:364:25:    got struct davinci_i2c_dev *dev


--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbdGIAAoJEBQN5MwUoCm2N8kP/R8lCaJLWFDxSDKO1QTPcUQt
oe35mng6heivpvPoGaA1ysb+iFTz2T5LAx/Q/qtpgATS63JxfQ50tpordoSpX3x7
oriMeqRUpXeAn4Vz5SjSp5pEo8e06aU+mk+vNqwqAlaEMl4cUW+tOG00C46ut6Gp
gs6fw9tgSOuldk/OcFaJ2ev8mztuua/CBjOqFxUENAoRk/3vlmGsSjx9M4VqgDp9
uPnc45COOj9C39kgsBpRXehU4K/vvd5tCczceDaiBfXfZhMga7eqYn6o8AMPHGaY
12D/oFmhGLiHSESbQmGnCR3DQ/n30EB7Q5HhCslLoHjvcGg140yoyxCJRpypN+R+
ycCQhq4JYYglu+ZfHDyKcpV1vD2CWaWEU0Jc5qXkgJjxiL14yK2yXtbooUMyiIJY
5m6YiXJp1awZtx9QLTzxTwQ2+D/vOctBKIWT7I5j1W3ILA1vwwfIncSFcMe7Mwer
nMcwLekBqIpaWxas/V5/F6SciwUZ9I7JPaHK0KAdC9lxVRXIBgM5tC5zwqFveYTX
LhK3qbkNuGjKyGauD0kYBGw0An5zR7/d6QO+0P2XuVZwnfOau59eN2KkKTwpw7+t
Ts/jZ7m7TFaHzB8a8F5YZh1ugdBAaDwPvWdqft8xik5lr7+S/8k9imm4qyRqZUZx
fneL+700EvB0eXL3LeHV
=tRwb
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--
