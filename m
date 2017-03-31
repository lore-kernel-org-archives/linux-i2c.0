From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.11
Date: Fri, 31 Mar 2017 23:09:53 +0200
Message-ID: <20170331210948.lxczt2cjjhrkdlam@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yt5uvffl4yzv5zcz"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44645 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753033AbdCaVJ4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 31 Mar 2017 17:09:56 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--yt5uvffl4yzv5zcz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here are two bugfixes from I2C, specifically the I2C mux section. Thanks
to peda for collecting them. I hope you are happy now with my merge
commit message.

Thanks,

   Wolfram


The following changes since commit 97da3854c526d3a6ee05c849c96e48d21527606c:

  Linux 4.11-rc3 (2017-03-19 19:09:39 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 0bf9e1270b56b2376ba3b16d951cd0ed7c573f54:

  Merge branch 'i2c-mux/for-current' of https://github.com/peda-r/i2c-mux into i2c/for-current (2017-03-30 16:53:48 +0200)

----------------------------------------------------------------
Andy Shevchenko (1):
      Revert "i2c: mux: pca954x: Add ACPI support for pca954x"

Mike Looijmans (1):
      i2c: mux: pca954x: Add missing pca9546 definition to chip_desc

Wolfram Sang (1):
      Merge branch 'i2c-mux/for-current' of https://github.com/peda-r/i2c-mux into i2c/for-current

 drivers/i2c/muxes/i2c-mux-pca954x.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

--yt5uvffl4yzv5zcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljexZgACgkQFA3kzBSg
KbbDlQ/+NAvMxX9YjA5w5bQn786s+20Lkj1GRWGgl5ap9CIOjz5Mcd49s/QgQJIv
1M7bUi2YiHtjl553wHGzICVGXwe9Miy4fwuZQ2iDgrd4mUNAVmyBrAsbjESR9S6g
Q6XvchKJdudC3FlOfrQavJqRmI0AdoW4uNTFJSgzqNLKY0BhnsigXqgoYgoLUFIS
/Y1HKGOa6lLv7eajLidy0BGcReZzZZAtGnKIPntnh4zxUfTnOZSeDS0fhQHtiYh5
iihLm7tKCbk42mB2W5vvYWxzV8mULR3jypUzwiUKnaoJ709HzPTrbhyf0Z1KDCo6
sRcYho+yzNmYw+sNfXloXPLxwidWviaF8qLndSUsmbQ4qXI0n1XgBeUqgYUO1HDp
ntxwv4Y7Y5k65DnVEY+aMaG64w1XWXI2SKx+TmxjIRTHbq4edoM9IMR9IJEzK/Iw
7ffteiNJ1Ds+TQDsI/9StKdZOb+J+jE/vMHDyDnuCItdMDxdykuoYD4SLL6b1l4z
3ko8T68WJtUCARxkpTlJU1lLehYjbVvuLkqG+SiyL4duwQPNy29EaBsFxcRcREYG
lMtsvZ1CdShm+rYgrGOnRgehpwSW12uw6bhSoF/ZtwErbEaiagtNWqi2YPkCmpTA
BxL37NGDnzDKxPIU3gQ4UNt2U0hdRspgiiyRbJPlh6XCNbkulP0=
=JE1n
-----END PGP SIGNATURE-----

--yt5uvffl4yzv5zcz--
