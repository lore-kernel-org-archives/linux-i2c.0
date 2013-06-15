From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: nomadik: allocate adapter number dynamically
Date: Sat, 15 Jun 2013 23:16:56 +0200
Message-ID: <20130615211656.GA3194@katana>
References: <1371328694-2073-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371328694-2073-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2013 at 10:38:14PM +0200, Linus Walleij wrote:
> The Nomadik I2C was using a local atomic counter to number
> the I2C adapters. This does not work on configurations where
> you also add, say a GPIO bit-banged adapter to the system.
> They will start to conflict about being adapter 0.
>=20
> There is no reason to use the numbered adapter function, and
> the semantic effect on systems with only Nomadik I2C blocks
> will be none - instead of increasing the number atomically
> in the driver itself, it is done in the I2C core.
>=20
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-next, thanks!


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRvNnIAAoJEBQN5MwUoCm2f+oP/RlYPPoiZoA8X9F67MYzqNZg
BAHSL2MtUhTgv1n5aeNZsfA/UtDxPgmC8zlojwdewNFE2pAV6TqZj0cKTRyVBN9O
AljAsTeMKSjqArnUnw9JKvhO4RI/6IwZt0URmBgcZWAcby5my9f1qPX8HO0LOj/G
8+OoIlhihHvYaX5LlEl86uj0IQPfzIkQTRpSNaE/06euV/pSYeiPIh3EfKLreA6D
aGMnQwIaVK3syx4rcmKfvJuonncbMRrZj7k5YjKpoTegamMcZ8N5t2NQmOYLBoft
azuNuyHvKd1mrz0V+Cgzrv886v9CCJgD5QzmmCIPj2EP8trSmepaqphs6eMh20OH
GhnHPqKT87R+hlSZv9XYYE0x35uK/7vhNhl17c5+2MpXLxYF2akG5BShccU0vm+W
XS10qn9+bkM9s6EmLSh0oDSnvKt9BbXNIi2Wv92TWfKr4OV8ECqCYxJMVKTGU2HP
tzJjVSu88FGlXBGzwmwhoWOc5D86vt5rwpToN06hWmGuU6pfX+CkegJt2wJfYq1f
64sYO+Lm+Vms+8fKp/l0Akbpn5eZcVhDxdFheg3xhfzsBU8Vq+FbYv0hgLyIdZbM
n1sMr0X7mlkPv5xy8vsV3ZoGdb9r6bL7SrfkLRFpAJULtnIXa9Jei5qRuWuLI+17
zheUMA/bofnkUeSQldqt
=dBR6
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
