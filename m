From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: gpio: add fault injector
Date: Mon, 4 Dec 2017 22:24:27 +0100
Message-ID: <20171204212427.wfd3zn7xyefz55cg@ninjato>
References: <20170825153918.7544-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s2fxzo5umejgri52"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170825153918.7544-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--s2fxzo5umejgri52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2017 at 05:39:18PM +0200, Wolfram Sang wrote:
> Add fault injection capabilities to the i2c-gpio driver. When connected to
> another I2C bus, it can create unusual states which the other I2C bus mas=
ter
> driver needs to handle. Only for debugging!
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--s2fxzo5umejgri52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlolvQcACgkQFA3kzBSg
Kbai/A//frDmKGg5xPUyznJ/dmzrHnaxh0Djw9BBYf+ABsL/2RFQ9NUCLmYUxzuJ
d3JUVmLUMqR9yDK8VttJALLwvCm5SEB8XioycWnUac4DaqyXpEP6dlqN41EzDlsf
xQrKxZLa+IMvoQEVosbIALjf01HCgm/I7gdqTIHQWM3HOR14SPhARbs4IDtXrrzC
34QlMGtMBJESuF8iJsLTx79tryJnQMpMkV+a2tib09BRy+2EIL+kDPNBcCUjHCz/
OdpNz396c8wblrAJgHL/ohmjGgyMQ/jCAbOqSzzyuaNwWFWaCtI0NxYB2W/0csVT
1JamaNsdHYOVyak9AwNAwmMbdRgAi/oKjxMLRCn8XzU31WTM8IdHS/p0RriXMBvK
YaKDbPJAel5uESW3EnXDBmp68sgtQRQs7vFm6n8eGYcemHFZNMH6nsBqTb84Zt8k
l3LIuUe4frMr79H9INprYf39Xe3mkG+NCerLGEC0pTbb9rmG0SQh3sW37oGv88BA
Bw305LxLASWJjhT1cF5snAhvuDfAJ7yjQczVAD7jbC6osPQuaLoeLed+i9NUlPDP
o7r/h2yoIa22Zrr1RoP/8Afs/Vzr+5vCYAYyKlvCWrZoMvze09B5HCjSW7YuM8nR
mWyXA6ASjYtmsuMIiAs94mRUhtDI3zavI0rzMFhJn4IPIYLB0a0=
=Mb0S
-----END PGP SIGNATURE-----

--s2fxzo5umejgri52--
