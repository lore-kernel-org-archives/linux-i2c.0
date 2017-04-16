From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 2/4] i2c: core: Add new i2c_acpi_new_device helper
 function
Date: Sun, 16 Apr 2017 22:08:24 +0200
Message-ID: <20170416200824.qbpcqsqplnzixa3z@ninjato>
References: <20170404220335.9815-1-hdegoede@redhat.com>
 <20170404220335.9815-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rvv3plk6vqs3mm4r"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170404220335.9815-3-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--rvv3plk6vqs3mm4r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 12:03:33AM +0200, Hans de Goede wrote:
> By default the i2c subsys creates an i2c-client for the first I2cSerialBus
> resource of an acpi_device, but some acpi_devices have multiple
> I2cSerialBus resources and we may want to instantiate i2c-clients for
> the others.
>=20
> This commit adds a new i2c_acpi_new_device function which can be used to
> create an i2c-client for any I2cSerialBus resource of an acpi_device.
>=20
> Note that the other resources may even be on a different i2c bus, so just
> retrieving the client address is not enough.
>=20
> Here is an example DSDT excerpt from such a device:
>=20
> Device (WIDR)
> {
>     Name (_HID, "INT33FE" /* XPOWER Battery Device */)
>     Name (_CID, "INT33FE" /* XPOWER Battery Device */)
>     Name (_DDN, "WC PMIC Battery Device")
> <snip>
>     Name (RBUF, ResourceTemplate ()
>     {
>         I2cSerialBusV2 (0x005E, ControllerInitiated, 0x000186A0,
>             AddressingMode7Bit, "\\_SB.PCI0.I2C7",
>             0x00, ResourceConsumer, , Exclusive,
>             )
>         I2cSerialBusV2 (0x0036, ControllerInitiated, 0x000186A0,
>             AddressingMode7Bit, "\\_SB.PCI0.I2C1",
>             0x00, ResourceConsumer, , Exclusive,
>             )
>         I2cSerialBusV2 (0x0022, ControllerInitiated, 0x00061A80,
>             AddressingMode7Bit, "\\_SB.PCI0.I2C1",
>             0x00, ResourceConsumer, , Exclusive,
>             )
>         I2cSerialBusV2 (0x0054, ControllerInitiated, 0x00061A80,
>             AddressingMode7Bit, "\\_SB.PCI0.I2C1",
>             0x00, ResourceConsumer, , Exclusive,
>             )
>         GpioInt (Level, ActiveLow, Exclusive, PullNone, 0x0000,
>             "\\_SB.PCI0.I2C7.PMI5", 0x00, ResourceConsumer, ,
>             )
>             {   // Pin list
>         0x0012
>             }
>         GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullNone, 0x0000,
>             "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>             )
>             {   // Pin list
>         0x0005
>             }
>         GpioInt (Level, ActiveLow, Exclusive, PullNone, 0x0000,
>             "\\_SB.PCI0.I2C7.PMI5", 0x00, ResourceConsumer, ,
>             )
>             {   // Pin list
>         0x0013
>             }
>     })
>     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>     {
>         Return (RBUF) /* \_SB_.PCI0.I2C7.WIDR.RBUF */
>     }
> <snip>
> }
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to for-next, thanks!


--rvv3plk6vqs3mm4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljzzzgACgkQFA3kzBSg
KbZc2g/9HRIG6SjNq2tqFQiv9CAISPZIIv98kTHkPIAhbOQ0NT+vYT8jsj3Pxcpi
EeNlpBY7EAFbHdM2dZYoso5OnjlxrOFv5VuQuq4d4PIAuiNbFy6CPlkRlc7AlPVx
IPWpwRdmvJxHJa37iaXC+3tyDBKYb/1P4LsEJJ53kNjU1kiGUEzk4IHJE72sC6aW
6T5hujD5bOaM2E1lKW1gVcifiBxvvtLZz9oL3Cr7Ez3dvJMsNAEjIKNwm3R4trTW
KNDEiYcp0PcC6x/g8bqySxMfOf4s9s2nLeSlQtamXz3tiKV8EKC15CdKt8KRnBP5
8CxSWQXwawJYpbAiDjpfopYdBvNituPY2WBNB9+zI05S4NylujCYWSouNqUxY4kr
p2fqWJP79HJlyMalpfW6HibTONSrdkE6PQ6HIHPlyBj79XRZwUVafmn162uBL465
aHOAcHQJnUjy9WMJmdAowVIhmDQY82tPkNHE6XfnC80EkqdFJduN75m8WlC7YZlt
rNIFfrd9TVE19WoyWV3xgefXwOL1lqfrxK2MCuWvKD1ksMA6Llw1d9WUnMCG7Kk4
PyilT8Gu303q/mTgENOzBu2F5mFf4KttWC7wNmF/gvsltt6rCedEJyvYKEk3DHOK
To74mZKhZsQmtTyd+Xve20zIqpWniYYWukuituy9P7AjqLs1xfg=
=Pfds
-----END PGP SIGNATURE-----

--rvv3plk6vqs3mm4r--
