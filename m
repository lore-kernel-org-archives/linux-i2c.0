From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6] i2c: add driver for Rockchip RK3xxx SoC I2C adapter
Date: Thu, 12 Jun 2014 00:25:04 +0200
Message-ID: <20140611222504.GC3109@katana>
References: <5192968.EzcUiXba22@typ>
 <1956748.HoDAyYWJMb@typ>
 <8609129.ZdoNIueQ2G@typ>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8609129.ZdoNIueQ2G@typ>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, kfx-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2014 at 10:34:37PM +0200, Max Schwarz wrote:
> Driver for the native I2C adapter found in Rockchip RK3xxx SoCs.
>=20
> Configuration is only possible through devicetree. The driver is
> interrupt driven and supports the I2C_M_IGNORE_NAK mangling bit.
>=20
> Signed-off-by: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>

Applied to for-next, thanks!


--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTmNdAAAoJEBQN5MwUoCm2SG8QAK/C13XA/UVf3pj3B5Bt1hxv
7IZ5QndbVS6saU6mq8stfLKyi4CW04PD8Jktm+DkPKusgAYwpWmWz507sh+MSGAK
gRSNU6eoBVenbhs2ueA6IPdfYVoQ5SN+J6UiPs/Y635WbYy3ZuCYiCXRbl7V4HFb
sFIYiIV1ymRsvVFPezxwem8cGzk+T5mJmTQckJbxoB7FgJRvLEYg9MLg3JDVv6CN
6V4wmWQCi4YqQEVJS6eQPWRgcKrlD6jwH0StHP5+CKMoVDNG08+ghxe4cQ9EnKEd
0/l0FF88A9uNEiq7wHUdGuoVo9huYbHQjLbGoZyPDxC7xo4023LxWrGb2A3K6gAP
6wT6jj0UXk3RX/jTJa6mgREP70GiWrBJx762vV1xYca3/xW6Ga3HO0K0nP27L5UY
fGKMujOcL7SqtoSSt8BJWTyd2jO3Q3X4VuAkj4053rplVxmupxTrY1yXOseqNIR4
NQYEf+PweFn/pSQjBWKgfmKgUs8Ih8zI0p1/GNBK6kd6A/y4MTZiELKLO3707haw
KKA9dsJUKhbrigDNhDGEly60zlYqJTjxHI/olUf0BNT5JkJxrB+rvi+ua0yaLTxu
Oak8HmZBWk5DZIiJt8/SIW9sU66xzSMna10+uR6AXVpaLoyYILS7IrfuBvA4/Lba
uWxI62PIxsJ8O4uEFFlW
=gCOe
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
