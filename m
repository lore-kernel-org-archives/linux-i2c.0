From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] i2c: at91: add setting HOLD field of TWIHS_CWGR via
 DT
Date: Mon, 30 Nov 2015 16:13:20 +0100
Message-ID: <20151130151319.GM1513@katana>
References: <1448372862-11912-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FxlYARId5dseejUu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448372862-11912-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com, plagnioj@jcrosoft.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cyrille.pichen@atmel.com, Wenyou Yang <wenyou.yang@atmel.com>
List-Id: linux-i2c@vger.kernel.org


--FxlYARId5dseejUu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2015 at 02:47:40PM +0100, Ludovic Desroches wrote:
> From: Wenyou Yang <wenyou.yang@atmel.com>
>=20
> Add the HOLD field management. Some i2c devices need a longer data hold
> time than the one given in the i2c bus specification. Since this value
> depends on the i2c device connected to the bus, add a DT property to
> configure it: "atmel,twd-hold-cycles".

We already have "i2c-sda-hold-time-ns". Can you use that one? Sorry that
this is not obviously documented, I am working on it...


--FxlYARId5dseejUu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXGePAAoJEBQN5MwUoCm20IkQAIUT+8p9jBSDz5FuJ6ODvovU
Z1LsU1sZ/tJLbVtsMArkPmMwm1KUrxrReQWzqRkq9FbhOuHM7oCzgsim+sDjDGIV
diS6CX+B3FH9DDeACv+shppfO7Ng3Jx3qrvd+6P/sSxhrOXL+waRYo1DNhgAEG68
aoMQmiukrJ2cRYTk8cyaVgwUBlSFtyfA3v6hwrDaQI2N5jOdhS0kPRCHD1GzqmSh
9xz86d+39HNUXMZfa92OTJJGoVTTCkFyRLIXT1shfF7wPxocvtEGvSFNJ0wkbffF
QSm2BxYxS/Pw9qY26Vu2s8Yr1UlSOId4g86qhKvG8XRWYnGJZS4NJ+O1ladEYabx
mkWJccfY2Wr1E3AF6rhaDws3qlhxgfy289y5W3l5Pq+EfaxvHWpDTgLOYoFLNxx4
ffo04SxihJSn0uQP+17noYMjZG3/AIydi9yliPN6aN2PL1GyYXzrbkpz1oME/yFg
Y0HlZLHkX1JkAIGezznifsMrT3FW5l37amjnTXyhOmCZZFD0ZQbUV0gsl0J1ugvm
13kjCWYTNo50nkzyD54vSiRfj8TUerVRqGz8lLxxUjAma4lBmQFiUCBHM3nIxood
1vO9ICXSiGiFwEnIsnvVvMfiT2Ah8FMnrPwteeNoDuK9zTGKmAbAyPM7K1Ur8pno
TPwOsuzA4c+kPuGbsz1b
=aJlr
-----END PGP SIGNATURE-----

--FxlYARId5dseejUu--
