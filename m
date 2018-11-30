From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 09/15] i2c: acpi: Introduce
 i2c_acpi_get_i2c_resource() helper
Date: Fri, 30 Nov 2018 10:55:33 +0100
Message-ID: <20181130095533.GC1079@kunai>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-10-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181128114535.80223-10-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 01:45:29PM +0200, Andy Shevchenko wrote:
> Besides current two users one more is coming. Definitely makes sense to
> introduce a helper.
>=20
> No functional change intended.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/i2c/i2c-core-acpi.c | 41 ++++++++++++++++++++++++++-----------
>  include/linux/acpi.h        | 11 ++++++++++

Any reason this is not in i2c.h?


--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwBCRUACgkQFA3kzBSg
Kbb2Zw/+KIFR//ViXIFxnfqfmnDmACP6YVFjHscMVU/c8XCmSkNjN/YHrfuWTOTB
PWtzB2d6SsVwnnmijfxllUo8mgb/aj27T29nSin5oW7lKJ4OW5aBJIKnI3uo6gTU
O+eaSIXlxdnzYUR6z7twqZ32zQl6wgAC3IjAtyAR1650hvoy+Zb99V12jqpDsy8J
adxra4PFbuUQxMUe0vmofS8DZtJ1/M/WAnih0ubqiBGIlHGDSINmgatdTAFYA4p2
jQ0mWo31A+BYNFhtY9Dcj2xr7rlPMjg8DSqU2wbD+4nPGBsvzqvoGdkAImsDic1j
W9qp3KrgHDWkF7mGuHML9NMOZ1r+2BXYIHXfElSfOaAQFsMyVKWi1TUsd0ftEw+S
rOrOL/h0MbXlC1nUkYC/1uIcvb4D0Qh4T06n3WQsFSkqgYxugX7bwSfitKm12Sa3
VfvkmBn2WlgnOirDPmPhSouvCal/gstrLBT0QA3PmxZfrRr33THHwECOGA71qtDR
IUdDv7ZY/7/3yEA8xdl73FSv/le3IU9KLkhfYsbNmwM7bAzVEZTNAzhSP32xNaQy
LPSL/flRFo2EhLNWNMYEGcusOae7bt9JU5g0qkO5um56rWN0GdgUEcg3tPV+w3ay
4SQJZOtNDGYY3IHEkgssllnTsvKOs1pSSQGyfgk2n22Autsu8ko=
=nGlL
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
