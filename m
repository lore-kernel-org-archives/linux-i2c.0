From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: sprd: Fix undefined reference errors
Date: Thu, 31 Aug 2017 20:33:16 +0200
Message-ID: <20170831183316.ncq7o2bgg6kb4uhw@ninjato>
References: <550ed5bf75d653e227d09266670caf2a058b0473.1504061716.git.baolin.wang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rydphbotd5laho2w"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54021 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750996AbdHaSdS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 31 Aug 2017 14:33:18 -0400
Content-Disposition: inline
In-Reply-To: <550ed5bf75d653e227d09266670caf2a058b0473.1504061716.git.baolin.wang@spreadtrum.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Baolin Wang <baolin.wang@spreadtrum.com>
Cc: andy.shevchenko@gmail.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, baolin.wang@linaro.org


--rydphbotd5laho2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2017 at 11:05:47AM +0800, Baolin Wang wrote:
> Since the i2c driver of Spreadtrum can not be build as one module, thus
> it should depend on CONFIG_I2C is build in.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>

Applied to for-next, thanks!


--rydphbotd5laho2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmoVmwACgkQFA3kzBSg
Kbb9uA/43Bqero5XKmFncoStG7L51NkMrC8uAvPnqUXvDvcul8+Drjnsb+bzfiAQ
r+zfY6m7qKBnCrhTGob0eGsvWHYyEYC9ddAqQRmvCbfUJeIySD8dOggyBXIBElkh
OTSHWkxfCpDog4tAA6DUbm4QR5P69hm+0yQ10quO7uga09heN+Dk6uPiCRP9oMTu
GYuuD01NzN4Njo5Ai4NfhEuMcSQCpQEhn995uk0n8lSUJfAkr0t0cvTcnk+grAjp
KQAel3ObzvTydYTKTHQiCmWbRyCb5Gq3eTJ2tldJOl7gQvnwW+yDqfAqMjFOCbDc
wNQJJy/sXFP629CFM35Ay8YVXw4s/gXS0NfzB7+/jbA4utwbGpoWUFcjUB8mIedE
bfC8MUIUS456wfxvcg2rCs4Mf++J9fbbQxtSqHcYsvAkZ2yGZrjrWHiyOLLtHvhe
iyCNUUv0PYxXZhGdti9AxXhPcqXIrhhp59FqJbEh6gbac4NcjLEFIPqdbDi9p/qW
ibwduXb2oVX0gHCMsgLrxreHd4BHIbZvRyctPx+HmEe/iyTXEV8b9K1Qdg0DiAxi
zLv5loIlpP0+8j6QSw+Lm2f+2FLoj3Y2Ew2yG0ogTyhTYAHXDRfQAwdgcZDClQqX
PZYBDqqmuqu9mnP1FGSEL06pvzrZ30ryXWCvmStcC5YY91Huig==
=Kst+
-----END PGP SIGNATURE-----

--rydphbotd5laho2w--
