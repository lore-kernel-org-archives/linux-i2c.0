From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.8
Date: Fri, 19 Aug 2016 20:28:20 +0200
Message-ID: <20160819182816.GA1802@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40089 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752156AbcHSTCA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 19 Aug 2016 15:02:00 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has some pretty standard driver bugfixes and one minor cleanup for
you. Please pull.

Thanks,

   Wolfram


The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 0268263f0cf2239eb3a747936d8d36ef5f5e1688:

  i2c: meson: Use complete() instead of complete_all() (2016-08-15 00:55:34 +0200)

----------------------------------------------------------------
Alexey Khoroshilov (1):
      i2c: ocores: add missed clk_disable_unprepare() on failure paths

Brian Norris (1):
      i2c: cros-ec-tunnel: Fix usage of cros_ec_cmd_xfer()

Cyrille Pitchen (1):
      i2c: at91: fix support of the "alternative command" feature

Daniel Wagner (4):
      i2c: bcm-iproc: Use complete() instead of complete_all()
      i2c: bcm-kona: Use complete() instead of complete_all()
      i2c: brcmstb: Use complete() instead of complete_all()
      i2c: meson: Use complete() instead of complete_all()

Wolfram Sang (1):
      i2c: mux: demux-pinctrl: properly roll back when adding adapter fails

 drivers/i2c/busses/i2c-at91.c           | 24 ++++++++++++++----------
 drivers/i2c/busses/i2c-bcm-iproc.c      |  2 +-
 drivers/i2c/busses/i2c-bcm-kona.c       |  2 +-
 drivers/i2c/busses/i2c-brcmstb.c        |  2 +-
 drivers/i2c/busses/i2c-cros-ec-tunnel.c |  2 +-
 drivers/i2c/busses/i2c-meson.c          |  6 +++---
 drivers/i2c/busses/i2c-ocores.c         | 14 ++++++++++----
 drivers/i2c/muxes/i2c-demux-pinctrl.c   |  4 +++-
 8 files changed, 34 insertions(+), 22 deletions(-)

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXt0/AAAoJEBQN5MwUoCm2Ij8QAIiOb+vzjPGn0UcmsCy2GmqU
Ir2WwFommxXy8LHwBG67B2nyt17A9hCIPwwU9Z9XWNcNBgWj557Tt6xcP2xmXI1p
zsC+3ElaBrFJUA1OjzEPu+w7ZDBSqs89KhaGpGaUUid1X2yrOzam8YrcdpePbsv7
5fMr0yNDsVrRRM+gF89iVV/0mteuAS+hLbtiuOPmoAOMHei/GikvrX55DE4cuhFA
XVayzouZhpMvLfpxtv5oIrWFBTPEoSlPiWq2/HR9HnlafN7UuB/4ya97NzUzGFQS
MZfXeNBKDzJr950RWbDAWKZowqi5KUpqwAevSJp72FoX4GhJ4H5VuSXdUjCEJEnr
fvvn+/Y1k5gys5/WbOis2ExddfyLUSwVxUe0i44xxi32pVBbk22UfVmvqE7M9jaZ
lyJlIM6jTlq+8aivxn0CUT6ekEUbkx0DZP+NYbXCgk7pLWS7LOVRjhkFQLi1XXF2
Y/vluo8/DWaleBJHbULDkp4jTgE+gqKFYrwrKk9CYf7L96WWKPjFP+1qIgnCHYo3
g9atNakrUX4xa8xq75z6TGfDNTdUmMGat9jYlpD5g5FnmizKl4rFwwliZC2Tp0A5
msztMZv2SDHnmFkJw8e78Us9RN711Mgc6a1m7q7PDuk/JMrfE0DQFuBqe3Iz1pYR
smLliQvGvdmEWhZ2ekoC
=GFtn
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
