From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] Revert "i2c: imx: improve the error handling in
 i2c_imx_dma_request()"
Date: Wed, 14 Aug 2019 11:52:53 +0200
Message-ID: <20190814095253.GC1511@ninjato>
References: <20190808210136.10294-1-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190808210136.10294-1-festevam@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux@rempel-privat.de, linux-imx@nxp.com, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, kernel@pengutronix.de, cphealy@gmail.com, andrew.smirnov@gmail.com, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 06:01:36PM -0300, Fabio Estevam wrote:
> Since commit e1ab9a468e3b ("i2c: imx: improve the error handling in
> i2c_imx_dma_request()") when booting with the DMA driver as module (such
> as CONFIG_FSL_EDMA=3Dm) the following endless clk warnings are seen:
>=20

A bit surprised nobody acked or tested this patch, still:

Applied to for-current, thanks!


--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1T2fUACgkQFA3kzBSg
KbZnvBAAmEk80qUX88ybzLbMMbcb6Dye0laI5GuoIQwEDmKBiwvwlBHfR58oD/mp
Umf7UojOEfg2HRHrfURZ/DDBfxdLN8k2uPITqV7vwEaOsG8X63VUq9Q5xtCqwlfo
fcpsgsDQb5mlXu/ZUSjJebTo0IB9oupHeEIgy1wbunyU7T7gFQZWVRiCJZJTkbRV
NdA0y/QpUVz6PnsD/c5O9Wmh6I0qhfDk2gMe81Du5ehKYoy7WAFK3RsgUb+AfXQR
N69twC00dhwpup6UYatQ+lmKzIbfplZrsXZJEawV3sJMea2IDh5W5g/l5DgiZpPz
mrANfat/cNOkaK5uWxGGCIlsmAXq0EyiyCIzlInwMdA399+or3nC0pTw7MH82UCa
yZU18kvz8P8ceZ+hSpnYnWD8OftyXrmQlrBkqvhf5xHnDTgKjex+jgfnVMe8PmSl
wErzq5C8Z1XP7wL+5MCnVGzbxepCY9Rjxs+n5a9qyzOGJIPR8YosLPGXFqUBLPMF
rEagRDcFw4F96hpDHT1RBp2++G0WcS1V81DkCtxZYUOFibfyTooCVNRP5thYo6oC
GLBvs1RJDPOggPNirkSkSiUlPaKyoJ25xeqAIy6gjrend5aJl8DQc8QibLvMFXK6
TVGmwq1lVPVI56/0q/l6Z/dOmd34X9C0RNPg6LrfM6dK8cvUcWo=
=OuCg
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
