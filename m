From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 00/10] i2c: meson: series with improvements
Date: Thu, 30 Mar 2017 17:56:51 +0200
Message-ID: <20170330155651.be6kcggq4bb7py4p@ninjato>
References: <645519b8-93e6-57b1-ae8f-7804c6beb9b1@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f5a3tkhj2v4cb7ec"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39469 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933610AbdC3P4y (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 30 Mar 2017 11:56:54 -0400
Content-Disposition: inline
In-Reply-To: <645519b8-93e6-57b1-ae8f-7804c6beb9b1@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org


--f5a3tkhj2v4cb7ec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 25, 2017 at 01:57:00PM +0100, Heiner Kallweit wrote:
> This patch series includes several improvements for the i2c-meson
> driver.
>=20
> Changes in v2:
> - removed patches 8 and 12
> - removed one small change in patch 6
> - don't print error message in patch 7
>=20
> Changes in v3:
> - changed order of patches 3, 4, 5 what makes the patches more simple
> - remove one change from patch 7 to still properly deal with timeouts
>=20
> Changes in v4:
> - update DT binding documentation as part of patch 4
>=20
> Changes in v5:
> - extend commit message for patch 3
> - remove unused properties from binding documentation in patch 4
> - replace WARN_ON with dev_err in patch 5
>=20
> Heiner Kallweit (12):

Note that since v2 the above "12" is obsolete ;)

>   i2c: meson: use min instead of min_t where min_t isn't needed
>   i2c: meson: remove member irq from struct meson_i2c
>   i2c: meson: set clock divider in probe instead of setting it for each t=
ransfer
>   i2c: meson: use i2c core for DT clock-frequency parsing
>   i2c: meson: use full 12 bits for clock divider
>   i2c: meson: remove variable count from meson_i2c_xfer
>   i2c: meson: improve interrupt handler and detect spurious interrupts
>   i2c: meson: don't create separate token chain just for the stop command
>   i2c: meson: remove meson_i2c_write_tokens
>   i2c: meson: improve and simplify interrupt handler

Applied all to for-next, thanks!


--f5a3tkhj2v4cb7ec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljdKsMACgkQFA3kzBSg
KbaPmQ/+IB1PXhmtMcRATR6mf99nUK5Oa+sOYMeHXQ5d7oZ5BXHiAJXbJwKcQHPv
kLD5wa3CriMcUPKTY2KL1IZpsbvXCQR8MT/ZjivJZf5SUNzqJLEOjVktuBuT1GY1
HQPJT5B2arL7BTdwpDWyf0E+m899FXgLxALuGdhXyRsKryxvCZ6/XT988HA3/STJ
WcJO5HEcsRgj9pMtYxVrTfJRJrEOULrzsoVd+cHujwOVTt0SyXKQJvYkMK6gAznd
JkNjlBNVyCQra+wnZAknBPdV+b9Vz8fC+D5emH7/qhCxxSd1oBPKwkWBT2IoRkFV
P4/14QWa9i/kDzXgsfnFYtUtqeQEo6KQijSIQzQ020JOPgzCRDQI1Ctu8pwff3MD
on3g8fia53d0LgLyfR0XqlFg6Xea5fUA0+rgQDeOaKOW7rCvFFevfbsfIeoOUSXc
R/AF7WzAQSh7KKzpLXTSQw0AA6W8o/a/VqRYpl0xKrfqprXv7GpnqKe1nWHh0OeT
GSGN5IMYM33hb90KhP9hHlsN6vtTUR17RNNkBF/M5tmr+8hJiI40OvrFspthzfBU
c7PuetPFTG0C6Ipw3YxlUSmhW2j8fYM2B4SpzL4Fi+nh4mydWqKcDJtYDODGPH9G
ypFr40+RnE5vr4yQkbFt6oKNEzaMrJS7xhnCNJNmbR//K+MmZg0=
=3bqH
-----END PGP SIGNATURE-----

--f5a3tkhj2v4cb7ec--
