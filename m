From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] i2c: uniphier-f: fix race condition when IRQ is
 cleared
Date: Sun, 28 Oct 2018 22:08:03 +0000
Message-ID: <20181028220803.GD1882@kunai>
References: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
 <1539658909-26691-4-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539658909-26691-4-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 12:01:49PM +0900, Masahiro Yamada wrote:
> The current IRQ handler clears all the IRQ status bits when it bails
> out. This is dangerous because it might clear away the status bits
> that have just been set while processing the current handler. If this
> happens, the IRQ event for the latest transfer is lost forever.
>=20
> The IRQ status bits must be cleared *before* the next transfer is
> kicked.
>=20
> Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driv=
er")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-next, thanks!


--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvWM0MACgkQFA3kzBSg
KbYaZw/8D196rBzyuYFWIH6vzaZIogMkHLhq1FZmHdwcJmP3efMuSF17XlfKcWI8
YOP425jIvNf3xNQnmRWlONVzNoI2kACVH+tINdqL4sn1QM+sOJ3Fze+tFJqxk9oP
kBHtZeATi+2/M6sh0UaYxL3vE0ntm3jcv1afdrl5rstqa92/vOpax5jG5gpP7evc
UYgKAJyf3SJLV4NpndGnMve7jQZAqK4Xf9vtokPiKSF9gEmE7Ma05Rsf1a25P4u6
qNRwvOrFU+6lUleQfJqidc2rjwNB0kQRLvyj7x1vE0nQ+KEzuUXhddi6o6qcZt9B
9/BxL3dQJPNccFsc7O4xFljX0qzChQc+0iquRdIcpN5eSZtNivg0aDFXszNaCLOQ
uzEnE7mkk9gY0+BVoLGT8l5UIzkY+sg33EAHozPkdBJeECzMWBKH8Q+4POAd1GlF
p6Odi7xUDvy8e1k7uhImfpAmrGJtwDCVIygXzPN0wJy8PDxeBeb7i4OdNUblz6yr
SWV33UR3gJSevo358ZApF42Oc7hURvfdBzzOF9n9PM2vn7grFJNV14QLycRH/Wh0
DCgAmS7W5mj+Nr1WkVw0aqkd901if7rxEsp/zfx358jL2nzbYa8GYi5rC0QfWZEm
RJK1s8suh1B7xw0cliLbdxpogcfhVWrmBAlqgWryWEX0hE1ijoE=
=o6bX
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
