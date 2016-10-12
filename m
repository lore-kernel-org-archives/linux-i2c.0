From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] gpio: pca953x: add a comment explaining the need for a
 lockdep subclass
Date: Wed, 12 Oct 2016 09:00:14 +0200
Message-ID: <20161012070014.GA1442@tetsubishi>
References: <1474883655-15824-1-git-send-email-bgolaszewski@baylibre.com>
 <1474883655-15824-2-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47919 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753959AbcJLHAn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 12 Oct 2016 03:00:43 -0400
Content-Disposition: inline
In-Reply-To: <1474883655-15824-2-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


--bg08WKrSYDhXBjb5
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

Applied to for-current, thanks!


--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX/d99AAoJEBQN5MwUoCm2Z8wP/ibdzah58Y5v1xUo1zhuqjJv
MR+VyDVNQspaNHZFU5i6eDkKB0Gey1UHr6NRDOrnR27pqdGHHZWUoM0oWK700HIV
irTh3QJB88xHd9DASpo30iIBJxNm3yYBMS4YYGAKHVLAdZdR776fVfI5q6pDHhKI
OvJfboBoGHwDHR4JZDmP8AzaNeUjAljsl3Z00SaEV79IhYKgsWTXPqHcs8DzkMEA
CjdewofG7+TByrt4OQKncznUDCRVXt6d4jJ7Vd30Ru3jmpsaDdCMwZ5+6mIm0569
c7CE8klSPr6LfO0E1/Jn72ViTqJwxpxNwHIxlNnGuwtWJNo9bPCxjChQ4WZHkU5+
qLkNrDfkxi4R077W5H1aA/0NbFDU8+7RSjG8OEY1+Ac6x5hOf5gFBlm7GfFviSZk
Wc7l1ktzctP66VZRgXZVAfcm+K1lijpNfV6SC2b5J2M4yqBG5sAang93Nq+jdlMG
smZt82LbuOnDoceLPxl1/VNBuXaVoLa6McvYTqCnxgf4wxKkmpa1GR87b7deNrFa
We3ziIrH9sbpj5nRXTstoxSgtio9oZn+nxY/e/WuuSXkyBm/RqJDjObWnRETBIcm
ZmcW1wsGw43TQb9Hw4kK1OKVrdzkpWK+132SXM8tk4dIU92T7hUjKKjtzMFzCDDy
nWDXnqs+09CTzsc2E1QJ
=Qubp
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
