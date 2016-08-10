From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: slave framework support for SMBus Alert
Date: Wed, 10 Aug 2016 10:26:01 +0200
Message-ID: <20160810082601.GC1607@katana>
References: <1470787373-26738-1-git-send-email-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40588 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932173AbcHJSCX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 10 Aug 2016 14:02:23 -0400
Content-Disposition: inline
In-Reply-To: <1470787373-26738-1-git-send-email-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: linux-i2c@vger.kernel.org


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This has been tested with a slave mode driver I am currently working which I
> can provide upon request (I am planning on submitting the driver as well, but
> it part of a larger upstream submission).

Thanks for the patch.

When adding features to the core, I need a user for this feature
upstream. So, I noticed what you need, yet the patch needs to be resend
together with the i2c slave driver for a full review.

Regards,

   Wolfram


--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXquUYAAoJEBQN5MwUoCm2GDQQAIuI+736DabO9Aa41y0jbV4Y
0YZfpt9rUuNyVpbZxkffiykkZdC91tIXzLAK7pRjThiokY/XPO+oXyQxn9GJOO/x
RPrlXRJNPBz7fAgTChnshkeV2gLDau+8lkbqlj1Ihx6Yd7oUVH1E21/ArUS9d3hD
AylTOKQnCwJYp84/2Q8iE3y5Gd/4Q6FQI8fMUR8dA7HMbTaSd2mN+4iEJhgZD7IO
mDYtVTI5lYEtmxurCurXeqG9YpxSwO/UMSx0h3MSVyCtBHN4U+kQL7BAp+PMLL1p
yMlYOQNhTtAXzMtb11+Q5KS8WYEKp0aTOPPlqhe6QPFvN+r9RwIjoyiOHXOgHGOc
BbwjF7MS1MtQtKUVeRnOZ1EeEkzgYTHfkitnH8A7CmdqZ3GByPC/pSBGKij5GpgF
voewRkdPHWnJybnwaVNdYgChP8du/nYQKVjGeSa1CQUELKorEUuMJuU1m5cEva0t
RkOKfX889oY4jGHNvMo7zGYcm+Ew9BCcmZAUik05Kf4bqTtzjl6xOHwVEmUX4DtI
l0A5cLLnj+95lJjBY41GO2+6ibF28Hg9NigPifTS036e9bkvwKQ/ieSa26lA4zQU
kSUpCkrMvP6dDrpWxpHI+ljlvxuGH/FWd8Q+o54qEN5dguhK4vMpgK+/gaeJ7AWS
ZxyZaRfoiPlYKqeAcZYi
=6tgX
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
