From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: sprd: Fix the i2c count issue
Date: Fri, 27 Apr 2018 14:14:21 +0200
Message-ID: <20180427121421.fsh44y7gq3ehiqvx@ninjato>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
 <e42cc3e001d612e811166b8d21f44802ff20069e.1523255712.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ugy5rrwuo6qde57z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e42cc3e001d612e811166b8d21f44802ff20069e.1523255712.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: broonie@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--ugy5rrwuo6qde57z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 02:40:55PM +0800, Baolin Wang wrote:
> We found the I2C controller count register is unreliable sometimes,
> that will cause I2C to lose data. Thus we can read the data count
> from 'i2c_dev->count' instead of the I2C controller count register.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Applied to for-current, thanks!


--ugy5rrwuo6qde57z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrjFB0ACgkQFA3kzBSg
KbYf8w/5AaXaBbCybjPFXvDVtzfKs8JtAeQR9+HfsZTtacUA9HmceyH6MddwzvKh
Ho0wOi44ZqcCTWURId7fq1Au9bscjlqk01NbCiDso/lctZgckWtFRPjlcLxr03NH
Y/5fD8q2dSnrqyzG3kTAXjK7yEyzHiV9dYPJD+vqy8+ZaOAxWLw2v5xbZG8UkGfs
T9yzbTBv03QOkQNNeBvNXa+axOG/nvXjOUEJ15dmVKG947X5IJ0JlO1bcQuUa6Y8
1iz7kO8B8IODEiOhv2sLdIZSkerN8fxoEPBfJpYJpZUCmGXHCYZlA9rqAAN+V8dj
p4CnyiEk6Tbfif6XMRIBNgRCcw4kmcJrxppL2eZMr18RDiQJisEQ0Os47bkRrBcj
KW7f4+rLYt7bPvIGj3urol6+RxvQpVKn70Z08IQ5DfieppJ8qHrQEbQBwj7MP4WU
Xjt6etO5gOHB6yqy2/kgRT0OXVClVmXNguPwsWNm7/y49YYwIcU6nznTOcr20D3t
pCKTu3jzLVOSHDw6dX18rcJD7UxcSRZykjlTg0BORnMUKyc7bI63dpY/uF8OgilN
MX482FL+758v6fmmDUMDXFV2WksZHikEnE2UQS3gJsykaY1pueuIo91e9e5bBowm
3bkBCp7w/RymH2qHV0k+bCHIPZ2VN+UPJIqFyX8s3ahz/H6qnhc=
=mHRI
-----END PGP SIGNATURE-----

--ugy5rrwuo6qde57z--
