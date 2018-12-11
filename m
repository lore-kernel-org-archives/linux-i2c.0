From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] i2c: meson: add support for Meson G12A SoC i2c
 controller
Date: Tue, 11 Dec 2018 21:36:53 +0100
Message-ID: <20181211203652.rogajl4ajwu7cs6f@ninjato>
References: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
 <8a6a204b28523e5a181f9e85dda18fade76a26a3.camel@baylibre.com>
 <b2bceaf4-92ce-92a4-c382-713d29ae3b70@amlogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r6j4ocolv5vcwqhy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b2bceaf4-92ce-92a4-c382-713d29ae3b70@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jian Hu <jian.hu@amlogic.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jianxin Pan <jianxin.pan@amlogic.com>, Hanjie Lin <hanjie.lin@amlogic.com>, linux-amlogic@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--r6j4ocolv5vcwqhy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I am okay if it is reasonable below in file
> arch/arm64/boot/dts/amlogic/meson-g12a.dtsi. I2c controller node just uses
> axg's compatible.
>=20
> 			i2c0: i2c@1f000 {
> 				compatible =3D "amlogic,meson-axg-i2c";

Actually, you should have

	compatible =3D "amlogic,meson-g12a-i2c", "amlogic,meson-axg-i2c";

in the DT to have support for future SoC specific additions. And then,
patch 1 is needed.

Or do you handle this differently? I'd think this is DT standard.


--r6j4ocolv5vcwqhy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQH+QACgkQFA3kzBSg
KbYghA//e+Y8jxdhjD74FHRwHJedpaaTeb8kDXLWeywBEDsZikyyg521dDLFYodO
1fm88aVcj21Of70l3aXd5XlRUndSa701Rm/JStWJR6xgHY1wmU0MiuUAINO3XvbE
90yyjh5gVOonytSaEM1at5rvgsuMknBPDWigRNEbPfQkXckMYyh+Ini2nAvKs5ZB
GZUNMt1JZcKRdd599coNfhuKPQAxp+SmikdPBJ+H9RSm58IyU8iitPw9AR6JesMM
7ihWoNOC5REbI8CzCKlYTFM0J8ppRnpJfzAkDKDl18V147TAmXVBQ+hPSDKfTxYH
VbtZQ9AUPUawMWhTVmt7ZsZuZPmOoPjccsLo+nWqz/db/JDyhyMzjY/46AWl37U2
b6H55meUJyPVf/AKDY67ey/DpjA00C6URXkOLCelW0vV4qy71hzYgMXGGJ3yWdwi
4NmJtPpqax3st/K2/mwDQc4humJ+4FeLw9OREsLhdOw++3fRkYr8ZrysJDmNH7yS
h5cgVTGqE0rtCt9sct8Om88gut//78pusStosThw+nwHbTOL5gsK405OrSQFoe2N
nitfLq2ISw/njOwajTWSgdUcWa9kkwmTk/UixXjBe8r5VEiv32qmt/Q/K8vmyDES
O9MOHcWu3slySjEBzXQs519PblIQJCYgUdHVaXwuIStWkHpkO1k=
=Uiz1
-----END PGP SIGNATURE-----

--r6j4ocolv5vcwqhy--
