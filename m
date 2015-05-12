From: wsa@the-dreams.de
Subject: Re: [PATCH v2 2/3] i2c / ACPI: Use 0 to indicate that device does
 not have interrupt assigned
Date: Tue, 12 May 2015 15:09:21 +0200
Message-ID: <20150512130921.GD4447@schokonusskuchen.bad>
References: <1430908148-201129-1-git-send-email-mika.westerberg@linux.intel.com>
 <1430908148-201129-3-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430908148-201129-3-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2015 at 01:29:07PM +0300, Mika Westerberg wrote:
> This is the convention used in most parts of the kernel including DT
> counterpart of I2C slave enumeration. To make things consistent do the sa=
me
> for ACPI I2C slave enumeration path as well.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVUfuBAAoJEBQN5MwUoCm2FyEP/1EEODbElxZn++Us9zQEethx
QwQq9Jk4dAHkdOZtZlWG11b/67zL+KNur6D+2V2pt6eApl6Kgj2JHuAe9lgo6bnz
YwAcIKmfaAUKtzOgxLHOOprxSeSC0oW6nAeozNLp0vLoEiHc7QU6iWmbsUfCgm3Q
VAZDBYi3Rh9dgbucxBcjE0+rsXSVxDVXjH3f3OGpnvoPVotLh9gaxaUrX2e3mwAb
kr4kGZrKJbdFpPIIa5u8WD9vvZvAvsIO9dfZunRXLx1e266RNXFxQ+Uz3J/2aQtW
NePYc2gXfCMPQXOAh2rOtB0OnSPxi8TwFtqGB5hp5P9jxhiyS2sluBGJ3qo6qu0G
cTgUb2nnWmG0uKJn3frsEkhj9oio5FoRYCiTha4Z2f3b971Ly/FTbCHOYdvMk7mY
abz4lp4FIls6j/gT76E3Cq6Yp+OFYkoaSPPlFIfIdEVo87HvhtRUCEsbeywGZT25
d3Xu5k8ZKb8KQbRpkp9vztPpheDJUjZhDhmn+5/EeaFVc1UR+XoD/ohIrlJgYhZ8
aCD/LBBi8IufSp5ZHZQGKwHtgfV2tD10Mclqd7Pe8MxdeXUkwKAhN3sQ0HupSKP5
VzyzVasAGCLXYrsEsqGgDubxOV1eWdBzP3ilLDgRvjHys2EjMmw+m/y6YLVNmzlZ
gHpom71PMlm+orlMsDbi
=f0Yv
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
