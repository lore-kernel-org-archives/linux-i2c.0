From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 5/8] i2c: i2c-cbus-gpio: Add vendor prefix to retu
 node in example
Date: Wed, 19 Apr 2017 21:41:55 +0200
Message-ID: <20170419194155.yux5sivesu3sjfba@ninjato>
References: <20170412172800.23035-1-javier@osg.samsung.com>
 <20170412172800.23035-6-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4v6ysjcjbk4qlcp6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170412172800.23035-6-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-i2c@vger.kernel.org


--4v6ysjcjbk4qlcp6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2017 at 02:27:56PM -0300, Javier Martinez Canillas wrote:
> The example contains a device node for a retu device, but
> its compatible string doesn't have a vendor prefix.
>=20
> While being there, drop the -mfd suffix since isn't correct.
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Acked-by: Tony Lindgren <tony@atomide.com>
>=20

Reviewed-by: Wolfram Sang <wsa@the-dreams.de>

I assume this goes with the rest of the series and not via my tree.


--4v6ysjcjbk4qlcp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlj3vYMACgkQFA3kzBSg
KbbG4RAArV8NwHy8CPgBCIniHhUOFGZWAAIl8Y076qm5WCP6b2fStsMBV+mZ4kam
jJoOA9Q8fqRR+Sz03VI/bAr3WUG+ultmYG/ctSfa2/1ZwPFBJIOLTGGJnIlTLDwH
MC7jvhGo1TPsr9KCUwapSVjBdt3lLXvrobRTfX3Z9Dk5mRVbjUw3dUXq60vUm8Hq
ZYcYbI0DfNDyqujmekXAxpXA3ThaIge5UDDBPV7bIGQBSTyf3Fd8T+k+rqkymYhV
K2M+QvX6CbrryM6TxKQQcG9+S5RSv69wQlYK6ozDOgLnuGMN6Jjp8+/Tg62kFH/B
akiJhv5GJHjyxCg/Roo2/3uidGWhqyyOOQrTQ6Xf4B6lI0zlY70llJ8ruf2r8PiK
h5QmFuii/QB+mwzCncK5I4YqAgJvarndYAEXGsMyQKl58bZyeuA8rEQPztCu8hf3
wkzM7x5LReO5ACcF76XO0QitLZuytG6OaVeO2r4aBS9Rrg1B/u2Xe90M630TdWoF
E/uwsNUsAX3ujpK0h7uXPrn8/0WDy6J8xGL02HjFSkTTu+7lrzjB5RisARHaBoWR
qIYyB4jAH3d4zYCJZB3sYjGoXaXpKs1P7P1Gt02JYuVmavWUVHj3LBzfUiw3F9vG
gLYXpoiiG6u0pd7YyP8iQD7GOSqeOcqEJkhwLx6CIZ8mxNst6lM=
=gj+v
-----END PGP SIGNATURE-----

--4v6ysjcjbk4qlcp6--
