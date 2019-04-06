From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: imx: don't leak the i2c adapter on error
Date: Sat, 6 Apr 2019 17:58:43 +0200
Message-ID: <20190406155843.GB5253@kunai>
References: <20190401101437.9626-1-laurentiu.tudor@nxp.com>
 <20190403204756.mbc7zc5klfd5zydg@ninjato>
 <20190406154847.gknmrvjzebih3tu5@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190406154847.gknmrvjzebih3tu5@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: laurentiu.tudor@nxp.com, mojha@codeaurora.org, linux-i2c@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, leoyang.li@nxp.com
List-Id: linux-i2c@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 06, 2019 at 05:48:47PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hey Wolfram,
>=20
> On Wed, Apr 03, 2019 at 10:47:56PM +0200, Wolfram Sang wrote:
> > On Mon, Apr 01, 2019 at 01:14:37PM +0300, laurentiu.tudor@nxp.com wrote:
> > > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > >=20
> > > Make sure to free the i2c adapter on the error exit path.
> > >=20
> > > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> > > Reviewed-by: Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
> > > Fixes: e1ab9a468e3b ("i2c: imx: improve the error handling in i2c_imx=
_dma_request()")
> >=20
> > Applied to for-current, thanks!
>=20
> Is your tree already stable? If not, would you mind correcting my name
> in 9b0a9982d8b465e0394db10f15ba53f1a8d60e21?

It is stable, but I created an i2c/for-current-fixed branch just for you
:)


--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyozLMACgkQFA3kzBSg
KbZpnBAAiyy4ergFBvA8t/lhwyYjpDrQnuf84gaCeWEbz3SIV1QSVr5ImsVLVWqe
zDaC8cWMlKreGg8zUolF/JlePUMP1dxBdd8uiquWuoG5j9mwVByEnBDPTewP44zH
dWGWAVPr+WmWBznPj0vHodnfnIaP6ozTb5/nfmW6z2l5t4y2CBdlRgElk4PRcryt
Qy/uJJGlQau8cFgjdqRoay4zH9B8am5Okb5ns7TrUk9sUGaq7C2R3JDobfdtSnFY
04v4hZ/qtjh3PMiHm/c6z0HG7rWwO99WUlKdaGXPbn+nDRsgGFsC5YCLxHQt9oo7
PHMf31015j6UKDG7SghuHrEcQXUfHZCLUtJWPpkmNLxjBuzYGoX/fgZmv+XYguBh
H7kRP9DRNmUaLyvsbRfw0tYaZCztsy5AVfLhGTcQ2LQJq5srMVkQ900XCFrTDRhY
Yy/2Pb/xopfxTxqr2ttzu+C163N1ynSRX3aEq3x2yxXOIvH2/jVYUETWneX9epzM
Wbo234OcCbFUaldcOssxhuI5DJ9zdMTljbI9xXJ065wrlCBiYoI187LjURzISlhO
ozLIP0rnehCHZ5MesH47VSHBGuvuRfNP9Svz9D3rKS8fHlBPUZkPcaWxjt/MMLGh
B8No23fFTKDsFmgn+tZYRuqWOltsWBg1OoR4NZAO7FR45JBxXGU=
=AMMw
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
