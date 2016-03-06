From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.5
Date: Sun, 6 Mar 2016 12:52:29 +0100
Message-ID: <20160306115224.GA4322@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55925 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbcCFLwh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 6 Mar 2016 06:52:37 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is one I2C bugfix ensuring correct memory allocation in a driver.
Please pull!

Thanks,

   Wolfram


The following changes since commit fc77dbd34c5c99bce46d40a2491937c3bcbd10af:

  Linux 4.5-rc6 (2016-02-28 08:41:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 7314d22a2f5bd40468d57768be368c3d9b4bd726:

  i2c: brcmstb: allocate correct amount of memory for regmap (2016-03-01 19:16:45 +0100)

----------------------------------------------------------------
Wolfram Sang (1):
      i2c: brcmstb: allocate correct amount of memory for regmap

 drivers/i2c/busses/i2c-brcmstb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJW3Bn4AAoJEBQN5MwUoCm2bP8P93gNcVi0NGwy5TyJ4lJRRtmx
tvsLrlLjIqhVpUk6JKfc28oFnVobcscY6NLo71xRoJS2exW0slxCLwC6GwZkHUQP
GII3tNASwveupdqG0ueKnyDBx275NBS5SOfZGs3i+PpslPS7+LeBZXZo5mC0Bj6d
IS5IT/KVdGQRd6tIAzCKnes1q42cy3ZjTmebj7t9vKjrdK2Zt6qEEufyptYZfG75
XwYoOBl4Yq16kGsxy9UcvyRe3DeKHgd+ZTirW+Znc02OiitRhx0//ceaONdKWMC/
NaZ1RpQM9VmSZUPpJaiTNGNTncLZYn7OSqWU4z3UTaT+NUu3jF9LbCbvNJpm2xMz
5vu6pjTYR6QWO3DdwgB85uQzupTaKG0jZJ+rUsPvTzln/VXpM9WLCTeMxQV+hnbx
M/vFreOgJcFDtX49MGP2firQ7/FKcAEb/8+RAwkVM8VsKs0DojQY4QH64SoR19J8
f24jviAaGTOw2ObFukEAYm4R0JAwf1mxzTqvofD+zZwPAzHHakL+aWjgSITWk1S9
KHhT2Op8g4cZNPUmWpfm+B4h14TeNDYfTlyxuMzIJG9u54aEceOvJueqxnQFf3uw
NMtbckxucG0JU4t4YaivYLOnl/DG79BfjIxpnka2NnpRhld/l5Qkqt3Gac2eBvUa
GYoXn4O38SxOXZOudp8=
=deeB
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
