From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/4] i2c: pca-platform: updates
Date: Mon, 19 Jun 2017 17:01:19 +0200
Message-ID: <20170619150119.bu6saf7xvt3tvhtx@ninjato>
References: <20170613015641.29373-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bswz35zs44ktub3m"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170613015641.29373-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--bswz35zs44ktub3m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2017 at 01:56:37PM +1200, Chris Packham wrote:

> We're using a PCA9564 on an embedded platform to provide an i2c
> controller. This adds devicetree support and I've included some
> cleanups for the driver while I was at it.

Coooool, this was the first driver I ever hacked! Ah, memories :D

Patches 2-4 look good to me. I agree to your and Rob's comments on patch
1.

Thanks,

   Wolfram


--bswz35zs44ktub3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH5z8ACgkQFA3kzBSg
KbZdMw//XzsJm3+CKq+np4cpWwoKbwqejJcSvSL5NTv/XAl3lVW6w4uhY3BXcFoV
WaqsTMF2/s1i57WUdVrQV/WYB0OZa5wA0d2dYOdhixtnwLivPGk43eF8nobeTwjD
Z77CVgJCIJk4l0BkZVUSMpTvpNqa6yfLhDUcC8/sjXKvjQR/cxwun+jw4ixyMPyM
mZjOCAbyG8LJxTgle1tkAy5hfwq6dkY50OLyKWympg84X5+0uSmA2Ybb9PqHBKAB
rnMlc8ZsyNsD732BWONrl4UCx2pcfC5ovv5YCQJimsEUUX/qTUsfcwvcbAmL7zeS
0bC1UcWIcC0xl/Vvj2naJEfOsvd7SguikmKQpg+E253rgpZy1hEQ/daYGQWr5Hwf
oeSpelBp7PR4D5oBTiDTxQfDDjGNmvzQINgdQ5N/9T7Qc4xNNm+NQ9G7FbeGWvyo
YP/zDcDyd0n16JuP5F/BsaBLxQY38rKmjC0E3dcWZPuZ98YUjzd+oFQyAF0U3JM6
/3WFkzJkGkn1S+kfb7eifWc84FQ5lMugHf5N2Bc6wniT2Y+96vkqY8mkZYEQZ5Gf
gHgkeHeHIuDrlChEY6S1tmJZ1YnieXygyTVY4I2B5rul536+rUcv875DulwhaniS
kPKzY6nCerzbcy51G3AmCFBgOOKMdaXlmyjdMoYDErWz7nKCMUU=
=/kjz
-----END PGP SIGNATURE-----

--bswz35zs44ktub3m--
