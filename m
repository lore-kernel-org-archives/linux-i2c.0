From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv7 00/11] i2c: Relax mandatory I2C ID table passing
Date: Thu, 17 Nov 2016 22:15:21 +0100
Message-ID: <20161117211521.GA4638@katana>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>
Cc: Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2016 at 12:47:35PM +0000, Kieran Bingham wrote:
> Version 7 of this patchset performs a rebase to linux-4.9-rc4 and adjust
> the usage of strncasecmps to sysfs_streq. I have also renamed the
> function i2c_of_match_device_strip_vendor to i2c_of_match_device_sysfs
> which feels more appropriate now.
>=20
> Retested with successful usage of full compatible strings, and shortened
> device id's based on the vendor prefix being stripped.
>=20
> Wolfram, for your convenience this series is available as a tagged commit
> at: https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/linux.git=20
> i2c-dt/v4.9-rc4-probe-conversion-v7, though this includes the TESTPATCH so
> it is not by itself suitable for a merge.

As agreed, I applied this series except the last two patches and
squashing two of the patches into patch two.

Thanks to all involved!


--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYLh3pAAoJEBQN5MwUoCm2HcEP/iOcRqJAjyAMhbAXdhR5dCI8
qBnl+kuxn8v7ORIVSI+95IyRe+WijU0uLzViXx7JIrNlKyt/JFN/BXoQQZFdQ8GZ
1Oc36XyTfELL+0Q3/CM8eLCzCkiy8eyeNSRNNAH85MCuC9qsGoDcUa31Vc2Gx6Uv
pXF0sTWMyciUDS+YKXo8evlgjHuaQ1WoT9CaAPBFVTKy6FpfvIl4QTqoXnAQUJvy
SAChPXHuRCLKN1hn29aW68FJDmN0QlDeQJksWK2SObAyGSmC/4u20XYRigh7nKuh
PxB5BZ6uIxx0DvJqGufj6B0XDa+2v8OtIxNBYBwIzvvnp0fAleImbnDFe3+Apd0e
B2TpqrkW55X8r3rTUzfSHlQiCqC7pMNcIfvlO/j7Lcz0Xs2d7nfF7pE6P9Oq74p4
I99jyDDOXLq+6QdBN07QgEuMMdSjPxCY6Vd4I8v3K6UMWK5sP3zl7kkMys+b0i0v
hlg9aG5NozflPaba0xMBF6jbxWQSkYSeDPIaWaYlaV4T+cAEC9SuNBolWTm4dTiG
emq5WIJ5mDFHc+9YptiEu2cJuOdu6OrwCi0LqET5yNT/pFVZScR+zMi51q/v1bA7
qQBRWPKtcDZjR2IG1UxbJFUeWvHWJo30PaWLTslcX+7gwUKILk0pri4PJFLKtcXr
DHg5QtEhX7pUeSBjHzyg
=BIbK
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
