From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.12
Date: Fri, 19 May 2017 22:40:30 +0200
Message-ID: <20170519204014.jumojwrdw6lfnycw@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yhn6wjqi2kohiasl"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48077 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756733AbdESUkc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 19 May 2017 16:40:32 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--yhn6wjqi2kohiasl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is a regression fix for I2C that would be great to have in rc2
already. Based on your tree from today. Please pull.

Thanks,

   Wolfram


The following changes since commit 8b4822de59d5d9919b9b045183a36c673ce20b73:

  Merge tag 'md/4.12-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/shli/md (2017-05-18 12:04:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 9d6408433019bfae15e2d0d5f4498c4ff70b86c0:

  i2c: designware: don't infer timings described by ACPI from clock rate (2017-05-19 14:36:24 +0200)

----------------------------------------------------------------
Ard Biesheuvel (1):
      i2c: designware: don't infer timings described by ACPI from clock rate

 drivers/i2c/busses/i2c-designware-platdrv.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--yhn6wjqi2kohiasl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkfWCkACgkQFA3kzBSg
Kbb27w/7B2xm4uOX/mOfUM0Ofp2GjshZwK35qMsSxrcbYy+0EPZMUZkSVa7G+mCJ
eLHSAvt9NYlXxOubE+LzwXL3h1KlcqcOr4rroTh5aiQr8ljfT2Mzrz647d/ZhCwP
g0gURhh7ZB4Rk0eUJ1bQQMJvqLomj6Xmfeh7naxZG2Cisr8xavVvx6F693JBVUt4
IetcELSunhKLqG18WKD3zI8J7xAeGJIB4Ol/+3AUxoF1AnGUSho+FobtwAM+punF
QYZpBgx6uPgu4tIpn0lHbg6OVzLIeykl/cWfNF6zJRiJT/65y2FVH6HWudsHBL8M
KaK3vLIgVwSORkg2t0viA4u18HCH7D/phJq++amRw/r+0zzkNJQdhDLJc7M5Tgl/
R9gQ2WQugjcdKBB8RUnn9FiK+JYY/39MqyR7CkCG2UYL3s5/IINwZcUdE5yzNRP3
mrK4XPbB6AoiINgOBZspdbwka+jJ123eEdw0uGSTd56IIqSSOtcMAQnfO3YZk0lm
lOWpqpnkjhZ77+EMN3J58kCFW90epdrYIc4RBGeQytA5E55WWQl3szsB+OpvCicZ
SEGPJWdLT5wUnKglOlr7tYVrU5uxmEOJ0WrHxpIpEk6SFMsaV2EOnknTm2ZlySnJ
ig25AQHLk8CHBzIz//gEwVdLgQAKE80bjefwvm54fNIGQBQMqhM=
=4Xwj
-----END PGP SIGNATURE-----

--yhn6wjqi2kohiasl--
