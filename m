From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c-cht-wc: Add Intel Cherry Trail Whiskey Cove SMBUS
 controller driver
Date: Sun, 13 Aug 2017 21:45:01 +0200
Message-ID: <20170813194501.dwic6iynbeeoyliy@ninjato>
References: <20170813101651.6708-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g72ilew4sutmz4oa"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47212 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752026AbdHMTpD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 13 Aug 2017 15:45:03 -0400
Content-Disposition: inline
In-Reply-To: <20170813101651.6708-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org


--g72ilew4sutmz4oa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2017 at 12:16:51PM +0200, Hans de Goede wrote:
> The Intel Cherry Trail Whiskey Cove PMIC does not contain a builtin
> battery charger, instead boards with this PMIC use an external TI
> bq24292i charger IC, which is connected to a SMBUS controller built into
> the PMIC.
>=20
> This commit adds an i2c-bus driver for the PMIC's builtin SMBUS
> controller. The probe function for this i2c-bus will also register an
> i2c-client for the TI bq24292i charger after the i2c-bus has been
> registered.
>=20
> Note that several device-properties are set on the client-device to
> tell the bq24190 power-supply driver to integrate the Whiskey Cove PMIC
> and e.g. use the PMIC's BC1.2 detection (through extcon) to determine
> the maximum input current.
>=20
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to for-next, thanks!


--g72ilew4sutmz4oa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmQrD0ACgkQFA3kzBSg
KbbqIRAArBZmSJlz6zeUouvLuaD89iCCe5lPZDNG+l9g2o2W/VokNYx/XKySnpaJ
MLY/YeM/8EjKD8PtwX0hKsUTXc36MqD+pUauwyMl4UE8X5U3FRKMdiGjUB7IT9Vo
RBYrbtpXjes7FVM0xemBSSUgWPGBqUiYaR6cSKBOEtJn00enwTvZO/n7aUX59XGH
QN9hGQdDCnG+lvegmqNWp4FMC2fSW/U0JBOhagoRtFSt7EecAwfOe310F8PV81EB
oixwCc6M2+oJAaX68mpkc1j0BfI/jTkeKPJotgltPR9xo5uKrsDyqGLoveGIYxoc
W6ojqg9BR6yGX4zgWGW6ViXAFDftwcqlA1p29R2vmFwsH0fxh8K0rmXRLuho8Ky9
KVJ2NWXqmqG3cQWnFiqNJgpzhrbwmmwzJbog25KrY5v9SFisuzCOSwGDo/Mn6Fnx
nJtn72beV4wcVThESUMUeLMFredHfisiZBBnUBIFVr/VuIwzeo0TVAlS4A45XMZZ
OjHKKPTX7W95/1adAbSqPWQD3dj69fWYFfnhyY83q/NNwBtI2og6vc8MyB+XGrdk
vimfAP7ZXzan198H/7Dmov/CuMsS4Vk2DxYRRpENZPfOCLU1zg2mY4I1eshAgdcK
LXolrUv7sArK++56FxmC5hk8QFk+Ock+jbD59d+8GxcZvJlqpec=
=tf/J
-----END PGP SIGNATURE-----

--g72ilew4sutmz4oa--
