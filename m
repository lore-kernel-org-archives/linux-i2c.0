From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] gpio: pca953x: add a comment explaining the need for a
 lockdep subclass
Date: Mon, 26 Sep 2016 12:00:30 +0200
Message-ID: <20160926100030.GA5606@katana>
References: <1474883655-15824-1-git-send-email-bgolaszewski@baylibre.com>
 <1474883655-15824-2-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474883655-15824-2-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2016 at 11:54:15AM +0200, Bartosz Golaszewski wrote:
> This is a follow-up to commit 559b46990e76 ("gpio: pca953x: fix an
> incorrect lockdep warning"). The reason for calling
> lockdep_set_subclass() in pca953x_probe() is not explained in
> the code.
>=20
> Add a comment describing the problem, partial solution and required
> future extensions.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>

Linus, because of dependencies, I should probably pick it up?


--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX6PG+AAoJEBQN5MwUoCm22akP/i11EefXMZ7tyqfCrjwgr3hC
GdXG7Lpi8vWy7sS6xaZvjWhB0xbwvjig89vp8GfBAxu+wYAGGDy0DPt2IT+h6ejr
gt/F7Oj7wg3Xt1i3cdCMZPAPQEF+idJisnF30Imv19cJLthTj7Uacx/cYQFuJ+Qo
xotVETWBS5GitErjQ9OLrBtJBDuyDS/KQH/V4Ryfo2nk48rYlzABva3WTgm0qXSW
aB2xUKHCaY5VVrBnkTj/AeAVl0HzKrqVMNYzUNV+s7NmFjIFpXhgl2mY1t/j7bKl
Ogp5KghzwFeuiR0bmGcp0nc9w0gH/4FHy3NCyX5wux7MLBN635a21l19UKR6M3TO
SjI5u5ba9jqFTTBAzTTqr4YSsaJ6dKZ5MKQSm6aO9aYKw71AJcDE/NpOIW+GZCXo
XhfuAxOLa0t/O9PbIheAWoiXfGiFlseMtvXUwHHL3WgMepAfwdTHRCy7DWUZ6hpR
zllK/etiW7ci0ieoLaRu6HLAHxVvaKgsWId2C6rAhbnqLtSa7AlLB1Vg7n+U7eeY
5sIeDoUfIkIK573JyQQ1euQhUj7lWg3FpSl5ZAXfmpxjbnigrpf/+m+etOq7QOdt
BHWf8hZ9CvNvL6SE8/RtMwvoZrgRAmEvQ3NXQ693n70PXwx9xbUq33QYnPASgoWp
Zhm1LDnT9sWGSoNcq5dm
=y3Tl
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
