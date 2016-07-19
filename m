From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] i2c: core: Add function for finding the bus speed
 from ACPI
Date: Tue, 19 Jul 2016 06:33:59 +0200
Message-ID: <20160719043359.GF1640@katana>
References: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1465212383-24639-3-git-send-email-jarkko.nikula@linux.intel.com>
 <20160714133540.GG4149@tetsubishi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y1L3PTX8QE8cb2T+"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56397 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505AbcGSEeG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 19 Jul 2016 00:34:06 -0400
Content-Disposition: inline
In-Reply-To: <20160714133540.GG4149@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>


--Y1L3PTX8QE8cb2T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 14, 2016 at 10:35:41PM +0900, Wolfram Sang wrote:
> On Mon, Jun 06, 2016 at 02:26:22PM +0300, Jarkko Nikula wrote:
> > ACPI 5 specification doesn't have property for the I2C bus speed but
> > I2cSerialBus resource descriptors which define each controller-slave
> > connection define the maximum speed supported by that connection.
> >=20
> > Thus finding the maximum safe speed for the bus is to walk all
> > I2cSerialBus resources that are associated to I2C controller and use
> > the speed of slowest connection.
> >=20
> > Add function i2c_acpi_find_bus_speed() to the i2c-core that adapter
> > drivers can call prior registering itself to core.
> >=20
> > This implies two-step walk through the I2cSerialBus resources: call to
> > i2c_acpi_find_bus_speed() does the first scan and finds the safe bus
> > speed that adapter drivers can set up. Adapter driver registration does
> > the second scan when i2c-core creates the I2C slaves by calling the
> > i2c_acpi_register_devices(). In that way the bus speed is set in case
> > slave device probe gets called during registration and does
> > communication.
> >=20
> > Implement this by reusing the existing ACPI I2C walk routines in the
> > i2c-core. Extend them so that slowest connection speed is saved during
> > the walk and I2C slaves are registered only when calling through the
> > i2c_acpi_register_devices() with the i2c_adapter pointer.
> >=20
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>=20
> Applied to for-next, thanks!

And reverted due to merge problems and 3/3 not being in shape currently.
Please rebase on v4.8-rc1 and resubmit.


--Y1L3PTX8QE8cb2T+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXja23AAoJEBQN5MwUoCm2fdkP+wXHuKTk1wwNCgtG6JFgUsG3
7NAR6b6W6IhJIYxfwz9eig8T3mX5HRShS2KXWRccSFK0HByWim8sdNfwyWoKEWOV
OuDqu5ZUfcvdS0GysQ341qO6IhFDocQRo7eIlCA983k7ogIQ6aBtv00G9c5YRdmm
ZVe/OpbLG4ckKM6jjDb0iNIaTCZYJ6e1fu24Z8XQo+PzZqe+BFAQKpsT8omqsB1+
MNygf97zYD2M3P+rmIwRAHx3iyM8vXp4BcAJl2+VeFV7qD2NdxRYDEAMX8o+9+g0
tUuUtj2gpO+Hcd+VBc+Y7mBVURcyBsK5mLkPwCnsoGgScvCVzsQhidgWR92x5nkH
JtnQtt2ubx8vNN75DzNLGTZmzBNb2aQ7ME4QYqauyS7D7UWOxnSqr4uujEoS9Ebq
7LFGRHPHQKqhE0Q5h13zlWoSztrjAvS0xrXSa45K01U9C+BfmSBDep/ippyPgbXC
O+6bz1S2WZxiX/4sHXzp7JM3nx/P/Sb3i8Y7ZpCcKpjxrqAJoXyLZxm8mme+Yq5R
DPWsAOJw42er6t/iAj/pD5ntcEdP4j/6c0pOs9BqhPQHun+4flhJjnmRvw9cfbWI
x+1+Y6sPWByQkaZAIy46SxnhIjs9Ar0xUPzsw1e9nVPDp2J9+BB2E68ViJjZTWTs
t5SxWOlhK+PWSAGVBGV0
=SjOE
-----END PGP SIGNATURE-----

--Y1L3PTX8QE8cb2T+--
