From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v6] platform/x86: Add Intel Cherry Trail ACPI INT33FE device driver
Date: Thu,  6 Apr 2017 09:24:36 +0200
Message-ID: <20170406072436.12898-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932933AbdDFHYk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 6 Apr 2017 03:24:40 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org

The INT33FE ACPI device has a CRS table with I2cSerialBusV2 resources for
3 devices: Maxim MAX17047 Fuel Gauge Controller, FUSB302 USB Type-C
Controller and PI3USB30532 USB switch.

This commit adds a driver for this ACPI device which instantiates
i2c-clients for these, so that the standard i2c drivers for these chips
can bind to the them.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>
---
Changes in v4:
-This is a new patch in v4 of this patch-set replacing the
 cht_wc_fuel_gauge driver which was binding to the INT33FE device before
 I figured out this is some sort of meta device describing 3 devices
 and that the fuel-guage really is just a Maxim MAX17047. The
 cht_wc_fuel_gauge driver will be replaced by a max17047 driver which I
 will submit seperately
Changes in v5:
-Remove not needed (and not upstream) #include <linux/power/acpi.h>
-Sort variable declarations in upside-down Chistmas tree order
Changes in v6:
-The i2c device at address 0x22 pointed to by the INT33FE acpi node is
 actually a FUSB302 not a FUSB300C do s/300c/302/
-Added Reviewed-by-s from v5 review
---
 drivers/platform/x86/Kconfig             |  13 +++
 drivers/platform/x86/Makefile            |   1 +
 drivers/platform/x86/intel_cht_int33fe.c | 143 +++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+)
 create mode 100644 drivers/platform/x86/intel_cht_int33fe.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 6a5b79c..53afa78 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -772,6 +772,19 @@ config ACPI_CMPC
 	  keys as input device, backlight device, tablet and accelerometer
 	  devices.
 
+config INTEL_CHT_INT33FE
+	tristate "Intel Cherry Trail ACPI INT33FE Driver"
+	depends on X86 && ACPI
+	---help---
+	  This driver add support for the INT33FE ACPI device found on
+	  some Intel Cherry Trail devices.
+
+	  The INT33FE ACPI device has a CRS table with I2cSerialBusV2
+	  resources for 3 devices: Maxim MAX17047 Fuel Gauge Controller,
+	  FUSB302 USB Type-C Controller and PI3USB30532 USB switch.
+	  This driver instantiates i2c-clients for these, so that standard
+	  i2c drivers for these chips can bind to the them.
+
 config INTEL_HID_EVENT
 	tristate "INTEL HID Event"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 6d4b01a..6731893 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_TOSHIBA_BT_RFKILL)	+= toshiba_bluetooth.o
 obj-$(CONFIG_TOSHIBA_HAPS)	+= toshiba_haps.o
 obj-$(CONFIG_TOSHIBA_WMI)	+= toshiba-wmi.o
+obj-$(CONFIG_INTEL_CHT_INT33FE)	+= intel_cht_int33fe.o
 obj-$(CONFIG_INTEL_HID_EVENT)	+= intel-hid.o
 obj-$(CONFIG_INTEL_VBTN)	+= intel-vbtn.o
 obj-$(CONFIG_INTEL_SCU_IPC)	+= intel_scu_ipc.o
diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
new file mode 100644
index 0000000..6a1b2ca
--- /dev/null
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -0,0 +1,143 @@
+/*
+ * Intel Cherry Trail ACPI INT33FE pseudo device driver
+ *
+ * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Some Intel Cherry Trail based device which ship with Windows 10, have
+ * this weird INT33FE ACPI device with a CRS table with 4 I2cSerialBusV2
+ * resources, for 4 different chips attached to various i2c busses:
+ * 1. The Whiskey Cove pmic, which is also described by the INT34D3 ACPI device
+ * 2. Maxim MAX17047 Fuel Gauge Controller
+ * 3. FUSB302 USB Type-C Controller
+ * 4. PI3USB30532 USB switch
+ *
+ * So this driver is a stub / pseudo driver whose only purpose is to
+ * instantiate i2c-clients for chips 2 - 4, so that standard i2c drivers
+ * for these chips can bind to the them.
+ */
+
+#include <linux/acpi.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#define EXPECTED_PTYPE		4
+
+struct cht_int33fe_data {
+	struct i2c_client *max17047;
+	struct i2c_client *fusb302;
+	struct i2c_client *pi3usb30532;
+};
+
+static int cht_int33fe_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct i2c_board_info board_info;
+	struct cht_int33fe_data *data;
+	unsigned long long ptyp;
+	acpi_status status;
+	int fusb302_irq;
+
+	status = acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP", NULL, &ptyp);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "Error getting PTYPE\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * The same ACPI HID is used for different configurations check PTYP
+	 * to ensure that we are dealing with the expected config.
+	 */
+	if (ptyp != EXPECTED_PTYPE)
+		return -ENODEV;
+
+	/* The FUSB302 uses the irq at index 1 and is the only irq user */
+	fusb302_irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 1);
+	if (fusb302_irq < 0) {
+		if (fusb302_irq != -EPROBE_DEFER)
+			dev_err(dev, "Error getting FUSB302 irq\n");
+		return fusb302_irq;
+	}
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	memset(&board_info, 0, sizeof(board_info));
+	strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
+
+	data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
+	if (!data->max17047)
+		return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
+
+	memset(&board_info, 0, sizeof(board_info));
+	strlcpy(board_info.type, "fusb302", I2C_NAME_SIZE);
+	board_info.irq = fusb302_irq;
+
+	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
+	if (!data->fusb302)
+		goto out_unregister_max17047;
+
+	memset(&board_info, 0, sizeof(board_info));
+	strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
+
+	data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
+	if (!data->pi3usb30532)
+		goto out_unregister_fusb302;
+
+	i2c_set_clientdata(client, data);
+
+	return 0;
+
+out_unregister_fusb302:
+	i2c_unregister_device(data->fusb302);
+
+out_unregister_max17047:
+	i2c_unregister_device(data->max17047);
+
+	return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
+}
+
+static int cht_int33fe_remove(struct i2c_client *i2c)
+{
+	struct cht_int33fe_data *data = i2c_get_clientdata(i2c);
+
+	i2c_unregister_device(data->pi3usb30532);
+	i2c_unregister_device(data->fusb302);
+	i2c_unregister_device(data->max17047);
+
+	return 0;
+}
+
+static const struct i2c_device_id cht_int33fe_i2c_id[] = {
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, cht_int33fe_i2c_id);
+
+static const struct acpi_device_id cht_int33fe_acpi_ids[] = {
+	{ "INT33FE", },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cht_int33fe_acpi_ids);
+
+static struct i2c_driver cht_int33fe_driver = {
+	.driver	= {
+		.name = "Intel Cherry Trail ACPI INT33FE driver",
+		.acpi_match_table = ACPI_PTR(cht_int33fe_acpi_ids),
+	},
+	.probe_new = cht_int33fe_probe,
+	.remove = cht_int33fe_remove,
+	.id_table = cht_int33fe_i2c_id,
+	.disable_i2c_core_irq_mapping = true,
+};
+
+module_i2c_driver(cht_int33fe_driver);
+
+MODULE_DESCRIPTION("Intel Cherry Trail ACPI INT33FE pseudo device driver");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
+MODULE_LICENSE("GPL");
-- 
2.9.3
