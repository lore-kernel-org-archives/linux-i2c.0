From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 4/4] gpio: pca953x: fix an incorrect lockdep warning
Date: Sat, 24 Sep 2016 11:15:06 +0200
Message-ID: <20160924091506.GE1434@katana>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
 <1474041765-17818-5-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474041765-17818-5-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>  drivers/gpio/gpio-pca953x.c | 2 ++
>  1 file changed, 2 insertions(+)

FYI, my code checkers found this in this driver:

    SMATCH
drivers/gpio/gpio-pca953x.c:562 pca953x_irq_pending() error: buffer overflow 'cur_stat' 5 <= 8191
drivers/gpio/gpio-pca953x.c:573 pca953x_irq_pending() warn: buffer overflow 'old_stat' 5 <= 8191

Didn't check further. I fixed a sparse warning, though.


--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5kQaAAoJEBQN5MwUoCm2GtYQAKlSeAV3yzVUxyTZn1GekdJo
pq7bG6Vn02rMHh5glCrXZDkfkjjlfI9XN8DxRM+CDDSWCtEkg9LZ25QAtNgmnAur
yQ77urdIU6WtRNdjJoO6tWVdPH8/tgr6GUNxARq7vNORIeqIUvIzEZbqN+ScJRXh
jpKfuQDdRa1rzUKI71WF2KEMQa0sgHsTltjS+ENDncSfJS/uYVZUfw3JOEXLGJJw
6jX/s8tlDRAVE2rHnX5C2qYO+E8vm4Y17Rm5lRNO40GEijELWSJGoqXm/HElqcfE
L+lGjk0pYOs02PNdt17Z7pLn4Zop+7lvmK+TCfhn2BWpp6c2yCP2HnuOHVsWx9l7
lPUEdTxeTEtbTW/TFtQbyEEs8kuMOE83u3vlL16pV+crcGxkp4Ty6MVl75f4Uoi3
w5E5Z6/pKxvsHs1uJwgFrN6NcvCP8x0eJCT0Nc+f2nVit2GfjL8znbEWMZX5dlIi
k3PMgNVpDLVcfMos3nHkLjZTv88tlVL9J2RWuvan8cdxuxFiKpLLM7PHufittBc0
2WetEzCYA3A5prDAk13ytJdaj+AiMOxy6GN2yMxBUN7/Rp44iSXlko3P2emc0421
V/Nc0TWvw/jB2dG23GqoUnE9dR5pBSMt1Bgcbd3kT/BbQfiJaGqu77o4ZZuMBm1+
5X6EzpN862LiZeEPwJv1
=ey61
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--
