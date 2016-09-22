From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c / ACPI: Do not touch an I2C device if it belongs
 to another adapter
Date: Thu, 22 Sep 2016 19:46:28 +0200
Message-ID: <20160922174628.GA1861@katana>
References: <874m5ax3o4.fsf@gmail.com>
 <20160920135925.45450-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160920135925.45450-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Nicolai Stange <nicstange@gmail.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 20, 2016 at 04:59:25PM +0300, Mika Westerberg wrote:
> When enumerating I2C devices connected to an I2C adapter we scan the whole
> namespace (as it is possible to have devices anywhere in that namespace,
> not just below the I2C adapter device) and add each found device to the I=
2C
> bus in question.
>=20
> Now after commit 525e6fabeae2 ("i2c / ACPI: add support for ACPI
> reconfigure notifications") checking of the adapter handle to the one fou=
nd
> in the I2cSerialBus() resource was moved to happen after resources of the
> I2C device has been parsed. This means that if the I2cSerialBus() resource
> points to an adapter that does not exists in the system we still parse
> those resources. This is problematic in particular because
> acpi_dev_resource_interrupt() tries to configure GSI if the device also h=
as
> an Interrupt() resource. Failing to do that results errrors like this to =
be
> printed on the console:
>=20
>   [   10.409490] ERROR: Unable to locate IOAPIC for GSI 37
>=20
> To fix this we pass the I2C adapter to i2c_acpi_get_info() and make sure
> the handle matches the one in the I2cSerialBus() resource before doing
> anything else to the device.
>=20
> Reported-and-tested-by: Nicolai Stange <nicstange@gmail.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to for-next, thanks!


--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5Bj0AAoJEBQN5MwUoCm20OAP/39fPhfGQX6MOarontAEGygW
1W3l+0OSi2OK5TAmMVWcPCs7/b1Hp3GdSK5qHXVuTy176bRwTBK4i3/CuopzPPu+
NluA/niQOouxlwvXP5+4nUWT8trDfD2n24x0s1BcufFirmsfgZIatO/nQU9T4IGI
J6FRiVqbMdHVegv7KMWIG2UNscw9W/u3KYw64K+g8iWsOBLVEqfJ/5ly1iL8T/CV
HyGQT6nBpcma/Dp83dR25YPKAPW06iwsRymgwSVIiJrhwJ7WXRhfJ0sdWid+p7ZN
yjnFuedFNTLCTrDkTno7FsTbASsaEouO11dlX5Vd9/lveGczQrBXiPD2Hc6NNE+E
ywwZacONlxrdKGf9vzxwTUxvvlN4YplyfW6Mc4CPxSjvxZSOxkx8mLQCYoQIHIQJ
pgxIPx7m0b4ZW+6evXdo6vgjdZ1xSFEJJFPMbGR6/fuJr2WRpgORoa7sP+ogCLfX
901pLrempPz1A4APDnlp9xu2ULlNMwKsT11hcNyDzYpJA7KKggRp28diRuH430rF
RKrgXLdUsOpnhVRAoQ7ywjK5LYbUMoytJSF4+IK/gNhebMhd3ENiKj33288o3Eaf
8WQ0zUIuw6BpCQRvhy44YZQEaaCQT6z52J+HbRQm+kSOKGbNK6rxdmg6EDfwEfzs
H52kCUK/BS9oub9Y+LIp
=nyzK
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
