From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7] i2c: imx: make bus recovery through pinctrl optional
Date: Thu, 15 Sep 2016 21:45:27 +0200
Message-ID: <20160915194526.GC7863@katana>
References: <1473718950-6667-1-git-send-email-leoyang.li@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473718950-6667-1-git-send-email-leoyang.li@nxp.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Li Yang <leoyang.li@nxp.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Gao Pan <pandy.gao@nxp.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 12, 2016 at 05:22:30PM -0500, Li Yang wrote:
> Since commit 1c4b6c3bcf30 ("i2c: imx: implement bus recovery") the
> driver starts to use gpio/pinctrl to support optional bus recovery
> feature.  But pinctrl is not always usable.  There are platforms such
> as ls1021a and ls1043a that don't support pinctrl, and it could just
> be broken due to old/broken device tree.  The patch makes it really
> optional that the probe function won't bailout on pinctrl problems
> instead it just disables bus recovery and prints out notification when
> there is problem with pinctrl.  Since pinctrl is only used by bus
> recovery in this driver, move pinctrl initialization into bus recovery
> init function to prevent confusion.
>=20
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> Cc: Gao Pan <pandy.gao@nxp.com>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Applied to for-next. Thanks to all reviewers and to Li Yang for keeping
at it!


--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX2vpWAAoJEBQN5MwUoCm2DjkP/AqohoYFvswOTcG1gE76O1p7
mqXhtFdiA2VT2tfaWmQceRcj8jKLe1K3B6A9iKI0xPnX4jdMojN/k81lAD4UDfe6
dOxUFajkakPylQrhNRKxt+S+c3aQ8xKjkNzv+FQNb/pRdXlExYI+2bf0pu75e5QV
QAlGyeholc/3iz9AM3A72enRlsqCt3DvqGjOZHkWmgrcAVjXMwPOEvOBGAvYmLw8
GLCHIq0yHh7GL8DCi6quvRpydLn2dsOA/TqgqV2fmG/1pHAM1fYsYc7qA9QZ5dCH
CeZPnv2HquoA9zxYBRS89sNAx54RFugy/ppYEmHBl84rTTSWGLuv6C0yYNGZ4j84
5Fzm0SNxfKCRebXvvWCjRhkTCg6ekdHPwuXgPeZZZuCNWsGYH6G093BWAzr2PrSv
5KPw70aUmCmQvxJrlwo4lsP2vjfHFxeblJmToa5cgIO+HsggDJuf3T8vBbeHpDB3
c9Bl0pXh+f57uV4LIIWUAVb/9VBDv3qXlfVoLva9loZxFu9OrOae/Ezdzn/KLul0
rBEgVPeFTWO4DEtM6soFP+q4X3jJhTN/BTcTjzcL6xXi20vEVBWxvwL24lmIPfjE
qk0GgXeA5zf1d1TjQpzL3snATgtjE0vq2IU/DpexjQJYIUuB2AZU+oYFHF/vpHby
E6YUtbL1gsvBrwd2oA/D
=RvnF
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
