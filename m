From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: cadence: Added slave support
Date: Thu, 19 Dec 2019 14:05:01 +0100
Message-ID: <20191219130501.GA958@kunai>
References: <20191219124120.53754-1-radu_nicolae.pirea@upb.ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191219124120.53754-1-radu_nicolae.pirea@upb.ro>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu_nicolae.pirea@upb.ro>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Chirag Parekh <chirag.parekh@xilinx.com>, Michal Simek <michal.simek@xilinx.com>
List-Id: linux-i2c@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +/**
> + * enum cdns_i2c_mode - I2C Controller current operating mode
> + *
> + * @CDNS_I2C_MODE_SLAVE:       I2C controller operating in slave mode
> + * @CDNS_I2C_MODE_MASTER:      I2C Controller operating in master mode
> + */

Can't the hardware operate as master and slave at the same time?


--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl37dXkACgkQFA3kzBSg
Kbbt0A/9G7dnHkPv6eu3f7KNRWgl+KyWAG1doDbApk+NkT47uu+hfNRDnb3XzAs6
2NsXG9/26GVEJL/ATHPBxWahXHzvvd4Dh2kYx8vUpy09EmlHUEFennlKdWUXAezQ
23SfiuyrbZLJuM+hlEag2FPhIKxdExkotQYa+Qn2TjbR51VAPz0uDK7tzqt/aQ5g
4Q5KYZrUaFlgG6rRSnncOyrZb3GHDXeMS4gQuGu0U1sn9CEcWzswlJHMBug+D+Uy
4HnwS6ADhHbGIqXROqcrAyemGP7WKFwajmJ0dg7nDXFtyU4pZm6zbTtHlKj+r5aJ
VtvXQJSxUxTuy4iQFg0pY0Vs+E1uIsO/TGuVhNh1TrBsLFgn48kIugAsyKE3Fl0F
nDUJvEiuFUa3eWe+fwpECpFxIQkUsF194rWiMJQeNnE3BWN4k+2c/tP/CGy110Ca
0CT+I/aQaFFMbih71E6kzazR+PkmKeFksl+jRp3Uiw8Krg3Gk669FbhySuwTqDeJ
zjfWhKxuc4dkvCuXpxUi2nF4uzF16M2/1ZUL+xP4b4FB4ciHKomK0Du0jShn4zsF
qSNg6udixqR097xmg1UeDqDXtPyJx5iI/txwIAO2w6LKg/WqLSCYph1F15nAeKOb
hKJkSf7g9rrgz5Kd6bf7IVa8ckdh0q1Mtr+XeYe6ubKpB2BM1LE=
=L4Bm
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
