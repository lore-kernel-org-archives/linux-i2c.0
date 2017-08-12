From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 02/13] i2c: rk3x: add support for rv1108
Date: Sat, 12 Aug 2017 16:01:16 +0200
Message-ID: <20170812140116.pjcswhe5mylns7x4@ninjato>
References: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com>
 <1502422753-30725-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hkcpjsr7mbybzghj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502422753-30725-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: heiko@sntech.de, robh+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--hkcpjsr7mbybzghj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> +static const struct rk3x_i2c_soc_data rv1108_soc_data = {
> +	.grf_offset = -1,
> +	.calc_timings = rk3x_i2c_v1_calc_timings,
> +};
> +

I don't care super much, but why don't you reuse rk3399_soc_data()?
Or even use the rk3399 compatible as fallback value?

Kind regards,

   Wolfram


--hkcpjsr7mbybzghj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmPCiwACgkQFA3kzBSg
KbYFvA/+NolCjQUN4gqJJw17QDcxgLbJUSIn5nFxRraSjaUCEDnOgzAQW0gYVhkY
vSGMmU9dPOGvLgGyRFukqtRuYJd8aLFSGUqtsOLzd0c6LQn2vAxCgxbya8T1U20L
JPZWNg3R0ejVHW0boDG8UkSW2XLyrY3e5+uIAEk28EiCnZeHO9Z+05vTInCzX0W/
05Rq6ED1qcZc3LxQdNIovyK81bmt/7Odpy0NE6piGpM5miO4byxwrm4k6ywGQVyz
r2fqyQAt95rT6Fj9xhIBCVqF1G+rCpcG5n9PJ3HoRsNZsiUvIUI9aTsKiZJdV8aX
7AgcIz3BMMhzuC+p1Hr8YwgK4QzsWfl7VXLo1oiw6ZseJiySJntY/VJvU3N4lK1p
1/zg5ed16tQlRiKv9SykWJ7wngQUd23Qmi9/nGFhGSDWV+BRyX9cTJzyMheaK8vb
qETzO8ZpkNzyg0VtxQImDlQ9zlsXUbwMfiRa57/oeoeayCIWwGLGRRH190VAt+i1
kiQF8jRmcL+RxVWZrL4qz+8i67DpTgNduQIaTrfoqBG3OUe3A9HSQIT7psUbLEaX
RreBQJj7GLwItTQPoLrguKDZgbFKvurME4+i6p0IF36nUd0BRUEj5gzBaZJGN49q
FheEy6j8igINMWsJSlER3wJqveKU4X6yFzTgV2N5Af+D1KQBemI=
=4Z8K
-----END PGP SIGNATURE-----

--hkcpjsr7mbybzghj--
