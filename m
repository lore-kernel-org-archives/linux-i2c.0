From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 4/4] gpio: pca953x: fix an incorrect lockdep warning
Date: Wed, 21 Sep 2016 07:45:21 +0200
Message-ID: <20160921054521.GB1484@katana>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
 <1474041765-17818-5-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43963 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751226AbcIUFqF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 21 Sep 2016 01:46:05 -0400
Content-Disposition: inline
In-Reply-To: <1474041765-17818-5-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 16, 2016 at 06:02:45PM +0200, Bartosz Golaszewski wrote:
> If an I2C GPIO multiplexer is driven by a GPIO provided by an expander
> when there's a second expander using the same device driver on one of
> the I2C bus segments, lockdep prints a deadlock warning when trying to
> set the direction or the value of the GPIOs provided by the second
> expander.
>=20
> The below diagram presents the setup:
>=20
>                                                - - - - -
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
> The reason for lockdep warning is that we take the chip->i2c_lock in
> pca953x_gpio_set_value() or pca953x_gpio_direction_output() and then
> come right back to pca953x_gpio_set_value() when the GPIO mux kicks
> in. The locks actually protect different expanders, but for lockdep
> both are of the same class, so it says:
>=20
>   Possible unsafe locking scenario:
>=20
>         CPU0
>         ----
>    lock(&chip->i2c_lock);
>    lock(&chip->i2c_lock);
>=20
>   *** DEADLOCK ***
>=20
>   May be due to missing lock nesting notation
>=20
> In order to get rid of the warning, retrieve the adapter nesting depth
> and use it as lockdep subclass for chip->i2c_lock.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Linus, we'd like that in 4.9. Can I get your ack for the gpio part?


--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4h5wAAoJEBQN5MwUoCm2q2IQAK3UXvisqHb4hnf6re5CfGg8
Sv9QeabfKYPTq0uL2qKzmcZmXdi0ES+vivSZl5y+duYKkZBSxqRX09jrL7+JaXO0
dhPzEsbaag+7mGR/+yqrzN9rLwyfFCA3jj7DQqdSjxi+3IiGwNUu5blfcyuGJkcr
foxMl8k9OyygnOxSbQpv2hFed6Hvbb9hspWKOBE98a3r0Zuc2UaGLq0UclhouTsl
RMgQf041mLt9Sy0inm/Tmei75yF+R89mrCI1YT3V/PoQvqKjB96J//u9qJPBYDq9
e6fFNy3mhoTTZHn16GA3q+TE/5ownVNKEbYEPX49v4fZ2ZFJu/i1l+os5ML8Fl+Y
0jZZspNapqne75TporBiBBoljGByvELjPQIOwhyHucEm3ujUt8LeQTH8zpWz89HK
JZWVF2MuyrFQW+DHkCopSkwRQXOwfhld16JMv6xDZxszpZMMJjp1bxxcY5FCIoki
gtFlvOa1HXAiLSvgFilUNVBedZdiaETPVnpjqnMp5TKtLsvVAbhXRw28OHi8zNiY
22tpLrD+gyr6TO5hcD64W9JZE5rIW20+OiGxzkviLqBbU4W403sVy/LJNiGLdkIW
ODSLrtqIw8kc8nN6+ZXAIGrkHVb3XKvTwKJ5TvH0TXf1nxeH0+PaegxuOUjPNwuN
UaIw6xtDywYTvwD3JKKP
=xUs+
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
