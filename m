From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.12
Date: Wed, 17 May 2017 09:27:09 +0200
Message-ID: <20170517072703.7max6bezbmhuau6f@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jcduitnuw26nky6m"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:37296 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751319AbdEQH1L (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 17 May 2017 03:27:11 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>


--jcduitnuw26nky6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here are some bugfixes from I2C, especially removing a wrongly displayed
error message for all i2c muxes.

Please pull.

Thanks,

   Wolfram


The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 83345d51a49a4b3f3b4a08a5db644dae438b0189:

  i2c: xgene: Set ACPI_COMPANION_I2C (2017-05-17 09:21:06 +0200)

----------------------------------------------------------------
Peter Rosin (3):
      i2c: mux: reg: put away the parent i2c adapter on probe failure
      i2c: mux: reg: rename label to indicate what it does
      i2c: mux: only print failure message on error

Thomas Petazzoni (1):
      i2c: mv64xxx: don't override deferred probing when getting irq

Tin Huynh (1):
      i2c: xgene: Set ACPI_COMPANION_I2C

Wolfram Sang (1):
      Merge branch 'i2c-mux/for-current' of https://github.com/peda-r/i2c-mux into i2c/for-current

 drivers/i2c/busses/i2c-mv64xxx.c       |  6 +++---
 drivers/i2c/busses/i2c-xgene-slimpro.c |  1 +
 drivers/i2c/i2c-mux.c                  | 26 ++++++++++++++++----------
 drivers/i2c/muxes/i2c-mux-reg.c        | 21 ++++++++++++++-------
 4 files changed, 34 insertions(+), 20 deletions(-)

--jcduitnuw26nky6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkb+0cACgkQFA3kzBSg
KbbgphAAsY6kDChTdFzm/J+MzwSXaZCNM/7/cBY9+1CZLWb8IW/oJMGwsW46rXdd
ibTjqkSepaq+WfJjWO8nJbpn21+QnFND8Ve+Z73G54MZUU7QnznJ4Z7Rntb+2SMu
lQCiVvRXH6au8txqNrMyHjg5mVQjPB5aX2jK9OXLugQbnz0/s2G3oi02J2ZxJ+jV
7ECqWatXIg0lK8TMhFW8Nc13lieJMpOxoGMVpYhzDLTHaJV5TPnqhIABbHn+nuAg
Hvldt5C5p5YWZ/ji3JnOVm/Set2xpTLBKHDLalvOCv4B2rfeUEwNM59dWnUz3FxG
DshNObk8e5YxGcPN94DeN/7VplPR6KSLWMpFFFCxoxdulJKugmbh8xC+pjzT+LJ5
OO+QKh45E6rAYLSodjUPbS7e+/6ayz1Guvt7b/S2O/MLkFlx3ozJnP/sCohVVMBX
nHDoQTTaptRz6Tiv1FwGoEdOyI2qTfxp4IOC0EMW2fDb4qWQhdNSO12GcbOAzUXt
mWfP5+NiHF3m0NQ9xVLyLaM9eu7E/juteQqobz1jTQuPlFhr0AEueOy1/g07AaEM
XrPHb34+zyQ9e8entH7MmDGhRtrYlnb6QlMayOyjbO8o2HpTIWZjBoqq4esd4V25
6GPVIbvPfElZxXMh6RvchpMODv9qNXo0rf4Gm+IbbPrZU1r25O8=
=el1l
-----END PGP SIGNATURE-----

--jcduitnuw26nky6m--
