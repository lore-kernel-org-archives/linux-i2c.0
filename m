From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] i2c: uniphier-f: make driver robust against
 concurrency
Date: Sun, 28 Oct 2018 22:07:55 +0000
Message-ID: <20181028220755.GB1882@kunai>
References: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
 <1539658909-26691-2-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539658909-26691-2-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 12:01:47PM +0900, Masahiro Yamada wrote:
> This is unlikely to happen, but it is possible for a CPU to enter
> the interrupt handler just after wait_for_completion_timeout() has
> expired. If this happens, the hardware is accessed from multiple
> contexts concurrently.
>=20
> Disable the IRQ after wait_for_completion_timeout(), and do nothing
> from the handler when the IRQ is disabled.
>=20
> Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driv=
er")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-next, thanks!


--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvWMzYACgkQFA3kzBSg
Kbbv3Q//UHC1ylz0MLVT9hMtFF15YgjiWLWTmF1Z4+nkZYGuZbwAcLSMNCgJOnUQ
9FejiSk1/vbYDw+PqeyNSLcaTBVdmX4TuS7ssFH9PVPMFK4wi4ZknrxFrPBJBsU1
1iNd19i+HnjxbDl5VDTrf7wXvVTW8/aDMzb+LcopjhwE1/EX1ApiflVH6vqknDuc
7kwZFYVLCFQjp/GMdz5NHWj6TTde2CTF5PPC7DDwmQagGyf/Jf1bnVuZb0uad1U+
uyHgTvC7czX7erPJ3QzlQJvEuA0MyiUEU6qbVqkHv6kXFdXGSypvXs5xkdhFarkT
FL6PbunWtXAx42pJ9CETdRoSSIQTib81YoVNNGFb4rViPObuK8ek5x3MmKt2jCLm
uCqyalcdRte9PkwEh6Wa6NL27WlaAhMnoRPQZevMRmF4q6RKzT3LNuzCPPsc+Hob
jVdmVUDGtFHAW1FAczDFOnwWZWvU6QZOopMcdMLwf2crGBN3hGNxW3CHmrRsqiQs
DRmHKrjzn0z18DPrE0Mxn0EfGtp1xfO9APmmLzq54zwsA+mvEeGRgavxumDqdhYt
GkxGIXCRlMqYvFposQlxZ3dD3jgoh8xD9r2nT0w8qlyfWeJugyH8Mf/n3l9gOu5j
hWHgOwtCBb1DUSJVsQMuKEUA/bFLwLdqkG1n4hKhAsqtGxnmSI8=
=9M1/
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
