From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 0/8] devicetree cleanup for i2c muxes/arbs/gates
Date: Thu, 25 Aug 2016 18:22:17 +0200
Message-ID: <20160825162216.GE2856@katana>
References: <1471268431-5148-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46030 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751393AbcHYQXn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 12:23:43 -0400
Content-Disposition: inline
In-Reply-To: <1471268431-5148-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 15, 2016 at 03:40:23PM +0200, Peter Rosin wrote:
> Hi!
>=20
> The nxp pca9541 chip does not have any devicetree bindings.
> When trying to write such bindings matching the implementation,
> I stumbled upon something which I did not like. I had to
> give the node holding the i2c child bus a 'reg' property that
> is left unused and is really odd to explain from a devicetree
> point of view. It really is a leftover from the fact that linux
> implements i2c arbitrators (and i2c gates) using the i2c mux
> code. See this thread for history [1].
>=20
> This series resolves the issues, and maintains backwards compat
> with old device trees (well, one could, in theory, create a
> device tree that would break with these changes, but my guess
> is that the odds for that happening inadvertedly are high...)
>=20
> This should also help Crestez Dan Leonard with the mpu6050
> series containing the changes for its auxiliary i2c master [2],
> especially if you also consider the recent (very similar) changes
> from Jon Hunter that adds an optional 'i2c-bus' subnode [3].
>=20
> If this is ok, I will follow up with patches for other drivers
> so that they inform the i2c mux core if they are muxes, arbs or
> gates. As stated, they will continue to work with these changes,
> so there is no huge rush.
>=20
> The mux core does not really need to differentiate between
> arbitrators and gates. Should they be folded? What to call them
> in that case?
>=20
> Changes since v1:
>=20
> - Fixes and additions suggested by Rob Herring (3/8 still needs an ack).
> - Inserted patch 6/8 so that the two arb drivers support the new more
>   compact dt syntax.
>=20
> Cheers,
> Peter
>=20
> [1] https://lkml.org/lkml/2016/6/27/203
> [2] https://lkml.org/lkml/2016/5/18/355
> [3] https://patchwork.ozlabs.org/patch/641934/
>=20
> Peter Rosin (8):
>   dt-bindings: i2c: add support for 'i2c-mux' subnode
>   dt-bindings: i2c: add support for 'i2c-arb' subnode
>   dt-bindings: i2c: add support for 'i2c-gate' subnode
>   dt-bindings: i2c: add bindings for nxp,pca9541
>   i2c: mux: add support for 'i2c-mux', 'i2c-arb' and 'i2c-gate' DT
>     subnodes
>   i2c: mux: inform the i2c mux core about how it is used
>   i2c: pca9541: add device tree binding
>   i2c: pca954x: add device tree binding

Applied to for-next, thanks!


--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvxs4AAoJEBQN5MwUoCm24rwP/iHe6a6TPC1Vfeb8qXAyqzQ5
a+QVbUrF+LCtKm5YEonb03SsVOGwG0fBxb8Wz6p4T4x438urNmcheTVDZzvFAT2t
haYpaJLoTdFjSRN5n+eI1akuWKGegoearXAU5pGHH5MzwXEPhCPExsjg6KzmcwlR
e8uSLTPcZanw27PHh5OYnf+F25MSjP5ZzmJhyBnEUqGkBysSU8/ECCwpnVx/Rvqu
D9r4dj1B24mt5gokmUWlpEy+95Cuf/Yz17UIgl3KhEyvTyLVdPvv4Nntohh83aKQ
W+FQd0yBikNmubKKcuMtGs3gmPxBL0g17SOVQ6NY6VhtZrSPUMBaxvAQxq5V66Qx
y9Xof+RP/CqCpD3fuKGBKZA2Q03hC5X6FOSnFWAWJwBDtOcN0dixY/zmP4yRGfFj
VMl7cfjAuFXy2xFFWhXtbTA8xkWLyDWfUpHYuv3j35QWPb7eqYxq1Ri40twpeMty
F/BuutvPsWiPjdiCxhWexLiEgyVXLY0wbSgse7Bn9IiQabxe3S99d0KOUXF09fpF
GIztQi0CyhT2zILnRrCENpuaYbWTRN6RaKJghsG4lwDJMnX3czG1Y0+F0RRUNbwf
lD/BAgpMV+Tco9pddpeeWRF50skFRBQVknBHQXOkoHiMd+W6W4fsN+5rl2P4/Dz6
M6IIdSYwX/GD1gOQ+N0o
=6hP+
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
