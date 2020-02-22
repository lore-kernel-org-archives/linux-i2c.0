From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/6] i2c: at91: implement i2c bus recovery
Date: Sat, 22 Feb 2020 12:33:58 +0100
Message-ID: <20200222113358.GB1716@kunai>
References: <20200115115422.17097-1-codrin.ciubotariu@microchip.com>
 <20200115115422.17097-3-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:53062 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgBVLeB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 22 Feb 2020 06:34:01 -0500
Content-Disposition: inline
In-Reply-To: <20200115115422.17097-3-codrin.ciubotariu@microchip.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kamel.bouhara@bootlin.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, robh@kernel.org, peda@axentia.se, linux@armlinux.org.uk


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 01:54:18PM +0200, Codrin Ciubotariu wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>=20
> Implement i2c bus recovery when slaves devices might hold SDA low.
> In this case re-assign SCL/SDA to gpios and issue 9 dummy clock pulses
> until the slave release SDA.
>=20
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Applied to for-next, thanks!

The implementation is very similar to i2c-imx. Maybe we should move this
mechanism into the core somewhen...


--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5REaYACgkQFA3kzBSg
Kbb/5BAAjIRoPQE9LABWbJpndp9jLdUzU84jFgAC8Doa8diKtDq4FRlalY3b3N+D
ciV1rCm+jDxHbvrtSkzoB4zzqVwoHbCYG2UqCDeb6kGQW+64oCn2PaRGETahlzTt
t6xJGm/VCwYNoDOTlp6M27TWtP89PAIc2byd6YgejLdkPld5gfYatdWT5WIv4zci
ayDRoh7drxaSKT3umNfixWaafLSLnrVP4ylTA+2FZ2mgp9luw6y6scnSj0Yyk0do
elir7QNRItWLYJdtEI5oo2Jfm8wII5P0V3MMS9RWK3diOheswZBdJuX7mEMHXHLz
7hqFRGpkW9U0/7kXfFaLBQWJFAANZeoNHVKg7MyA9rIbRwAqrngy6uVwZD1KPtxn
DIYRKZotx/PNmOOaZEMGuwwU70vM9ff0b/ZOYQtYBTzwYDDirXO/ZGipUFLyfaIl
sfvCQB6FNb8f8qQpOip20ecYjorUP4duRY2kK0ZTvfqJQTyQi7ziRPLVSB1ukNv+
LG8jlj0RyWojDK/jl0lTUW4mbncWkqBMhWigd5nIJp5qAGRZLfCjKW+xhGos7CNc
AJAYLMyGhVazIidpUhju9zqqsTMNXVLwbmwqXd76TmK4hhneqjJqN+uRndSiZNY8
EfnrgyJ6mdYSBxh6MhBZ6fw/s1FplEMs1SR5aOMN1LzGdYIoQg0=
=BEk4
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
