From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Do not use parameters from ACPI on Dell
 Inspiron 7348
Date: Thu, 15 Oct 2015 13:40:29 +0200
Message-ID: <20151015114029.GB1546@katana>
References: <1443085614-101362-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38155 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600AbbJOLkg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 15 Oct 2015 07:40:36 -0400
Content-Disposition: inline
In-Reply-To: <1443085614-101362-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Christian Ruppert <christian.ruppert@alitech.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Pavel Roskin <plroskin@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2015 at 12:06:54PM +0300, Mika Westerberg wrote:
> ACPI SSCN/FMCN methods were originally added because then the platform can
> provide the most accurate HCNT/LCNT values to the driver. However, this
> seems not to be true for Dell Inspiron 7348 where using these causes the
> touchpad to fail in boot:
>=20
>   i2c_hid i2c-DLL0675:00: failed to retrieve report from device.
>   i2c_designware INT3433:00: i2c_dw_handle_tx_abort: lost arbitration
>   i2c_hid i2c-DLL0675:00: failed to retrieve report from device.
>   i2c_designware INT3433:00: controller timed out
>=20
> The values received from ACPI are (in fast mode):
>=20
>   HCNT: 72
>   LCNT: 160
>=20
> this translates to following timings (input clock is 100MHz on Broadwell):
>=20
>   tHIGH: 720 ns (spec min 600 ns)
>   tLOW: 1600 ns (spec min 1300 ns)
>   Bus period: 2920 ns (assuming 300 ns tf and tr)
>   Bus speed: 342.5 kHz
>=20
> Both tHIGH and tLOW are within the I2C specification.
>=20
> The calculated values when ACPI parameters are not used are (in fast mode=
):
>=20
>   HCNT: 87
>   LCNT: 159
>=20
> which translates to:
>=20
>   tHIGH: 870 ns (spec min 600 ns)
>   tLOW: 1590 ns (spec min 1300 ns)
>   Bus period 3060 ns (assuming 300 ns tf and tr)
>   Bus speed 326.8 kHz
>=20
> These values are also within the I2C specification.
>=20
> Since both ACPI and calculated values meet the I2C specification timing
> requirements it is hard to say why the touchpad does not function properly
> with the ACPI values except that the bus speed is higher in this case (but
> still well below the max 400kHz).
>=20
> Solve this by adding DMI quirk to the driver that disables using ACPI
> parameters on this particulare machine.
>=20
> Reported-by: Pavel Roskin <plroskin@gmail.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pavel, have you tested this patch?


--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWH5CtAAoJEBQN5MwUoCm2wS4P/10psTf9cfhS4z6iI3HLQ72x
E4tLWvWNlRt/sijg73U3K+T4j7qYiJnTNkpUogwch3Me2etP6e5qkzOvv0xX+pxH
wR9aplNs0NmSPu23kJTD02kkTP4I9EhDqv4XWhtZQ8zBjRAvgW8A2oPBnv9pr+0A
4Z/DQTXgzwCDbOnfNSg1Wcs3schCHfWPGDqZCJS2D2S3KohbpYeJc0ZMpixJUlGg
/3HacoA3zAPhZ5TTOc8qdjAmfZ01zgkaOdittJgKZ//Ox2sbFcPzqY+pJ+f6yrQh
DJ/aNBp7PR8VOspPLHGThBISyHRN4V3qAaRePqo+7WRK47x5iFgofnZYDn9bAR6P
RDN+T7Ce8fgM+P92eaDI18RgDYS1Klp5NDYb7FI/9JlLfGgX/o1I5kBIqOHrBlUN
EVTISEks+tI5t9CcUZcd4XFZsLgWWAvlb7AID8k7HvJae40FmHfo9c1Fmp0DAgu/
vd1QYSaN/5qkYaEXGN/8dhkOb1sN3aJ1+gYJrrARboFoIV/DLYYKzRTqzufxNWfT
pHfImPimeOdczSisiJaBq5HDa8hJZ6EfCBgyH2iZFAhKQWJGoKQFjIaOdtmyNo77
OJY++b/fAnHMqiwBjvL/6mzBcLwU2BfxLtt7BTH4wv5oqF5qWL8NsoYLI9Cm+4qS
gdpanfz0LO/BnoZbd4wI
=wAX2
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
