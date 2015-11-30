From: Christophe Ricard <christophe.ricard@gmail.com>
Subject: [PATCH v3 0/2] ACPI: Add irq_type to gpio interrupt
Date: Mon, 30 Nov 2015 23:47:51 +0100
Message-ID: <1448923673-2582-1-git-send-email-christophe-h.ricard@st.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Christophe Ricard <christophe-h.ricard@st.com>
List-Id: linux-i2c@vger.kernel.org

Hi,

This serie only move from RFC to final. I am also adding gpio folks for potential
feedback.

ACPI probing method does not retrieve irq_type from a gpio interrupt declared
with GpioInt as it is done with devicetree probing. In other terms, irq_get_trigger_type
will always send back 0.

Those 2 patches propose a way to retrieve the correct interrupt polarity/type from a GpioInt
acpi declaration when using irq_get_trigger_type.

Best Regards
Christophe 

Christophe Ricard (2):
  acpi: Rename acpi_gsi_get_irq_type to acpi_get_irq_type and export
    symbol
  ACPI / gpio: Add irq_type when a gpio is used as an interrupt

 drivers/acpi/gsi.c          | 21 +--------------------
 drivers/acpi/utils.c        | 21 +++++++++++++++++++++
 drivers/gpio/gpiolib-acpi.c |  5 ++++-
 include/linux/acpi.h        |  2 ++
 4 files changed, 28 insertions(+), 21 deletions(-)

-- 
2.1.4

