From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: do not show SDA hold time warning when
 not needed
Date: Sat, 3 Jun 2017 23:25:53 +0200
Message-ID: <20170603212553.GA1532@katana>
References: <1492203192-28025-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1492502087.24567.47.camel@linux.intel.com>
 <20170418095939.68788787@free-electrons.com>
 <7b011e1e-8fa3-07c4-6688-5e258fd64dbd@linux.intel.com>
 <20170602201502.yobk7f7sdp34ez3d@ninjato>
 <20170603151821.736e6236@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:40336 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751193AbdFCVZ4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 3 Jun 2017 17:25:56 -0400
Content-Disposition: inline
In-Reply-To: <20170603151821.736e6236@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Sat, Jun 03, 2017 at 03:18:21PM +0200, Thomas Petazzoni wrote:
> Hello,
>=20
> On Fri, 2 Jun 2017 22:15:02 +0200, Wolfram Sang wrote:
> > > hardware that doesn't support SDA hold time. But needless spamming ha=
ve
> > > negative value so this is worth to fix. (I would do this as a single =
liner
> > > by else if ()).
> > >=20
> > > Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com> =20
> >=20
> > I agree with Jarkko on everything, including the 'else if' fix.
>=20
> I am not sure to understand what Jarkko suggested to fix, besides using
> "else if" in one line. Could you be more specific about the changes you
> expect me to do?

I agree with Jarkko that needless spamming is worth fixing. Yet, it
should be done as a single line using "else if". So, basically the
paragraph I quoted from him. More clear now?

Regards,

   Wolfram

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkzKVwACgkQFA3kzBSg
KbYpPQ//VwAHU4cndUoC9p8Syf2OKaFD81SaSBjABwQuZEjI1VONeg06QBg8tDE7
1fngd0j3jg6kUQU/hbn4PgyJucGyB59JLTcfKSCNNmj+dBtWt6ke+kvYeqoXBsij
shsVhqSB2Qaiv7yhX0JdXMtSsl6i3HAN671Ao86flD/BlW+zhynSmWX81Fz0OS+a
2/NJ3VZvabwl7Sb0uy/DYxul+fDpKmz5Su6eaZEjWwsmCJ8gBi5WSkIYxf4b9tx6
EXGv3iw9ge0DjgBq4IeZN09xDNED0RtEnAixfT2Z9Jgl10M+KpPUYQuUZ6pu2KrK
DYU3JPHJYoLlGH/nO9y8rxWhTe8GN7Dy7EDUgdl5n20s4B3tVQ9NlhFMG3VicH9G
WEp2gCcdF6TXSRYfYI8SQjEY1+AQ+OfIsdsVt/BVqL/m7BNqFxiHZpW9I4vvt8lf
wwZiPVX8mwferb+JT89C9TfLcNAz+i0cOwy+g7DQK3gs/riybAW2dOCE+Hb5ZTke
LJoZ46mBWzrjLx1sRa4t8NvctYiaa1cxw5kpue3ePVelPXL5OF4JNEIw85eN3BbR
a12hv12RTevA1S2Na6ijJdYmTL/Fhd0t4clWwHJLnzLzDxIVRFLxW1yG//igU3A7
QUZh+n+2Vqh3CillDP8sMqNRio/9VqlIeLVr8kSp1b2CTZZ1kwE=
=toMP
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
