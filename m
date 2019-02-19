From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/2] i2c: designware: Add support for a bus clock
Date: Tue, 19 Feb 2019 21:25:27 +0100
Message-ID: <20190219202527.rz45advkmpyzvaf4@katana>
References: <1550589042-11096-1-git-send-email-gareth.williams.jx@renesas.com>
 <1550589042-11096-3-git-send-email-gareth.williams.jx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xncw63d3ut7d66zp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550589042-11096-3-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gareth Williams <gareth.williams.jx@renesas.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--xncw63d3ut7d66zp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -	if (prepare)
> +	if (prepare) {
> +		/* Optional bus clock */
> +		ret = clk_prepare_enable(dev->busclk);
> +		if (ret)
> +			return ret;
> +
>  		return clk_prepare_enable(dev->clk);

This leaves 'busclk' enabled when the other clock fails.


--xncw63d3ut7d66zp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxsZjcACgkQFA3kzBSg
KbYF/Q//YfCWlIPd7f5aibwFWpnbkSx2UvQwQg/+XuG/IA8BTP3NTwXD6r/S5zOZ
5DSUrYAkyRlvzisB7IEKhTzAG9lTNgIhGZxYWraI00zw9ahpfxJP9Eu45t7sPmPW
nWRg6WlHtVlEYIOP+AAR4+qnlb6FaNYISpy14pSA1xNSGf3SidE9yKZANblrKGuS
HECknFMvMHTJ4AayzyjzZXUH3AIXvTKXVgKGOgkk1Uv5AdI5AOtRmVFpaW5Ax30J
LRKr2Ald7345U4uyuA9nXctaLu2PR9UyVJ/Vpiu5k8K1ucW7XMMUcHnHNXdZUqMI
yAIZimb5tjAHh3TbsBQ00CG9vip9FkpavPLjLouGBXvc0ixKXZlpJyCkYn5C4d8+
vn/YdV3GzEcicXSPKh8dJA5OSCeeAtIDIo+C46tNDnm9vw/3ZROi3Al+SDdzPAtl
TbUR7thUTQ2bz6rMJD4HPYQ3Pi3D0EGGpQJ0yhfgBaCdJhBHwP1jSH05NfgffODt
TBj690d1s+xaU0LAR/vSVQFPXjqwC5BBYUTu92CopAIJJc9/6EfsQTCQbKa5zI1y
/ZLX9SeBFRKMdGx0C7odTmcudUi9N9UkPiVVpsYJApAAKd6rjYpRc14eEwHpQqFg
qo1Jny5QJ5fQWwgNOKHkMePzdnwVME0BXNzHzAw2SGbbkHDDKPw=
=1A/8
-----END PGP SIGNATURE-----

--xncw63d3ut7d66zp--
