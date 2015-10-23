From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 0/5] enable I2C devices behind I2C bus on Gen2
Date: Fri, 23 Oct 2015 12:16:40 +0300
Message-ID: <1445591805-28886-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-i2c@vger.kernel.org

There is a board in the wild, i.e. Intel Galileo Gen2, that has ACPI enumerated
devices behind I2C bus. This patch series dedicated to enable those devices.

The MFD framework is also updated to cope with interesting implementation of
the cell descriptions under ACPI MFD (patch 1).

The patches 5 and 6 are pretty independent and could be applied ahead, though
they don't make much sense without previous ones.

Wolfram, since Lee acknowledged patches 1-3, can you pull them to your tree?

Tested on the actual Intel Galileo Gen2 by Ismo (gpio expanders) and me (at24).

Cc: Thierry Reding <thierry.reding@gmail.com>

Changelog v4:
- amend at24 patch to satisfy sparse (Wolfram)
- drop applied patches

Changelog v3:
- append ACKs from Rafael (from ACPI angle)
- drop upstreamed patches (GPIO pca953x)

Changelog v2:
- append tags
- re-make patch 3 (suggested by Lee)
- improve patch 8 (suggested by Thierry)


Andy Shevchenko (5):
  mfd: core: redo ACPI matching of the children devices
  mfd: intel_quark_i2c_gpio: load gpio driver first
  mfd: intel_quark_i2c_gpio: support devices behind i2c bus
  at24: enable ACPI device found on Galileo Gen2
  pwm-pca9685: enable ACPI device found on Galileo Gen2

 Documentation/acpi/enumeration.txt | 11 +++++---
 drivers/mfd/intel_quark_i2c_gpio.c | 33 ++++++++++++++++--------
 drivers/mfd/mfd-core.c             | 52 ++++++++++++++++++++++++++------------
 drivers/misc/eeprom/at24.c         | 22 +++++++++++++---
 drivers/pwm/Kconfig                |  2 +-
 drivers/pwm/pwm-pca9685.c          | 20 ++++++++++++---
 include/linux/mfd/core.h           | 10 ++++++--
 7 files changed, 111 insertions(+), 39 deletions(-)

-- 
2.6.1
