From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 1/5] i2c: i2c-davinci: switch to use platform_get_irq
Date: Thu, 4 Dec 2014 19:28:18 +0100
Message-ID: <20141204182818.GF7944@katana>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
 <1417448047-15236-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417448047-15236-2-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2014 at 05:34:03PM +0200, Grygorii Strashko wrote:
> Switch Davinci I2C driver to use platform_get_irq(), because
> it is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ, .=
=2E)
> for requesting IRQ resources any more, as they can be not ready yet
> in case of DT-boot.
>=20
> CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

Applied to for-next, thanks!


--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgKfCAAoJEBQN5MwUoCm2vN4P/25C5VmYsVkyFkSbuNq1PsRU
dbD80jYu/s/kzQ3e2tLBIpwEPvjxrqFUZ/EDth9SK5h8K2LOkPAwf3fkeKdePOxP
VgeG6iynQLsT1RpKmbRABSOMYAQLscYR21/z1u8m9xRHYGmiMCO2B4TkP4aOCq9A
pGkBeuFRWm5wuXvO39/Lc0heWwWk3DluoUAx/NdkyawxtikqkAwZmgjaMhjFGK8o
pJB2hiy9IpptfGzN1Rt/Ffxliw+DQktnWw1TdZaO0N2RZ2852j1Q0yAp9gBsAf1N
drZj8ZwMnCWHtVrfs/NKrgx1Bds/w7LJfrQ2jIT2QQoVTuHc0n8stV/tufcPzqQw
lhGSU5YPo0rTk3Xcv8jiyIo1oDn45rITzx80ChNZ/iplulZoWR015KbrsQWCBM7s
4ri2m33Gzq8HGJQ4nZq8EykBC+K7kI+jey9AbIeiiwgARxw3CQmAzdzn+CSHHvgs
V52grVQawAjEbuXhds/5sslrCwLborBbaWbZ30aV36HSyH8sipShMzsnpYR2xJmM
4Hwxfr7W5cU8IcMpDPr/yYzSjksChXXrxUnLLsUVYcHb5fL2blbtcipqHUAY2Q18
601YadQ8UXAsKba6U2b1Q3W87OZCvLWkUlKanMaLaHtmXxfmFzsvBNTOY0+PHrJy
nxL7dtE5fKQrHLfJpq1R
=vkj6
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
