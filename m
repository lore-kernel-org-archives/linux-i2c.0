From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] i2c: core: Add function for finding the bus speed
 from ACPI
Date: Thu, 14 Jul 2016 22:35:41 +0900
Message-ID: <20160714133540.GG4149@tetsubishi>
References: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1465212383-24639-3-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yQbNiKLmgenwUfTN"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:32912 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbcGNNft (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Jul 2016 09:35:49 -0400
Content-Disposition: inline
In-Reply-To: <1465212383-24639-3-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>


--yQbNiKLmgenwUfTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2016 at 02:26:22PM +0300, Jarkko Nikula wrote:
> ACPI 5 specification doesn't have property for the I2C bus speed but
> I2cSerialBus resource descriptors which define each controller-slave
> connection define the maximum speed supported by that connection.
>=20
> Thus finding the maximum safe speed for the bus is to walk all
> I2cSerialBus resources that are associated to I2C controller and use
> the speed of slowest connection.
>=20
> Add function i2c_acpi_find_bus_speed() to the i2c-core that adapter
> drivers can call prior registering itself to core.
>=20
> This implies two-step walk through the I2cSerialBus resources: call to
> i2c_acpi_find_bus_speed() does the first scan and finds the safe bus
> speed that adapter drivers can set up. Adapter driver registration does
> the second scan when i2c-core creates the I2C slaves by calling the
> i2c_acpi_register_devices(). In that way the bus speed is set in case
> slave device probe gets called during registration and does
> communication.
>=20
> Implement this by reusing the existing ACPI I2C walk routines in the
> i2c-core. Extend them so that slowest connection speed is saved during
> the walk and I2C slaves are registered only when calling through the
> i2c_acpi_register_devices() with the i2c_adapter pointer.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-next, thanks!


--yQbNiKLmgenwUfTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXh5UrAAoJEBQN5MwUoCm2g54QAJ7zT2ZQNJnHJOHaqHq75Eea
b5S16IJovd/ldbtAar9FH99p4SKOi33pfvBILCbrjfXlr5COsHTjtRgc94dG9rq7
2dQKu2azUJpMNH7E3oXBU9O9Kapdi9URtR9VBus4bYOGpio4iDkI6jTe0Abbf4WF
kD2jhPYLAqCOEdyXI5y2AIN0b4TUZF/7fDFN4R3YFqsp4euKE2iP1vBwCe9fzMeQ
SxAyfBYJynqZix10jE7WvcoaOdE8u+klJ1rC8IYB6pAtNrL4v4e6d/G+2gTLG/2k
nlawm59kG9qdZF2fWginNwc2DRu1kgCPj5kkGvIJ7kEbSI87nGqPPRtvgIeo5bTf
yZsEYpha5bisnGHadssqYCFduj4DBBIT2FmgkB3DcfOnQQPIXKMCQWSENdo6rmk8
Ruo+oNnvnlYj+N5Hna3XVp5Bbea5F/Lw2y4gbf9Q9Tpgj4INHe7fY5RhXJzsh398
pZpqHuOoViG0tC4hhOs/G433WpJDVLqEHIgR3hRa/INiqE6mZWR4GWW4skLLnDbT
vxh1Koc23v1En2uDOBAa25AxibPyHMDi+kgVwctvvRFyVpf9vv5Y2I4MZXLeScoG
UArxgJtjomaU9XR2yvxuYn6BfEfJ4wb9OuKn+eIpofzRRjzfVG6mJT6+5hgehDlj
DPUqiryki3UK4/J+YPj9
=jf4/
-----END PGP SIGNATURE-----

--yQbNiKLmgenwUfTN--
