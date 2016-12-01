From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v7 2/4] i2c: pxa: Add support for the I2C units found in
 Armada 3700
Date: Thu, 1 Dec 2016 23:36:21 +0100
Message-ID: <20161201223621.GC19261@katana>
References: <20161201110440.27530-1-romain.perier@free-electrons.com>
 <20161201110440.27530-3-romain.perier@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:40670 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754724AbcLAWgZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 1 Dec 2016 17:36:25 -0500
Content-Disposition: inline
In-Reply-To: <20161201110440.27530-3-romain.perier@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Romain Perier <romain.perier@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yahuda Yitschak <yehuday@marvell.com>, Hanna Hawa <hannah@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 01, 2016 at 12:04:38PM +0100, Romain Perier wrote:
> The Armada 3700 has two I2C controllers that is compliant with the I2C
> Bus Specificiation 2.1, supports multi-master and different bus speed:
> Standard mode (up to 100 KHz), Fast mode (up to 400 KHz),
> High speed mode (up to 3.4 Mhz).
>=20
> This IP block has a lot of similarity with the PXA, except some register
> offsets and bitfield. This commits adds a basic support for this I2C
> unit.
>=20
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied to for-next, thanks!


--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYQKXlAAoJEBQN5MwUoCm2DxcQALOO1OqoKGUBxoU/m/NC5g2Q
mYZ5PnDif3wjUplvy88GjTMXSXAyBO96QDtCTxjj4zr4wIROoALISAXPfOvNEOTY
K+4gWo6yQ9to/b4HyeUnJVhZVH/kC6gFRw6VhIBi4UX2D1PO+Ua5UIv0T5B+mm8P
5pRriEU+wD5KaNyDMtzY78Tu8wthkyRfUwhI0BzZ8glCnP+qZTBeeHO781UD040g
CLzXdYWr2NayyKHCB7VqB0csPefOH/XQ2MT5g4f18zb0HfXhxoGQYFTZr7DaEliA
n9OWlkftuqksu3kEasMz/hHMJQyPm2t1uGfYIQ2B8IpwxkUCYjuOjG3LLE/AJASc
YGw/YT2Dy2ItjA0jSxr8SKpQp81tIWTOL2G9KzpnKfG2yq4So5g8+c/KlvozjkJc
Cm/hWaPN1orAW1naaJLEJ80lp4R3zXQMuDHRTi9qF9gUCGDiH6dGWQFS57C9Y9N6
clu5yAVlj5/wrdBc3TMEDWxeteKcollcjQsNQ9JM41SFnEPlihAwtRA42Z7SIYua
HznXVXhuDo8EljYCuy8K0hVK4XkujXp7LS9EMku9j1DSoqK/iTt5KzxSqnSYE7W0
prYWXhowI6uedz0e/m0GH703y0RtPBMq4aWZyB+Fd2/hwRkpeAREp8hjyP3RheXt
5NMF9BVSsqRfq9LivYxf
=m+n0
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
