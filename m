From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/6] enable I2C devices behind I2C bus on Gen2
Date: Wed,  7 Oct 2015 13:18:43 +0300
Message-ID: <1444213129-29793-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

There is a board in the wild, i.e. Intel Galileo Gen2, that has ACPI enumerated
devices behind I2C bus.

This patch series dedicated to enable those devices. Meanwhile it also changes
I2C core to cope with ACPI 6.0 specification (patch 1).

The MFD framework is also updated to cope with interesting implementation of
the cell descriptions under ACPI MFD (patch 2).

The patches 5 and 6 are pretty independent and could be applied ahead, though
they don't make much sense without previous ones.

Srinivas, it would be nice to see your tag (ideally Tested-by) to be sure we
don't break ISH stuff.

Since it touches multiple subsystems someone needs to create an immutable
branch. I don't actually know whose subsystem better here. Wolfram?

Tested on the actual Intel Galileo Gen2 by Ismo (gpio expanders) and me (at24).

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

Mika Westerberg (1):
  i2c / ACPI: Rework I2C device scanning

 Documentation/acpi/enumeration.txt | 11 +++--
 drivers/i2c/i2c-core.c             | 82 +++++++++++++++++++++++++++-----------
 drivers/mfd/intel_quark_i2c_gpio.c | 33 ++++++++++-----
 drivers/mfd/mfd-core.c             | 52 ++++++++++++++++--------
 drivers/misc/eeprom/at24.c         | 22 ++++++++--
 drivers/pwm/Kconfig                |  2 +-
 drivers/pwm/pwm-pca9685.c          | 20 ++++++++--
 include/linux/mfd/core.h           | 10 ++++-
 8 files changed, 170 insertions(+), 62 deletions(-)

-- 
2.5.3
