From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: zx2967: drop COMPILE_TEST dependency
Date: Tue, 27 Jun 2017 21:59:05 +0200
Message-ID: <20170627195905.zpirzdx7f22dj4ww@ninjato>
References: <1498314326-16121-1-git-send-email-shawnguo@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a5fodzea37pfyfvr"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54171 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753587AbdF0T7H (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 27 Jun 2017 15:59:07 -0400
Content-Disposition: inline
In-Reply-To: <1498314326-16121-1-git-send-email-shawnguo@kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-i2c@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>


--a5fodzea37pfyfvr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 24, 2017 at 10:25:26PM +0800, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
>=20
> 0-DAY kernel test reports the following build issue on IA64 architecture
> with allmodconfig.
>=20
>    drivers/i2c/busses/i2c-zx2967.c: In function 'zx2967_i2c_writesb':
> >> drivers/i2c/busses/i2c-zx2967.c:87:2: error: implicit declaration of f=
unction 'writesb' [-Werror=3Dimplicit-function-declaration]
>      writesb(i2c->reg_base + reg, data, len);
>      ^~~~~~~
>    drivers/i2c/busses/i2c-zx2967.c: In function 'zx2967_i2c_readsb':
> >> drivers/i2c/busses/i2c-zx2967.c:93:2: error: implicit declaration of f=
unction 'readsb' [-Werror=3Dimplicit-function-declaration]
>      readsb(i2c->reg_base + reg, data, len);
>      ^~~~~~
>    cc1: some warnings being treated as errors
>=20
> It's caused by that writesb/readsb are unavailable on IA64 architecture.
> Let's drop COMPILE_TEST dependency to avoid the build issue.
>=20
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Applied to for-next, thanks!


--a5fodzea37pfyfvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllSuQkACgkQFA3kzBSg
KbYYCQ/+NGYCQo2tZ9JCxLFMlpyeBKDlXxtW9TFBqiSsrLAZsRc2VI8MuVllTDHe
mqxAU/0evYAJwmhFfoNePVvaDzm2P02HKthDBpVlmCW1JKtn2KsIqq9jCkgoDpkO
sLAz53ehr7f9yH/xv+vC4yaZml7/87Q51lQ8NdWln6GSoxyqDhXgNi9WHLwgpsTG
0f+0fQgj+5eWvhy74E+BpMKsdrj/NXe88Q/OqgWknZnM/havcyqSXf2P55ekkzag
BrBr2lJbyInc2VbM0HM5neI1n/PdMnBYBOhGJu/LklwpRCdP4tPlDK66+2ktBtQF
JuLhnpnxA6Gwvd616WY1/Tv6Kaxwg50rXZclqNpeUOqA6KkB7RrZGU4eJIB7zfab
ii1z9G72fDFs9Q04ufLo9W0cVxi8oim/S2MfV96MTzkH3/MAEpYqD3d6uUTGvft9
0mrBPZbi6nSWmvZ8Fp52EC+HJ9208HlVNXP4EUrpxHUutCuLyVAO/vmhm3PK3+h2
KXGi73RL4Jrpsd5Ku0QZ0HAycfLHrECFZBmLW0VT/bRi9SrSKrhfWZiYz7KhsWyP
ws85Vuf+SkJxT4xh/MU9gijcsusDAuKmL7kXwfd7FAyQZQQ8Nt28IgESTRmym4XR
CQ+lLepWEqaYrjbowU2Y/xJH1Hj9yqiP1l+mRoGNXc/yfJWFClA=
=r9jc
-----END PGP SIGNATURE-----

--a5fodzea37pfyfvr--
