From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: algo-bit: add support for I2C_M_STOP
Date: Wed, 21 Jun 2017 16:54:26 +0200
Message-ID: <20170621145426.yeourbp3coddjwmu@ninjato>
References: <20170621092402.773a4b14@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yw7t3pdcriq3crdc"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170621092402.773a4b14@endymion>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--yw7t3pdcriq3crdc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +				if (msgs[i - 1].flags & I2C_M_STOP) {
> +					bit_dbg(3, &i2c_adap->dev,
> +						"emitting enforced stop condition\n");
> +					i2c_stop(adap);
> +					bit_dbg(3, &i2c_adap->dev,
> +						"emitting start condition\n");

Do you mind if I combine the two debug outputs into one?

> +					bit_dbg(3, &i2c_adap->dev,
> +						"emitting enforced stop/start condition\n");


--yw7t3pdcriq3crdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllKiJ4ACgkQFA3kzBSg
KbYIVRAAjiZB73snN8/PlY4m/D9b+AFfYG0xUlh+GMMvDPT3ozTgQvD8G3g6yOQL
8XKl/NPieN1rAJ5KHdNJp6Sj4Ow5uSrdufL5E2RDXg0b9Wzkle+djg2YLyzQyESm
XypLRJza4sKzxz6tUlVSNedmZiSNueo52UZRzHUYlg5FDNZbhFPgfhuZL4xN119T
4g9tP+lQ/NlFiqLdRaihMfa0pl5+TVMkmcrK4hiRJF5VQXPsFcXfhT9Uamx3kmcd
SUOjNGbAtau/ZbwZjuzbZbLrmbTc10D3Ghlv0KdFM8Zqwi8J+6+2crAZi8xXIqTu
44TlGbKQxTKUAM2bLKI6rSdrQq5X80KsVOhom50jpirPjZeicT4FxKOuO7NPkdSN
pv/DUyoVLjGCo6yyPU8FlCd6KI9OQPeF1bhlux0yKWeZjZz0QH8v1V8dd2Wq8Qog
fmnGuA47UIXbKFe125AeEKg6cykT5C6TN8+snh4NMVc0N3kXiflMdiXpk3UUMMG0
YTaN7q4HtDIizA+6scp2HrIv81HL4qixxL2w3bSjFPSmsMIDxQsRGFGaLTMOE2nw
3XUrNMqi/M6sqz0sZnGwKZCL85EFdFI5DILGPs3tghaAzHU0gZixmuTQem1Jykbp
ufHgQvkOT4GbhIeCQRczTGxl7Zb9aVINqli0y0FREMxSNUCpTnw=
=zMfU
-----END PGP SIGNATURE-----

--yw7t3pdcriq3crdc--
