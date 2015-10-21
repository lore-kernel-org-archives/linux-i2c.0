From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/6] enable I2C devices behind I2C bus on Gen2
Date: Wed, 21 Oct 2015 18:05:54 +0300
Message-ID: <1445439954.22669.38.camel@linux.intel.com>
References: <1444213129-29793-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21805 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752975AbbJUPGK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 21 Oct 2015 11:06:10 -0400
In-Reply-To: <1444213129-29793-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org

On Wed, 2015-10-07 at 13:18 +0300, Andy Shevchenko wrote:
> There is a board in the wild, i.e. Intel Galileo Gen2, that has ACPI
> enumerated
> devices behind I2C bus.

Lee, since Wolfram is going to apply patches 1 and 5, how could we
proceed with the rest? Patches are indeed build independent, though
they are unified by enabling logically piece-by-piece. It would be
great if you think you may apply them to your v4.4 queue.


> This patch series dedicated to enable those devices. Meanwhile it
> also changes
> I2C core to cope with ACPI 6.0 specification (patch 1).
>=20
> The MFD framework is also updated to cope with interesting
> implementation of
> the cell descriptions under ACPI MFD (patch 2).
>=20
> The patches 5 and 6 are pretty independent and could be applied
> ahead, though
> they don't make much sense without previous ones.
>=20
> Srinivas, it would be nice to see your tag (ideally Tested-by) to be
> sure we
> don't break ISH stuff.
>=20
> Since it touches multiple subsystems someone needs to create an
> immutable
> branch. I don't actually know whose subsystem better here. Wolfram?
>=20
> Tested on the actual Intel Galileo Gen2 by Ismo (gpio expanders) and
> me (at24).
>=20
> Changelog v3:
> - append ACKs from Rafael (from ACPI angle)
> - drop upstreamed patches (GPIO pca953x)
>=20
> Changelog v2:
> - append tags
> - re-make patch 3 (suggested by Lee)
> - improve patch 8 (suggested by Thierry)
>=20
> Andy Shevchenko (5):
> =C2=A0 mfd: core: redo ACPI matching of the children devices
> =C2=A0 mfd: intel_quark_i2c_gpio: load gpio driver first
> =C2=A0 mfd: intel_quark_i2c_gpio: support devices behind i2c bus
> =C2=A0 at24: enable ACPI device found on Galileo Gen2
> =C2=A0 pwm-pca9685: enable ACPI device found on Galileo Gen2
>=20
> Mika Westerberg (1):
> =C2=A0 i2c / ACPI: Rework I2C device scanning
>=20
> =C2=A0Documentation/acpi/enumeration.txt | 11 +++--
> =C2=A0drivers/i2c/i2c-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 82 +++++++++++++++++++++++++++-
> ----------
> =C2=A0drivers/mfd/intel_quark_i2c_gpio.c | 33 ++++++++++-----
> =C2=A0drivers/mfd/mfd-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 52 ++++++++++++++++--------
> =C2=A0drivers/misc/eeprom/at24.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0| 22 ++++++++--
> =C2=A0drivers/pwm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> =C2=A0drivers/pwm/pwm-pca9685.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0| 20 ++++++++--
> =C2=A0include/linux/mfd/core.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0| 10 ++++-
> =C2=A08 files changed, 170 insertions(+), 62 deletions(-)
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
