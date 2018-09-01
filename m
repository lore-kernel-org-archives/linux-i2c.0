From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: uniphier: issue STOP only for last message or
 I2C_M_STOP
Date: Sat, 1 Sep 2018 14:52:01 +0200
Message-ID: <20180901125200.GD1196@kunai>
References: <1535725848-4076-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1535725848-4076-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 11:30:47PM +0900, Masahiro Yamada wrote:
> This driver currently emits a STOP if the next message is not
> I2C_MD_RD.  It should not do it because it disturbs the I2C_RDWR
> ioctl, where read/write transactions are combined without STOP
> between.
>=20
> Issue STOP only when the message is the last one _or_ flagged with
> I2C_M_STOP.
>=20
> Fixes: dd6fd4a32793 ("i2c: uniphier: add UniPhier FIFO-less I2C driver")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-current, thanks!


--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluKi3AACgkQFA3kzBSg
KbYkwg//cixDikZbhlbmEg9se5SihXJiO3HwHbaE8rSoV3MyJoJLctJa9MpEMf1x
R+Dnn+td9aGhP9NTidHBZydrZBKqmqFnCHTsom9i9uYzWYI/Lf0Xk8B1SqpA+huI
wp4OP8OPIZS3b3fBmsR/u0IkRbNmzBQTwOhZ+sqE028O0zH2RkcJeAzQ/qZuQ6Ix
MdSBLe8jkTTIEBeBL7YQ3Ogz6nEE47lANwNQGow1zvPjl2lqYTbe0tEoY31IAO8I
JtrcsVixNSg7Nv6TvJKjfTNsrIzvhFPGSuW4NWPCi9lgOrrS5TJSGVhznEsXBHIO
TSJKlvDAnC6sjMMkqodUiRgStNcWiLrguJsejWx4YMQViqPMIQfcGWV/1aCp032D
Zzsh3K/ogWJIxwZzYXh0TtfSfCaL2SnhaVhkYklPa19yVmZIULI1PCFB73+oN/fF
y5gMgKTwomVTw9GwmLncNv/9mpg5M0DSse+cRMUwZQSngqkP/0eELE1DwxSi2diJ
GJeeEJ243eKnMhhM3oKlMdKWGzNHvFc1DW365y/ZVUidbQlMQ++Tj3TN9tDMy+ME
NQCkejoVz+T7jy/wPTt22wvgggcxNBJLyQecMi0sa4cHF0fziIIrqi2ImYXaTxb0
igjBBpjvxiRSibCugXFqhdfHb00oChDJWHTCL38Nvr9hZTyIewM=
=UZOe
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
