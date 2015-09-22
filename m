From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/8] enable I2C devices behind I2C bus on Gen2
Date: Tue, 22 Sep 2015 13:10:11 +0300
Message-ID: <1442916619-140607-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

There is a board in the wild, i.e. Intel Galileo Gen2, that has ACPI enumerated
devices behind I2C bus.

This patch series dedicated to enable those devices. Meanwhile it also changes
I2C core to cope with ACPI 6.0 specification (patch 1/8).

The MFD framework is also updated to cope with interesting implementation of
the cell descriptions under ACPI MFD (patch 2/8).

The patches 7 and 8 are pretty independent, though they don't make much sense
without previous ones applied.

Srinivas, it would be nice to see your tag (ideally Tested-by) to be sure we
don't break ISH stuff.

Since it touches multiple subsystems someone needs to create an immutable
branch. I don't actually know whose subsystem better here. Lee, Wolfram?

Apparently we would like to get ACKs / comments from the rest.

Tested on the actual Intel Galileo Gen2 by Ismo (gpio expanders) and me (at24).

Andy Shevchenko (7):
  mfd: core: redo ACPI matching of the children devices
  mfd: intel_quark_i2c_gpio: load gpio driver first
  mfd: intel_quark_i2c_gpio: support devices behind i2c bus
  gpio: pca953x: store driver_data for future use
  gpio: pca953x: support ACPI devices found on Galileo Gen2
  at24: enable ACPI device found on Galileo Gen2
  pwm-pca9685: enable ACPI device found on Galileo Gen2

Mika Westerberg (1):
  i2c / ACPI: Rework I2C device scanning

 Documentation/acpi/enumeration.txt | 11 +++--
 drivers/gpio/gpio-pca953x.c        | 36 +++++++++++++----
 drivers/i2c/i2c-core.c             | 82 +++++++++++++++++++++++++++-----------
 drivers/mfd/intel_quark_i2c_gpio.c | 62 ++++++++++++++++++----------
 drivers/mfd/mfd-core.c             | 52 ++++++++++++++++--------
 drivers/misc/eeprom/at24.c         | 22 ++++++++--
 drivers/pwm/Kconfig                |  2 +-
 drivers/pwm/pwm-pca9685.c          | 14 +++++--
 include/linux/mfd/core.h           | 10 ++++-
 9 files changed, 212 insertions(+), 79 deletions(-)

-- 
2.5.1
