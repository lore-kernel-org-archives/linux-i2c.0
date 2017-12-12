From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: Include GPIO consumer header in main include
Date: Tue, 12 Dec 2017 23:33:19 +0100
Message-ID: <20171212223319.4fuzn3w6h4hwbcwt@ninjato>
References: <20171208133934.18038-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6r7tbm5wlpyug452"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46061 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752772AbdLLWdV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 12 Dec 2017 17:33:21 -0500
Content-Disposition: inline
In-Reply-To: <20171208133934.18038-1-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--6r7tbm5wlpyug452
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2017 at 02:39:34PM +0100, Linus Walleij wrote:
> It seems most users of <linux/i2c.h> pick up their
> dependency of <linux/gpio/consumer.h> from other paths but
> that is not a universal law, so include the header
> explicitly so we have struct gpio_desc available.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Not sure. Having GPIOs is not really a requirement for I2C. I tend to
think drivers using it should include this explicitly?


--6r7tbm5wlpyug452
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlowWSsACgkQFA3kzBSg
Kbbffg/+OZ18iOVgPayWx258EUdHvKfQi16GnK9lC/OMKe+QJOzf3fFI5W+Hex9C
XZaIIB/hE3yGDf8NO5iSb2iuQlajIu2RtNJt94pheETR7VW/hFSlO26IEe597S8t
zZEDsqlWi16IoO2EzupeB/mIeJO9kcnGzx8JmHISqTbLYZnDssHQ1+sxLzgSIKy0
YOfvr0ehQSyByeqZi3u7M30tjSQkfaSy4kTlJrKvkCPJ/NH5P+SKH5I9k6ObEmjb
mirOCYNfnkRRtN1kXD2vJEZpiDynH4QBOiWD7ogaDFUoYQUcQRw2BLisgdjzyFZi
5/N3QgKqbgRt1Py9nxkDMRDXDtjnYppCrTlBjkE4f0IC+wj30XVZ0bcZdMwvQR6+
8oXBDQL3cAPmu8lXYRsZVS8lg1Zrey2cn3Z2OR66J7+DSK7Gu9x3lQx8+rbMoEdV
3cYI1mW9cvx7/O21BU/YMwEadMXIt5T+py4ZV7BXk1VEIP/JNq6ceYeSBVIz5zTj
YR8iB3IKDlfS5dbYdYYFq5TGOOniDqgURIwUFHT/NnYjAuTehpKo6JvUXuWaOtn1
XvaKhVfJlgQ5CKSM9kic54azPa7viO5CvIEQj/CHIqlpIjEJAAghYW9QYF7YT11F
9ryxWdPM72ENa44eWFX8XeYxsugRngBPFtQ1HhkYE/UasQEQWNU=
=xQGl
-----END PGP SIGNATURE-----

--6r7tbm5wlpyug452--
