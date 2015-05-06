From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 0/3] ACPI: Translate Linux IRQ number directly from GpioInt
Date: Wed,  6 May 2015 13:29:05 +0300
Message-ID: <1430908148-201129-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

This is second iteration of the series. The previous version can be found
from [1].

Currently drivers for ACPI enumerated devices that have their interrupt
line connected to a GPIO controller instead of IO-APIC are required to do
complete gpiod_get()/gpiod_to_irq() etc. dance themselves. This adds
unnecessary lines of code to these drivers.

It turned out that DT solved the problem already with introduction of
of_irq_get() which is able to handle GPIO based interrupts as well through
irqchip API [2].

The following three patches achieve the same for ACPI by introducing new
function acpi_dev_gpio_irq_get() that is then used in I2C core to automatically
translate ACPI GpioInt resource to Linux IRQ number.

Changes to the previous version:
 - Added Rafael's ack to the first patch
 - Introduce new patch that makes I2C ACPI slave enumeration code use 0 to mean
   no interrupt.

If no objections, I would like this to merged via either I2C or GPIO trees.

Thanks.

[1] https://lkml.org/lkml/2015/4/28/455
[2] https://lkml.org/lkml/2015/3/25/103

Mika Westerberg (3):
  gpio / ACPI: Add support for retrieving GpioInt resources from a device
  i2c / ACPI: Use 0 to indicate that device does not have interrupt assigned
  i2c / ACPI: Assign IRQ for devices that have GpioInt automatically

 drivers/gpio/gpiolib-acpi.c | 29 +++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.c      | 12 ++++++++----
 include/linux/acpi.h        |  7 +++++++
 3 files changed, 44 insertions(+), 4 deletions(-)

-- 
2.1.4

