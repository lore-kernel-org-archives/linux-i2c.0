From: Curt Brune <curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 1/2] Create eeprom_dev hardware class for EEPROM devices
Date: Wed, 22 Jan 2014 09:47:34 -0800
Message-ID: <1390412855-2927-1-git-send-email-curt@cumulusnetworks.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Create a new hardware class under /sys/class/eeprom_dev

EEPROM drivers can register their devices with the eeprom_dev class
during instantiation.

The registered devices show up as:

  /sys/class/eeprom_dev/eeprom0
  /sys/class/eeprom_dev/eeprom1
  ...
  /sys/class/eeprom_dev/eeprom[N]

Each member of the eeprom class exports a sysfs file called "label",
containing the label property from the corresponding device tree node.

Example:

  /sys/class/eeprom_dev/eeprom0/label

If the device tree node property "label" does not exist the value
"unknown" is used.

Userspace can use the label to identify what the EEPROM is for.

The real device is available from the class device via the "device"
link:

  /sys/class/eeprom_dev/eeprom0/device

Signed-off-by: Curt Brune <curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
---
 Documentation/misc-devices/eeprom_hw_class.txt |   81 ++++++++++++
 drivers/misc/eeprom/Kconfig                    |   11 ++
 drivers/misc/eeprom/Makefile                   |    1 +
 drivers/misc/eeprom/eeprom_class.c             |  159 ++++++++++++++++++++++++
 include/linux/eeprom_class.h                   |   35 ++++++
 5 files changed, 287 insertions(+)
 create mode 100644 Documentation/misc-devices/eeprom_hw_class.txt
 create mode 100644 drivers/misc/eeprom/eeprom_class.c
 create mode 100644 include/linux/eeprom_class.h

diff --git a/Documentation/misc-devices/eeprom_hw_class.txt b/Documentation/misc-devices/eeprom_hw_class.txt
new file mode 100644
index 0000000..b5cbc35
--- /dev/null
+++ b/Documentation/misc-devices/eeprom_hw_class.txt
@@ -0,0 +1,81 @@
+EEPROM Device Hardware Class
+============================
+
+This feature is enabled by CONFIG_EEPROM_CLASS.
+
+The original problem:
+
+We work on several different switching platforms, each of which has
+about 64 EEPROMs, one for each of the 10G SFP+ modules.  In addition
+the systems typically have a board info EEPROM, SPD and power supply
+EEPROMs.  It is difficult to map the device tree entries for the
+EEPROMs to the appropriate sysfs device needed for I/O in a generic
+way.
+
+Also mappings are further complicated by some systems using custom i2c
+buses implemented in FPGAs.
+
+The solution is two fold:
+
+1. Create an EEPROM class for all EEPROM devices.  Each EEPROM driver,
+at24 for example, would register with the class during probe().
+
+2. Create a mapping in the .dts file by adding a property called
+'label' to each EEPROM entry.  The EEPROM class will expose this label
+property for all EEPROMs.
+
+For example, for all the EEPROM devices in the system you would see
+directories in sysfs like:
+
+  /sys/class/eeprom_dev/eeprom0
+  /sys/class/eeprom_dev/eeprom1
+  /sys/class/eeprom_dev/eeprom2
+  ...
+  /sys/class/eeprom_dev/eeprom<N>
+
+Within each eepromN directory you would find:
+
+  root@switch:/sys/class/eeprom_dev# ls -l eeprom2/
+  total 0
+  lrwxrwxrwx 1 root root    0 Sep  3 22:08 device -> ../../../1-0050
+  -r--r--r-- 1 root root 4096 Sep  3 22:08 label
+  lrwxrwxrwx 1 root root    0 Sep  4 17:18 subsystem ->  ../../../../../../../class/eeprom_dev
+
+device -- this is a symlink to the physical device.  For example to
+dump the EEPROM data of eeprom2 you could do:
+
+  hexdump -C /sys/class/eeprom_dev/eeprom2/device/eeprom
+
+As an example the device tree entry corresponding to eeprom2 could
+look like:
+
+	sfp_eeprom@50 {
+		compatible = "at,24c04";
+		reg = <0x50>;
+		label = "port6";
+	};
+
+From the original problem, imagine 64 similar entries for all the
+other ports.  Plus a few more entries for board EEPROM and power
+supply EEPROMs.
+
+From user space if I wanted to know the device corresponding to port6
+I could do something as simple as:
+
+root@switch:~# grep port6 /sys/class/eeprom_dev/eeprom*/label
+/sys/class/eeprom_dev/eeprom2/label:port6
+
+Then I could access the information via
+/sys/class/eeprom_dev/eeprom2/device/eeprom.
+
+It is nice that it keeps the mapping all in one place, in the .dts
+file.  It is not spread around in the device tree and some other
+platform specific configuration file.
+
+Note: For devices without a 'label' property the label file is still
+created, however, its contents would be set to 'unknown'.
+
+Note2: The class cannot be called 'eeprom' as that is the name of the
+I/O file created by the driver.  The class name appears as a
+sub-directory within the main device directory.  Hence the class name
+'eeprom_dev'.
diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 9536852f..be6b727 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -1,102 +1,113 @@
 menu "EEPROM support"
 
+config EEPROM_CLASS
+	tristate "EEPROM Hardware Class support"
+	depends on SYSFS
+	default y
+	help
+	  Creates a hardware class in sysfs called "eeprom_dev",
+	  providing a common place to register EEPROM devices.
+
+	  This support can also be built as a module.  If so, the module
+	  will be called eeprom_class.
+
 config EEPROM_AT24
 	tristate "I2C EEPROMs / RAMs / ROMs from most vendors"
 	depends on I2C && SYSFS
 	help
 	  Enable this driver to get read/write support to most I2C EEPROMs
 	  and compatible devices like FRAMs, SRAMs, ROMs etc. After you
 	  configure the driver to know about each chip on your target
 	  board.  Use these generic chip names, instead of vendor-specific
 	  ones like at24c64, 24lc02 or fm24c04:
 
 	     24c00, 24c01, 24c02, spd (readonly 24c02), 24c04, 24c08,
 	     24c16, 24c32, 24c64, 24c128, 24c256, 24c512, 24c1024
 
 	  Unless you like data loss puzzles, always be sure that any chip
 	  you configure as a 24c32 (32 kbit) or larger is NOT really a
 	  24c16 (16 kbit) or smaller, and vice versa. Marking the chip
 	  as read-only won't help recover from this. Also, if your chip
 	  has any software write-protect mechanism you may want to review the
 	  code to make sure this driver won't turn it on by accident.
 
 	  If you use this with an SMBus adapter instead of an I2C adapter,
 	  full functionality is not available.  Only smaller devices are
 	  supported (24c16 and below, max 4 kByte).
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called at24.
 
 config EEPROM_AT25
 	tristate "SPI EEPROMs from most vendors"
 	depends on SPI && SYSFS
 	help
 	  Enable this driver to get read/write support to most SPI EEPROMs,
 	  after you configure the board init code to know about each eeprom
 	  on your target board.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called at25.
 
 config EEPROM_LEGACY
 	tristate "Old I2C EEPROM reader"
 	depends on I2C && SYSFS
 	help
 	  If you say yes here you get read-only access to the EEPROM data
 	  available on modern memory DIMMs and Sony Vaio laptops via I2C. Such
 	  EEPROMs could theoretically be available on other devices as well.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called eeprom.
 
 config EEPROM_MAX6875
 	tristate "Maxim MAX6874/5 power supply supervisor"
 	depends on I2C
 	help
 	  If you say yes here you get read-only support for the user EEPROM of
 	  the Maxim MAX6874/5 EEPROM-programmable, quad power-supply
 	  sequencer/supervisor.
 
 	  All other features of this chip should be accessed via i2c-dev.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called max6875.
 
 
 config EEPROM_93CX6
 	tristate "EEPROM 93CX6 support"
 	help
 	  This is a driver for the EEPROM chipsets 93c46 and 93c66.
 	  The driver supports both read as well as write commands.
 
 	  If unsure, say N.
 
 config EEPROM_93XX46
 	tristate "Microwire EEPROM 93XX46 support"
 	depends on SPI && SYSFS
 	help
 	  Driver for the microwire EEPROM chipsets 93xx46x. The driver
 	  supports both read and write commands and also the command to
 	  erase the whole EEPROM.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called eeprom_93xx46.
 
 	  If unsure, say N.
 
 config EEPROM_DIGSY_MTC_CFG
 	bool "DigsyMTC display configuration EEPROMs device"
 	depends on GPIO_MPC5200 && SPI_GPIO
 	help
 	  This option enables access to display configuration EEPROMs
 	  on digsy_mtc board. You have to additionally select Microwire
 	  EEPROM 93XX46 driver. sysfs entries will be created for that
 	  EEPROM allowing to read/write the configuration data or to
 	  erase the whole EEPROM.
 
 	  If unsure, say N.
 
 config EEPROM_SUNXI_SID
 	tristate "Allwinner sunxi security ID support"
 	depends on ARCH_SUNXI && SYSFS
 	help
diff --git a/drivers/misc/eeprom/Makefile b/drivers/misc/eeprom/Makefile
index 9507aec..d2369ca 100644
--- a/drivers/misc/eeprom/Makefile
+++ b/drivers/misc/eeprom/Makefile
@@ -1,8 +1,9 @@
+obj-$(CONFIG_EEPROM_CLASS)	+= eeprom_class.o
 obj-$(CONFIG_EEPROM_AT24)	+= at24.o
 obj-$(CONFIG_EEPROM_AT25)	+= at25.o
 obj-$(CONFIG_EEPROM_LEGACY)	+= eeprom.o
 obj-$(CONFIG_EEPROM_MAX6875)	+= max6875.o
 obj-$(CONFIG_EEPROM_93CX6)	+= eeprom_93cx6.o
 obj-$(CONFIG_EEPROM_93XX46)	+= eeprom_93xx46.o
 obj-$(CONFIG_EEPROM_SUNXI_SID)	+= sunxi_sid.o
 obj-$(CONFIG_EEPROM_DIGSY_MTC_CFG) += digsy_mtc_eeprom.o
diff --git a/drivers/misc/eeprom/eeprom_class.c b/drivers/misc/eeprom/eeprom_class.c
new file mode 100644
index 0000000..c934ba6e
--- /dev/null
+++ b/drivers/misc/eeprom/eeprom_class.c
@@ -0,0 +1,159 @@
+/*
+ * eeprom_class.c
+ *
+ * This file defines the sysfs class "eeprom", for use by EEPROM
+ * drivers.
+ *
+ * Copyright (C) 2013 Cumulus Networks, Inc.
+ * Author: Curt Brune <curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
+ *
+ * Ideas and structure graciously borrowed from the hwmon class:
+ * Copyright (C) 2005 Mark M. Hoffman <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kdev_t.h>
+#include <linux/idr.h>
+#include <linux/eeprom_class.h>
+#include <linux/gfp.h>
+#include <linux/spinlock.h>
+#include <linux/pci.h>
+
+/* Root eeprom "class" object (corresponds to '/<sysfs>/class/eeprom_dev/') */
+static struct class *eeprom_class;
+
+#define EEPROM_CLASS_NAME "eeprom_dev"
+#define EEPROM_ID_PREFIX "eeprom"
+#define EEPROM_ID_FORMAT EEPROM_ID_PREFIX "%d"
+
+static DEFINE_IDA(eeprom_ida);
+
+/**
+ * eeprom_device_register - register w/ eeprom class
+ * @dev: the device to register
+ *
+ * eeprom_device_unregister() must be called when the device is no
+ * longer needed.
+ *
+ * Creates a new eeprom class device that is a child of @dev.  Also
+ * creates a symlink in /<sysfs>/class/eeprom_dev/eeprom[N] pointing
+ * to the new device.
+ *
+ * Returns the pointer to the new device.
+ */
+struct device *eeprom_device_register(struct device *dev)
+{
+	struct device *eeprom_dev;
+	int id;
+
+	id = ida_simple_get(&eeprom_ida, 0, 0, GFP_KERNEL);
+	if (id < 0)
+		return ERR_PTR(id);
+
+	eeprom_dev = device_create(eeprom_class, dev, MKDEV(0, 0), NULL,
+				   EEPROM_ID_FORMAT, id);
+
+	if (IS_ERR(eeprom_dev))
+		ida_simple_remove(&eeprom_ida, id);
+
+	return eeprom_dev;
+}
+
+/**
+ * eeprom_device_unregister - removes the previously registered class device
+ *
+ * @dev: the class device to destroy
+ */
+void eeprom_device_unregister(struct device *dev)
+{
+	int id;
+
+	if (likely(sscanf(dev_name(dev), EEPROM_ID_FORMAT, &id) == 1)) {
+		device_unregister(dev);
+		ida_simple_remove(&eeprom_ida, id);
+	} else
+		dev_dbg(dev->parent,
+			"eeprom_device_unregister() failed: bad class ID!\n");
+}
+
+/**
+ * Each member of the eeprom class exports a sysfs file called
+ * "label", containing the label property from the corresponding
+ * device tree node.
+ *
+ *  Userspace can use the label to identify what the EEPROM is for.
+ */
+static ssize_t label_show(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	const char* cp = NULL;
+	int len = 0;
+
+	/*
+	 * The class device is a child of the original device,
+	 * i.e. dev->parent points to the original device.
+	 */
+	if (dev->parent && dev->parent->of_node)
+		cp = of_get_property(dev->parent->of_node, "label", &len);
+
+	if ((cp == NULL) || (len == 0)) {
+		cp = "unknown";
+		len = strlen(cp) + 1;
+	}
+
+	strncpy(buf, cp, len - 1);
+	buf[len - 1] = '\n';
+	buf[len] = '\0';
+
+	return len;
+}
+
+struct device_attribute eeprom_class_dev_attrs[] = {
+	__ATTR_RO(label),
+	__ATTR_NULL,
+};
+
+static int __init eeprom_init(void)
+{
+	eeprom_class = class_create(THIS_MODULE, EEPROM_CLASS_NAME);
+	if (IS_ERR(eeprom_class)) {
+		pr_err("couldn't create sysfs class\n");
+		return PTR_ERR(eeprom_class);
+	}
+
+	eeprom_class->dev_attrs = eeprom_class_dev_attrs;
+
+	return 0;
+}
+
+static void __exit eeprom_exit(void)
+{
+	class_destroy(eeprom_class);
+}
+
+subsys_initcall(eeprom_init);
+module_exit(eeprom_exit);
+
+EXPORT_SYMBOL_GPL(eeprom_device_register);
+EXPORT_SYMBOL_GPL(eeprom_device_unregister);
+
+MODULE_AUTHOR("Curt Brune <curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>");
+MODULE_DESCRIPTION("eeprom sysfs/class support");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/eeprom_class.h b/include/linux/eeprom_class.h
new file mode 100644
index 0000000..389ac16
--- /dev/null
+++ b/include/linux/eeprom_class.h
@@ -0,0 +1,35 @@
+/*
+ * eeprom_class.c
+ *
+ * This file exports interface functions for the sysfs class "eeprom",
+ * for use by EEPROM drivers.
+ *
+ * Copyright (C) 2013 Cumulus Networks, Inc.
+ * Author: Curt Brune <curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#ifndef EEPROM_CLASS_H__
+#define EEPROM_CLASS_H__
+
+#include <linux/device.h>
+#include <linux/err.h>
+
+struct device *eeprom_device_register(struct device *dev);
+
+void eeprom_device_unregister(struct device *dev);
+
+#endif /* EEPROM_CLASS_H__ */
-- 
1.7.10.4
