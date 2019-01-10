From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: dev: prevent adapter retries and timeout being
 set as minus value
Date: Fri, 11 Jan 2019 00:11:57 +0100
Message-ID: <20190110231157.GA3628@kunai>
References: <e0fba81c63e03b58e15143638f0cc42678d07c61.1547018829.git.yizeng@asrmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e0fba81c63e03b58e15143638f0cc42678d07c61.1547018829.git.yizeng@asrmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yi Zeng <yizeng@asrmicro.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 03:33:07PM +0800, Yi Zeng wrote:
> If set adapter->retries to minus value from user space via ioctl,
> will make __i2c_transfer and __i2c_smbus_xfer jump the calling to
> adapter->algo->master_xfer and adapter->algo->smbus_xfer that
> registered by the underlying bus drivers, and return value 0 to
> all the callers. The bus driver will never be accessed anymore by
> all users, besides, the users may still get successful return value
> without any error or information log print out.
>=20
> If set adapter->timeout to minus value from user space via ioctl,
> will make the retrying loop in __i2c_transfer and __i2c_smbus_xfer
> always break after the the first try, due to the time_after always
> returns true.
>=20
> Signed-off-by: Yi Zeng <yizeng@asrmicro.com>

Applied to for-current, thanks!


--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw30TkACgkQFA3kzBSg
Kba04RAAgQBNX3MnzAximH2sCiu5dNJYr5v2qfnibyvIn2RpOV0ZTXdDyW4MTrd/
xCLF2xdQo2MiGIWjjUbucFx005GFqTosFyZWPERHMI53ugDOBY0WNlEkfXghP2N7
IIfh7xj8bgsy3TXhKcTZq9oKQLnfB6hpyzq07uy3taQ1l0xvjtgR+07Njw5ZgO/W
57omF9LcRp6T5jzvFoLHI/pDUb8awySektNqZYw03OSVFwf8Oq2JU/6g6egPlPiF
Z9kJ0DzmQVn4l/jchCs/mcPggfyGkMYTClEhLwycLVQTye4n27Nkmh75c3ej7uFB
5rGvgqZyWeb7HCZKX6ln4dZ9qL+ejdjt6gHV0Umnxpoz8/8I6BXInQLTiDAUHwxI
LaW5MN/duPeaD3tYMEaS5TF/3F21Y6ukpUC3dH2al2qAfk9qLBwxMWXqWxOpxOb3
y+CJcey2yPfwLt/spt8+xHaDx81dnFkfojAkkRUe+/zcgfHZAQiBQ81zQJHHiT2O
aTiW/ySB8gyCjjcMTObgSZfU5l/qLir3cCiDkwmBfbXFYbjvKKCFUy2DoEQXnabb
k76oCUsqZD80zFATtf7uQNANnEEMLXJasxTr/8SrMeJvRYY8BrTWqHjhIOri9ynZ
KeuFawo5gaJsSMjYr43MTedxZ6/sfZvQVUZr1HLV47G6O+KInm4=
=nqMS
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
