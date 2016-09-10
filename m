From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.8
Date: Sat, 10 Sep 2016 16:07:49 +0200
Message-ID: <20160910140745.GA2112@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56849 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753229AbcIJOH7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 10 Sep 2016 10:07:59 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is a pull request from I2C. Mostly driver bugfixes, but also a few
cleanups which are nice to have out of the way. Please pull.

Thanks,

   Wolfram


The following changes since commit fa8410b355251fd30341662a40ac6b22d3e38468:

  Linux 4.8-rc3 (2016-08-21 16:14:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to cbfff439c54f37fc363b1d365183fa61af43585c:

  i2c: rk3x: Restore clock settings at resume time (2016-09-08 22:50:33 +0200)

----------------------------------------------------------------
Doug Anderson (1):
      i2c: rk3x: Restore clock settings at resume time

Geert Uytterhoeven (1):
      i2c: Spelling s/acknowedge/acknowledge/

Wolfram Sang (6):
      i2c: mux: demux-pinctrl: invalidate properly when switching fails
      i2c: sh_mobile: use proper device with dma_mapping_error
      i2c: rcar: use proper device with dma_mapping_error
      i2c: bcm-kona: fix inconsistent indenting
      i2c: mux: demux-pinctrl: run properly with multiple instances
      Documentation: i2c: slave-interface: add note for driver development

Zhuo-hao Lee (1):
      i2c: designware: save the preset value of DW_IC_SDA_HOLD

 Documentation/i2c/slave-interface        |  5 +++++
 drivers/i2c/busses/i2c-bcm-kona.c        |  2 +-
 drivers/i2c/busses/i2c-cadence.c         |  2 +-
 drivers/i2c/busses/i2c-designware-core.c | 16 ++++++++++------
 drivers/i2c/busses/i2c-rcar.c            |  2 +-
 drivers/i2c/busses/i2c-rk3x.c            | 14 +++++++++++++-
 drivers/i2c/busses/i2c-sh_mobile.c       |  2 +-
 drivers/i2c/muxes/i2c-demux-pinctrl.c    | 15 +++++++++++----
 8 files changed, 43 insertions(+), 15 deletions(-)

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX1BOxAAoJEBQN5MwUoCm2KUwP+gJXAP871yymdJzaVUr69UNj
5Tn98I9DEiimiynComozf0Bs6O7VsxpuiLTBdVyLO/XgFbmmroXRUmbM+PTiO/iK
8DR49z0RkoIJuF8pPjDhJqZ4Pe1YjvJPdVGD2vh57SYdnTzhLt0JkyZncEVRC+hk
WKh4TaR0UTGBOJKSWtXF4jZI0s449gE/huJ2/ngg7LU6vRJfP2oofD05TVDY6xU7
wL6PzqBjiJwiBJTNZST64vsFm0e2MymOoMBnzDCC5ja9HnE7H9LtYt2xbWiz3EYd
coCCpeNuv6+Xb/FXiOnTMKdutrJlxATDHlrXYe2DdqUU4tAUJ3uv72yPoKTmt8xL
xNPIkd7IRwuSoBe33DIfNSjJesWis625HVW/s4mi2dFYLYdMdfjcjjC9Q5IJAO+Y
lyrqiIW+SAf8C7WvSu0vGj/N4czxXSVxRmSXy4/OzaZFWj1akQr/J+RTUyC742Th
LKABhJWblqcXHyE2likYiK6XVN/cBxWrvXQkHR533xa8//OjZRW69hAdqc9NMirE
f32VIwamPvEP2XLynR4B66A32WWsnoAogv0desgseOVmdaU26is9cye3h4f/jbXF
cpfzsrfFNro2iT4tJMnaQq4QHz9zgZuT2JGEE1/ZYU4n5mh7JrFnngacYm/7fViw
gBYquAUI/A9KBfE5bmSs
=3Blh
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
