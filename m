From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 06/27] drivers/i2c/busses: don't check resource with
 devm_ioremap_resource
Date: Wed, 7 Aug 2013 17:38:36 +0200
Message-ID: <20130807153836.GK2978@katana>
References: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
 <1374602524-3398-7-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6d1KVhp94hk3Jrm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1374602524-3398-7-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--d6d1KVhp94hk3Jrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2013 at 08:01:39PM +0200, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--d6d1KVhp94hk3Jrm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSAmn8AAoJEBQN5MwUoCm2NxEP/0CkvKIYCGUeE9P4/9xEFmOp
0/ikYXrmHNBX1VBfYs8Li3ZPLSg0KRgdosZ+E4tMH5sRaoLzUSB8JVYcgeWv+dbk
tR++xlBBJiIbvrbQdpjBhDLsmu+0/7S6UCkRm9DLseeIKvkqu/c0NnpcJzEsGDM/
tFGvMY8OKvQyouJu8c9Zv8pu67uN6Ub+zLfI0MlzvFuVivntHNVan5SzIrBkKsA6
rGeTRTfGQDhKtm7yevib0wJEVX4jGk6rhIhsvgyCltZrC8ugHI2I0Oxp1b1V8rHp
9ooivvfWfaDfMT4Gyvp6E0J8MH45mHvD32h0LKZ6kDH1InWySp9hBMxuy+t+l9Bx
yqYWFjBbHSVSonYvJx48tKictoT0j0rkWsq8Ho0Q5UbgiYGpEh7lflzd9YzrAWgk
oahS+B5e9hVwTWoGxjzLAhBrxLDvDPNww75gIECejNcqsv7ecxD+/u3kCLhj6WLx
YWkd4J1FBf49aLoFkuJtjpx6G65z5KNWfycvzevp+lNORZlgmbg/HXQHJ3IciKEH
d6a/+YOsCCOQBsQPhW7h4FORyqIQJIhTCPPogtBk7klrLOfS6xSbpCY+4egTCYJG
HmvZqg8mq4ZPZEDqt+m71aAZYX/FncQnak9zeTx4wQRTBmsqeQ2qIVJH/mWHw8qz
hpRGMi3em7iLItD8m8zq
=un3P
-----END PGP SIGNATURE-----

--d6d1KVhp94hk3Jrm--
