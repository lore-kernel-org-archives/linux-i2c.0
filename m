From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v11 3/6] i2c: designware: MASTER mode as separated driver
Date: Mon, 19 Jun 2017 18:26:59 +0200
Message-ID: <20170619162659.7okhgxse3ssu6jf4@ninjato>
References: <cover.1497025304.git.lolivei@synopsys.com>
 <c6f74647391d17f904efd459c1279deed0074caa.1497025304.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rxinjiygixxij6gu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c6f74647391d17f904efd459c1279deed0074caa.1497025304.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org


--rxinjiygixxij6gu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2017 at 11:43:23AM +0100, Luis Oliveira wrote:
> - The functions related to I2C master mode of operation were transformed
>   in a single driver.
> - Common definitions were moved to i2c-designware-core.h
> - The i2c-designware-core is now only a library file, the functions
>   associated are in a source file called i2c-designware-common and
>   are used by both i2c-designware-master and i2c-designware-slave.
> - To decrease noise in namespace common i2c_dw_*() functions are
>   now using ops to keep them private.
> - Designware PCI driver had to be changed to match the previous ops
>   functions implementation.
>=20
> Almost all of the "core" source is now part of the "master" source. The
> difference is the functions used by both modes and they are in the
> "common" source file.
>=20
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-next, thanks!


--rxinjiygixxij6gu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH+1MACgkQFA3kzBSg
KbaWkhAAlNQJBZ5IL3BOf9/BHL9HnngBA6VD9agH9xoXCTNKUN1k9mCMj1+B3Edk
dMSAWGDPtrA/OPl8MZs4UCuwHEzEAUcIsUFoM+34cZyI8TnfSarETvgUl3TXw8p9
gZcCTjRQxvxqniDd3CugxK14APHtPwZ6Gt8yEAOIX8bhbKiiwhWv8A5hsB5LIYK8
QOELUfTZzB+6nTqlBKyCoGQfmpeafhdhg87ywXRiDKdUwA8p1K78JQHQZa6XIRhn
IxHEtPVhwzhvhB2Z2a21JaS3yqB0p7+81m9fvIX5uZnsss7KtUkpyZso6v9uPqzh
sa23NdH2CsFeBlKIVz67JDDO/32wSLvbz5wdVFk/4fbZVeZuryMHsLdAvqpzfC6L
iyzjoIKNRnQvx3BOSYAk4U6gIJYnwrIUGo1e9gf2NMq+BTyOROAscJpYHYNw/ktP
sJKfV/N8g+gMVOy91DU58IZdiAMpMbKqrSF28ykHt+PwsglDNyzL+lLLQDkfRkW9
Sd+3J17uAjy9sf6bSFvCYvn4Ekpm0oONu1+5yv6694BB6d+u0N/WEUZ5YG9rivt0
v2u+Pz7mpEoYJPinCYteZ/RRexsgU31AjajPfYbgq27jMTx1zgD58dtLfBU9n3+D
rZr7JJc4lQo35nI6fMWuDKCPF4g/K2mC723gjICvTDIXfOyq870=
=duoZ
-----END PGP SIGNATURE-----

--rxinjiygixxij6gu--
