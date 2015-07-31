From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: change dev_info to dev_dbg to reduce dummy log
Date: Fri, 31 Jul 2015 13:04:43 +0200
Message-ID: <20150731110442.GK1522@katana>
References: <1437985615-30791-1-git-send-email-b38611@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vk/v8fjDPiDepTtA"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437985615-30791-1-git-send-email-b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fugang Duan <b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--vk/v8fjDPiDepTtA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 04:26:55PM +0800, Fugang Duan wrote:
> For most of imx platforms, there have no DMA support for I2C bus.
> So, by default, there is only cpu mode.
>=20
> The current driver to check whether there have DMA channel config in
> dts file to judge whether it support DMA mode or not, if doesn't config
> it print out "can't use DMA" for each bus during probe.
>=20
> kernel boot up log:
> i2c i2c-0: IMX I2C adapter registered
> i2c i2c-0: can't use DMA
> i2c i2c-1: IMX I2C adapter registered
> i2c i2c-1: can't use DMA
> i2c i2c-2: IMX I2C adapter registered
> i2c i2c-2: can't use DMA
> i2c i2c-3: IMX I2C adapter registered
> i2c i2c-3: can't use DMA

Let's just drop this message. There is a success message when DMA is
used which is good enough.


--vk/v8fjDPiDepTtA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVu1ZKAAoJEBQN5MwUoCm266IP/1YE+eXqK0kLWS4PrLXjPLz7
AlR/HLmplsHo+IYNFnLcOuY9ojLsGYpiBqqgGGwAJFQBNEr4mzM4YJLHTOZAd80r
VfRBnN3v2LIS5I/0RaNsXjKjo3zV93QE+mI8Qp9gufIwptaMhQVnVQkMTbtoAz0M
fFNc6GlQHFkJTBnaw7CwtLni5e6Ycylc7UeA3MmJ+MSdzB5+5yx7NJi5KMH6p58I
+u9Isfj+RFLRB6e3Lpv3Ddw+6XWTRyjYEYZFBq8s4ySkAgTR1J92NXLiKLnxzBOp
Htrgw389ID6QYh6xvfVF8gcdqvZYa6iMDolamxoTVuQ6Q1aOQN5tpQHunrFLl39m
+6n6Zp1whbpwtD4HsbVMVWomQp+fNr4Nx0scminoSiC0inG5ktNSwCfdzp4XYK7/
Fnjp+wi3Vk4KelNmMycrzWx5PlboOI09A9rr0h1frQfiaKNSVm7J3jLEhHZ9vBgM
5EZZWQ/Pi4BAVt1n4M6TrPjmyfGGcun/NqiWu9G/jald95Mav6uFSbcvtilheQuV
tc6MtGBUUlQtwiDEU7MWlUdp1j+Fezj1uMbjvY4X72fH8gDDrqbfPEDFoJwhl0bH
u5l3h5XE+RyF93zvua1alWZ7VtT4QY5fO4Di55TGAOSPCEiKg9AwetbXuCJh3cDe
EmAS57Pcoz3qXnpgp3ji
=4s3n
-----END PGP SIGNATURE-----

--vk/v8fjDPiDepTtA--
