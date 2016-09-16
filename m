From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Fri, 16 Sep 2016 19:26:21 +0200
Message-ID: <20160916172621.GA1426@katana>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 16, 2016 at 06:02:41PM +0200, Bartosz Golaszewski wrote:
> If an I2C GPIO multiplexer is driven by a GPIO provided by an expander
> when there's a second expander using the same device driver on one of
> the I2C bus segments, lockdep prints a deadlock warning when trying to
> set the direction or the value of the GPIOs provided by the second
> expander.
>=20
> This series exports an already existing function from i2c-core as
> public API and reuses it in pca953x to pass a correct lock subclass
> to lockdep.

Looks good from my POV, but will wait for Peter to comment.

If accepted, I'd think this should go via my I2C tree and I would like
to ask Linus to ack patch 4. D'accord, everyone?

Thanks,

   Wolfram


--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX3Cs9AAoJEBQN5MwUoCm2K5EQAJtJcdtBmS+r8yqnZms8cC0C
wasFOZeKBqYzRGwx0Nk+xG3JXd9z7R/P2Qh+KXGQoyxW3x284V+aMaLQWk2tNAAy
NS0O4BTPUUJPaKIHCE9ueO9DU61UL0DOVH+MeoOIz6U3/mEVqc/ZP8pvP07f82nH
feb4vG8nTH211e561fvJ6VGPqBoj0GyMu/HMrYIF2CkPxuaCavSgDPpul9CKF85D
4g1W9it4HGPHkBUQApwmS32H/m2rsk+3U6LelCjEOfGNi0cio88MThLG2NmKGzC2
BJP/+n/A050/8fIj+YfBcaxyYO50xJjNiyAP9qwuACJ/iZ01I3SYQlV8P1kpQcB7
Oi9q3T444mwkbi3ple6kb71imvFpvexUUsJdptEfvygpeCv5pGPZ+78RdTJDvYc1
PHST2B6gaNDG23iYWFXKvpRUfoIhdcnxXCoIB7YzQHyQqSSgTDug5Z7kTjvJ+QOi
hkIaYL44uL/eyF+8lHcNpZdCUQVq3Uy3pmY5MQjmguXCZG69XCMt32Na56p8bccf
iDmi5qwYGaf9ss8hRuyNGJrB+WOEkhLrIU2K1ZTMpoSLZOsF2WA4OVDmPSSia+y2
mUClel4F3yJ5NDbuagcTSKr1rOeAHNJlGDkcx7CFk0tO7yfvNfD+EBdB7k3f5/I0
hAUSas0U99NRRSmhALuH
=cYoO
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
