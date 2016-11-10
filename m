From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: octeon: Fix register access
Date: Thu, 10 Nov 2016 21:17:31 +0100
Message-ID: <20161110201731.GE1585@katana>
References: <20161107200921.30284-1-paul.burton@imgtec.com>
 <20161108071337.GA4601@hardcore>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161108071337.GA4601@hardcore>
Sender: stable-owner@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: Paul Burton <paul.burton@imgtec.com>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2016 at 08:13:37AM +0100, Jan Glauber wrote:
> On Mon, Nov 07, 2016 at 08:09:20PM +0000, Paul Burton wrote:
> > Commit 70121f7f3725 ("i2c: octeon: thunderx: Limit register access
> > retries") attempted to replace potentially infinite loops with ones
> > which will time out using readq_poll_timeout, but in doing so it
> > inverted the condition for exiting this loop.
> >=20
> > Tested on a Rhino Labs UTM-8 with Octeon CN7130.
> >=20
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Jan Glauber <jglauber@cavium.com>
> > Cc: David Daney <david.daney@cavium.com>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: linux-i2c@vger.kernel.org
> >=20
> > ---
>=20
> Acked-by: Jan Glauber <jglauber@cavium.com>
>=20
> Thanks for spotting this. I think this should go into stable too for
> 4.8, so adding Cc: stable@vger.kernel.org.

Shall I still apply this one? Seems to me that 70121f7f3725 is still
under discussion of being reverted?


--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYJNXbAAoJEBQN5MwUoCm2z+wQAK6jROLXhNiQVSYlIiRxi6//
jniKiwcgArjuKY6bQsnA52WriObDUdgSUPAdTq/LwdobNfOKl40ZDEcQHVKRgE5Y
1Fo8CdPICsQ57NyxTce9F31AEQrWc8oI8NBEQLUPf/27CSfDTG97p0dbt4ATQSSs
Khy0NOanLXB3qn5Uc+F7HNny4vnYkm9IkL4hgWlx2Sbg6/VZCzSpthTSmXH4Mv6h
Iyw85NHtRTl/vIQQr3S/+2Os0V8ofixtyZkD8TiwiCy00hzHLhG96oUvqoR1UpTJ
GZ15ENG/Ci1MA48YSukrkZypQehzHZV1jP7Sz4TVDUFYXr9Riu39t/io54Gt856B
3LYqzX7SApBE9TKYXBTda3M5/y5bj5g+TtSNUuCTVt+S/zMUfHyY31DyiJ751mw+
pBayXUBvSPtBpC0TyBGCNCH24Wk2IDqLvxC+xZm7Hr95joJ2dXdn07ESumPkKCke
7Wik2QA4xkSZb74sgk3JlRwYX1XSqMnxjnNL/PR3OoaWd23wcaORMq3Jb74x+8jE
d20Qsy7/Ts3eTCOd4RoEJhmTmNY+0TLBAyQJ0LjAQb1rx4jiR3eQqOH5WZZvSYsR
Z3xpGMiyVzL3dro+6V7+ORwmrZxUaWG8lxc1vBVcr2vP6V5kE9l28OthEDDllDFi
RhrZYNN3+tU9n3C1CMJX
=Fbbf
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
