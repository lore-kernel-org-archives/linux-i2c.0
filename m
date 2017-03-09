From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: riic: fix restart condition
Date: Thu, 9 Mar 2017 15:40:04 +0100
Message-ID: <20170309144004.oegbdczlluoywtxl@ninjato>
References: <20170306202051.3158-1-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bx723lxykcjcxmzi"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170306202051.3158-1-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org


--bx723lxykcjcxmzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2017 at 03:20:51PM -0500, Chris Brandt wrote:
> While modifying the driver to use the STOP interrupt, the completion of t=
he
> intermediate transfers need to wake the driver back up in order to initia=
te
> the next transfer (restart condition). Otherwise you get never ending
> interrupts and only the first transfer sent.
>=20
> Fixes: 71ccea095ea1 ("i2c: riic: correctly finish transfers")
> Reported-by: Simon Horman <horms@verge.net.au>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Applied to for-current, thanks!


--bx723lxykcjcxmzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljBaUQACgkQFA3kzBSg
KbZtsxAAjHGo35U+37pU2obNM7C8tqKOJ8x8HepOChGgP2xO26N+yNNVHEkbFeVm
Ayogz4EY0QP5ZJOMuyGj8Ol4YZIDFaF7FKe63gMcgPldktq2+8BHXP/6kLqOdNVu
9JAjZPc28CkArLDGCLxmtYP/9kq4TKNa+OO94+wFYDCKC6rZKodJvs0x/9xaOLGL
qRdrP+Iz0glkQwifZJaxVeYXBtdwucw38BLnqFaIrIvC2S3lcbK9iocD9CCPgiKn
8OHc9dPSmRZ9n4KOHYkAHW9ga69i3bMVkft1UDbmFJOP8ZdtkjO7KprPqmSirmip
FVQw9/yvwnExguYPhLitnOXo7BNXKzJ5t2/0MOXTKcWtsWf1DRlK15DCOXarLHme
02bcw/0JTeFqcqsaL4ISB19EZpiyOHDWlFTdAqHJMK7f2TuXQ8CGsFud4gVo/yFQ
9x8vxKGcNE75zRgCCubTUCqoJf2FuOIYH3SNwczji6U080/mliwtKhWNagD+3kT7
vBoo1U3Cktf/TLT3W3w7DrMh3zqKyxCQwzzNwj+CfK7X/n0JHjMt00kXuXDSydm9
bZb9UbR+vAoNp57ZEIGZ2neCOHh6GLzv/fQioSq3alI4RB+JT4/4sfsZSAeloi5W
yyLLNnbVPaWrAa6+9GiZpT1sVYcnd6b9CaKv5L3Qd23gjHv2ooM=
=S2IF
-----END PGP SIGNATURE-----

--bx723lxykcjcxmzi--
