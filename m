From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/6] i2c: send STOP after recovery; use it for i2c-rcar
Date: Tue, 9 Jan 2018 12:15:50 +0100
Message-ID: <20180109111550.yaazgjwwzhjq7ogy@ninjato>
References: <CGME20171204123700epcas2p4273f3313a4c52e7685bbf04d776cbcef@epcas2p4.samsung.com>
 <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
 <ae01d819-8f12-0f12-fc35-b46fd41c9477@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sfqqtudsnk4frxz4"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ae01d819-8f12-0f12-fc35-b46fd41c9477@samsung.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Phil Reid <preid@electromag.com.au>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>
List-Id: linux-i2c@vger.kernel.org


--sfqqtudsnk4frxz4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I do not feel myself experienced I2C developer, so please be merciful if
> I write stupid things :)

Don't worry :) Thanks for sharing!

> From what I see the whole recovery infrastructure partially duplicates
> i2c_bit_algo/i2c_algo_bit_data algorithm, and GPIO recovery duplicates
> i2c-gpio driver.
> Wouldn't be better to somehow reuse existing code? For example by adding
> recovery callback in i2c_algorithm, and call i2c-gpio::recovery or
> i2c_bit_algo::recovery from rcar-i2c-recovery (in this particular case).

I understand what you mean but I also don't think it is a good idea in
practice. We can't save much by using i2c-gpio, because GPIO is only one
use-case, having custom set/get functions being another one, for
example. A bigger chance for reuse would, in deed, be i2c-algo-bit.c,
but there are some subtle differences and encoding them in the generic
functions would make them more unreadable IMHO. But the real argument
is: dependency hell. The core might be build-in, the rest is a module,
and things get more complicated. And I don't want to enforce this on
_every_ I2C user out there. So, given the really simple functions, I
think it makes sense to have them in the core.


--sfqqtudsnk4frxz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpUpGIACgkQFA3kzBSg
KbZ7bQ/+OUfkFTjZhdJ56Yq1dXLSVKJzttl9+zSGokMI9GROc4NIQhMzg8mvZojS
qh8HhGsCffbcWipqEny2PFT4VAGN/l8S8vJ2fAZRQwfXYgoHdHdgPjXjt3K4T/OC
NxHDQbGi+Gu6aSwgi7DGdrdYf97aks6fHPc5gNLxNulOn1l7bMBDqwKzaIBICQli
x770DXLh8jKZjjx4ZqJJjFEzkD6BIpQYFyiOAqo6lQffpg1gkvWiXBBMU8BZyuQt
LgNC9Y8uhqwa89f7OWPH//uEBN9WKjjSZ9F8D/F9SkhyI6NIJXHCPZ2zdIbvotL+
QkGElDErtWVA7bObokHuJwgXb6AqfjgpUJOfcJkfEymzEDNpnNaIki5uKcUsRD3q
zkLMW3om5geOdxgBQbg604M0MHuER+7vJvZkmIfXQ9qLAG3Gjimdxb/YYqmB7XSv
VSOCtR/EPWekb02IiqukQgKW6nVxe0xgZpSmfNobso5hueNYeAeDy/E6RM4AE2L0
b8cX53KjHTOdaLZ4ymd7/7Yr8jGLrK33rZUvB3UwaR+k8MivRPdyON7mEbIWQJ02
myZY7hXEdZjRnaDYvlFXHEv29WPXT3QyVzhDQ6VYrbx5QXUP0AF0WIinsypulNZL
VpjN3uEhdnXwB7y/EcGIgnttHeRosgXUEgedRvMTBNQM5tp4x5s=
=aPae
-----END PGP SIGNATURE-----

--sfqqtudsnk4frxz4--
