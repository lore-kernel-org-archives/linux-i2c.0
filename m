From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [GIT PULL] at24 fixes for 4.15
Date: Sat, 2 Dec 2017 23:40:07 +0100
Message-ID: <20171202224006.hek22kekxaqr4px2@ninjato>
References: <20171130111222.11887-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="abug2pglaiwjtgkf"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:38660 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752365AbdLBWkI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 2 Dec 2017 17:40:08 -0500
Content-Disposition: inline
In-Reply-To: <20171130111222.11887-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-i2c@vger.kernel.org


--abug2pglaiwjtgkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec83=
23:
>=20
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/at24-=
4.15-fixes-for-wolfram
>=20
> for you to fetch changes up to d9bcd462daf34aebb8de9ad7f76de0198bb5a0f0:
>=20
>   eeprom: at24: check at24_read/write arguments (2017-11-29 16:05:37 +010=
0)

Thanks, pulled!

Hmm, patchwork didn't notice your pull request somehow. Could you try
next time the string "GIT PULL REQUEST" in $subject? Maybe the string
matching is not perfect there yet. Sorry for working around tools...


--abug2pglaiwjtgkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlojK8YACgkQFA3kzBSg
KbbDOw//cranImdQCEy3/Ou9g4SrfeNSgFOGqDSowMfBKAB8Gq0YsU3K+HQxbmYC
rbKdVHkeUUHBc9E98iTv8zN/YNR0lDPXezMWljices1KRFywtvj4D6+fhQt7Fb5f
gHJo33nym4Y8Tz/4oV05/ua1bQ13O1Uvbzl1p1r5frjVxSOnl8M87slvJyu0PJe7
2qcdoaTfa/p+k9ro9oym0PVYlKGerRPoAajS9ejbMTjFI+jb5l40jy6m2bm57JWM
zSe6zIt2P5vxDP15NEGnoti6e4qAXbisCgAUmxo07Ggy+jeY32TCYNy5EYuhJ929
lhKD8b5762toU7LQG4fYigkF07ZlE21dGQ4tZK0xhkmEWKSm3VPZa/FEwGZgRTtR
9Biw1hhzPxUPs7tlbscUiGLHHxwZNZNzta05pP71608dLvBFakjJfphDjAfqdOpB
dIJEvxfGXoB1c6ITD3dqX7mk/f2Opysp1spEg0DxNDATbRwWKWlnwnK1Vs7GSxiK
Jgxe8DdBfEKWamVSXWAB0bW3GtdLmiq0AGZoYX4e0IkGv4UvxuYKwj/6vMMdM79K
vaRLHEMxqp1wUB57DAWkIPjcdCCg+SDjAAcmGrCCx8/MhCATvtDYM6Lxli0p2FyA
prCOzm3dIUbwQkiybEc7exlYr4de6Yu0pus8mEwqJqvTsIlxiv8=
=3mj0
-----END PGP SIGNATURE-----

--abug2pglaiwjtgkf--
