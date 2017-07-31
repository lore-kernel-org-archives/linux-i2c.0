From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/2] i2c: designware: Some broken DSTDs use 1MiHz
 instead of 1MHz
Date: Mon, 31 Jul 2017 15:56:31 +0200
Message-ID: <20170731135631.xyhigfsvahsvgz3q@ninjato>
References: <20170713134502.10816-1-hdegoede@redhat.com>
 <20170713134502.10816-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="elpj3bqeczu624y2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:49368 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752302AbdGaN4d (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 31 Jul 2017 09:56:33 -0400
Content-Disposition: inline
In-Reply-To: <20170713134502.10816-2-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, stable@vger.kernel.org


--elpj3bqeczu624y2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 03:45:02PM +0200, Hans de Goede wrote:
> At least the Acer Iconia Tab8 / aka W1-810 uses 1MiHz instead of
> 1MHz for one of its busses, fix this up to 1MHz instead of failing
> the probe of that bus.
>=20
> This fixes the accelerometer on the Acer Iconia Tab8 not working.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-current, thanks!


--elpj3bqeczu624y2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAll/Nw8ACgkQFA3kzBSg
KbZb5Q//QmNQOjpP6AJ63NzWA3iDm2frHdg3OEiroO4gixtOR2ZJ8f4LeZ1QHkuM
XKUaR9xss+Te+tUCEO7zm655Ml6OU75Eb1wQQUEnr/wylMYg9GV9gLpXq+nRyF8q
1ScZp5sHFJ5N4CGC9fyWtqgAbwXxCLrb1GLkceQ3TD5yumgXkn0WhmBWxrZh5EI+
CwQ0ddI6/yD0RMAhxqhJo9oeXbyM6cR4st4Epff7lUN/wsWtU4uobqidTsaF0iwx
s+VEczi9HqJmaKM8opB85xPqk4pIjkn9y7tQgPuiGXsl/XTzDuVQqMEs8AxpiznC
LQdPsZNiZgq6gTRghHZX/dFYcW3ciDq46JLWmPtMy7YY8gc11r731pW+coXuIhvw
HeL3lo9FNmAmX9ufa8jut/UV3dpuBgaWKZSRLnWx4Q2ccPMagSnKKaiUYXKsLCIK
6d0fJSJar/Ji9CZgzK0HnGnA+st2qx++IehxpyrY/KyluhUpgHLzie4d5nc5zaCd
OBMkwHTAW3uWzjHQyb9YvsM3mWbq0lBoUBoka0UGgfY0K1VjOBJsavojeNeLQtdv
k0TNuXlRY/pRG9Dd1BDEsBtcf9/pgnU6GxTxchtCeqxWuh64clvwCFZcZ0Wavnua
NIJMBA9NnPFu7nCwey3+zQzYpgHwWKxljcSimhbI3YWic0gGi2Y=
=o9X1
-----END PGP SIGNATURE-----

--elpj3bqeczu624y2--
