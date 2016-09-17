From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Sat, 17 Sep 2016 12:18:21 +0200
Message-ID: <20160917101821.GB4753@katana>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
 <20160917011952.GK5016@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56691 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755291AbcIQKTH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 17 Sep 2016 06:19:07 -0400
Content-Disposition: inline
In-Reply-To: <20160917011952.GK5016@twins.programming.kicks-ass.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ingo Molnar <mingo@redhat.com>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 17, 2016 at 03:19:52AM +0200, Peter Zijlstra wrote:
> On Fri, Sep 16, 2016 at 06:02:41PM +0200, Bartosz Golaszewski wrote:
> > If an I2C GPIO multiplexer is driven by a GPIO provided by an expander
> > when there's a second expander using the same device driver on one of
> > the I2C bus segments, lockdep prints a deadlock warning when trying to
> > set the direction or the value of the GPIOs provided by the second
> > expander.
> >=20
> > This series exports an already existing function from i2c-core as
> > public API and reuses it in pca953x to pass a correct lock subclass
> > to lockdep.
>=20
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Oops, I overlooked that I need your ack as well :) Thanks!

> > Note: if this series gets merged, I'll prepare follow-up patches for
> > other expanders for which a similar problem could potentially occur.
>=20
> We can't push this annotation into the i2c core, can we? Since the mutex
> is in driver specific code, not more generic...

Afraid so.


--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX3RhtAAoJEBQN5MwUoCm2RLoQAJWTNlTDEctb2R3Cg9Ept/Lc
1zwC4HqyaozBgMiXLvfsu1Ajm4nYKCLR86c8oGtbx161Ot+pYhH5nsoEYGQ0cqzV
8k+q/wP11nDg7olfkKpPAEzef2+aaac9JI8ykBZKAmfOTVtLCscYXeiom/XTNZ6k
vDsYTEl2B54CZHXcZPRylNgXFZKgF5oMB5bh3NLan8s95oX/TMX+DmtulAdYNiMZ
0Ja0IANzmspQ7aV4qMXbdUSMADkJds3rKVrJIMLXZMAgsE45VMyEKhW1S7KKxROe
nK7q9PFoaUZRNgt+Y3EqM3Ad9HZmcK4QoibYCuUhwPuyb+A8pi4an/mFXRwmfQE7
Rsk9vv+9QnB5JdIWiTq71tbySFpspDmi6lonkxadxi1RQLL31dXBbE/8tEHrRS2h
nUXnUzwpZo7sg7+tjNJ10GTal2rVh6mA8+0Z0UTacOgNPernP7cW064tH7xrsD90
Z93/xUO17xWPapNqNHXw4LOdYnO56GdzM2h1CvwmB/HDS9TspAwci4DFUXkJpDvP
LJ/Sib4jMG8LZtVwESdbIRWAfVe4coNlyaOHo/rKWzSMDcermNfDJslfzRwAxdDs
K0IWgNiXiK66r3YSA9V+6RMMUIWuVFkL0T2jtHiPQOLS2CzbjludL0webrxxV7b3
1shuvOuyLSauvdnQBIJ/
=HZJF
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
