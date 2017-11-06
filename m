From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4] i2c: aspeed: Deassert reset in probe
Date: Mon, 6 Nov 2017 19:23:18 +0100
Message-ID: <20171106182318.xk2rkz7vv2p3sqso@ninjato>
References: <20171101002330.24981-1-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qjklndlmcwznakby"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171101002330.24981-1-joel@jms.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>
Cc: Brendan Higgins <brendanhiggins@google.com>, Philipp Zabel <philipp.zabel@gmail.com>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--qjklndlmcwznakby
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2017 at 10:53:30AM +1030, Joel Stanley wrote:
> In order to use i2c from a cold boot, the i2c peripheral must be taken
> out of reset. We request a shared reset controller each time a bus
> driver is loaded, as the reset is shared between the 14 i2c buses.
>=20
> On remove the reset is asserted, which only touches the hardware once
> the last i2c bus is removed.
>=20
> The reset is required as the I2C buses will not work without releasing
> the reset. Previously the driver only worked with out of tree hacks
> that released this reset before the driver was loaded. Update the
> device tree bindings to reflect this.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Applied to for-next, thanks and thanks for the ack, Rob!


--qjklndlmcwznakby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloAqJIACgkQFA3kzBSg
KbahkQ//VIh1EAq5M9s0tPYvs2j2yM9Xm2ccJTm6pdBjA29nXZXNGWK3RtiRt4/r
Qu/YOmVuIZHS+TF/UbVG7Hz5hX8c9nv+SZWg47A+Zk5C6YFqbQ/IB833HZ6jTm9N
arOic9aDbC4wqgxT9uxMZiQKqZtMc7ERuYMIfk3EGp8bNe4sn7Ql/RyDYc1cMeUx
TdnLtGO5pGEBDqh6kT65aiKG12g3UVisz+i9Tu+8mTnfd+xgIRe9TFYzoeRR+EHO
trtMx54wk7mXioiRD7TMZnh4E5RfbyoDXlkW3z07hDOHeFbfDGM3/KAIGzLlbozo
KGDYUHc4KjcKsk4NJG4UHtxR9AkNwL2tb+pFJWWVlzjTTdOJ8N/o4cojqpf6VVEE
livuCOw6G75MjNiZudoXKo0S1rrT56NLarpYiLPigPh6FnuKCmVHF4xgDDkLu/8R
9IGHPWA/6lDU2mjolsBUk/bmcuPKAZgWrC64wd/EVPb+xIay7t9fo7urlz6H0SQj
SJKd3DiEvqv4mFWboZ5T/CnnQXOHQYa5MtDvFa+ZcDiZ2aX+w0Q4BA/lObH5ggSD
tEVv2H3PgGi+Sc2sCneaZwtg7HHI+JPFTXohC+s0Vcc+O2VhXk1R8N91QyczQGY/
9e/dOnofdHmOKKmY4mQ4g1RMH+JmF2Nt1I4TOqyKloOe+MnnLs8=
=g29h
-----END PGP SIGNATURE-----

--qjklndlmcwznakby--
