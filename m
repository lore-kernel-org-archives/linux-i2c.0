From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: i2c-mxs: Use DMA mode even for small transfers
Date: Mon, 5 Aug 2013 10:11:32 +0200
Message-ID: <20130805081132.GA2980@katana>
References: <1372713261-20551-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1372713261-20551-1-git-send-email-festevam@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: marex@denx.de, shawn.guo@linaro.org, kernel@pengutronix.de, linux-i2c@vger.kernel.org, alexandre.belloni@free-electrons.com, to-fleischer@t-online.de, Fabio Estevam <fabio.estevam@freescale.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2013 at 06:14:21PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Recently we have been seing some reports about PIO mode not working prope=
rly.
>=20
> - http://www.spinics.net/lists/linux-i2c/msg11985.html
> - http://marc.info/?l=3Dlinux-i2c&m=3D137235593101385&w=3D2
> - https://lkml.org/lkml/2013/6/24/430
>=20
> Let's use DMA mode even for small transfers.
>=20
> Without this patch, i2c reads the incorrect sgtl5000 version on a mx28evk=
 when
> touchscreen is enabled:
>                                           =20
> [    5.856270] sgtl5000 0-000a: Device with ID register 0 is not a sgtl50=
00    =20
> [    9.877307] sgtl5000 0-000a: ASoC: failed to probe CODEC -19          =
      =20
> [    9.883528] mxs-sgtl5000 sound.12: ASoC: failed to instantiate card -1=
9     =20
> [    9.892955] mxs-sgtl5000 sound.12: snd_soc_register_card failed (-19) =
=20
>=20
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied to for-current, thanks!


--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR/14zAAoJEBQN5MwUoCm2u3oP+gPk9Qr78oueEiPgJbyPXGpc
Y4ylku5qfZJEGSMe1yBwzODHvhogBhngVduHu4qRpaZVBedSnsBLO1oPUq9DsZa2
idu+DbSPbbzHeH0jqKdHDfMzgxecr1XEg2yE8yr630+Sd7FLrYfmNRRLQCw8hgkO
UFUyUi7IMBW5c1XRyLEIQ4hVhgaCwj6yBfH8z2sqBSOcoy6SUE6WfsKQ0s4xyHrA
I0c+KpzpwQkxBciTUB3F+mkCagBMGUUFT2Yc5/A7qUykD4lK5k/+mpH5iftnQUrU
dolcjXygUIHRXAVerObyxXQ/HoOQEVnbFYDwuJj9PXlXnu7b7UZC7Ft8axit+4uY
tJfLF3kRzsae9gE5qSuyl5wr/+u71o7Wl1HA3ut9ANFbaTTosRmV512k+t6VMjmF
yd5VGvKJWt6BDTGWkObZd0DOrkJF5UHw/ooqLrMoOj1HkOetbtuEc7YLIZ/oMzIs
9v9qaPBBDDE6WewcwRxVXiJPySInLISMMnd8b9t2RqRWJvgtHCBSoKNhCBmUSF+m
BnQz/rZLl7IDs0+lAXnsE5Mqf24IcMEwcUPsrsyTUlYW+An7+lzZl6xQVSrp2qUZ
Ksilz9JSAzkWdDV+AOUC+xtf9dfITDWOzi/YfQhvPUNM/5SlhCwwOeA52kVIAgKf
4m7L795Gy/yVcvguyVcA
=6vh6
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
