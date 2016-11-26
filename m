From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.9
Date: Sat, 26 Nov 2016 23:12:30 +0100
Message-ID: <20161126221221.GA2119@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:38587 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751724AbcKZWMe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 26 Nov 2016 17:12:34 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is a revert and two bugfixes for the I2C designware driver. Please
pull.

Please note that we are still hunting down a regression for the
i2c-octeon driver. While there is a fix pending, we have unclear
feedback from the testers currently. An rc8 would be quite helpful
for this case.

Thanks,

   Wolfram


The following changes since commit 9c763584b7c8911106bb77af7e648bef09af9d80:

  Linux 4.9-rc6 (2016-11-20 13:52:19 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 89119f08354b628548118cacd686a7700372ad19:

  Revert "i2c: designware: do not disable adapter after transfer" (2016-11-25 23:23:25 +0100)

----------------------------------------------------------------
Jarkko Nikula (1):
      Revert "i2c: designware: do not disable adapter after transfer"

Russell King (2):
      i2c: designware: report short transfers
      i2c: designware: fix rx fifo depth tracking

 drivers/i2c/busses/i2c-designware-core.c | 64 +++++++++++++-------------------
 1 file changed, 25 insertions(+), 39 deletions(-)

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYOgjFAAoJEBQN5MwUoCm2ZVcP/RPKpY3hhpI8mcxpWnAI/VWA
uZ2nAkQwK0Ez4cHgf7RSZCD1TUrw98bTVBk+Sm9TsBaKLG0wRL4TITVSdcfdQoOQ
9hIZnWMIWlw8/pIxkVKnXtg+S6lW/slSk/yFh528VRzbZWim+Glk0P0DpZXdNfX0
VUAMoc4g5i90wg5laMTRckuaq4ydVnpKllvX6UAOfJVPuZ6rcj2Vs+tRwlCjQM0N
gUG0hTAhzbLqBucNVc3GxJLMK143Azf71ogvWPY/5+fwuEDzrlsI8pcZjbiY/N2w
QE4L4e1h8EhZvXy1HIete2pCWGX2XzD5VxjmiA7ycaqxUUrGpOQD0JGJWAGSEyjL
OyZPzq4EUM/hx7ZOqCSg9tqznZGXq3Iz/W/GxyRiUTIwm2FF6JaVUJ9eaj6gEJHd
Q9V0jO7n5KZYAr0OclgXvcZhX2Yz1DnfxLNjXp+j71x9CMN9jGiwG52VhjuwfJ8R
jK1gx3qG2isYik9n7v7BqEpk1TO0vLhhnP32A3wJ9aLDxETyZPPuz8lhVhBT9N8Y
gIPRohUe1iKYNKVtss6z1KZrNw8Ad3gxmrLjzyXoGGmvqiWgv/Z2s/8knKbRDUPx
5XlISYagLMwM0xdmKer6vr/Ov9YmPZ3pRfC3uNsRgJPIGm42aAWWuBnrPi1fk9u3
ozvLiIcbBTM05QVuLzeK
=Eeey
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
