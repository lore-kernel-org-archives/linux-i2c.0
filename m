From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Do not use parameters from ACPI on Dell
 Inspiron 7348
Date: Sat, 17 Oct 2015 19:57:26 +0200
Message-ID: <20151017175726.GB3359@katana>
References: <1443085614-101362-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50610 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652AbbJQR5c (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 17 Oct 2015 13:57:32 -0400
Content-Disposition: inline
In-Reply-To: <1443085614-101362-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Christian Ruppert <christian.ruppert@alitech.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Pavel Roskin <plroskin@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
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

Applied to for-current with Pavel's Tested-by:, thanks!


--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWIowGAAoJEBQN5MwUoCm2HtUP/Aym2c6U7R9xGPmR/XsPDGMN
Db2v0R5FdV1nn+NiB4njIbaJFrAZ0ZMenQo/Ln/E3MPK/0PorJ5fP5KHMzu0VZvs
CwmfJvS/6oO5qAKsOinwOl9xmS63gfH3JCvJ8MoYJ9Ln1oDeNSCZ54RQRQBK3BLm
ICWuCs40+cZMngOODlUEW08IaoJAbaoS2/gtmv0slRn6O84moCTGuN0vXTDo7rW1
8Vi30KDHbwwx4u6GXowGhzvnx5dIde3xUgCQ41H/wE27rLNX5fmg7Is7SxlZ1ubR
VjJKc86I7eEGezPXZbirw/tvwE9czl7RwGdGkUMhU4aF4a3hrhnYtqZPdOJdOoFG
8L06n3MO7m9kz0F8OSie33AdsE2W2U6IQsNUO2db5Xxp1kLReotVjHPSkBH9TBus
dXN9s8h1bymzcGrRmBLJ/uwKg71q0PPGG5iWU00aCqR0MoSBKqmdyj9guadaUlHE
T4MYi7h1i/hWLddRxhIRJvofXExNLjwRM3XBiyBh3TQDVSaN3RHO3mMRd4dfiUsv
RcamrlMQ5XCX9IS4Da6wd5guR2lJpHTXMiBoIfRltVMp52NVrnQpR/f6mwDcf0fi
mTfj3KG9Iqfr+fs+aL5SmmGlQ63KbJcJTHc0GnOj2F/FmrlGZyONfC/f2e0pR/cH
PBFwogsBfghHrciahK68
=p+ou
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
