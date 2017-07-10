From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1] i2c: core: Protect acpi_match_device() against NULL
Date: Mon, 10 Jul 2017 20:21:52 +0200
Message-ID: <20170710182151.xes5biaaj7jwkhzz@ninjato>
References: <20170709131618.12121-1-andriy.shevchenko@linux.intel.com>
 <1499606299.22624.315.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wbb7pxtcftq3beqo"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1499606299.22624.315.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org


--wbb7pxtcftq3beqo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 09, 2017 at 04:18:19PM +0300, Andy Shevchenko wrote:
> On Sun, 2017-07-09 at 16:16 +0300, Andy Shevchenko wrote:
> > The commit 09b3b246acba
> > 	("i2c: core: Allow empty id_table in ACPI case as well")
> > brought an additional check for ACPI match table entry, though missed
> > NULL check for table itself.
> >=20
> > Do it here by introducing a helper i2c_acpi_match_device().
> >=20
> > Note, we rename some static function in i2c-core-acpi.c to distinguish
> > with public API.
> >=20
>=20
> Wolfram, feel free to squash it into the original commit if it looks
> better.=20

I didn't want to send Linus a branch which too many last minute fixes.
That's why I dropped the original patch and would like to ask you to
resend a combined patch after rc1. If it is a bugfix, we will have no
problems getting it into v4.13 but it seems a bit more testing is
needed.


--wbb7pxtcftq3beqo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlljxbsACgkQFA3kzBSg
Kba3tQ//UcDKVHFKP148nCuK1rL7fcFe5kZmgDUd3bAemt9UG/X3syZdZupkNaoq
Q8u1hoeR9nXdHuwUvvGeKHyBreePTgCtnoagmHddmQijib4jwREHy8kR30ANWSuR
KLdYddH5yrl9cbQDmS7x7TDoIJ5BzJAs8nGJpe+l2X9nTihpychuOxglX8b8Gg4h
7hgrbGkpZtQpmgNx2dYNRhg+MDxQv8HQdMvj6DcjRQKS1TJkt+MoHObsezX7AjMi
2OjaqAFJWoMqwtqpgN9/ppkhBO7/LOidwlf5XeRWeANmzGE1KK1eSx270WuVWZoa
TSV7qMkbHiohd0Vy7d7e+4L7qLGHShYWr3SG5QVHJWM392upme+dpFiJA5K7C1hN
0zLe/QN2kYMFzoA13DlkpZbG8HsAF5v1vbYZtCUTtqIg8XCK5NZMQ2CKQmgBmPPp
JmLcbjT4iIaKF5wkp4Sbmp01SBnMn3nFbn7I3/p2gjXABKmFXSycptoJP+qUfjiW
0we0MIXjeArQrbv83ifhisOBGSq3amNs0iNfVLZayllQBCHHXgXjw6y6AUKiJyV7
PhUnF448Zw15SIN1PF+QqtgNRck/qWchYzvLwoAxCbzSNBKIHUUjr+kCSWsxzpYN
m5gNinoDJjJgSqMaaFprEAN3i0AkWEIj4Pj6Y5fBcS9wPY9Ru6U=
=M2PT
-----END PGP SIGNATURE-----

--wbb7pxtcftq3beqo--
