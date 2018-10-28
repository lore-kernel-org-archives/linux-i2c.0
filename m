From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] i2c: uniphier-f: fix occasional timeout error
Date: Sun, 28 Oct 2018 22:08:00 +0000
Message-ID: <20181028220759.GC1882@kunai>
References: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
 <1539658909-26691-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539658909-26691-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 12:01:48PM +0900, Masahiro Yamada wrote:
> Currently, a timeout error could happen at a repeated START condition.
>=20
> For a (non-repeated) START condition, the controller starts sending
> data when the UNIPHIER_FI2C_CR_STA bit is set. However, for a repeated
> START condition, the hardware starts running when the slave address is
> written to the TX FIFO - the write to the UNIPHIER_FI2C_CR register is
> actually unneeded.
>=20
> Because the hardware is already running before the IRQ is enabled for
> a repeated START, the driver may miss the IRQ event. In most cases,
> this problem does not show up since modern CPUs are much faster than
> the I2C transfer. However, it is still possible that a context switch
> happens after the controller starts, but before the IRQ register is
> set up.
>=20
> To fix this,
>=20
>  - Do not write UNIPHIER_FI2C_CR for repeated START conditions.
>=20
>  - Enable IRQ *before* writing the slave address to the TX FIFO.
>=20
>  - Disable IRQ for the current CPU while queuing up the TX FIFO;
>    If the CPU is interrupted by some task, the interrupt handler
>    might be invoked due to the empty TX FIFO before completing the
>    setup.
>=20
> Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driv=
er")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-next, thanks!


--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvWMz8ACgkQFA3kzBSg
Kbb4CRAAlbWEMkwhwkSEVYQ0agoI0dekQGE2wmtMrttLYheXWwwJSrrVzcGNM9BJ
4gayx6WTWGq7vClDVQrS6eTLxZo4JDib3DqUQAyY/fI3HALs5ED1ju77hzKTODpS
i1qMX+oyLEWLUusdPY5JfVw0FT7kJ7/fodR8aaVhzhIp8VfSV/Bn4ozsXc/KJIBU
NVi77LgLpfoUWwoRtOr5k2ZLjRPiHLxNniQUjwnJu8Q0mIvNt8T3WJxQZYmUnCVD
eGn8M6Z96MRlnoqQ9LYCiPrTVbQrvHV/dTAwtwh3Hqsis0D2sgljE9QjpscIAoNf
oHO+ayS3XGtVp0gMY3J8AOweGPIbLLlJS+l3U33WG018uXWvnyAl3fWNklmTFGLX
vnMKtifnpwOgnsdd0/EEkawrQoik/8sQCi5B/fw7g4wF/iP7UnT6UP4Ch0sJG/JO
ZRXMNx1jqPUCDhRxmhyBUYFJ153EwgYXTq3BrQLkZ6eRCHF/qEiYMrWpDyHYG/S2
tvpnd2Oj7DEfm7CnOPQaS4FtfcLybiukqozsxG0erDhwaN9ytRKA5l0Y673OpgQY
g/Xygun4iD1OUgbQCsi2+9u2SrfKGV6WPVIXQmGtlNKuVAv4BQwXa9AFGZD11pl8
RCVrnIp1e+cukXA6A+VvfQdDHjcB4Gyl+bkQyD+udf00m01jOzg=
=my3U
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
