From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 0/3] i2c: davinci improvements and fixes
Date: Fri, 10 Apr 2015 17:59:40 +0200
Message-ID: <20150410155940.GA2408@katana>
References: <1428323921-25832-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428323921-25832-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@linaro.org
Cc: Sekhar Nori <nsekhar@ti.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, grygorii.strashko@ti.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <ssantosh@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>, Alexander Sverdlin <alexander.sverdlin@nokia.com>
List-Id: linux-i2c@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2015 at 03:38:38PM +0300, grygorii.strashko@linaro.org wrot=
e:
> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>=20
> This series converts driver to use I2C bus recovery infrastructure and
> adds Davinci I2C bus recovery mechanizm based on using ICPFUNC registers.
> These patches are combination of two patches from Ben Gardiner [1] and
> Mike Looijmans [2] which i've reworked to use I2C bus recovery infrastruc=
ture

Applied to for-next, thanks for keeping at it and providing useful info!


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVJ/NsAAoJEBQN5MwUoCm2BSUP/jI6fuI/0kVaJwOwK4MCvtlR
z9lgOsCjzgi3P+j8x+9I0tvMDVwxYlbtI1IcTuWLBYnTN+OFbCy+jvGzGdtidkXP
fptUklY6muS4EksCxL8X7TBBWLeqBILvyZ6hVLaJK3tcPpYhZk3ydKInMvU9cE5P
y4lUkcxixoUci4ZMCNDpX/DW7G7dTylKX/wDb7UmNUtRm8KtJO8kHPutBj33348D
OyVlJ2tMI4qsJFfD6yQHBu/+ZO7iy30QYVYlfGPIkXFwsG8bGF5R6g1uCWT77rSD
MOXdjrzHHSnV21gAzBfVyUihHJzSb+snfodLnNMcxUoZ4gsBoJQ+UFFxjgGmiG5e
PJJ2ZQq8b9l9T2gCvPMuTgV4HntY5dJpQ8uEbPu8hBlaC1iDjoNx2h0c+5aN6BUA
Sdm1bNTBEFI+XnXzS0A1cgGbVzXLHh3ZcsumKPwSTF2CYUxO48B23vVNdXguSPnx
qcn96kx8/S8OL4XqEzhN1ENE0qboGGL4hlntfGwKV4oioyeaRgn4R6U7hzp+BN6S
92qFxo6cT4hzRHHquuqSNCX9Amhw2ka2WOPk1UahcONNieXiwbtStE2AIIeT95ZR
Ns2kvKgPW/GKyQszCVbw9lIfUWDVE/ZhKR7N5Mn++TEq0KvXmv+KyWqE3MhfygYy
eU40wC8IQuUCTlbAkoun
=b9oo
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
