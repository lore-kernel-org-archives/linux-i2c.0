From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-stub: Avoid an array overrun on I2C block transfers
Date: Fri, 18 Jul 2014 11:13:23 +0200
Message-ID: <20140718091323.GB2765@katana>
References: <20140713171717.25497712@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140713171717.25497712-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2014 at 05:17:17PM +0200, Jean Delvare wrote:
> I2C block transfers can have a size up to 32 bytes. If starting close
> to the end of the address space, there may not be enough room to write
> that many bytes (on I2C block writes) or not enough bytes to be read
> (on I2C block reads.) In that case, we must shorten the transfer so
> that it does not exceed the address space.
>=20
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTyOUzAAoJEBQN5MwUoCm2fLwP/3cXSEBpjZhLWcKPdBBVVxmL
1n291CS+hc3bZGMEDTqKHAslh5VLl1sXuLXtl++OrFYHNrm2Mw24zRHzi6VCOSVA
+XgNwq4DffrGIo32ZHb0ZmTdlTo1ptWSR+0WT8RMc6w+6wFGre0VRgYSYvLp2yTd
EoPN0GF5XAqQU2Mbqeu9s91fXZvm+Di2wNFzKrLXNVYL5jyngC1iknoBYxPuGIBB
n9VtgNnHtGsaooJ7vFdF39ccNp+vxU3bHQ2BvVuoemjKneDP4m8aoshXXwuNQRoR
W0FL995O8Rl0NHmuqnjyY2eWoujvV4uKB5fBQlWAJ9S+nR0EjuDqQRG3x82RRQGx
CJdnAFsQ5jbgx9xKiiAsCiFlLnU6NctD4rNsPYypbpwNNF5t8UneqFEF96wwlx0N
pcN6juyo8JX4fYXkVZfR9KDKVLO9XKlmnY83IP3O049rrqCdxwZXuUWmZ0lpgQPc
86DVs0grlC5zA0Ifwi9RYUJmmHpcDjvq0YpC0v3+MqPtXeH9ofofBrBf4d98E1pq
z+I3YXQScbp9iIhm9iwfOE1DPJD3MSj2I2gL9l3iaRfbZdccZOZMkOCAoZrzK6f4
4vEJyVdP7w/eSlV102kwLeuzs3GSGrpiIuxPeBbvAyqk6/utj7ynJI2rumpkBT5w
HvrTO0ct0mtGrrtJAVl3
=BhsM
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
