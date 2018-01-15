From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/2] i2c: mv64xxx: Fix clock resource by adding an
 optional bus clock
Date: Mon, 15 Jan 2018 18:19:00 +0100
Message-ID: <20180115171859.nukvtrez5yun4564@ninjato>
References: <20180112103956.4875-1-gregory.clement@free-electrons.com>
 <20180112103956.4875-3-gregory.clement@free-electrons.com>
 <20180112105434.juefp2apuber3zti@flea.lan>
 <87wp0n5nw1.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="waalp63hndsbiftr"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40628 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934845AbeAORTB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 Jan 2018 12:19:01 -0500
Content-Disposition: inline
In-Reply-To: <87wp0n5nw1.fsf@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-i2c@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Antoine Tenart <antoine.tenart@free-electrons.com>, Omri Itach <omrii@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Igal Liberman <igall@marvell.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, Hanna Hawa <hannah@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>


--waalp63hndsbiftr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Are you sure the i2c controller is on the AXI bus? It seems more
> > likely to be on an APB bus.
>=20
> No I am not sure :)
> Actually I don't have this information, so lets call it "reg" for
> register clock.

So, I assume a V4 is needed for this series.

BTW would be someone from FreeElectrons be up to maintaining this
driver?


--waalp63hndsbiftr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpc4oMACgkQFA3kzBSg
Kbbemw//e2nhq5XLDrku1gt7078TXjUu75oLOWxvVPmQE1lzHlmEOA5X+6gth+63
aZgnzaHy2Q9mvTV7C5GTEZfhQgLc8vCkKyq5bTMYne1oox20so3Q2zoClBGohPBV
608//qWsAUXhsKEUrtgBXf8EO6rF6k0XqN6mHX0fAziBfvxGWZ4EHV/M4yMO+vBQ
yzx7nmzqwNvHD+UO3I96eBc1Lm2dCwOgIo8+Qr2DTEvE7mIkiWdoxADXrFSdVufr
6fSb3YJwjC3X6GmTM4qHTj7Ub8C9ldv6KSmDi26ZDXVpoy1fhYwYyk6xLyR/Ml4r
gPpO+NRiIpR5vrH3wZilu4qwcewQpPcVUW4c6wZI7iggeFpKpABIO48oYlPhvweq
QERG+ioPCXjKiL2AgoL8bY00sLSQm1MZgto95WCzxLSui2r+oo3SnCkcNIfMgsEb
5GIGrCRIjd+LkxJCHHCoHUg04+GKCNUHPG0xOLrsc614YsixEAXEYAXTT0R+pvjG
X/G1wLD64xBweIcOd11DDMg4GIvgOGDowB5O8lkBl/ag1IVkXT+CyPUPo2SVzcRy
aycyqBkVrGVGR1F09RO22rxOm+ckcgspwOJk5YTKE5PIg9tQ5eoQGpd1HlLw+pBy
Nobrfqvo3PBy9HXXNSv401RGFg6MNb4TmFkdGHkMqR9PUy8BfpM=
=/tV5
-----END PGP SIGNATURE-----

--waalp63hndsbiftr--
