From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 2/2] i2c, i2c_imc: Add DIMM bus code
Date: Thu, 28 Apr 2016 18:03:25 -0700
Message-ID: <01cb3ac1d5c76f61890e258a20758c7f75fb161a.1461891499.git.luto@kernel.org>
References: <cover.1461891499.git.luto@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461891499.git.luto@kernel.org>
In-Reply-To: <cover.1461891499.git.luto@kernel.org>
References: <cover.1461891499.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Christoph Hellwig <hch@infradead.org>
Cc: Boaz Harrosh <boaz@plexistor.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Rui Wang <ruiv.wang@gmail.com>, Jean Delvare <jdelvare@suse.de>, Alun Evans <alun@badgerous.net>, Robert Elliott <Elliott@hp.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Paul Bolle <pebolle@tiscali.nl>, Tony Luck <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-i2c@vger.kernel.org

Add i2c_scan_dimm_bus to declare that a particular i2c_adapter
contains DIMMs.  This will probe (and autoload modules!) for useful
SMBUS devices that live on DIMMs.  i2c_imc calls it.

As more SMBUS-addressable DIMM components become supported, this
code can be extended to probe for them.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/i2c/busses/Kconfig    |   5 ++
 drivers/i2c/busses/Makefile   |   4 ++
 drivers/i2c/busses/dimm-bus.c | 107 ++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-imc.c  |   3 ++
 include/linux/i2c/dimm-bus.h  |  20 ++++++++
 5 files changed, 139 insertions(+)
 create mode 100644 drivers/i2c/busses/dimm-bus.c
 create mode 100644 include/linux/i2c/dimm-bus.h

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 3c05de897566..10aa87872408 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -152,9 +152,14 @@ config I2C_ISMT
 	  This driver can also be built as a module.  If so, the module will be
 	  called i2c-ismt.
 
+config I2C_DIMM_BUS
+       tristate
+       default n
+
 config I2C_IMC
 	tristate "Intel iMC (LGA 2011) SMBus Controller"
 	depends on PCI && X86
+	select I2C_DIMM_BUS
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  Integrated Memory Controller SMBus host controller interface.  This
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index ab3cdf1b3ca1..093591935bc8 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -25,6 +25,10 @@ obj-$(CONFIG_I2C_SIS96X)	+= i2c-sis96x.o
 obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
 obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
 
+# DIMM busses
+obj-$(CONFIG_I2C_DIMM_BUS)	+= dimm-bus.o
+obj-$(CONFIG_I2C_IMC)		+= i2c-imc.o
+
 # Mac SMBus host controller drivers
 obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
 obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
diff --git a/drivers/i2c/busses/dimm-bus.c b/drivers/i2c/busses/dimm-bus.c
new file mode 100644
index 000000000000..d41c1095c093
--- /dev/null
+++ b/drivers/i2c/busses/dimm-bus.c
@@ -0,0 +1,107 @@
+/*
+ * Copyright (c) 2013-2016 Andrew Lutomirski <luto@amacapital.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/i2c.h>
+#include <linux/bug.h>
+#include <linux/module.h>
+#include <linux/i2c/dimm-bus.h>
+
+static bool probe_addr(struct i2c_adapter *adapter, int addr)
+{
+	/*
+	 * So far, all known devices that live on DIMMs can be safely
+	 * and reliably detected by trying to read a byte at address
+	 * zero.  (The exception is the SPD write protection control,
+	 * which can't be probed and requires special hardware and/or
+	 * quick writes to access, and has no driver.)
+	 */
+	union i2c_smbus_data dummy;
+
+	return i2c_smbus_xfer(adapter, addr, 0, I2C_SMBUS_READ, 0,
+			      I2C_SMBUS_BYTE_DATA, &dummy) >= 0;
+}
+
+/**
+ * i2c_scan_dimm_bus() - Scans an SMBUS segment known to contain DIMMs
+ * @adapter: The SMBUS adapter to scan
+ *
+ * This function tells the DIMM-bus code that the adapter is known to
+ * contain DIMMs.  i2c_scan_dimm_bus will probe for devices known to
+ * live on DIMMs.
+ *
+ * Do NOT call this function on general-purpose system SMBUS segments
+ * unless you know that the only things on the bus are DIMMs.
+ * Otherwise is it very likely to mis-identify other things on the
+ * bus.
+ *
+ * Callers are advised not to set adapter->class = I2C_CLASS_SPD to
+ * avoid having two separate mechanisms trying to automatically claim
+ * devices on the bus.
+ */
+void i2c_scan_dimm_bus(struct i2c_adapter *adapter)
+{
+	struct i2c_board_info info = {};
+	int slot;
+
+	/*
+	 * We probe with "read byte data".  If any DIMM SMBUS driver can't
+	 * support that access type, this function should be updated.
+	 */
+	if (WARN_ON(!i2c_check_functionality(adapter,
+					     I2C_FUNC_SMBUS_READ_BYTE_DATA)))
+		return;
+
+	/*
+	 * Addresses on DIMMs use the three low bits to identify the slot
+	 * and the four high bits to identify the device type.  Known
+	 * devices are:
+	 *
+	 *  - 0x50 - 0x57: SPD (Serial Presence Detect) EEPROM
+	 *  - 0x30 - 0x37: SPD WP control -- not easy to probe
+	 *  - 0x18 - 0x1f: TSOD (Temperature Sensor on DIMM)
+	 *
+	 * There's no point in trying to probe the SPD WP control: we'd
+	 * want to probe using quick reads, which i2c-imc doesn't
+	 * support, we don't have a driver for it, we can't really use
+	 * it without special hardware (it's not a normal i2c slave --
+	 * see the JEDEC docs), and using it risks bricking the DIMM
+	 * it's on anyway.
+	 *
+	 * NB: There's no need to save the return value from
+	 * i2c_new_device, as the core code will unregister it for us
+	 * when the adapter is removed.  If users want to bind a
+	 * different driver, nothing stops them from unbinding the
+	 * drivers we request here.
+	 */
+	for (slot = 0; slot < 8; slot++) {
+		/* If there's no SPD, then assume there's no DIMM here. */
+		if (!probe_addr(adapter, 0x50 | slot))
+			continue;
+
+		strcpy(info.type, "spd");
+		info.addr = 0x50 | slot;
+		i2c_new_device(adapter, &info);
+
+		if (probe_addr(adapter, 0x18 | slot)) {
+			/* This is a temperature sensor. */
+			strcpy(info.type, "jc42");
+			info.addr = 0x18 | slot;
+			i2c_new_device(adapter, &info);
+		}
+	}
+}
+EXPORT_SYMBOL(i2c_scan_dimm_bus);
+
+MODULE_AUTHOR("Andrew Lutomirski <luto@amacapital.net>");
+MODULE_DESCRIPTION("i2c DIMM bus support");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/i2c/busses/i2c-imc.c b/drivers/i2c/busses/i2c-imc.c
index ace93bb1adb2..57cc44879061 100644
--- a/drivers/i2c/busses/i2c-imc.c
+++ b/drivers/i2c/busses/i2c-imc.c
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/ratelimit.h>
 #include <linux/i2c.h>
+#include <linux/i2c/dimm-bus.h>
 
 /*
  * The datasheet can be found here, for example:
@@ -416,6 +417,8 @@ static int imc_init_channel(struct imc_priv *priv, int i, int socket)
 		return err;
 	}
 
+	i2c_scan_dimm_bus(&ch->adapter);
+
 	return 0;
 }
 
diff --git a/include/linux/i2c/dimm-bus.h b/include/linux/i2c/dimm-bus.h
new file mode 100644
index 000000000000..21559058e034
--- /dev/null
+++ b/include/linux/i2c/dimm-bus.h
@@ -0,0 +1,20 @@
+/*
+ * Copyright (c) 2013-2016 Andrew Lutomirski <luto@amacapital.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _I2C_DIMM_BUS
+#define _I2C_DIMM_BUS
+
+struct i2c_adapter;
+void i2c_scan_dimm_bus(struct i2c_adapter *adapter);
+
+#endif /* _I2C_DIMM_BUS */
-- 
2.5.5
