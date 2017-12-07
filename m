From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: imx: use proper GPIO directions for recovery
Date: Thu, 7 Dec 2017 12:04:27 +0100
Message-ID: <20171207110427.eszvw3kpj3thgggr@ninjato>
References: <20171204123154.3233-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ii2zrl4qrg2oo3g"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171204123154.3233-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Clemens Gruber <clemens.gruber@pqgruber.com>, Phil Reid <preid@electromag.com.au>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org


--3ii2zrl4qrg2oo3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 01:31:54PM +0100, Wolfram Sang wrote:
> When converting to GPIOD, the GPIO directions of SCL/SDA have been
> swapped. Fix it!
>=20
> Fixes: ad36a27959cabb ("i2c: imx: switch to using gpiod for bus recovery =
gpios")
> Cc: Clemens Gruber <clemens.gruber@pqgruber.com>
> Cc: Phil Reid <preid@electromag.com.au>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--3ii2zrl4qrg2oo3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlopIDsACgkQFA3kzBSg
KbYdMQ/9GfqsbhpNgphZkVJyB5DJUVOz31H6ui7/YufTv99BXuULvJC45uPnUxs2
Bdtgha2DkIDWFs6FvoSjIJ0XnZVssVsClu3dKOWw9z7LZbt2K6adDNMV1gN/r83/
qL1cIXnNjayjuqLOK/Md9ysZBYLTctl/VR0Q5Bhy6vCqA6E6j354WPYV93W/13v8
CIv3HUFfCMnEwAXiPzTmDJhXpYjglIb6VK4pwAYFATuH1rCFLAAw8q/W8TjlIob0
pKQ8XOaiVkjJ6TeW0zO5+kVd5S8sC3KzbnJ2TaVNpwTt8mG0u16+smFHieQKzxx9
vXrhVUd/Bd0vAPNJSlofaf3r0tUnFcq6zV4yVNzkt2oFxQQBxXSnu4simg82J6Y7
3FciDjmZ8uxa4nqC7b1hh6NE6XM0Be8/pCXDoDuo2A0SdxdwuOcZw/IbFznx+n7J
L5T8016rtgEzgQudT1jzel1vOP9FMdnXp+42nID161kdErgbn88hI3fd0Az3L9Tp
G79+wNJaqo/RZThY1d3xNT9oD6R5SdznFjh1muZOAlzIin3384WZ5Q1KikOgVkYD
sLnT6XibCKEDDPwlQBIu/ebRTTgd2ZxHnFK7KJg577wdRLd2aYtmOay9kwBvV/DA
mu7Wcz7LMycu69S3joTy8a4ImqRQ4Dj1f6nYWxX4KfLN0r+mZbs=
=Qd8J
-----END PGP SIGNATURE-----

--3ii2zrl4qrg2oo3g--
