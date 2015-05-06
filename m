From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 1/3] gpio / ACPI: Add support for retrieving GpioInt resources from a device
Date: Wed,  6 May 2015 13:29:06 +0300
Message-ID: <1430908148-201129-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1430908148-201129-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1430908148-201129-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

ACPI specification knows two types of GPIOs: GpioIo and GpioInt. The latter
is used to describe that a given device interrupt line is connected to a
specific GPIO pin. Typical ACPI _CRS entry for such device looks like
below:

    Name (_CRS, ResourceTemplate ()
    {
        I2cSerialBus (0x004A, ControllerInitiated, 0x00061A80,
                      AddressingMode7Bit, "\\_SB.PCI0.I2C6",
                      0x00, ResourceConsumer)
        GpioIo (Exclusive, PullDefault, 0x0000, 0x0000,
                IoRestrictionOutputOnly, "\\_SB.GPO0",
                0x00, ResourceConsumer)
        {
            0x004B
        }
        GpioInt (Level, ActiveLow, Shared, PullDefault, 0x0000,
                 "\\_SB.GPO0", 0x00, ResourceConsumer)
        {
            0x004C
        }
    })

Currently drivers need to request a GPIO corresponding to the right GpioInt
and then translate that to Linux IRQ number. This adds unnecessary lines of
boiler-plate code.

We can ease this a bit by introducing acpi_dev_gpio_irq_get() analogous to
of_irq_get(). This function translates given GpioInt resource under the
device in question to the suitable Linux IRQ number.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 29 +++++++++++++++++++++++++++++
 include/linux/acpi.h        |  7 +++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index d2303d50f561..bff29bb0a3fe 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -514,6 +514,35 @@ struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 	return lookup.desc ? lookup.desc : ERR_PTR(-ENOENT);
 }
 
+/**
+ * acpi_dev_gpio_irq_get() - Find GpioInt and translate it to Linux IRQ number
+ * @adev: pointer to a ACPI device to get IRQ from
+ * @index: index of GpioInt resource (starting from %0)
+ *
+ * If the device has one or more GpioInt resources, this function can be
+ * used to translate from the GPIO offset in the resource to the Linux IRQ
+ * number.
+ *
+ * Return: Linux IRQ number (>%0) on success, negative errno on failure.
+ */
+int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
+{
+	int idx, i;
+
+	for (i = 0, idx = 0; idx <= index; i++) {
+		struct acpi_gpio_info info;
+		struct gpio_desc *desc;
+
+		desc = acpi_get_gpiod_by_index(adev, NULL, i, &info);
+		if (IS_ERR(desc))
+			break;
+		if (info.gpioint && idx++ == index)
+			return gpiod_to_irq(desc);
+	}
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(acpi_dev_gpio_irq_get);
+
 static acpi_status
 acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 			    u32 bits, u64 *value, void *handler_context,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e4da5e35e29c..f57c440642cd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -721,6 +721,8 @@ static inline void acpi_dev_remove_driver_gpios(struct acpi_device *adev)
 	if (adev)
 		adev->driver_gpios = NULL;
 }
+
+int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index);
 #else
 static inline int acpi_dev_add_driver_gpios(struct acpi_device *adev,
 			      const struct acpi_gpio_mapping *gpios)
@@ -728,6 +730,11 @@ static inline int acpi_dev_add_driver_gpios(struct acpi_device *adev,
 	return -ENXIO;
 }
 static inline void acpi_dev_remove_driver_gpios(struct acpi_device *adev) {}
+
+static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
+{
+	return -ENXIO;
+}
 #endif
 
 /* Device properties */
-- 
2.1.4

