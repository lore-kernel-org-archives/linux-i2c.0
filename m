From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH 00/14] eeprom: at24: driver rework and
 at24cs/at24mac support
Date: Sun, 17 Jul 2016 20:02:31 +0200
Message-ID: <20160717180231.GB1814@katana>
References: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49763 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbcGQSCe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 17 Jul 2016 14:02:34 -0400
Content-Disposition: inline
In-Reply-To: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2016 at 10:48:42AM +0200, Bartosz Golaszewski wrote:
> Chips from the at24cs EEPROM series have an additional read-only
> memory area containing a factory pre-programmed serial number. In
> order to access it, a dummy write must be executed before reading
> the serial number bytes.
>=20
> Chips from the at24mac familiy, apart from the serial number, have
> a second special memory area containing a factory programmed
> EUI-48/EUI64 mac address.
>=20
> The read-only serial/mac memory area is accessible on a different i2c
> slave address (addr + 0x08). This patchset makes it possible to
> instantiate a separate at24 device on this second address and access
> the read-only area through the regular eeprom sysfs attribute or the
> new nvmem subsystem.
>=20
> This series also contains several patches refactoring the driver code.
> Most notably: the low-level read/write routines are split into more
> specialized, smaller functions that no longer perform functionality
> checks at runtime.
>=20
> Minor readability tweaks are also included.
>=20
> Tested with at24cs32 and at24cs02 chips (for both 16 and 8 bit address
> pointers). I have no means of testing the support for at24mac chips, I
> relied solely on the datasheet.
>=20
> Bartosz Golaszewski (14):
>   eeprom: at24: improve the device_id table readability
>   eeprom: at24: move at24_read() below at24_eeprom_write()
>   eeprom: at24: coding style fixes
>   eeprom: at24: call read/write functions via function pointers
>   eeprom: at24: hide the read/write loop behind a macro
>   eeprom: at24: split at24_eeprom_read() into specialized functions
>   eeprom: at24: split at24_eeprom_write() into specialized functions
>   eeprom: at24: platform_data: use BIT() macro
>   eeprom: at24: platform_data: add serial number flag
>   eeprom: at24: support reading the serial number
>   eeprom: at24: add the at24cs series to the list of supported devices

I changed the 128 / 8 to 16 as discussed and squashed the last 3 patches
into 1 here...

>   eeprom: at24: platform_data: add at24mac series flag
>   eeprom: at24: add support for at24mac series
>   eeprom: at24: add at24mac chips to the list of supported devices

=2E.. and here.

After that, applied to for-next , thanks!


--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXi8g2AAoJEBQN5MwUoCm2qwsP/17YAWr6YoL8yM9PtAyNqWx6
bracpPPdvYoJ/Kc7GV2p5rkIfEtucvzcBfn9jt5ep1UwBq8WoQhaj3JmCuE9+PO7
uyicwbuaVPJZsNFcXxzTaoxcx93kams0rSidKaYqTqJA1XRkCEkajFo8/p/xEjs0
pOUCWLylyhuZWYHGrYBD8khlm39M0wq5w3Y+H+M8SK0rqk8LZtNxZGnQtjD8X2/J
S1pMQ0CjIslH3e5EoQyXPcuvA4TWktjuSu+ifV5jnyEnBKg7V42AcgzRpt56kBhN
DswN1b322mwItcM4UsbThTYX+5Kxx8bqilYJVxQea4kbkGzOyjrcjy/I8sPHiy0O
HJbrnqhrj26miB6I7ZkcR7wJ2QVElCZia6jl3ySZEtBDG+rGyZD7o+EAWKmg8BLM
2Tze1twoun+y6f0qgfDdlpasVQa4iFKaxDL4AEaxsao05GfuXXywkglUbYrKN5th
JosD1rz+E22ygSoE736SOBUOTKQ5fHCUDqnGKYBtsJON7Xd2AG+M7O47uwkAvXMK
NHHm3sG69aRc0lj+OUz4cSUUZ///ZR5p41cvBlDUjeDHBfJU2er+dmXSIL+qYWn4
G/fd3mJxcn4ZUM8zjieWk56a36IoDG4v7Y/VQrs0DDJNc4kTDQa9W4oRIn4Boms/
pBvyDIhVOdkle/kcGkp4
=0UM5
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
