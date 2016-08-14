From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: at91: fix support of the "alternative command"
 feature
Date: Mon, 15 Aug 2016 00:34:37 +0200
Message-ID: <20160814223437.GG10501@katana>
References: <20160803145826.11927-1-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0qt3EE9wi45a2ZFX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160803145826.11927-1-ludovic.desroches@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>
List-Id: linux-i2c@vger.kernel.org


--0qt3EE9wi45a2ZFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2016 at 04:58:26PM +0200, Ludovic Desroches wrote:
> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>=20
> The "alternative command" feature was introduced with sama5d2 SoCs.
>=20
> Its purpose is to let the hardware i2c controller automatically send the
> STOP condition on the i2c bus at the end of a data transfer.
> Without this feature, the i2c driver has to write the 'STOP' bit into the
> Control Register so the hardware i2c controller is triggered to send the
> STOP condition on the bus.
>=20
> Using the "alternative command" feature requires to set the transfer data
> length into the 8bit DATAL field of the Alternative Command Register.
> Hence only data transfers up to 255 bytes can take advantage of the
> "alternative command" feature. For greater data transfer sizes, the driver
> should use the previous implementation, when the "alternative command"
> support was not implemented yet.
>=20
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Applied to for-current, thanks!


--0qt3EE9wi45a2ZFX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXsPH9AAoJEBQN5MwUoCm20OIP/0C8qmkN4DTS/wvozM/VlgQo
Rz/2wm3eDI6SK8qF6UChN4tp7qStV0Zkf4SwoCIS9iHdJ34kv3B64vaXTcS/jih7
xnBj5HLqV5DH8Y6dMRda+esAguFS4QRl3gDtKvYn6JdfFmGxyM8a8g78tnKGHZgD
LG69dykJnLRz0C29jRaaTyo1VCgION3dn2u7xo/6RSYGDzMf1DYt21Sy7mWkuvEJ
+oIHcExxJDjdKfvYZKpjItn9pCNPuEJSwwMV1tLRcRJX9Uf1eiNA+xNaBFHvQgbf
9hPvpkfJ6lmOYkDITE4ozBEooRux/8lAIfEs3xn55fewgQHACt10swW8QOi1YrgB
r77TT4d3I0I+yoe1GaarAuNjxY33AuVqOEiO6lc0yYIuzCu2h/BDHvVkOy0vZpRY
LkQx9pC7hkEXhAON3tyl73G4ChjKX/1I1a8tl4Bndyov4FwQCHRTXHqBfpN1fMSZ
Kdoe5HB086JdvydF6d9GrLCK8rv/VET8oljxnMcQQanTEVadjbaaCxtzeBEbDQ9B
C2wLdiusnKyWdUAtvwI8nqGeF1uGBTbYk9/F/xxhV+6ZYFStUVcaCNPW1yoQ7Vr0
+wusfZIad/FNR9Bf8z7QCKj12QFqO9BluV4ZWFaIOrnLLifT79rIGIZhgkbnEopl
BSuB7ViI6NNl+6wZ9Pz/
=9yGF
-----END PGP SIGNATURE-----

--0qt3EE9wi45a2ZFX--
