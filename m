From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/3] x86: baytrail/cherrytrail: Rework and move P-Unit
 PMIC bus semaphore code
Date: Sun, 14 Oct 2018 15:17:24 +0200
Message-ID: <20181014131724.GA863@kunai>
References: <20181011142911.13750-1-hdegoede@redhat.com>
 <20181011142911.13750-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181011142911.13750-2-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 11, 2018 at 04:29:09PM +0200, Hans de Goede wrote:
> On some BYT/CHT systems the SoC's P-Unit shares the I2C bus with the
> kernel. The P-Unit has a semaphore for the PMIC bus which we can take to
> block it from accessing the shared bus while the kernel wants to access i=
t.
>=20
> Currently we have the I2C-controller driver acquiring and releasing the
> semaphore around each I2C transfer. There are 2 problems with this:
>=20
> 1) PMIC accesses often come in the form of a read-modify-write on one of
> the PMIC registers, we currently release the P-Unit's PMIC bus semaphore
> between the read and the write. If the P-Unit modifies the register during
> this window?, then we end up overwriting the P-Unit's changes.
> I believe that this is mostly an academic problem, but I'm not sure.
>=20
> 2) To safely access the shared I2C bus, we need to do 3 things:
> a) Notify the GPU driver that we are starting a window in which it may not
> access the P-Unit, since the P-Unit seems to ignore the semaphore for
> explicit power-level requests made by the GPU driver
> b) Make a pm_qos request to force all CPU cores out of C6/C7 since enteri=
ng
> C6/C7 while we hold the semaphore hangs the SoC
> c) Finally take the P-Unit's PMIC bus semaphore
> All 3 these steps together are somewhat expensive, so ideally if we have
> a bunch of i2c transfers grouped together we only do this once for the
> entire group.
>=20
> Taking the read-modify-write on a PMIC register as example then ideally we
> would only do all 3 steps once at the beginning and undo all 3 steps once
> at the end.
>=20
> For this we need to be able to take the semaphore from within e.g. the PM=
IC
> opregion driver, yet we do not want to remove the taking of the semaphore
> from the I2C-controller driver, as that is still necessary to protect many
> other code-paths leading to accessing the shared I2C bus.
>=20
> This means that we first have the PMIC driver acquire the semaphore and
> then have the I2C controller driver trying to acquire it again.
>=20
> To make this possible this commit does the following:
>=20
> 1) Move the semaphore code from being private to the I2C controller driver
> into the generic iosf_mbi code, which already has other code to deal with
> the shared bus so that it can be accessed outside of the I2C bus driver.
>=20
> 2) Rework the code so that it can be called multiple times nested, while
> still blocking I2C accesses while e.g. the GPU driver has indicated the
> P-Unit needs the bus through a iosf_mbi_punit_acquire() call.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

For the record: once the designware maintainers are okay with this
change, I am also okay with it going via the x86 platform tree.


--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvDQeAACgkQFA3kzBSg
Kba8cw//bcFMGnUf5u7LGI5EJg3nCoZhj4aZTu/Z4yxcWFtkgN3duynk3hnf5NiM
XcbT+8L/nIsvg2JhvBcGFAkFk4qIbMS5sibBWxAjrDpxR2welru8R+gk0kLqyxIL
LPT81ikAVz/nZ9Qd3smDu8cel6N2uu7bYGHwQdXszdp74prV64ZBbiByaV29zy59
LjvyW8+mBHszrrbnJu80VjmAhGFb2eYk8n7j/Csa/WdYZMZRxCTxkXzc2wmJva87
m3ZH132QJ73GLpnY4+Ey1idJyWrob65IXi3A3UklKsbzPWJWAyGuZPlr7O9/Ttx/
jYUvW7qJrA8+GmwPkbGRx9eL7oAT+ixZDAUEvi2ASxysh6e+pluvZTvM0S1gyU0/
Fh3fOLu/QmALd7ki3urs7fPJR113JU5eyQeF4FLQu2JUW0KPlLjTL07PlciEOqDK
hQIjWnGbJTi+5wsrQI0PC2D1GqmBvhT384ZvnT4GAL4kbog7ZAuiBtcKG5lgGOup
DHWkBHokM2zSMAsbYCnDbBcK4zVC54OR715w6hcFAlld3Tr3UZI0Y764zZ9R6moz
SPntQgy8ABOVdpOWY4yLZinkxRXDb0sJ8LNefF6C5UoJ7ht//BKvMdustiHE4yr6
16wk5RxkAnB0jvGMcPrTYhVYXJqvRnYoXfCwJRG26vTQl6ygsFU=
=iVmh
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
