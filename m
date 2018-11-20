From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 00/15] i2c-multi-instantiate: Adapt for INT3515 and alike
Date: Tue, 20 Nov 2018 17:59:09 +0200
Message-ID: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Currently i2c-multi-instantiate driver does not support the case
of INT3515 USB PD device, where:

- Interrupt() is used instead of GpioInt()
- All slaves may be the same from IP point of view
- There can be variadic amount of slaves

This series is addressing all above.

Notes:
- series has been smoke tested (Heikki would do BAT or more) on Coffee Lake system
- patch for BOSC0200 might be considered as RFC since the modalias potential issue

The idea is to push this either through PDx86 tree (needs Rafael's ACKs) or ACPI.
In any case it needs tags from Heikki, Hans, Mika, Wolfram and Jonathan.

Testing and comments are warmly welcome.

Andy Shevchenko (15):
  platform/x86: intel_cht_int33fe: Remove duplicate NULL check
  platform/x86: intel_cht_int33fe: Accept errors of
    i2c_acpi_new_device()
  platform/x86: i2c-multi-instantiate: Accept errors of
    i2c_acpi_new_device()
  platform/x86: i2c-mutli-instantiate: Defer probe when no adapter found
  i2c: acpi: Return error pointers from i2c_acpi_new_device()
  i2c: acpi: Assign fwnode for devices created via i2c_acpi_new_device()
  i2c: acpi: Use ACPI_FAILURE instead of !ACPI_SUCCESS
  i2c: acpi: Introduce i2c_acpi_get_i2c_resource() helper
  platform/x86: i2c-multi-instantiate: Count I2cSerialBus() resources
  platform/x86: i2c-multi-instantiate: Distinguish IRQ resource type
  platform/x86: i2c-multi-instantiate: Introduce IOAPIC IRQ support
  platform/x86: i2c-multi-instantiate: Allow to have same slaves
  ACPI / scan: Create platform device for INT3515 ACPI nodes
  ACPI / scan: Create platform device for BOSC0200 ACPI nodes
  iio: inv_mpu6050: Use i2c_acpi_get_i2c_resource() helper

 drivers/acpi/scan.c                          |  2 +
 drivers/i2c/i2c-core-acpi.c                  | 43 +++++----
 drivers/iio/accel/bmc150-accel-i2c.c         |  1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c   | 16 ++--
 drivers/platform/x86/i2c-multi-instantiate.c | 99 ++++++++++++++++----
 drivers/platform/x86/intel_cht_int33fe.c     | 34 +++++--
 drivers/usb/typec/tps6598x.c                 |  8 +-
 include/linux/acpi.h                         | 11 +++
 8 files changed, 158 insertions(+), 56 deletions(-)

-- 
2.19.1
