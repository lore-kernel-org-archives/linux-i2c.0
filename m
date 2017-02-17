From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.10
Date: Fri, 17 Feb 2017 12:19:23 +0100
Message-ID: <20170217111918.z2fxfj6cbdih3gbz@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dvvlocroyivscspq"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:42686 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932491AbdBQLT2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 17 Feb 2017 06:19:28 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--dvvlocroyivscspq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has a revert to fix a regression. Please pull.

Thanks,

   Wolfram


The following changes since commit 7089db84e356562f8ba737c29e472cc42d530dbc:

  Linux 4.10-rc8 (2017-02-12 13:03:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 12688dc21f71f4dcc9e2b8b5556b0c6cc8df1491:

  Revert "i2c: designware: detect when dynamic tar update is possible" (2017-02-14 22:10:26 +0100)

----------------------------------------------------------------
Jarkko Nikula (1):
      Revert "i2c: designware: detect when dynamic tar update is possible"

 drivers/i2c/busses/i2c-designware-core.c | 45 ++++++++------------------------
 drivers/i2c/busses/i2c-designware-core.h |  1 -
 2 files changed, 11 insertions(+), 35 deletions(-)

--dvvlocroyivscspq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlim3DYACgkQFA3kzBSg
KbYrGg//Ssuoblh2Ov6z9V7lewe8EeWpWM1AznuXOHVJGK6bZn5lIGTsGNBHhKVa
8p06Z/pZw2GB7SDF29EGmMKOkkzCGytwzf3OMtFSEVZDddTXOHNAcqiYiPQinoAN
+gWEaS0MvynHl9v6SVlPxy4t5IJr5U0Pjx9hRifFlomZqtcILzS9Z9dNGCdg9kwY
RFuzlZoeYA0khr6B/AJZnEUXhVP0SOuPTTp4++NUa8Bf5n/1GyCtipPsbqt0YlEZ
WBbrCSj7xWGSKnhuhcX9LskCTExljKJFhdDuFNzfXI5NAMXCl8PfoJliltckD4HA
AFVK4RSa5SpDX0NsxPAiaomsz8bhhpRPDiJXyiciD2BUaIOLaiQf7YGiSjeRT/jO
FycWJ3H5VEkTjbalV5RixUg/73aOfn+H/8fMCU2RY2KAscyRm7hfs+DNc81MJFJ7
GrY3ejMV0J4vOpwgyrQp7FsT9tmyJoGp2O5yiugschEKMjdQVZZk9dXzB8kyUJD5
r7Z2RmvybYkP3MSoOpHHMmHdsKkU341bnLJ3+dTIBHfgzfiXA/DnDs9GLN3YvOZi
v1gJ7zf9jIT40+RlMe3f+E0MQqL8SNFC1LrL9T2My9rnCZf60KMs9j3Bey5IfznM
f6RYizypLIowkIJFgEAluQuxt6KkN+3NstCUSnjuIr8EkAKeYkQ=
=LUVV
-----END PGP SIGNATURE-----

--dvvlocroyivscspq--
