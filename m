From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 14/16] mfd: intel-lpss: Pass SDA hold time to I2C host
 controller driver
Date: Mon, 8 Feb 2016 11:09:43 +0100
Message-ID: <20160208100942.GA2220@tetsubishi>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1448896304-87928-15-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448896304-87928-15-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-i2c@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2015 at 05:11:42PM +0200, Andy Shevchenko wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>=20
> Intel Skylake the LPSS I2C pad circuit has internal delays that require
> programming non-zero SDA hold time for the I2C host controller. If this is
> not done communication to slave devices may fail with arbitration lost
> errors like the one seen below taken from Lenovo Yoga 900:
>=20
>   i2c_hid i2c-SYNA2B29:00: Fetching the HID descriptor
>   i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: cmd=3D20 00
>   i2c_designware i2c_designware.1: i2c_dw_handle_tx_abort: lost arbitrati=
on
>=20
> To fix this we follow what the Windows driver is doing and pass the defau=
lt
> SDA hold time of 230 ns to all Intel Skylake host controllers. This still
> allows the platform to override these values by passing special ACPI
> methods SSCN and FMCN.
>=20
> Reported-by: Kevin Fenzi <kevin@scrye.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There has been a request to get this into stable:

https://bugzilla.kernel.org/show_bug.cgi?id=3D108581

Since we probably don't want to backport the whole device_property
series, is there a simpler fix to backport for stable?


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWuGlmAAoJEBQN5MwUoCm2RhEQAKpEZorTihLh528lRO4tR2MQ
rexKAfITZ3MdAFRKcvPlslnYeWAu2v3BYZ3h9Mbm3h9W4AtMCm6aLtEQ0KL83RnK
ikpAhALQm206O8D988SKD6m3nmmqq2ynd376ZPi3O4IJGKG3Q5HfY4sfpWZtg4rQ
UbTZWpegL7vqAjFLVQg1uHCvtSgfR2jwE/b2PsYKfM8Q55mQeGs5Tc7BECUiTJMW
UZkUcIDi26ATByabwnidpxdPl3vp+h+uaTcVHuF91w+uhNmZjJhSbeqloBDxN5Ir
5lXM6kt6KVXaLMFnNaJpysAkPM076l+uoe/CVtGVxmSYkvO53H51aVHj34XXM3MC
SX1gU9zJFzSYejy9JbzNtqvWC+u9ncujTxmqR/N8xjoS6nHLiK17DEJC3uigXGDa
y67tQgr2u25XtoUTTib0/9JfzwwCFrDrueI8MWQ9Kw/QVNBLYfcoze6gtocP42rj
MizbGaudyNQgMOgvCzXenikc9eZkIKYgQtfCpZyi2ldzIX9RyYaV0Ddz3vE7R5sP
x3n/hkmLESyd5YfNLmIXQOVdnfM/aokePukuj8lfppMBIECsg7EQ3CXN9p6Lt/8t
ENvgsit6y2Z/wx+UGWZ/0vkSt5icIpH7fhaYBayM765Lz+oxnHbeMltaew8xsbjb
V+bnWDhJ4VXucN+O6tCB
=sa2K
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
