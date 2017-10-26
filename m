From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH resend v5 3/3] platform/x86: intel_cht_int33fe: Update
 fusb302 type string, add properties
Date: Thu, 26 Oct 2017 22:33:23 +0200
Message-ID: <20171026203323.w5xj2mms5epda6pt@ninjato>
References: <20171011094121.6108-1-hdegoede@redhat.com>
 <20171011094121.6108-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ab45oeqlemti6fn4"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171011094121.6108-4-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--ab45oeqlemti6fn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2017 at 11:41:21AM +0200, Hans de Goede wrote:
> The fusb302 driver as merged in staging uses "typec_fusb302" as i2c-id
> rather then just "fusb302" and needs us to set a number of device-
> properties, adjust the intel_cht_int33fe driver accordingly.
>=20
> One of the properties set is max-snk-mv which makes the fusb302 driver
> negotiate up to 12V charging voltage, which is a bad idea on boards
> which are not setup to handle this, so this commit also adds 2 extra
> sanity checks to make sure that the expected Whiskey Cove PMIC +
> TI bq24292i charger combo, which can handle 12V, is present.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

I can't apply this one. Is there an immutable branch I need to pick up?
Or shall this go via another tree? My base is v4.14-rc5.


--ab45oeqlemti6fn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnyRpMACgkQFA3kzBSg
KbYV5hAAmPY9huUdoyhu+YG6Q9+L+i5knzPgh/DnImd8O/g6uEPYJhxyMbX5YSdL
00M0UBluArH6DUeAZZXJt8Ggq13d3tPvX/EpKDQe4ItA2zmubuBc6glDPKN1apda
myF+65WB75mSnBpZy6MHf38Tff40Tc0Xya8MNkHHU3W2nd9klAFPc5OQCuQahfFi
aTOxjV7njt0gcEZj7lH9GFFwBnHuijlJOyR1jIeycOFoUgUu4kBgJZORvuwItGO5
EnG3tIc0cTE60GzpL9tn8U1YAiuiqZKY8+nyae3HMdcBMJQ9bSRch/heUa403dqr
b84ir+0/eIzTi4WYCconFxU/vuvJr+lm1qceRlz19j0DOST19M3aTu7YcRbb/LO+
8yroDv323sl4QOOThKv1mEoDL9p2CCnXLCxXKgGnmKdjbJ5RFoiL6QWoAfBk2lve
XmPTA6S06P+ntXtoZtinZtef9Am2Woxv3nGydEe3cwoJEx8nFvDuHKGwI3mZkNbI
kbLovk6R0B2YeZfS9B60HRUyzPIduygZZeZQApGpsyr78zTEbP/yayoKwDidfkbT
u/Rp4gittCgzkmbtpyG7f609drvxiKyA4XV+6SD8jN6m+JcHNhhDbAvu7RWBopHP
K3q8ThJcDz0U0uRVamXFuGVQ4skEdV8m5mZC4FPUhaOeHRMCNcQ=
=Eyki
-----END PGP SIGNATURE-----

--ab45oeqlemti6fn4--
