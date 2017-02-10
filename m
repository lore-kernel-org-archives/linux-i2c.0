From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4] eeprom/at24: use device_property_*() functions
 instead of of_get_property()
Date: Fri, 10 Feb 2017 16:34:17 +0100
Message-ID: <20170210153416.lrjyq5i2p7axyxfj@ninjato>
References: <CAE7DoPan8Y_-F-Fj22xYkKBeCTPPD60MvEAv+hjSzU+H5DHovg@mail.gmail.com>
 <1486661768-21456-1-git-send-email-gardner.ben@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="55n7qfu7t242novf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1486661768-21456-1-git-send-email-gardner.ben@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Gardner <gardner.ben@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-i2c@vger.kernel.org


--55n7qfu7t242novf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 11:36:08AM -0600, Ben Gardner wrote:
> Allow the at24 driver to get configuration information from both OF and
> ACPI by using the more generic device_property functions.
> This change was inspired by the at25.c driver.
>=20
> I have a custom board with a ST M24C02 EEPROM attached to an I2C bus.
> With the following ACPI construct, this patch instantiates a working
> instance of the driver.
>=20
> Device (EEP0) {
>  Name (_HID, "PRP0001")
>  Name (_DSD, Package () {
>   ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>   Package () {
>    Package () {"compatible", Package () {"st,24c02"}},
>    Package () {"pagesize", 16},
>   },
>  })
>  Name (_CRS, ResourceTemplate () {
>   I2cSerialBus (
>    0x0057, ControllerInitiated, 400000,
>    AddressingMode7Bit, "\\_SB.PCI0.I2C3", 0x00,
>    ResourceConsumer,,)
>  })
> }
>=20
> Note: Matching the driver to the I2C device requires another patch.
>  http://www.spinics.net/lists/linux-acpi/msg71914.html

This should have been below the "---" because dependencies are not
relevant in the git history.

>=20
> Signed-off-by: Ben Gardner <gardner.ben@gmail.com>

Please send new patches not in-reply-to old patches, seperate threads
are easier to find IMHO.

Other than that:

Applied to for-next, thanks!



--55n7qfu7t242novf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlid3XUACgkQFA3kzBSg
KbbcDA//TCHkhSAqA5xAxzQUnGXWe72UcGz/opJCyg0hVMzub10XjwG684MBxkfx
Pk2HmaZPyA90lEMIRnJU7qDrkr5oYBHe2fwKG4MDHj73sD/M+EKDkq2PeBIC5cPX
6MBLbv5p3zPOdxIUojfPtekVSl4R8wsME3b2srDYvDWrwKIe5bAxLiELAHLGql1m
2NVjrcX0qOZG2GeUKQcJC9pG1W5x6Hs8IkQlEwfwErEOg86AqyT6iX+OuZH9Morl
nYzLCgaaV6yTPsuQrEanrDDxBPqPanQNuRCRSmLda2JtidYtWT+xXyaUaPrW7aG1
tYi8vX6MDZTXHSj9G6e5AXiKGG0K7UW9YNgqVU41GcqyoJa/b0oF6ucXHmjhAnly
wSZ7BIZRjba7bzmX4ZbvUW0JfWAfrgHCpKgXw6JOHaVozgSuUiJzQN4bB+uyrsKP
58Pp2zLz0TXxcEbtqzytuyASEvjfDg+407F3SIARziHHCdtnNERe6VoD6hOU6U4W
WOc5rHLPKrGhEVnaMY5cWrKnOeyicz2cRDOnsSujNChq5PWaPRZFaA/IgOCNoUko
ZgBKrGMZE9XIqNXt4bPvuIa7lnAEsBIGXYfcfONWOF1gl/18jvRpz+V9IWCwXhFI
aX8fx9HvfHZkwlDZ+ZsDisnnka6f+hos7I1qdWDnqA+OjG1P/Oo=
=FLAs
-----END PGP SIGNATURE-----

--55n7qfu7t242novf--
