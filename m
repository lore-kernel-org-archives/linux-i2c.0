From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3] [MFD] i2c-htcpld: Add the HTCPLD driver
Date: Mon, 14 Dec 2009 17:38:55 -0800
Message-ID: <1260841135-6680-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This change introduces a driver for the HTC PLD chip found
on some smartphones, such as the HTC Wizard and HTC Herald.
It works through the I2C bus and acts as a GPIO extender.
Specifically:

 * it can have several sub-devices, each with its own I2C
   address
 * Each sub-device provides 8 output and 8 input pins
 * The chip attaches to one GPIO to signal when any of the
   input GPIOs change -- at which point all chips must be
   scanned for changes

This driver implements the GPIOs throught the kernel's
GPIO and IRQ framework.  This allows any GPIO-servicing
drivers to operate on htcpld pins, such as the gpio-keys
and gpio-leds drivers.

Signed-off-by: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/mfd/Kconfig      |    9 +
 drivers/mfd/Makefile     |    1 +
 drivers/mfd/htc-i2cpld.c |  591 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/htcpld.h   |   24 ++
 4 files changed, 625 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mfd/htc-i2cpld.c
 create mode 100644 include/linux/htcpld.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 08f2d07..f8283cf 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -60,6 +60,15 @@ config HTC_PASIC3
 	  HTC Magician devices, respectively. Actual functionality is
 	  handled by the leds-pasic3 and ds1wm drivers.
 
+config HTC_I2CPLD
+	bool "HTC I2C PLD chip support"
+	depends on I2C
+	help
+	  If you say yes here you get support for the supposed CPLD
+	  found on omap850 HTC devices like the HTC Wizard and HTC Herald.
+	  This device provides input and output GPIOs through an I2C
+	  interface to one or more sub-chips.
+
 config UCB1400_CORE
 	tristate "Philips UCB1400 Core driver"
 	depends on AC97_BUS
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index af0fc90..a374457 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_MFD_ASIC3)		+= asic3.o
 
 obj-$(CONFIG_HTC_EGPIO)		+= htc-egpio.o
 obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
+obj-$(CONFIG_HTC_I2CPLD)	+= htc-i2cpld.o
 
 obj-$(CONFIG_MFD_DM355EVM_MSP)	+= dm355evm_msp.o
 
diff --git a/drivers/mfd/htc-i2cpld.c b/drivers/mfd/htc-i2cpld.c
new file mode 100644
index 0000000..23338ff
--- /dev/null
+++ b/drivers/mfd/htc-i2cpld.c
@@ -0,0 +1,591 @@
+/*
+ *  htc-i2cpld.c
+ *  Chip driver for a ?cpld? found on omap850 HTC devices like the
+ *  HTC Wizard and HTC Herald.
+ *  The cpld is located on the i2c bus and acts as an input/output GPIO
+ *  extender.
+ *
+ *  Copyright (C) 2009 Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *
+ *  Based on work done in the linwizard project
+ *  Copyright (C) 2008-2009 Angelo Arrifano <miknix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/irq.h>
+#include <linux/spinlock.h>
+#include <linux/htcpld.h>
+#include <asm/gpio.h>
+
+void htcpld_chip_set_ni(struct work_struct *work);
+
+struct htcpld_chip {
+	spinlock_t              lock;
+
+	/* chip info */
+	u8                      reset;
+	u8                      addr;
+	struct device           *dev;
+	struct i2c_client	*client;
+
+	/* Output details */
+	u8                      cache_out;
+	struct gpio_chip        chip_out;
+
+	/* Input details */
+	u8                      cache_in;
+	struct gpio_chip        chip_in;
+
+	u16                     irqs_enabled;
+	uint                    irq_start;
+	int                     nirqs;
+
+	/*
+	 * Work structure to allow for setting values outside of any
+	 * possible interrupt context
+	 */
+	struct work_struct set_val_work;
+};
+
+struct htcpld_data {
+	/* irq info */
+	u16                irqs_enabled;
+	uint               irq_start;
+	int                nirqs;
+	uint               chained_irq;
+	unsigned int       int_reset_gpio_hi;
+	unsigned int       int_reset_gpio_lo;
+
+	/* htcpld info */
+	struct htcpld_chip *chip;
+	unsigned int       nchips;
+};
+
+/* There does not appear to be a way to proactively mask interrupts
+ * on the htcpld chip itself.  So, we simply ignore interrupts that
+ * aren't desired. */
+static void htcpld_mask(unsigned int irq)
+{
+	struct htcpld_chip *chip = get_irq_chip_data(irq);
+	chip->irqs_enabled &= ~(1 << (irq - chip->irq_start));
+	pr_debug("HTCPLD mask %d %04x\n", irq, chip->irqs_enabled);
+}
+static void htcpld_unmask(unsigned int irq)
+{
+	struct htcpld_chip *chip = get_irq_chip_data(irq);
+	chip->irqs_enabled |= 1 << (irq - chip->irq_start);
+	pr_debug("HTCPLD unmask %d %04x\n", irq, chip->irqs_enabled);
+}
+
+static int htcpld_set_type(unsigned int irq, unsigned int flags)
+{
+	if (flags & ~IRQ_TYPE_SENSE_MASK)
+		return -EINVAL;
+
+	/* We only allow edge triggering */
+	if (flags & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH))
+		return -EINVAL;
+
+	irq_desc[irq].status &= ~IRQ_TYPE_SENSE_MASK;
+	irq_desc[irq].status |= flags;
+
+	return 0;
+}
+
+static struct irq_chip htcpld_muxed_chip = {
+	.name     = "htcpld",
+	.mask     = htcpld_mask,
+	.unmask   = htcpld_unmask,
+	.set_type = htcpld_set_type,
+};
+
+/* To properly dispatch IRQ events, we need to read from the
+ * chip.  This is an I2C action that could possibly sleep
+ * (which is bad in interrupt context) -- so we use a threaded
+ * interrupt handler to get around that.
+ */
+static irqreturn_t htcpld_handler(int irq, void *dev)
+{
+	struct htcpld_data *htcpld = dev;
+	unsigned int i;
+	unsigned long flags;
+	int irqpin;
+	struct irq_desc *desc;
+
+	if (!htcpld) {
+		printk(KERN_INFO "htcpld is null\n");
+		return IRQ_HANDLED;
+	}
+
+	/*
+	 * For each chip, do a read of the chip and trigger any interrupts
+	 * desired.  The interrupts will be triggered from LSB to MSB (i.e.
+	 * bit 0 first, then bit 1, etc.)
+	 *
+	 * For chips that have no interrupt range specified, just skip 'em.
+	 */
+	for (i = 0; i < htcpld->nchips; i++) {
+		struct htcpld_chip *chip = &htcpld->chip[i];
+		struct i2c_client *client;
+		int val;
+		unsigned long uval, old_val;
+
+		if (!chip) {
+			printk(KERN_INFO "chip %d is null\n", i);
+			continue;
+		}
+
+		if (chip->nirqs == 0)
+			continue;
+
+		client = chip->client;
+		if (!client) {
+			printk(KERN_INFO "client %d is null\n", i);
+			continue;
+		}
+
+		/* Scan the chip */
+		val = i2c_smbus_read_byte_data(client, chip->cache_out);
+		if (val < 0) {
+			/* Throw a warning and skip this chip */
+			dev_warn(chip->dev, "Unable to read from chip: %d\n", val);
+			continue;
+		}
+
+		uval = (unsigned long)val;
+
+		spin_lock_irqsave(&chip->lock, flags);
+
+		/* Save away the old value so we can compare it */
+		old_val = chip->cache_in;
+
+		/* Write the new value */
+		chip->cache_in = uval;
+
+		spin_unlock_irqrestore(&chip->lock, flags);
+
+		/*
+		 * For each bit in the data (starting at bit 0), trigger
+		 * associated interrupts.
+		 */
+		for (irqpin = 0; irqpin < chip->nirqs; irqpin++) {
+			unsigned old_bit, new_bit;
+
+			irq = chip->irq_start + irqpin;
+			desc = irq_to_desc(irq);
+
+			/* Run the IRQ handler, but only if the bit value
+			 * changed, and the proper flags are set */
+			old_bit = (old_val >> irqpin) & 1;
+			new_bit = (uval >> irqpin) & 1;
+
+			if ((old_bit == 0 && new_bit == 1 && desc->status & IRQ_TYPE_EDGE_RISING) ||
+			    (old_bit == 1 && new_bit == 0 && desc->status & IRQ_TYPE_EDGE_FALLING))
+			{
+				pr_debug("fire IRQ %d\n", irqpin);
+				desc->handle_irq(irq, desc);
+			}
+		}
+	}
+
+	/*
+	 * In order to continue receiving interrupts, the int_reset_gpio must
+	 * be asserted.
+	 */
+	if (htcpld->int_reset_gpio_hi)
+		gpio_set_value(htcpld->int_reset_gpio_hi, 1);
+	if (htcpld->int_reset_gpio_lo)
+		gpio_set_value(htcpld->int_reset_gpio_lo, 0);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * The GPIO set routines can be called from interrupt context, especially if,
+ * for example they're attached to the led-gpio framework and a trigger is
+ * enabled.  As such, we declared work above in the htcpld_chip structure,
+ * and that work is scheduled in the set routine.  The kernel can then run
+ * the I2C functions, which will sleep, in process context.
+ */
+void htcpld_chip_set(struct gpio_chip *chip, unsigned offset, int val)
+{
+	struct i2c_client *client;
+	struct htcpld_chip *chip_data;
+	unsigned long flags;
+
+	chip_data = container_of(chip, struct htcpld_chip, chip_out);
+	if (!chip_data)
+		return;
+
+	client = chip_data->client;
+	if (client == NULL)
+		return;
+
+	spin_lock_irqsave(&chip_data->lock, flags);
+	if (val)
+		chip_data->cache_out |= (1 << offset);
+	else
+		chip_data->cache_out &= ~(1 << offset);
+	spin_unlock_irqrestore(&chip_data->lock, flags);
+
+	schedule_work(&(chip_data->set_val_work));
+}
+
+void htcpld_chip_set_ni(struct work_struct *work) {
+	struct htcpld_chip *chip_data = container_of(work, struct htcpld_chip, set_val_work);
+	struct i2c_client *client;
+
+	client = chip_data->client;
+	i2c_smbus_read_byte_data(client, chip_data->cache_out);
+}
+
+int htcpld_chip_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct htcpld_chip *chip_data;
+	int val = 0;
+	int is_input = 0;
+
+	/* Try out first */
+	chip_data = container_of(chip, struct htcpld_chip, chip_out);
+	if (!chip_data) {
+		/* Try in */
+		is_input = 1;
+		chip_data = container_of(chip, struct htcpld_chip, chip_in);
+		if (!chip_data)
+			return -EINVAL;
+	}
+
+	/* Determine if this is an input or output GPIO */
+	if (!is_input)
+		/* Use the output cache */
+		val = (chip_data->cache_out >> offset) & 1;
+	else
+		/* Use the input cache */
+		val = (chip_data->cache_in >> offset) & 1;
+
+	if (val)
+		return 1;
+	else
+		return 0;
+}
+
+static int htcpld_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
+{
+	htcpld_chip_set(chip, offset, value);
+	return 0;
+}
+
+static int htcpld_direction_input(struct gpio_chip *chip,
+					unsigned offset)
+{
+	/*
+	 * No-op: this function can only be called on the input chip.
+	 * We do however make sure the offset is within range.
+	 */
+	return (offset < chip->ngpio) ? 0 : -EINVAL;
+}
+
+int htcpld_chip_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct htcpld_chip *chip_data = container_of(chip, struct htcpld_chip, chip_in);
+	return (offset < chip_data->nirqs) ? (chip_data->irq_start + offset) : -EINVAL;
+}
+
+void htcpld_chip_reset(struct i2c_client *client)
+{
+	struct htcpld_chip *chip_data = i2c_get_clientdata(client);
+	if (!chip_data)
+		return;
+
+	i2c_smbus_read_byte_data(
+		client, (chip_data->cache_out = chip_data->reset));
+}
+
+static int __devinit htcpld_core_probe(struct platform_device *pdev)
+{
+	struct htcpld_data *htcpld;
+	struct device *dev = &pdev->dev;
+	struct htcpld_core_platform_data *pdata;
+	struct resource *res;
+	int i, ret = 0;
+	unsigned int irq, irq_end;
+
+	if (!dev)
+		return -ENODEV;
+
+	pdata = dev->platform_data;
+	if (!pdata) {
+		printk(KERN_ERR "Platform data not found for htcpld core!\n");
+		return -ENXIO;
+	}
+
+	htcpld = kzalloc(sizeof(struct htcpld_data), GFP_KERNEL);
+	if (!htcpld)
+		return -ENOMEM;
+
+	/* Find chained irq */
+	ret = -EINVAL;
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (res)
+		htcpld->chained_irq = res->start;
+
+	platform_set_drvdata(pdev, htcpld);
+
+	htcpld->int_reset_gpio_hi = pdata->int_reset_gpio_hi;
+	htcpld->int_reset_gpio_lo = pdata->int_reset_gpio_lo;
+
+	/* Setup each chip's output GPIOs */
+	htcpld->nchips = pdata->num_chip;
+	htcpld->chip = kzalloc(sizeof(struct htcpld_chip) * htcpld->nchips, GFP_KERNEL);
+	if (!htcpld->chip) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	for (i = 0; i < htcpld->nchips; i++) {
+		struct i2c_adapter *adapter;
+		struct i2c_client *client;
+		struct i2c_board_info info;
+		struct gpio_chip *chip;
+		int ret;
+
+		/* Setup the HTCPLD chips */
+		htcpld->chip[i].reset = pdata->chip[i].reset;
+		htcpld->chip[i].cache_out = pdata->chip[i].reset;
+		htcpld->chip[1].cache_in = 0;
+		htcpld->chip[i].dev = dev;
+		htcpld->chip[i].irq_start = pdata->chip[i].irq_base;
+		htcpld->chip[i].nirqs = pdata->chip[i].num_irqs;
+
+		INIT_WORK(&(htcpld->chip[i].set_val_work), &htcpld_chip_set_ni);
+		spin_lock_init(&(htcpld->chip[i].lock));
+
+		/* Setup the IRQs */
+		if (htcpld->chained_irq) {
+			int error = 0, flags;
+
+			/* Setup irq handlers */
+			irq_end = htcpld->chip[i].irq_start + htcpld->chip[i].nirqs;
+			for (irq = htcpld->chip[i].irq_start; irq < irq_end; irq++) {
+				set_irq_chip(irq, &htcpld_muxed_chip);
+				set_irq_chip_data(irq, &htcpld->chip[i]);
+				set_irq_handler(irq, handle_simple_irq);
+				set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+			}
+
+			flags = IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING | IRQF_SAMPLE_RANDOM;
+			error = request_threaded_irq(
+					htcpld->chained_irq,
+					NULL,
+					htcpld_handler,
+					flags,
+					pdev->name,
+					htcpld);
+
+			device_init_wakeup(dev, 0);
+		}
+
+		/* Setup the GPIO chips */
+		chip = &(htcpld->chip[i].chip_out);
+		chip->label           = "htcpld-out";
+		chip->dev             = dev;
+		chip->owner           = THIS_MODULE;
+		chip->get             = htcpld_chip_get;
+		chip->set             = htcpld_chip_set;
+		chip->direction_input = NULL;
+		chip->direction_output = htcpld_direction_output;
+		chip->base            = pdata->chip[i].gpio_out_base;
+		chip->ngpio           = pdata->chip[i].num_gpios;
+
+		chip = &(htcpld->chip[i].chip_in);
+		chip->label           = "htcpld-in";
+		chip->dev             = dev;
+		chip->owner           = THIS_MODULE;
+		chip->get             = htcpld_chip_get;
+		chip->set             = NULL;
+		chip->direction_input = htcpld_direction_input;
+		chip->direction_output = NULL;
+		chip->to_irq          = htcpld_chip_to_irq;
+		chip->base            = pdata->chip[i].gpio_in_base;
+		chip->ngpio           = pdata->chip[i].num_gpios;
+
+		/* Register the chip with I2C */
+		adapter = i2c_get_adapter(pdata->i2c_adapter_id);
+		if (adapter == NULL) {
+			/*
+			 * Eek, no such I2C adapter!  Try and continue
+			 * with the next chip.
+			 */
+			dev_warn(dev, "Chip at i2c address 0x%x: Invalid i2c adapter %d\n",
+				 pdata->chip[i].addr, pdata->i2c_adapter_id);
+			continue;
+		}
+
+		if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA))
+			dev_warn(dev, "i2c adapter %d non-functional\n",
+				 pdata->i2c_adapter_id);
+
+		memset(&info, 0, sizeof(struct i2c_board_info));
+		info.addr = pdata->chip[i].addr;
+		strlcpy(info.type, "htcpld-chip", I2C_NAME_SIZE);
+		info.platform_data = &(htcpld->chip[i]);
+
+		/* Add the I2C device.  This calls the probe() function. */
+		client = i2c_new_device(adapter, &info);
+		if (!client) {
+			/* I2C device registration failed, contineu with the next */
+			dev_warn(dev, "Unable to add I2C device for 0x%x\n",
+				 pdata->chip[i].addr);
+			continue;
+		}
+
+		i2c_set_clientdata(client, &(htcpld->chip[i]));
+		snprintf(client->name, I2C_NAME_SIZE, "Chip_0x%d", client->addr);
+		htcpld->chip[i].client = client;
+
+		/* Reset the chip */
+		htcpld_chip_reset(client);
+		htcpld->chip[i].cache_in = i2c_smbus_read_byte_data(client, htcpld->chip[i].cache_out);
+
+		/* Add the GPIO chips */
+		ret = gpiochip_add(&(htcpld->chip[i].chip_out));
+		if (ret != 0) {
+			/*
+			 * GPIO adding failed, undo the I2C registration and
+			 * bail out
+			 */
+			dev_warn(dev, "Unable to register GPIOs for 0x%x: %d\n",
+				 pdata->chip[i].addr, ret);
+
+			/* This call can't fail */
+			i2c_unregister_device(client);
+			continue;
+		}
+
+		ret = gpiochip_add(&(htcpld->chip[i].chip_in));
+		if (ret != 0) {
+			/*
+			 * GPIO adding failed, undo the I2C registration and
+			 * bail out
+			 */
+			dev_warn(dev, "Unable to register GPIOs for 0x%x: %d\n",
+				 pdata->chip[i].addr, ret);
+
+			ret = gpiochip_remove(&(htcpld->chip[i].chip_out));
+			if (ret)
+				dev_warn(dev, "Unable to unregister output gpio for 0x%d: %d\n",
+					 pdata->chip[i].addr, ret);
+
+			/* This call can't fail */
+			i2c_unregister_device(client);
+			continue;
+		}
+
+		printk(KERN_INFO "htcpld: Registered chip at 0x%x\n", client->addr);
+	}
+
+	/* Request the GPIO(s) for the int reset and set them up */
+	if (htcpld->int_reset_gpio_hi) {
+		ret = gpio_request(htcpld->int_reset_gpio_hi, "htcpld-core");
+		if (ret) {
+			/*
+			 * If it failed, that sucks, but we can probably continue
+			 * on without it.
+			 */
+			dev_warn(dev, "Unable to request int_reset_gpio_hi -- interrupts may not work\n");
+			htcpld->int_reset_gpio_hi = 0;
+		} else
+			gpio_set_value(htcpld->int_reset_gpio_hi, 1);
+	}
+
+	if (htcpld->int_reset_gpio_lo) {
+		ret = gpio_request(htcpld->int_reset_gpio_lo, "htcpld-core");
+		if (ret) {
+			/*
+			 * If it failed, that sucks, but we can probably continue
+			 * on without it.
+			 */
+			dev_warn(dev, "Unable to request int_reset_gpio_lo -- interrupts may not work\n");
+			htcpld->int_reset_gpio_lo = 0;
+		} else
+			gpio_set_value(htcpld->int_reset_gpio_lo, 0);
+	}
+
+	/* Set them up initially */
+
+	printk(KERN_INFO "htcpld: Initialized successfully\n");
+	return 0;
+
+fail:
+	kfree(htcpld);
+	return ret;
+}
+
+/* The I2C Driver -- used internally */
+static const struct i2c_device_id htcpld_chip_id[] = {
+        { "htcpld-chip", 0 },
+        { }
+};
+MODULE_DEVICE_TABLE(i2c, htcpld_chip_id);
+
+
+static struct i2c_driver htcpld_chip_driver = {
+	.driver = {
+		.name	= "htcpld-chip",
+	},
+	.id_table = htcpld_chip_id,
+};
+
+/* The Core Driver */
+static struct platform_driver htcpld_core_driver = {
+	.driver = {
+		.name = "i2c-htcpld",
+	},
+};
+
+static int __init htcpld_core_init(void)
+{
+	int ret;
+
+	/* Register the I2C Chip driver */
+	ret = i2c_add_driver(&htcpld_chip_driver);
+	if (ret)
+		return ret;
+
+	/* Probe for our chips */
+	return platform_driver_probe(&htcpld_core_driver, htcpld_core_probe);
+}
+
+static void __exit htcpld_core_exit(void)
+{
+	i2c_del_driver(&htcpld_chip_driver);
+	platform_driver_unregister(&htcpld_core_driver);
+}
+
+module_init(htcpld_core_init);
+module_exit(htcpld_core_exit);
+
+MODULE_AUTHOR("Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("I2C HTC PLD Driver");
+MODULE_LICENSE("GPL");
+
diff --git a/include/linux/htcpld.h b/include/linux/htcpld.h
new file mode 100644
index 0000000..ab3f6cb
--- /dev/null
+++ b/include/linux/htcpld.h
@@ -0,0 +1,24 @@
+#ifndef __LINUX_HTCPLD_H
+#define __LINUX_HTCPLD_H
+
+struct htcpld_chip_platform_data {
+	unsigned int addr;
+	unsigned int reset;
+	unsigned int num_gpios;
+	unsigned int gpio_out_base;
+	unsigned int gpio_in_base;
+	unsigned int irq_base;
+	unsigned int num_irqs;
+};
+
+struct htcpld_core_platform_data {
+	unsigned int                      int_reset_gpio_hi;
+	unsigned int                      int_reset_gpio_lo;
+	unsigned int                      i2c_adapter_id;
+
+	struct htcpld_chip_platform_data  *chip;
+	unsigned int                      num_chip;
+};
+
+#endif /* __LINUX_HTCPLD_H */
+
-- 
1.6.3.3
