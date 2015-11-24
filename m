From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 00/13] intel-lpss: support non-ACPI platforms
Date: Tue, 24 Nov 2015 16:49:51 +0200
Message-ID: <1448376591.15393.23.camel@linux.intel.com>
References: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <3454625.b9jyZODPnk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40647 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754208AbbKXOvw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 24 Nov 2015 09:51:52 -0500
In-Reply-To: <3454625.b9jyZODPnk@vostro.rjw.lan>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>

On Tue, 2015-11-24 at 16:11 +0100, Rafael J. Wysocki wrote:
> On Tuesday, November 24, 2015 12:22:46 PM Andy Shevchenko wrote:
> > This series includes few logical sets that bring a support of non-
> > ACPI
> > platforms for Intel Skylake.
> >=20
> > First part is a refactoring of built-in device properties support:
> > =C2=A0- keep single value inside the structure
> > =C2=A0- provide helper macros to define built-in properties
> > =C2=A0- fall back to secondary fwnode if primary has no asked prope=
rty
> >=20
> > Second one is modifications to MFD code and intel-lpss.c driver in
> > particular
> > to define and pass built-in properties to the individual drivers.
> >=20
> > Last part is a fix for I2C bug found on Lenovo Yoga hardware and a
> > first
> > converted user.
> >=20
> > Built-in device properties is an alternative to platform data. It
> > provides a
> > unified API that drivers can use to cover all cases at once: DT,
> > ACPI, and
> > built-in properties.
> >=20
> > With this series applied platform data can be considered obsolete.
> > Moreover,
> > built-in device properties allows to adjust existing configuration,
> > for
> > example, in cases when ACPI values are wrong on some platforms.
> >=20
> > The series has been tested on available hardware and doesn't break
> > current
> > behaviour. But we ask you, Kevin, to apply the series on your side
> > and check
> > with Lenovo hardware.
> >=20
> > Andy Shevchenko (8):
> > =C2=A0 device property: always check for fwnode type
> > =C2=A0 device property: rename helper functions
> > =C2=A0 device property: refactor built-in properties support
> > =C2=A0 device property: keep single value inplace
> > =C2=A0 device property: improve readability of macros
> > =C2=A0 device property: return -EINVAL when property isn't found in=
 ACPI
> > =C2=A0 device property: Fallback to secondary fwnode if primary mis=
ses
> > the
> > =C2=A0=C2=A0=C2=A0=C2=A0property
> > =C2=A0 mfd: core: propagate device properties to sub devices driver=
s
> >=20
> > Heikki Krogerus (1):
> > =C2=A0 device property: helper macros for property entry creation
> >=20
> > Mika Westerberg (4):
> > =C2=A0 mfd: intel-lpss: Add support for passing device properties
> > =C2=A0 mfd: intel-lpss: Pass HSUART configuration via properties
> > =C2=A0 mfd: intel-lpss: Pass SDA hold time to I2C host controller d=
river
> > =C2=A0 i2c: designware: Convert to use unified device property API
> >=20
> > =C2=A0drivers/acpi/property.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A010 +-
> > =C2=A0drivers/base/property.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0| 298
> > +++++++++++++++++++++-------
> > =C2=A0drivers/i2c/busses/i2c-designware-platdrv.c |=C2=A0=C2=A048 +=
+---
> > =C2=A0drivers/mfd/intel-lpss-acpi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A01=
8 +-
> > =C2=A0drivers/mfd/intel-lpss-pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A043 +++-
> > =C2=A0drivers/mfd/intel-lpss.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|=C2=A0=C2=A016 +-
> > =C2=A0drivers/mfd/intel-lpss.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|=C2=A0=C2=A0=C2=A02 +
> > =C2=A0drivers/mfd/mfd-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A03 +
> > =C2=A0include/linux/mfd/core.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|=C2=A0=C2=A0=C2=A05 +
> > =C2=A0include/linux/property.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|=C2=A0=C2=A087 ++++++--
> > =C2=A010 files changed, 394 insertions(+), 136 deletions(-)
>=20
> All patches in this series look good to me overall, but please fix
> the build
> problems reported by 0-day and resubmit.

Thanks for fast response. We will do that later this week while
gathering comments from others.



> Thanks,
> Rafael
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
