From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: i2c-stm32f7: add PM Runtime support
Date: Sat, 1 Dec 2018 00:16:03 +0100
Message-ID: <20181130231602.GB860@kunai>
References: <1543329331-2471-1-git-send-email-pierre-yves.mordret@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543329331-2471-1-git-send-email-pierre-yves.mordret@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 03:35:31PM +0100, Pierre-Yves MORDRET wrote:
> Use PM Runtime API to enable/disable clock
>=20
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Applied to for-next, thanks!


--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwBxLIACgkQFA3kzBSg
KbbFUBAAh8qdHFxWwwJtTmJtHchfy31L3bwIYg4O9x4mHdo6CcAyBWQ69gSaFM1Y
S7cUti+/UyNj61umr6rXiy7/FlOSGKOOvV3KeSEfvJ9ElEiMtE9fRdNcft2NOGin
aAy9O2gm7TuIRf2V/kmylQkCyVbMUxH9J8N3huwM99/BcBmxl9IDTFMtWCL3GLel
cckpFJ3c4ZbF1VRfFPVKhYJ4gvGCt3xG2EdTUNvf6lHizZShIuAFLXlnyVnxh0+o
qKFWTBaDQNnnwiBQXV3FYyrpSpHrJwkcDf9QQoaL1uvF+ngh47W8cY7GPOt2sAtI
46OxieAkBte8fitAavZAI5WArtMY4IPITAuwrQyqEpErKQTNhbXM7nNUUsG5XLwK
1h86+cvOTZawSAuoMqdmnxAocyLIq0AvxIT5gxf05JUjZrQ4hIOO5CzTUe/Yvq1T
8PQzyuvCYjDbHae2lhOGUhffdLRyoWwwEqD9uFGhmxXoSMsIEN0UsRi7+XRvifcc
ulMjVNTaV/3HQY2aMl0Fv86LLCMboHJudO03tOeWTDA1rD6b1lJQI1WBydYfVJaB
Yf+T7kmWydYCzYIhT8kr91ALPitBGGIeIYt0ZxkkEPTKonGfty93tBgzWuGxCwJX
mPJt3W8jm8uWUKxzvbRSB7b3IV2qcsEHxlJjVI33C4kWvNMQU88=
=Zt3W
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
