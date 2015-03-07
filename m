From: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 2/2] i2c, i2c_imc: Add DIMM bus code
Date: Fri,  6 Mar 2015 18:50:54 -0800
Message-ID: <4ec9e7471354b350936ffa75e94125b169d14690.1425695891.git.luto@amacapital.net>
References: <cover.1425695891.git.luto@amacapital.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1425695891.git.luto@amacapital.net>
In-Reply-To: <cover.1425695891.git.luto@amacapital.net>
References: <cover.1425695891.git.luto@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>, Rui Wang <ruiv.wang@gmail.com>, Tony Luck <tony.luck@intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Alun Evans <alun@badgerous.net>, Robert Elliott <Elliott@hp.com>, Boaz Harrosh <boaz@plexistor.com>, Andy Lutomirski <luto@amacapital.net>
List-Id: linux-i2c@vger.kernel.org

Add i2c_scan_dimm_bus to declare that a particular i2c_adapter
contains DIMMs.  This will probe (and autoload modules!) for useful
SMBUS devices that live on DIMMs.  i2c_imc calls it.

As more SMBUS-addressable DIMM components become supported, this
code can be extended to probe for them.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 drivers/i2c/busses/Kconfig    |  4 ++
 drivers/i2c/busses/Makefile   |  4 ++
 drivers/i2c/busses/dimm-bus.c | 97 +++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-imc.c  |  3 ++
 include/linux/i2c/dimm-bus.h  | 24 +++++++++++
 5 files changed, 132 insertions(+)
 create mode 100644 drivers/i2c/busses/dimm-bus.c
 create mode 100644 include/linux/i2c/dimm-bus.h

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d6b9ce164fbf..2ea6648492eb 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -149,6 +149,10 @@ config I2C_ISMT
 	  This driver can also be built as a module.  If so, the module will be
 	  called i2c-ismt.
 
+config I2C_DIMM_BUS
+       tristate
+       default n
+
 config I2C_IMC
 	tristate "Intel iMC (LGA 2011) SMBus Controller"
 	depends on PCI && X86
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 4287c891e782..a01bdcc0e239 100644
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
index 000000000000..096842811199
--- /dev/null
+++ b/drivers/i2c/busses/dimm-bus.c
@@ -0,0 +1,97 @@
+/*
+ * Copyright (c) 2013 Andrew Lutomirski <luto@amacapital.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
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
+ * Callers are advised not to set adapter->class = I2C_CLASS_SPD.
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
+					  I2C_FUNC_SMBUS_READ_BYTE_DATA)))
+		return;
+
+	/*
+	 * Addresses on DIMMs use the three low bits to identify the slot
+	 * and the four high bits to identify the device type.  Known
+	 * devices are:
+	 *
+	 *  - 0x50 - 0x57: SPD (Serial Presence Detect) EEPROM
+	 *  - 0x30 - 0x37: SPD WP control -- not worth trying to probe
+	 *  - 0x18 - 0x1f: TSOD (Temperature Sensor on DIMM)
+	 *
+	 * There may be more some day.
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
+MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/busses/i2c-imc.c b/drivers/i2c/busses/i2c-imc.c
index 2dbf171114c6..f9d535a99035 100644
--- a/drivers/i2c/busses/i2c-imc.c
+++ b/drivers/i2c/busses/i2c-imc.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/i2c.h>
+#include <linux/i2c/dimm-bus.h>
 
 /*
  * The datasheet can be found here, for example:
@@ -425,6 +426,8 @@ static int imc_init_channel(struct imc_priv *priv, int i, int socket)
 		return err;
 	}
 
+	i2c_scan_dimm_bus(&ch->adapter);
+
 	return 0;
 }
 
diff --git a/include/linux/i2c/dimm-bus.h b/include/linux/i2c/dimm-bus.h
new file mode 100644
index 000000000000..3d44df43cf30
--- /dev/null
+++ b/include/linux/i2c/dimm-bus.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) 2013 Andrew Lutomirski <luto@amacapital.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
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
+#ifndef _I2C_DIMM_BUS
+#define _I2C_DIMM_BUS
+
+struct i2c_adapter;
+void i2c_scan_dimm_bus(struct i2c_adapter *adapter);
+
+#endif /* _I2C_DIMM_BUS */
-- 
2.1.0
