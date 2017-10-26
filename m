From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH resend v5 2/3] i2c-cht-wc: Add device-properties for
 fusb302 integration
Date: Thu, 26 Oct 2017 22:30:23 +0200
Message-ID: <20171026203023.tprixzub6u22jkhd@ninjato>
References: <20171011094121.6108-1-hdegoede@redhat.com>
 <20171011094121.6108-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ddtswb5solb4jvw4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59692 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932408AbdJZUa0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Oct 2017 16:30:26 -0400
Content-Disposition: inline
In-Reply-To: <20171011094121.6108-3-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--ddtswb5solb4jvw4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2017 at 11:41:20AM +0200, Hans de Goede wrote:
> Add device-properties to make the bq24292i charger connected to
> the bus get its input-current-limit from the fusb302 Type-C port
> controller which is used on boards with the cht-wc PMIC,
> as well as regulator_init_data for the 5V boost converter on
> the bq24292i.
>=20
> Since this means we now hook-up the bq24292i to the fusb302 Type-C port
> controller add a check for the ACPI device which instantiates the fusb302.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-next, thanks!


--ddtswb5solb4jvw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnyRd4ACgkQFA3kzBSg
KbYJGxAApk6A3baqYxM+ks1G+dCx9WJJdwehKLB5o1EXzLmccHntlWbCLCLeZwpa
nEkenUhl55G2//jRW0v5lpvdLd4OwIjZS4q1ZBtPjkP1BzwtgBomNWmruUQuqgKh
Z43h8zbwnrQdXhIkxOlL2D8uCOtwXVoyhMFEnMibrbgOEUCZfr7M5u2GuCPGEx8T
Kb04zJujQMLPuC2HMkWUVC9szSZlzIozO314/etfc3a8tLTAHt3xRQfRFL8uT+KI
1ga+nf2Jef+Cw45febGtci+VLYCIvXano6jwMTbfvCly4wXWkqtBxNVNIXvgfdFR
SgLZ/rwNSyS+Jf+cJ/mVmWJjsFWnNuZP/tCKWjOb3nCM+KUs/ZRnvywXc6KhtYdd
ksC89lZJTI9fqe06FqMdfDSHIj9+lQbizql66eQ5fwAzBlq5wxAvL8SoVWzPj+cE
iABp8hCb7P3qNl3KxI7+ZKt7y/3k3POhXgxNJXSc0xE5fTAlrKxMzNnzuiwxPZj+
YAz4KijlIgBrvASxMpZIYcnI7VoOL5X92K9nArXImi0uY7BP4XlYOmt74BablIt3
0eZUylCdIt7ZxOp4Hi6JDSNGqvt434DxJYdnmwIJUepQCnnkI0JJxL2GiayJieCb
NiDs93nCcRJpM31XIsDa/hR9v0RmxqMUNj5VMTIe1fskVQTnlI4=
=vGWt
-----END PGP SIGNATURE-----

--ddtswb5solb4jvw4--
