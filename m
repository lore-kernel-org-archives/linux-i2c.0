From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4] i2c: add driver for Rockchip RK3xxx SoC I2C adapter
Date: Tue, 20 May 2014 09:42:58 +0200
Message-ID: <20140520074258.GC27329@lukather>
References: <5192968.EzcUiXba22@typ>
 <1956748.HoDAyYWJMb@typ>
 <1547619.upPdAXDT0W@typ>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1547619.upPdAXDT0W@typ>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2014 at 11:32:55AM +0200, Max Schwarz wrote:
> Driver for the native I2C adapter found in Rockchip RK3xxx SoCs.
>=20
> Configuration is only possible through devicetree. The driver is
> interrupt driven and supports the I2C_M_IGNORE_NAK mangling bit.
>=20
> Signed-off-by: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>

Reviewed-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTeweCAAoJEBx+YmzsjxAglZ4P/RCAiHZmM8OP60R04F+ZMvdO
qvDPSzIpoyTmD1rdVmlBW/WyCCBQIk+i2BPidMm1YH1PNewcUQlwSDiquPgvG9sK
n3DkPmYFTOGPYDcD2F17h0iW9E4Y9QWM2/AeqGnCqGa2XkEVIxJoqXWrc/LZs/nU
/aGtmT+7wxsfjSiIBR+RppQ3J7jna2YKaOiJtBodxb6snaVj+Pt9NvljQsU15kA6
JGIxRwVdtCQHHKrFVuPTJVBgx3ZRGAuUaaS8VJ/mUd4800mikPoRlyVcmYuCFEM1
996MyS89hG3qpmdxxEZgXRXme46zK0QrSwO8K3mikOqk62KScS/IvtT0zsP+0UXf
k0X0SFNE5+iIl2O3R451pd2tprgMdqCeUXKYoIXz7AkZR3I7XAzAlnWZedqbyAI6
aOHzeo8cLh4765G2TY477rh09Q+DFSDfvl73Bi4r4k923oi2cbeBC52GdF6nHLtJ
zE+NjIqTw2V1nSkOWu0kUWViZiu3uINK4J6s6WcyHoP1g1g6ac0MhpeCwelatfyy
pON7TwfMD2PNwAcxJjVcbs0DjKxoD7yEYQDCYiADvSWqtcBKvClrlUzGM3EvLm8H
Ux3bdXaJM1/cdX4rdgeYbVnm5xEuF52Rxylh/2P5HCa+5FPvJmVKJxCkE3i2jPxU
fkfxowJW3LPLgNFgky03
=dKs+
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
