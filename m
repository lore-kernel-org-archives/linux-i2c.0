From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: [PULL REQUEST] i2c for 4.9
Date: Fri, 2 Dec 2016 14:21:49 +0100
Message-ID: <20161202132144.GA6009@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:54946 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752273AbcLBNVx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Dec 2016 08:21:53 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Glauber <jan.glauber@caviumnetworks.com>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is the revert for the regression of the i2c-octeon driver I
mentioned last time. I wished for a bit more feedback, but all people
working actively on it are in need of this patch, so here it goes.

Please pull,

   Wolfram


The following changes since commit e5517c2a5a49ed5e99047008629f1cd60246ea0e:

  Linux 4.9-rc7 (2016-11-27 13:08:04 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to dfa2ccc30e6556bd526f54f0e16fc9e5af4293cb:

  Revert "i2c: octeon: thunderx: Limit register access retries" (2016-11-29 20:04:21 +0100)

----------------------------------------------------------------
Jan Glauber (1):
      Revert "i2c: octeon: thunderx: Limit register access retries"

 drivers/i2c/busses/i2c-octeon-core.c |  4 +---
 drivers/i2c/busses/i2c-octeon-core.h | 27 +++++++++++----------------
 2 files changed, 12 insertions(+), 19 deletions(-)

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYQXVnAAoJEBQN5MwUoCm2OqgP/1nXs50VFHQe2yCh6lHCkBd7
ThUpXA4pAVPMbz7DmqXb4bC4nyVfYIrSlGO7BJUWlfpji7ZcSj59hwHzEXOCSNdy
5r4r2Y2mDR0acnVuk4l+0Ks5TEPdEZ0AvAfiUWMHl1qY24H7x+rDIEclbNFvmMhd
Meom5BAzF9l7jBolz48OPYR5JGY3xxyMycxe8aR5UglrSRdAlcHz2l+ae9Svl1Xy
hgAUcnL0xvln7a7dZDVPLKDADX1wU2xwWMMsmX5JqV9jy2//sNGYgUqv6L/e0KKv
tWZn8d61b8u+cdnnbASNOkshqsKL7nSv8yOeoUasy62ARwsbJbHgXbqn8DXZfL2e
/5Jdh6v4WUuakPYlMJU1CJRqFD9JEYSkmQgcWGi1696CTB8sXFpeZ5Q+exy4uzDJ
Bin5hhSptW+ys7Klp7cFHU0TpbDBhHH3DGwKA4OJSCNlqoaCEnqIHQSpEbxaCqSd
2wqY5BVoqpJulVt9plI4i0YET97MlW5JkUZEZPpA4owNab8q+oiFxAXx0xwxUktv
QRnyYwtVUOMf2Y8ma/Q/emcdm0lXjfak3rln8etWG9tFn6UFnGDDYFM657A70Tpc
t/W+rt/3jZJ23yyeK0NgmvSiRsDj9Jl8OfnyakyUCmmz6T90LJdlU0AbanDCGOEi
Yv0KzuAx4fqKVVTXCvQf
=l8HO
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
