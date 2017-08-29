From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Round down ACPI provided clk to nearest
 supported clk
Date: Tue, 29 Aug 2017 22:18:26 +0200
Message-ID: <20170829201826.htdia6olxs3j5k66@ninjato>
References: <20170829120835.17276-1-hdegoede@redhat.com>
 <1504009379.25945.142.camel@linux.intel.com>
 <078c7214-230e-2a68-734b-2a01003ee378@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7t4jmlr4yb56t7mi"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46201 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbdH2US3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Aug 2017 16:18:29 -0400
Content-Disposition: inline
In-Reply-To: <078c7214-230e-2a68-734b-2a01003ee378@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org


--7t4jmlr4yb56t7mi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> > I dunno what standard says if we may or may not use 100 kHz as a last
> > resort even for speeds defined less than 100 kHz.
>=20
> The < 100000 case is for when i2c_acpi_find_bus_speed() returns 0, so
> that we then keep it 0, in which case the code a bit lower will pick
> a default.

This is fine by me.

> Since speeds < 100000 are clearly not valid treating them

Here I wonder: Not valid because of ACPI specs? Because I2C specs surely
allow speeds < 100kHz.

> as ACPI not providing any bus-speed info seems sensible to me.

Regards,

   Wolfram


--7t4jmlr4yb56t7mi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmlzBIACgkQFA3kzBSg
KbaBMRAArElIM09m0M0r0bU1l0CYb70Fl0+QzoZugkJKQdRbwYwZeFnhdPpCFUIY
cgKcDpC6NRDyTSiXYO1bxnML4WuDVAGik+830cvx1cvGvWWntHDQljC9iufHlnJL
pQYhUPJcDfg/VKIF9td6WIWsvlqThjj9G5isivrUO1PD1LF9tI63kwGW4H/7B1Kb
uFur+bRDeTNX/2uL/M4ojwemHugMlPYs3nhshsuJWVl7k4NXiGPGLvTmS/4E2jq9
XptpPpI2xoSdZUXGAGBdaMmEtEo3C9gP0kY48I/szZEiBtVvhrAx2m+m508QhhVw
upDbNpBGzEdk6sPIPNJw/CSt78Qm9nA9hMOmTPKPfTtq8zSfNEmqPTOFFxug3NmG
YK7JdFaSqksgtHHl5rkNWkpyHA8fFv0oaDMMDBl7sDk6y348gPLSOTjqQEEb6+aD
3qXr79qFoZZwQtdn+uKe1g0AIdU6cOfD712dsTSCbHaxzFzUsa1Vw1IhddWblTj/
jqQoC4MfgZppkqL6tiEqQfGTSPgq7KBrPrpNotIg+mn8mzuidgINjIyI2NJ0bjHV
E8NyIUAUduUh2KFDktyCFZTrcTu+urr7F26cOcvpTp+VUtgMLmMb7Dse0F46MPa7
9nSyHSGf6sUdtz8vUCoOfCFHt0itAZDFh73aNKJ5tOLb6YmT5P8=
=7j2g
-----END PGP SIGNATURE-----

--7t4jmlr4yb56t7mi--
