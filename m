From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Sat, 24 Sep 2016 10:56:04 +0200
Message-ID: <20160924085604.GC1434@katana>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58849 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938318AbcIXI4R (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 24 Sep 2016 04:56:17 -0400
Content-Disposition: inline
In-Reply-To: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


--vEao7xgI/oilGqZ+
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
>=20
> Note: if this series gets merged, I'll prepare follow-up patches for
> other expanders for which a similar problem could potentially occur.
>=20
> Tested with the following setup:
>=20
>  -------             ---------  Bus segment 1 |         |
> |       |           |         |---------------  Devices
> |       | SCL/SDA   |         |               |         |
> | Linux |-----------| I2C MUX |                - - - - -
> |       |    |      |         | Bus segment 2
> |       |    |      |         |-------------------
>  -------     |       ---------                    |
>              |           |                    - - - - -
>         ------------     | MUX GPIO          |         |
>        |            |    |                     Devices
>        |    GPIO    |    |                   |         |
>        | Expander 1 |----                     - - - - -
>        |            |                             |
>         ------------                              | SCL/SDA
>                                                   |
>                                              ------------
>                                             |            |
>                                             |    GPIO    |
>                                             | Expander 2 |
>                                             |            |
>                                              ------------
>=20
> where expander 1 is a pca9534 and expander 2 is a pca9535.
>=20
> v1 -> v2:
> - added patches 1/4, 2/4 & 3/4
> - used i2c_adapter_depth() in patch 4/4 in order to detect multiple
>   adapter nesting
>=20
> Bartosz Golaszewski (4):
>   i2c: export i2c_adapter_depth()
>   lockdep: make MAX_LOCKDEP_SUBCLASSES unconditionally visible
>   i2c: add a warning to i2c_adapter_depth()
>   gpio: pca953x: fix an incorrect lockdep warning

Applied to for-next, thanks!


--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5j+kAAoJEBQN5MwUoCm2/dUQAI5piDKXU6RoU7wPANUobl6x
5gSbXjmxUkm4Lg0undyf01bEZKFdIo8beAMwb7LkkRV8OOL71v4hu5Z1qSpVTezF
hMrQ3eU71c7RADs9m1tXx0Z9bW3HcvxKSlIrDNXQPzHE4V3uJ3wk09RaShqSkVJm
2mprBTECBla0ATDf+RxmuQqD0r03sNlibtv/89gNvx18sAHOqADDDJ1N9KGF0Kma
HlPafbFa+ONl546IW8yG373QQwAe+2kgt57pRUKwbImk8fiiKgdSiWB+euxJx7dF
tWjHoa2y5DbwqzVfyYTcZq5nF1POfez0BWjtu6jRh5J+cNMAAxwb/frwCVUJQpp9
W9P0Ui4YfJ0bwTDl4t+NN+8oh7MGId4FoqUYzyO7LSiO4zAiMPsKHflS3P89JqcO
nwdajbwuUSZXAAQ4xhSxYOQ0pxrWJn70F+SoGwGBDnjz6+iAhuudH6x2uWFeKoCw
7B6QzDrHhuEM47ZW4qfOjmcHlMS79oEqkpxJ5ZlJIlUiQItrftB6JeW2mfYo05Io
cHrp2ohpO9Xorc3vePDdYa+yG6lIZLIb1NPPyeLh3Pdd2TAKHVwnGSggqFxWfkTb
3E6+36NPzE6S4y+ZKZya0zGW+qwixsIybJXrc+CqfsmIvblzwZKzcHjQnVcE6feJ
Bz2b3nISoCCqqZ9mWnzV
=sMPK
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
