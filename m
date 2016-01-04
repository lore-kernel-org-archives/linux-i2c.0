From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: retry transfer on transient failure
Date: Mon, 4 Jan 2016 20:49:49 +0100
Message-ID: <20160104194949.GE1522@katana>
References: <a34c8973420a179cb195ddcfbb29ef1728f32ba3.1450889004.git.baruch@tkos.co.il>
 <1451320480.30729.351.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52968 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835AbcADTty (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Jan 2016 14:49:54 -0500
Content-Disposition: inline
In-Reply-To: <1451320480.30729.351.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Rolland Chau <zourongrong@gmail.com>


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> After that, introduce a new property 'linux,i2c-retry-count' to be used
> as retries field in struct i2c_adapter.

Hmm, to be honest, I always have difficulties with this "retries"
parameter; to me "try x milliseconds" makes more sense than "try 5
times". It is there for ages, so we have to stick with it, but frankly,
I wouldn't like to expose it too much :)

I'm okay with the original patch putting some "sane" initial value. It
can be modified at runtime via a i2c-dev ioctl if needed.


--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWiszcAAoJEBQN5MwUoCm2zkkQAJ+G79T5wZXFWd+hWYhzSyoH
YLh9O1H0ctkZq3S5jB/uP/I1peXUOX9tkMpL6zgbvXdGADWeX0QeFipzlY+alxkw
Jw++mghh8ZhtwEPrQY7AmyoxbOxRHGTSM97hxsh3Qht4+3OXuJ1WzbZqmpRtPbg6
cc4R4RWzvzQP8UZOF7sHfWwtbZSa+hTHc/4hWwu0EUYavS8I34eG+02lwyL5L4uG
Os0QQjOe51fSt+4fKRuN0+fObyGEuU2xCPEI0uAKwHnw2WeGxhjO3T4GpztZWNm4
y9XieUolkLmvp5Uac/jYwlFYUNee5Xzfb98L85elY1kuSNqp42RutD7+PKjVAy5k
WADedRwepCvtFRemVW9fPtrHQWKCe/gjw7KYECIT2QMxUjbdi7qU0iNnySfUerX5
RcvVq8ep9Ri5B3FKX9Nyz4mhv9uXsnOuKn/QbkPEh+myu54Lya6LqRfAYGNdasZJ
wqMqPncx0Qcu7aZ6jAxnizyyioz0VprVHrnDKmauPPkQn9F3Wrw/BW7wareT4RMw
VKp4popgn0L2VpIQEIPLRJVhLhfr9+GOmX4k4Cm9FZjkwd2eePFujuqX7b/mLgyt
b12vSz3zPMLAEisPLbAtqKJ9AVXmP3l4mxx2URfM2N+6XXGA7pzj7ssULEBgu8Mi
IpZ+WXoTwSwJoIgFOPt8
=1FG4
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--
