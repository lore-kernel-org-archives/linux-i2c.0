From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-stm32f7: improve loopback in timing algorithm
Date: Wed, 20 Mar 2019 18:00:59 +0100
Message-ID: <20190320170059.2bkw4e62wo2vugbo@ninjato>
References: <1551885142-22365-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jlxgfbkaiqonc2hk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551885142-22365-1-git-send-email-bich.hemon@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bich HEMON <bich.hemon@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Pierre Yves MORDRET <pierre-yves.mordret@st.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--jlxgfbkaiqonc2hk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 03:12:32PM +0000, Bich HEMON wrote:
> From: Nicolas Le Bayon <nicolas.le.bayon@st.com>
>=20
> This avoids useless loops inside the I2C timing algorithm.
> Actually, we support only one possible solution per prescaler value.
> So after finding a solution with a prescaler, the algorithm can
> switch directly to the next prescaler value.
>=20
> Signed-off-by: Nicolas Le Bayon <nicolas.le.bayon@st.com>
> Signed-off-by: Bich Hemon <bich.hemon@st.com>

Applied to for-next, thanks!

Pierre-Yves, there are two binding patches for stm32 still open, if you
have some time for it...


--jlxgfbkaiqonc2hk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlySccsACgkQFA3kzBSg
Kbb1CA//RsWBLBogKq3sIipw89QpsZf+f5oNMl9ha+Olr8DPSwDWjJrvu3HNcdyw
Zl/jht9fZZj4exyIDePoGwu+ezJXcf+JOeKLyRuCHkf2Y8BYnsimC8D6HwuDe9SU
K7qR7j+Hqww6EcJKNwxfhWYc+ie4uUEUhGRuhTOTXkcp/Qd4qXZnfKZ8jN0jYGaJ
+T6q9JAvc4BLdF9S2frIvWSPnWPmpbgWOQ9edC6YMuzn0MBDPU29DiKLcGMrWSud
iXtj+cZpAPDYuox0Q7cC0Ot9rUPyJlSyz7glZzkQBTUhKTwaFxLwmODB6Pfp8AXY
HkFr3IHhEFH4QQHDtO1GFhQTvcxMph0Fdyo0jFs/c8OfWv1OVwKqR0v3/krdpaNm
HYhhdeR4cXkldmTH+iYtQirHskcB5TAzc7W8JhVBspgO15hiUi2HYaljTo9NjseP
tpXoCNrhqtjZjzSr3cxOLKhKWAPQDclFLbXxHXAXczJxDW4T+FtDNuitCLyrGw42
U7hl4aPO4QCkA3mNZpgeJRaJsW2zoiXKq8Qx6ShzOF18iseV8Aw6SjP8v1oJdUEl
WImd+oE2RPwujAkXfagPhFaAP9rJYegSV27P5OUKggnGQ55GOQFrrpbQPuJy8Ky/
z7rvk9UEy/jXQCXUdsaGS8PSZCaKQbvDEWsGH625BrDKATq3M/M=
=+MDo
-----END PGP SIGNATURE-----

--jlxgfbkaiqonc2hk--
