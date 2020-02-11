From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] [PATCH 07/14] MIPS: DTS: CI20: fix PMU
 definitions for ACT8600
Date: Tue, 11 Feb 2020 22:48:40 +0100
Message-ID: <20200211224840.40bf549d@kemnade.info>
References: <cover.1581457290.git.hns@goldelico.com>
        <aa9725056a1d2bfb490a1c912f34302de0e27fad.1581457290.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tv7EBQvO_xk_m_DPrEdmChx"; protocol="application/pgp-signature"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <aa9725056a1d2bfb490a1c912f34302de0e27fad.1581457290.git.hns@goldelico.com>
Sender: netdev-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Paul Cercueil <paul@crapouillou.net>, Paul Boddie <paul@boddie.org.uk>, Alex Smith <alex.smith@imgtec.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "David S. Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Andi Kleen <ak@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Miquel Raynal <miquel.raynal@bootlin.com>, Petr =?UTF-8?Q?=C5=A0tetiar?= <ynezz@true.cz>, Richard Fontana <rfontana@redhat.com>
List-Id: linux-i2c@vger.kernel.org

--Sig_/tv7EBQvO_xk_m_DPrEdmChx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Feb 2020 22:41:24 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> There is a ACT8600 on the CI20 board and the bindings of the
> ACT8865 driver have changed without updating the CI20 device
> tree. Therefore the PMU can not be probed successfully and
> is running in power-on reset state.
>=20
> Fix DT to match the latest act8865-regulator bindings.
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
hmm, what about a Fixes: tag here? Sounds like a regression.

Regards,
Andreas

--Sig_/tv7EBQvO_xk_m_DPrEdmChx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl5DITkACgkQl4jFM1s/
ye+rRw/+LUooQ7fIDcxBsFY9+xZRq6snbWx9wkMgAycU5UuVyjUZEzYUizVNm8pT
FfSwVCGf0hHXaz+2Xnm8d6Igp0ii2IWf7LQmE+eoLOOPWeEGIN74eIWXZ+OkJcG8
33+weHfRRx5Lx0SpRKx8g6nIQbGPXs9fWYB3ZjJwei+9DelyNKUqTbJY5xbAxeP5
C6qzOVgO9Py459cXYEXH3HsmW6vATceC+wZQO737h0IF3rclYsdTtNjBhELIT4xG
EgirCfreDPbCn3Y6g2AnAjqk151ssuhEF/p2JWu8VeNIegpksj2BbIRvKG3uWXc6
1sG6EkJ+E8gCdDOhc500PeLdWVPCWk9h9m7w/KMAuCqEr00uY313ya0nfp7EpDSu
oznxzkbQoP1Sy+zUYoaMJ759HELay07sHqI9juk7sLX7DXYeOKdxsoqOk45hEN0o
jU67WS/h6GvsKUgRBKxX0NidVnIikg1/XiMLjBaPyF+Hwq6eq4VL7DTc/86+6u6h
Anv+s3/C0hWq/de/Wr95j+yHtQQy8DMZ73bo8IwaihXbvuaW3IcgWj+lhACwvOjD
nEyj+GAnnBERn7rhRVrGdYgF8Uyq7u9yjOt87EjSPOfRxsOBW4zLFRG8GRiFAmbF
PQtd/UwQ17zKvCf3dezqrXcfQ3rOs9nxHT33IRmzbcPx5hiPwaA=
=WkOg
-----END PGP SIGNATURE-----

--Sig_/tv7EBQvO_xk_m_DPrEdmChx--
