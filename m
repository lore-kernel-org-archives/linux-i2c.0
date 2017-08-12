From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: mux: pinctrl: remove platform_data
Date: Sat, 12 Aug 2017 16:12:13 +0200
Message-ID: <20170812141213.oimvophh766u4wxi@ninjato>
References: <20170802072728.24586-1-peda@axentia.se>
 <20170802072728.24586-2-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p6udk7m3ctvgujl7"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:43229 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750896AbdHLOMP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 12 Aug 2017 10:12:15 -0400
Content-Disposition: inline
In-Reply-To: <20170802072728.24586-2-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, linux-i2c@vger.kernel.org


--p6udk7m3ctvgujl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2017 at 09:27:27AM +0200, Peter Rosin wrote:
> No platform (at least no upstreamed platform) has ever used this
> platform_data. Just drop it and simplify the code.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Very nice!

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--p6udk7m3ctvgujl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmPDLkACgkQFA3kzBSg
KbYSpg//f1fWa9yUvOQ7Fc1XEeQ9O7/auMFlZbaeYUlQQuPY0Js1IIHoTlSOly1k
3HB/JkIHROtawCmFiM4qOyLdi6qPCqwFFdBx1idtARGz9X+dGfdznzLo/5ypOZBZ
MnwIP/TAHa8QgW1iE4yC52nlkwzkPAn1aFjs3TwGp18fog/hr1gOwqcD/k7Y43cT
jk7eAPHEOzxDcnJqebzSYGo4fIFTSnirANCIGDyzH1Rc5NlW6vDf7s5ClGLs3BID
ZPAY7xaum6eUKDA8DzGtJOA6fMAzydvwE4NqqNsnoQkDcXZcTuM4PxlzY7Aua+Ra
19yfVJHxebLgriu7fPt6RexKbgol3eEpwLpSqKqtA6KEz29pteMma5NORA9Q7kVt
RJMxLYbWJLIIqsKibdIeh2P2skT2UHaWIVEAwUe2EhEmgcvDDaSCCYO9fKWqtcTP
MAGQ5tBaQ9zKEEcQsIOKBtgrPulSFpdH2jd4CFl+qNJkue9sg6hzsiMXXFju4vMS
HwUHyT2s7bwzXnJCFOgDw0n+5cTqYphEHiAxJ6hYlSb+k+XGBY45qFgMPFwEOOGG
I+yWp3aRzNfWVcCyayCE56A3GbP2mCpZL6wJFVkoxGPW26m8Kh987ZuQz/MGMOTW
6qoZ1J+qQE0x+9kajvNXqe5wFgfNCnK3ouSQH6v3y2j/s2npVGk=
=SZVb
-----END PGP SIGNATURE-----

--p6udk7m3ctvgujl7--
