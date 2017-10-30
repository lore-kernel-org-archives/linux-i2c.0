From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/7 v3] I2C GPIO to use gpiolibs open drain
Date: Mon, 30 Oct 2017 01:28:11 +0100
Message-ID: <20171030002808.ytay6nvqose4jspr@ninjato>
References: <20171005110310.5900-1-linus.walleij@linaro.org>
 <CACRpkdbjyDWFpb5p6kQTRm8Q=rM5L-Mhi4Q1rphEmOwgF6SHVg@mail.gmail.com>
 <20171027134918.uclfmwgmukshwi5z@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xhaaccp72mxktsdq"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44619 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751839AbdJ3A2X (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 29 Oct 2017 20:28:23 -0400
Content-Disposition: inline
In-Reply-To: <20171027134918.uclfmwgmukshwi5z@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--xhaaccp72mxktsdq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> don't get ACKs for Blackfin these days, but there is still some MIPS and
> MFD ack missing? Can you ping them again?

Update: Lee's ack is already collected and Ralf acked V1 of this series.
Did you miss to include it in v3? Or did the patch change so much?


--xhaaccp72mxktsdq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln2chUACgkQFA3kzBSg
KbZLTxAAin50f8mtJf0TQKLo8uuKOkG2b1Id5LIisDsU+OW69LFmo1HdMbVTJcnO
iuA+I00+XDhsUqAYA7c40r6zw7v3slVIzaNewIoCprz5u73AQQ5u02LJAlVKL30/
EADzq/oqZwyBFUmaNYKyL9BrMy3uBWq6m/tW0rCVuZwnPhlf0N0T4trAyAMNdb84
9f3dKaFitnh74UT/KYViZKNZBi5LLW4i2YIfgzsigROXgtDGw/NKmBQHNyulSMOV
w6PVgzkH09i/60aMfpo0GOzNxCtf90ctWJpS+eqmK+MY/w7N1gZbIhEKgCCPRxKf
1kMf4yZKIUieQCxKYETVEMGnJh3UYfi0b8lg7C4BVt/MN7Mqw6dzM62zA3ZXI9JC
SdsPqy5KJ5D0vgc1poN1Q2oy86TOxHPBCHUQrGT5RzFzbV+pV/2KPBAvVF5qaz6J
NvDQhWtkjlAawBYwjC7LH7OGWWm8NbOG1sK0OatxCaMNt8xpIPyA50eOAd6QplvX
uDCPz7yuZmBOhpkikELQCyWcZXmRp0aXnsZv9IvMeV4dLKNEKOTP70HATpvS5/O0
p80SWWwl1srLxJ/6Fq4GJOemD89tsrxvTOVceG8p+MLMwkZIpvLeibHLr9XOQ/UA
dfG3Dqbvg372FISgJPusSr6+ZABFednX/uxW2Ew5joH2KBBs3cY=
=NKvG
-----END PGP SIGNATURE-----

--xhaaccp72mxktsdq--
