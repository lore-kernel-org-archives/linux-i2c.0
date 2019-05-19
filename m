From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] eeprom: at24: use devm_i2c_new_dummy_device()
Date: Sun, 19 May 2019 22:52:35 +0200
Message-ID: <20190519205235.GA19630@kunai>
References: <20190519204012.31861-1-brgl@bgdev.pl>
 <20190519204012.31861-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190519204012.31861-2-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Now that it's upstream, use the resource managed version
> of i2c_new_dummy().

That was fast :)

> -	dummy_client = i2c_new_dummy(base_client->adapter,
> -				     base_client->addr + index);
> +	dummy_client = devm_i2c_new_dummy_device(dev, base_client->adapter,
> +						 base_client->addr + index);
>  	if (!dummy_client) {

Oh well, the confusion starts already :/ devm_i2c_new_dummy_device()
returns an ERR_PTR.


--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlzhwg8ACgkQFA3kzBSg
KbaunhAAnL04MZbjXegMV2akY03VuGzVoHwLdRndBqHOlG33ZNd0u4Wmf+fDv0ju
ddWxKuGDH7XShPa4n29ohHIIY4F6urlQV0zrs5eBS5vHLu+GEmeeXkic+a2wn3CA
O/Xnkgo5N7CXPGv9sTDX+IY3W86ZiKrioj8LcXXVdNcwNm15qGCgbN8ncUzxNrp5
XbJFjGFdoFcBpigZPqK3Pu44yRgdKfBS3eyEzGxwHcVQhaCbxysjMGRtfZwmqDKY
gJT2t3f7hXgK8gvcR4E/XvAT+v3TCvMWw9PiYEKhB+KmxDAQPEIGZFjptPpqsgcF
BCkABUuuknAx4Hl9OaqwrmezyAAnTZorIQUO2RYGk0pydiXEp5wvB6OREdxsARax
CYCptB747v+dkTUZ3ieoJeqj++lMpwH08jqydR3vIstJ7/mZ8YWJLxh/yIX4ew8D
XWj5VXFhleRi+AkfoV5ZT1mkJ1nZcUVMZTExhigkRYLipuyxjfbpwrlOwnpeBB2u
hj7gJ6yGxSlZRCr/kUXxBt5lHKe4677babpk1iQDXcyHK+EgXfJSbwu7K1FDXj2C
b8bWTaPgk8U8fw83BEtYQFruUdn2frsxSRex+qEmLdCHuLW3OCh//8sEbQ60vOsQ
h8r27tRSssN1RcQS36Vhrh8lgtR1ikXZnQfilyp+QSukd6BMMt4=
=jlLR
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
