From: Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH] i2c: aspeed: Retain delay/setup/hold values when
 configuring bus frequency
Date: Tue, 29 Aug 2017 16:26:49 +0930
Message-ID: <1503989809.5933.5.camel@aj.id.au>
References: <20170815072102.23067-1-andrew@aj.id.au>
         <20170828160702.x45hagij4kkm5zzc@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-5SFIj/aZuTWk4Ss2sI3E"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40899 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751219AbdH2G47 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 29 Aug 2017 02:56:59 -0400
In-Reply-To: <20170828160702.x45hagij4kkm5zzc@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, brendanhiggins@google.com, benh@kernel.crashing.org, joel@jms.id.au, openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, ryan_chen@aspeedtech.com


--=-5SFIj/aZuTWk4Ss2sI3E
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-08-28 at 18:07 +0200, Wolfram Sang wrote:
> On Tue, Aug 15, 2017 at 04:51:02PM +0930, Andrew Jeffery wrote:
> > In addition to the base, low and high clock configuration, the AC timin=
g
> > register #1 on the AST2400 houses fields controlling:
> >=20
> > 1. tBUF: Minimum delay between Stop and Start conditions
> > 2. tHDSTA: Hold time for the Start condition
> > 3. tACST: Setup time for Start and Stop conditions, and hold time for t=
he
> > =C2=A0=C2=A0=C2=A0Repeated Start condition
> >=20
> > These values are defined in hardware on the AST2500 and therefore don't
> > need to be set.
> >=20
> > aspeed_i2c_init_clk() was performing a direct write of the generated
> > clock values rather than a read/mask/modify/update sequence to retain
> > tBUF, tHDSTA and tACST, and therefore cleared the tBUF, tHDSTA and tACS=
T
> > fields on the AST2400. This resulted in a delay/setup/hold time of 1
> > base clock, which in some configurations is not enough for some devices
> > (e.g. the MAX31785 fan controller, with an APB of 48MHz and a desired
> > bus speed of 100kHz).
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>=20
> Applied to for-next, thanks!=20

Thanks!

> I even considered for-current but it does
> not apply there. So, I leave the backporting for the interested parties
> :)
>=20

It depends on Brendan's clock divisor calculation fix, which appears to
be in for-next but not for-current:

    87b59ff8d1d9 i2c: aspeed: add proper support fo 24xx clock params

I'd argue that Brendan's patch should go in for-current as well,
because it fixes a divisor rounding error for the ast2500 (bus is
clocked faster than requested).

Cheers,

Andrew
--=-5SFIj/aZuTWk4Ss2sI3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZpRAxAAoJEJ0dnzgO5LT5aeMP/1rp0owg8dov/DKlzF+JUiL2
UCsX8o0X+nnZhuoBFTx03yf4ghvxrzgQnH/gtCOTWhcJOV2Pf4S+aosaz99e0UvY
oy5MdNGXgerzNRbTbtfPCe7yzixEkFCHwcjeOF48jICq0pknA+JxQyotZnGvY6Eo
5RghPA0LZoqrgPw18DzFR0zuqcup17NjSdajFd0bM855FJZV93HlaTkN3Du+o2h2
d+6HqSm9ZWPZf47qwiOb2Mh5zxSXR7QhMfxQ1sBq659M0Aohh0Gq7dGT+hzdImJ2
5nlVAG8iUNZrzhiyszri+VFWz/L3SKhUMRKOSnIGEluGv7EfQWLXuFYB31WE1HqU
fJetN9uFjyfpp+GWwH7SAKcvdvio+sswxrgcki6o1p0EKk8NW8uV2coqY7CVMDIj
2hI0TJbWvjqAB9oYj41TOR5TTrUeVQJqtZeRaFkUKDYNSa8WnjD6BtZWiueVKVg+
t/bR/DKhvBxrHyqVg8zycD/MaFKowxn/N+PBz7hmpol6mD0g1byfsOReqvnRxU5v
JZA/TnmSw2R6y+hrgB2WehYuVbFLfe/7XLy39BwroDtcZ305VI0bGjspsCKoDK7m
LsFUhYRE+eZthZwFE5KDTxdS4VJd63pV2XkmP2jdOmlaw2eg3WBD8c2242yRbMW1
n08P6xrFanr2dgsHsLyG
=dYzu
-----END PGP SIGNATURE-----

--=-5SFIj/aZuTWk4Ss2sI3E--
