From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c-tools: add new tool 'i2ctransfer'
Date: Wed, 15 Mar 2017 16:58:36 +0100
Message-ID: <20170315155836.xh5uthutefc7do76@ninjato>
References: <20170313114135.2327-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4rkaniuhnw5doz6i"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170313114135.2327-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org


--4rkaniuhnw5doz6i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 12:41:35PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> This tool allows to construct and concat multiple I2C messages into one
> single transfer. Its aim is to test I2C master controllers, and so there
> is no SMBus fallback.
>=20
> I've been missing such a tool a number of times now, so I finally got
> around to writing it myself. As with all I2C tools, it can be dangerous,
> but it can also be very useful when developing.
>=20
> It has been tested with various Renesas I2C IP cores as well as Tegra,
> i.MX and AT91.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>

I think we can do further changes incrementally now. So, I fixed two
more typos and an ugly linebreak and committed this tool to i2c-tools
master branch. This should increase the visibility of the tool and
encourage further testing. I'd still appreciate a review by Jean, yet I
think it has a bit more time until the next release of the tools.
Although, unsurprisingly, I'd like to see this happen more soonish as
well ;)

Thanks for all the encouragement,

   Wolfram


--4rkaniuhnw5doz6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljJZKgACgkQFA3kzBSg
KbZjrhAAsTpvAiLNc158E15f2Jtu2r8YAqzw5o24CIs8Nzc+Z+cKCVEElxxX1Qme
1UYpxlwOXSp2k3WB4ECIiIboHJgR/AaPMDQywT1UM/fUahMjgo79uiGt4BRRtUCr
iwmxak8fRATJ4wr5g2q3wzzfWs4rIxDnnoqgLh+qbJzBddkYyKOCa3OTIqzGSY5S
bYYyA0XuGy0iB6dutWrsNPa4kKteEAQ5We3x4+9XzLxt5CNR/zdBa9zmubCsQQoq
P9HCWDGuUh2DVYAx3kQEH0ikaa/H3MSYqXpN58UIQ/p0ZiMKWNMYbPXJX1+b+2vT
AYedASt8l0yxxyWyBKC5img0F6DCmMbZUAK2Jr2+jgjvzGnNJuo9/MIz186o6Rld
Q1GHHEby+2CdrlhE3/zsBFPi1exPufbeBh7puiAC5R4ZEkFFUnSx47sCNrfDUJm4
Ah+JwW1tMBIx9Cze9F53UF96hMLbOdmdU/fMBwe04+OKldLGIXpOvryyZoH60Scf
P7G2vdFGWAjBVotMCFDPEWj7MT8n4l0K/dxxq7czApZ/Mb61QJDnnHILBHPVtlRN
DBHk9Rc6Q3sJSVs2yqrppTdXYiDyXpASnz2Z1gehJyns/WqNZ6IDBuwArSWn1bi7
7SQL4shEI+rsr/2GJWVeW+8dWUIdqjFwLLab02mWAFIStzniRds=
=CR8P
-----END PGP SIGNATURE-----

--4rkaniuhnw5doz6i--
