From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 00/16] intel-lpss: support non-ACPI platforms
Date: Mon, 30 Nov 2015 17:11:28 +0200
Message-ID: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

This series includes few logical sets that bring a support of non-ACPI
platforms for Intel Skylake.

First part is a refactoring of built-in device properties support:
- keep single value inside the structure
- provide helper macros to define built-in properties
- fall back to secondary fwnode if primary has no asked property

Second is a propagating built-in device properties in platform core.

Third one is modifications to MFD code and intel-lpss.c driver in particular
to define and pass built-in properties to the individual drivers.

And last part is a fix for I2C bug found on Lenovo Yoga hardware and a first
converted user.

Built-in device properties is an alternative to platform data. It provides a
unified API that drivers can use to cover all cases at once: DT, ACPI, and
built-in properties.

With this series applied a platform data can be considered obsolete. Moreover,
built-in device properties allow to adjust the existing configuration, for
example, in cases when ACPI values are wrong on some platforms.

The series has been tested on available hardware and doesn't break current
behaviour. But we ask people who have the affected hardware to apply the series
on your side and check with Lenovo hardware.

Changelog v2:
- fix isuues found by kbuild bot (kbuild)
- append a patch to propagate device properties in polatform code (Arnd)
- update few existing and add couple of new patches due to above
- check with kmemleak

Andy Shevchenko (9):
  device property: always check for fwnode type
  device property: rename helper functions
  device property: refactor built-in properties support
  device property: keep single value inplace
  device property: improve readability of macros
  device property: return -EINVAL when property isn't found in ACPI
  device property: Fallback to secondary fwnode if primary misses the
    property
  mfd: core: propagate device properties to sub devices drivers
  mfd: intel-lpss: Pass HSUART configuration via properties

Heikki Krogerus (1):
  device property: helper macros for property entry creation

Mika Westerberg (6):
  device property: Take a copy of the property set
  driver core: platform: Add support for built-in device properties
  driver core: Do not overwrite secondary fwnode with NULL if it is set
  mfd: intel-lpss: Add support for passing device properties
  mfd: intel-lpss: Pass SDA hold time to I2C host controller driver
  i2c: designware: Convert to use unified device property API

 drivers/acpi/property.c                     |  10 +-
 drivers/base/core.c                         |   5 +-
 drivers/base/platform.c                     |  25 ++
 drivers/base/property.c                     | 491 ++++++++++++++++++++++------
 drivers/i2c/busses/i2c-designware-platdrv.c |  50 ++-
 drivers/mfd/intel-lpss-acpi.c               |  19 +-
 drivers/mfd/intel-lpss-pci.c                |  44 ++-
 drivers/mfd/intel-lpss.c                    |  16 +-
 drivers/mfd/intel-lpss.h                    |   2 +
 drivers/mfd/mfd-core.c                      |   7 +
 include/linux/mfd/core.h                    |   5 +
 include/linux/platform_device.h             |   5 +
 include/linux/property.h                    |  99 +++++-
 13 files changed, 621 insertions(+), 157 deletions(-)

-- 
2.6.2
