From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: scx200_acb: avoid I2C bus overclocking.
Date: Sun, 25 Oct 2015 16:47:49 +0100
Message-ID: <20151025154748.GB23308@katana>
References: <553955C6.3030000@secomea.com>
 <20150602182134.GG1494@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46324 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067AbbJYPrw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 25 Oct 2015 11:47:52 -0400
Content-Disposition: inline
In-Reply-To: <20150602182134.GG1494@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Svenning =?utf-8?B?U8O4cmVuc2Vu?= <sss@secomea.com>, Jim Cromie <jim.cromie@gmail.com>
Cc: linux-i2c@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2015 at 03:21:35AM +0900, Wolfram Sang wrote:
> On Thu, Apr 23, 2015 at 10:27:50PM +0200, Svenning S=C3=B8rensen wrote:
> > According to I2C spec, max SCL rate is 100 kHz, but SCx200/CS5536
> > controller is currently driving it at 214 kHz according to my math.
> >=20
> > SCL is derived from an input clock of 48 MHz, which must be divided
> > by 480 (240 cycles for each SCL high/low state) to be within spec.
> >=20
> > Signed-off-by: Svenning Soerensen <sss@secomea.com>
>=20
> Thanks for mentioning that it fixed a problem for you. I needed this
> info.
>=20
> > +#define ACBCLK		240	/* 48 MHz / 100 kHz / 2 */
>=20
> Can you add a comment where you found the info about 48MHz? Since I
> don't know the hardware at all: Can you imagine that there is even older
> hardware with a clock where 0x70 was suitable?
>=20
> > -	outb(inb(ACBCTL2) | ACBCTL2_ENABLE, ACBCTL2);
> > +	outb(ACBCLK | ACBCTL2_ENABLE, ACBCTL2);
> ...
> > -	outb(inb(ACBCTL2) | ACBCTL2_ENABLE, ACBCTL2);
> > +	outb(ACBCLK | ACBCTL2_ENABLE, ACBCTL2);
>=20
> For consistency reasons and to be less intrusive, I'd rather keep the
> original chunks.

I just remembered that this driver still has a maintainer :) Adding Jim
to CC. Maybe he has some more info? Would be sad to lose this potential
fix, yet I am careful to not introduce regressions to this old hardware.

Jim: The rest of this small thread can be found here:

http://patchwork.ozlabs.org/patch/464046/

Thanks,

   Wolfram



--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWLPmkAAoJEBQN5MwUoCm2POQP/iuJhWvJD8EO5L4B4sM+l7XL
BLiVowFBzQ8W78vGXGXBM5Be+f0dRh6Gc6BbywCXllkCkj3q09DG0hzthIQC5Ewo
iwobCtY3KIDbIY4l/B15tAwOfZNesTRJLU2aJgjahxRj3AD2ojbfbCVU9PDs8Y4I
p15v3W0QhQGXzvm99gWewEkZMFimYq7KL5JgviFTuV9Txde8Iwt6RiZQAOl8fgqf
ndPPIO/O531VL6QGp5CE4j4tK6f1Ic/FGhg+QNy9J87mTyZYsrVLxmn0hRd2wSua
jiwbVbq7GvVlEpdwQ+QVu7TKHVDZRZRuBOutyg5wskaU02/O0ZNYiIw9aZe3eFo0
Du53ReCFDuCy5zXGg2g8h1WcLUwHwuE9c3k0j+jYlTBSj1nJHoFIf3cy1qb2+FxO
aMrLx0gVn0vEYiedr3OoA73WuOgb4UY1RA9T9Ycf4OaoDJihhorL+tCNn0Z0hTS6
5gXAHzSZ1XNqFaeCBUCZxHy8iZzAdeh4L38obA2gYc5L9vIOqM/5MprRBvo1sHiu
ClUFLWVJZj0O9+/tzqQyuMlsdBzQ7U/JkEhgTtFwkbLosgyAXgf4rpvawA9dhX49
A+SZmx68r4XgnWpNY3NncyU82PHU7lKKDDXNdJ3kC2uaWFY7ngSMH4TDS3fKJNoO
jj5t9gsV1G53HkEs30wX
=2+GF
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
