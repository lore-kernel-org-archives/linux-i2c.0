From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.12
Date: Tue, 23 May 2017 09:30:49 +0200
Message-ID: <20170523073041.agajqmfdg6a5bhrj@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hq2r7tvxftomxabb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:32829 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933273AbdEWHav (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 23 May 2017 03:30:51 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--hq2r7tvxftomxabb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is the pull request fixing the i2c-designware regression of rc2.
Also, a DMA buffer fix for the tiny-usb driver where the USB core now
loudly complains about the non DMA-capable buffer.

Please pull.

Thanks,

   Wolfram


The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:

  Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to e2c824924cdb41528932c550647406ad81336b18:

  i2c: designware: Fix bogus sda_hold_time due to uninitialized vars (2017-05-22 10:35:51 +0200)

----------------------------------------------------------------
Jan Kiszka (1):
      i2c: designware: Fix bogus sda_hold_time due to uninitialized vars

Sebastian Reichel (1):
      i2c: i2c-tiny-usb: fix buffer not being DMA capable

 drivers/i2c/busses/i2c-designware-platdrv.c |  2 +-
 drivers/i2c/busses/i2c-tiny-usb.c           | 25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 5 deletions(-)

--hq2r7tvxftomxabb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkj5SEACgkQFA3kzBSg
KbZONg/8CIo6Orv2E9xMmjhpNcQ3n9xS9E1027vUsAvR7LXklDVqrnqzNJDKAOXN
0zBDCDvDE38fe6td/Nh89gFRY0qCSWpPJx7qARwPopPd7dwA7jjQi54PFYkT4OsX
u5K69Q9WWPY8Mcx2rmKHBrw17G4aEq8nDHUxvcS0id4xacZK1/+UcXZx+PVbjKlb
22BHvrSQVjcg9s0D6qDsAdc84JQrVTwc5VfxbOAVy+s5NRRFwny0cox9qjl5d5uC
JFc31eYeQqG6QbmigNzTJL3MzFWvgOXKlbWoQOi33PY9cDgjdrXfXbdU6yskeH7C
ATuBsohRbiWd8YtPs+6pF/6pwU6rXfLgRoGhiny027gq3USdKBh/fhXjIOAtmuFo
8OfMlgTzgqnul2nTbU97WQg43s/Im/Y/LhtYd/JUDD6LKyP8djFXJxMkbxTJlR0d
TcEbQHq+GhS0G09AtD7AqKwq4Ag6kiZsNCLQN/fYTos8CZnHL95J8SQ0/ElJY0+r
HkIkL6OcSDk8IuDMFBoD45a0QcLknpoFL7wqir42NYA4UVcTUbj2zgmISsxTwK5Z
9lMzY1ansa+KRWFjFfBnPftr8Xn391mlMgywZhj/UT5mL1mTSLWl9kvnSCYNNQib
okLdDWX61pD8rq+BrvrsmA4ikQMgjt3A8pi9UD0ALk7tcDMXm+Y=
=tHte
-----END PGP SIGNATURE-----

--hq2r7tvxftomxabb--
