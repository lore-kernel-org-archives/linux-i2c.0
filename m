From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 5.0
Date: Sun, 17 Feb 2019 11:15:17 +0100
Message-ID: <20190217101513.mmbztn2nopa4phif@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x4lbudek2j2la7in"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org


--x4lbudek2j2la7in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has two more driver bugfixes for you.

Please pull.

Thanks,

   Wolfram


The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to f275a4659484716259cc46268d9043424e51cf0f:

  i2c: bcm2835: Clear current buffer pointers and counts after a transfer (2019-02-15 09:45:05 +0100)

----------------------------------------------------------------
Paul Kocialkowski (1):
      i2c: bcm2835: Clear current buffer pointers and counts after a transfer

Shubhrajyoti Datta (1):
      i2c: cadence: Fix the hold bit setting


with much appreciated quality assurance from
----------------------------------------------------------------
Kyle Roeschley (1):
      (Test) i2c: cadence: Fix the hold bit setting

 drivers/i2c/busses/i2c-bcm2835.c | 12 ++++++++++++
 drivers/i2c/busses/i2c-cadence.c |  9 +++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

--x4lbudek2j2la7in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxpNCwACgkQFA3kzBSg
KbYYcg//eJMnU7nHE4uM843ahTp+WgduIAVmpNuBLU8RFadO7mNqdWCLlu2/rYDy
kH+c3KDjwur30Uk5YGQAXDWzaJr3gCvvwzJzJHZ8/19i4rZgHsfhx6NiQhY2OPSQ
foQExmLazsKy9TN+JGJp+BMxy6IuoRY8AFgrudAH/OQnodEL1JOdxtqqT/c7FZMc
f8X4rWrux4HUoamNiXvsjoDkEWEbWjSIOJ2Mz0rie7zpBiJ7sFDiG64NvrKZz0vq
TMF4cwl2fOqLObNOuCs5yYFi2mVBJ4e6UgBKb6TU3eOJ6yit7hEk6G2e3GbGQO2z
GqZAwhd+VnVlCa0Ryqkdy0yVHKs0TesMn3fL7LWcYGBk2VKJbakGyvjXoB4wjkRd
xOOOwko7yYABZJTMP41c5Q6XODVEeg5KzjKZhmEBpFrK+FIpl7PhR5bwI28JkWV9
FaLnYHeUWIEEQ9/xPx2waIycW7WbtHC1J/iT/71DyXBbqrLuzlSiy34AjeMoYS9G
16wxIefEXKfsr6Z0RMzaq9Sk4ES2+gxhefGdaqYsTMXWnWLMt6ABBdeiuGfFEigv
zz0VqEn67xbAeGYiFC0+PM9qCiG+Qhj4pg2xu6KqYmQSFY6UbbQkjEupbbralvwe
cXscXe6vxX91b2jfrZMaJd+kgRH2J+sOfz3WdpRQz+uAJNuXeFQ=
=iluI
-----END PGP SIGNATURE-----

--x4lbudek2j2la7in--
