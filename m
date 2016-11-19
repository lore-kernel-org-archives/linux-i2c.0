From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: [PULL REQUEST] i2c for 4.9
Date: Sat, 19 Nov 2016 22:31:46 +0100
Message-ID: <20161119213140.GA11379@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:41620 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753036AbcKSVbt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 19 Nov 2016 16:31:49 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here are some I2C driver bugfixes (and one documentation fix) for you.
Please pull. Note that I currently need to use a different email address
until the problems with my main mail provider are settled.

Thanks,

   Wolfram


The following changes since commit bc33b0ca11e3df467777a4fa7639ba488c9d4911:

  Linux 4.9-rc4 (2016-11-05 16:23:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to ad092de60f865c1ad94221bd06d381ecea446cc8:

  i2c: i2c-mux-pca954x: fix deselect enabling for device-tree (2016-11-19 21:49:29 +0100)

----------------------------------------------------------------
Alex Hemme (1):
      i2c: i2c-mux-pca954x: fix deselect enabling for device-tree

Linus Walleij (1):
      i2c: mux: fix up dependencies

Peter Rosin (1):
      i2c: Documentation: i2c-topology: fix minor whitespace nit

Wei Yongjun (1):
      i2c: digicolor: use clk_disable_unprepare instead of clk_unprepare

Wolfram Sang (1):
      i2c: mux: demux-pinctrl: make drivers with no pinctrl work again

 Documentation/i2c/i2c-topology        |  4 ++--
 drivers/i2c/Kconfig                   |  1 -
 drivers/i2c/busses/i2c-digicolor.c    |  2 +-
 drivers/i2c/muxes/Kconfig             |  1 +
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 22 ++++++++++++++++++++--
 drivers/i2c/muxes/i2c-mux-pca954x.c   |  4 ++--
 6 files changed, 26 insertions(+), 8 deletions(-)

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYMMS8AAoJEBQN5MwUoCm28CwP/jSXHON9+ETP5QMGypy335Tt
zvqhE3i2BNFl0Mdj55/UsOcFaI+DQXpAu04b+jf28NyvqxXMzAruqRb1NBUH8wHp
FvHEzTZl04caez5xwGMIlXud/Ewv8jkBdPRyVk3RiB5EKzqxhh+tlHyyq7Jekc87
TfybE5wDO8K9gRz9a7JjY6TCvJ8cZyFXG+AIwqnaqZxMA+dl6zvFbC4fjOvKozgl
K7FT1eoNoXofQbk1uaVD7QGW/T7SduZUE0Q/zfVz4FDaGZISKaI3YN9bIGPof6Yz
tyhVBGiQRmc91ybHY0NIRD3TA0uBfUo1xVbGzM4oB0F8ryPLUGBwJW4H1vQTE2D9
jEN/OuRz5QRXJMN/6rOCRBeLTXyNUxvdcTUr0hB8/PMJ1wRTtnCXvO4XJvKzm7VY
wbYqkc1B2WNrMKgeU6dVDcuff+u9YPVq3Lu5xtCHxvHx7yyDBTkDzsuulPmlBnyA
kGzfVApOb8kyGipVwlkbAPbGsw3rX4lltWpah6Ds8kteDsTMw764peCc0p4NN3c7
kqVrr3gtIrzlWPBDTu0QHyEOXjUdA6f+ahnTKAkWUxd+zfOHHtcOCJ8kUPzmZaxX
1LutXhQrpdxyyezVOPzY9LVvRLfFab1ykYz7Q6H1xzqRbW46g10I94QbmNm6vVUg
Ik+cHpsF3qOz8qebgzq+
=pNte
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
