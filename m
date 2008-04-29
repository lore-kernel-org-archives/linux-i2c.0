From: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: Add Intel SCH I2C SMBus support (revised)
Date: Tue, 29 Apr 2008 11:06:28 +0800
Message-ID: <20080429110628.66d4892b@dxy.sh.intel.com>
References: <20080424100510.09cc2d4b@dxy.sh.intel.com>
	<48124673.8020808@assembler.cz>
	<20080428144514.53aa54fd@dxy.sh.intel.com>
	<20080428105738.06429ed2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080428105738.06429ed2-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean, Rudolf,

I modified and tested the SCH I2C driver according to your kind comments. Please help to review again:

This patch adds Intel SCH chipsets (US15W, US15L, UL11L) i2c bus support.

Signed-off-by: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/Kconfig    |    7 +
 drivers/i2c/busses/Makefile   |    1 +
 drivers/i2c/busses/i2c-isch.c |  362 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h       |    2 ++
 4 files changed, 372 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-isch.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 48438cc..39d86f7 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -247,6 +247,13 @@ config I2C_PIIX4
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-piix4.
 
+config I2C_SCH
+	tristate "Intel SCH SMBUS 1.0"
+	depends on I2C && PCI
+	help
+	  If you say Y or M to this option, support will be included for the
+	  Intel SCH based systems. Module will be called i2c-sch.ko.
+
 config I2C_IBM_IIC
 	tristate "IBM PPC 4xx on-chip I2C interface"
 	depends on 4xx
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index e8c882a..9a9ec31 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
 obj-$(CONFIG_I2C_PCA_PLATFORM)	+= i2c-pca-platform.o
 obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
 obj-$(CONFIG_I2C_PMCMSP)	+= i2c-pmcmsp.o
+obj-$(CONFIG_I2C_SCH)		+= i2c-isch.o
 obj-$(CONFIG_I2C_PNX)		+= i2c-pnx.o
 obj-$(CONFIG_I2C_PROSAVAGE)	+= i2c-prosavage.o
 obj-$(CONFIG_I2C_PXA)		+= i2c-pxa.o
diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
new file mode 100644
index 0000000..4535c85
--- /dev/null
+++ b/drivers/i2c/busses/i2c-isch.c
@@ -0,0 +1,362 @@
+/*
+    i2c-sch.c - Linux kernel driver for Intel SCH chipset SMBus
+    - Based on i2c-piix4.c
+    Copyright (c) 1998 - 2002 Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and
+    Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>
+    - Intel SCH support
+    Copyright (c) 2007 - 2008 Jacob Jun Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License version 2 as
+    published by the Free Software Foundation.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+/*
+   Supports:
+	Intel SCH
+   Note: we assume there can only be one device, with one SMBus interface.
+*/
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/stddef.h>
+#include <linux/ioport.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/io.h>
+
+
+struct sd {
+	const unsigned short mfr;
+	const unsigned short dev;
+	const unsigned char fn;
+	const char *name;
+};
+/* SCH SMBus address offsets */
+#define SMBHSTCNT	(0 + sch_smba)
+#define SMBHSTSTS	(1 + sch_smba)
+#define SMBHSTADD	(4 + sch_smba) /* TSA */
+#define SMBHSTCMD	(5 + sch_smba)
+#define SMBHSTDAT0	(6 + sch_smba)
+#define SMBHSTDAT1	(7 + sch_smba)
+#define SMBBLKDAT	(0x20 + sch_smba)
+
+/* count for request_region */
+#define SMBIOSIZE	64
+
+/* PCI Address Constants */
+#define SMBBA_SCH	0x040
+
+/* Other settings */
+#define MAX_TIMEOUT	500
+#define  ENABLE_INT9	0
+
+/* I2C constants */
+#define SCH_QUICK		0x00
+#define SCH_BYTE		0x01
+#define SCH_BYTE_DATA		0x02
+#define SCH_WORD_DATA		0x03
+#define SCH_BLOCK_DATA		0x05
+
+static int sch_transaction(void);
+static unsigned short sch_smba;
+static struct pci_driver sch_driver;
+static struct i2c_adapter sch_adapter;
+
+/*
+ * Start the i2c transaction -- the i2c_access will prepare the transaction
+ * and this function will execute it.
+ * return 0 for success and others for failure.
+ */
+static int sch_transaction(void)
+{
+	int temp;
+	int result = 0;
+	int timeout = 0;
+
+	dev_dbg(&sch_adapter.dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb(SMBHSTCNT),
+		inb(SMBHSTCMD), inb(SMBHSTADD), inb(SMBHSTDAT0),
+		inb(SMBHSTDAT1));
+
+	/* Make sure the SMBus host is ready to start transmitting */
+	temp = inb(SMBHSTSTS) & 0x0f;
+	if (temp & 0x08) {
+		dev_dbg(&sch_adapter.dev, "SMBus busy (%02x)\n", temp);
+		return -EPERM;
+	} else if (temp & 0x01) {
+		dev_dbg(&sch_adapter.dev, "Completion (%02x). "
+			"clear...\n", temp);
+		outb(temp, SMBHSTSTS);
+	} else if (temp & 0x06) {
+		dev_dbg(&sch_adapter.dev, "SMBus error (%02x). "
+			"Resetting...\n", temp);
+		outb(temp, SMBHSTSTS);
+	}
+	temp =  inb(SMBHSTSTS) & 0x0f;
+	if (temp) {
+		dev_err(&sch_adapter.dev,
+			"SMBus is not ready: (%02x)\n", temp);
+		return -EPERM;
+	} else {
+		dev_dbg(&sch_adapter.dev, "Successful!\n");
+	}
+
+	/* start the transaction by setting bit 4 */
+	outb(inb(SMBHSTCNT) | 0x10, SMBHSTCNT);
+
+	do {
+		msleep(1);
+		temp = inb(SMBHSTSTS) & 0x0f;
+	} while ((temp & 0x08) && (timeout++ < MAX_TIMEOUT));
+
+	/* If the SMBus is still busy, we give up */
+	if (timeout >= MAX_TIMEOUT) {
+		dev_err(&sch_adapter.dev, "SMBus Timeout!\n");
+		result = -EPERM;
+	}
+	if (temp & 0x04) {
+		result = -EPERM;
+		dev_dbg(&sch_adapter.dev, "Bus collision! SMBus may be "
+			"locked until next hard reset. (sorry!)\n");
+		/* Clock stops and slave is stuck in mid-transmission */
+	} else if (temp & 0x02) {
+		result = -EPERM;
+		dev_dbg(&sch_adapter.dev, "Error: no response!\n");
+	} else if (temp & 0x01) {
+		dev_dbg(&sch_adapter.dev, "Post complete!\n");
+		outb(temp, SMBHSTSTS);
+		temp = inb(SMBHSTSTS) & 0x07;
+		if (temp & 0x06) {
+			/* Completion clear failed*/
+			dev_dbg(&sch_adapter.dev, "Failed reset at end of "
+				"transaction (%02x), Bus error\n", temp);
+		}
+	} else {
+		result = -EPERM;
+		dev_dbg(&sch_adapter.dev, "Transaction failed.\n");
+	}
+	dev_dbg(&sch_adapter.dev, "Transaction (post): CNT=%02x, CMD=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb(SMBHSTCNT),
+		inb(SMBHSTCMD), inb(SMBHSTADD), inb(SMBHSTDAT0),
+		inb(SMBHSTDAT1));
+	return result;
+}
+
+/*
+ * This is the main access entry for i2c-sch access
+ * adap is i2c_adapter pointer, addr is the i2c device bus address, read_write
+ * (0 for read and 1 for write), size is i2c transaction type and data is the
+ * union of transaction for data to be transfered or data read from bus.
+ *
+ * return 0 for success and  others for failure.
+ */
+static s32 sch_access(struct i2c_adapter *adap, u16 addr,
+		 unsigned short flags, char read_write,
+		 u8 command, int size, union i2c_smbus_data *data)
+{
+	int i, len, temp;
+
+	/* Make sure the SMBus host is not busy*/
+	temp = inb(SMBHSTSTS) & 0x0f;
+	if (temp & 0x08) {
+		dev_dbg(&sch_adapter.dev, "SMBus busy (%02x)\n", temp);
+		return -EPERM;
+	}
+	dev_dbg(&sch_adapter.dev, "access size: %d %s\n", size,
+		(read_write)?"READ":"WRITE");
+	switch (size) {
+	case I2C_SMBUS_QUICK:
+		outb(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		size = SCH_QUICK;
+		break;
+	case I2C_SMBUS_BYTE:
+		outb(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		if (read_write == I2C_SMBUS_WRITE)
+			outb(command, SMBHSTCMD);
+		size = SCH_BYTE;
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		outb(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		outb(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE)
+			outb(data->byte, SMBHSTDAT0);
+		size = SCH_BYTE_DATA;
+		break;
+	case I2C_SMBUS_WORD_DATA:
+		outb(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		outb(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE) {
+			outb(data->word & 0xff, SMBHSTDAT0);
+			outb((data->word & 0xff00) >> 8, SMBHSTDAT1);
+		}
+		size = SCH_WORD_DATA;
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+		outb(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		outb(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE) {
+			len = data->block[0];
+			if (len < 0)
+				len = 0;
+			if (len > 32)
+				len = 32;
+			outb(len, SMBHSTDAT0);
+			i = inb(SMBHSTCNT);	/* Reset SMBBLKDAT */
+			for (i = 1; i <= len; i++)
+				outb(data->block[i], SMBBLKDAT+i-1);
+		}
+		size = SCH_BLOCK_DATA;
+		break;
+	default:
+		dev_err(&adap->dev, "I2C transaction not supported!\n");
+		return -EPERM;
+	}
+	dev_dbg(&sch_adapter.dev, "write size %d to 0x%04x\n", size, SMBHSTCNT);
+	outb((size & 0x7), SMBHSTCNT);
+
+	if (sch_transaction())	/* Error in transaction */
+		return -EPERM;
+
+	if ((read_write == I2C_SMBUS_WRITE) || (size == SCH_QUICK))
+		return 0;
+
+	switch (size) {
+	case SCH_BYTE:
+		/* Where is the result put? I assume here it is in
+		   SMBHSTDAT0 but it might just as well be in the
+		   SMBHSTCMD. No clue in the docs */
+		data->byte = inb(SMBHSTDAT0);
+		break;
+	case SCH_BYTE_DATA:
+		data->byte = inb(SMBHSTDAT0);
+		break;
+	case SCH_WORD_DATA:
+		data->word = inb(SMBHSTDAT0) + (inb(SMBHSTDAT1) << 8);
+		break;
+	case SCH_BLOCK_DATA:
+		data->block[0] = inb(SMBHSTDAT0);
+		i = inb(SMBHSTCNT);	/* Reset SMBBLKDAT */
+		if (data->block[0] > I2C_SMBUS_BLOCK_MAX)
+			data->block[0] = I2C_SMBUS_BLOCK_MAX;
+		for (i = 1; i <= data->block[0]; i++)
+			data->block[i] = inb(SMBBLKDAT+i-1);
+		break;
+	}
+	return 0;
+}
+
+static u32 sch_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	    I2C_FUNC_SMBUS_BLOCK_DATA;
+}
+
+static const struct i2c_algorithm smbus_algorithm = {
+	.smbus_xfer	= sch_access,
+	.functionality	= sch_func,
+};
+
+static struct i2c_adapter sch_adapter = {
+	.owner		= THIS_MODULE,
+	.class		= I2C_CLASS_HWMON,
+	.algo		= &smbus_algorithm,
+};
+
+static struct pci_device_id sch_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SCH_LPC),
+	  .driver_data = 0x40 },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, sch_ids);
+
+static int __devinit sch_probe(struct pci_dev *dev,
+				const struct pci_device_id *id)
+{
+	int retval;
+
+	/* driver_data might come from user-space, so check it */
+	if (id->driver_data & 1 || id->driver_data > 0xff)
+		return -EINVAL;
+
+	pci_read_config_word(dev, SMBBA_SCH, &sch_smba);
+	sch_smba &= 0xfff0;
+	if (sch_smba == 0) {
+		dev_err(&dev->dev, "SMB base address uninitialized\n");
+		return -ENODEV;
+	}
+	if (!request_region(sch_smba, SMBIOSIZE, sch_driver.name)) {
+		dev_err(&dev->dev, "SMB region 0x%x already in use!\n",
+			sch_smba);
+		return -ENODEV;
+	}
+	dev_dbg(&dev->dev, "SMBA = 0x%X\n", sch_smba);
+
+	/* set up the driverfs linkage to our parent device */
+	sch_adapter.dev.parent = &dev->dev;
+
+	snprintf(sch_adapter.name, I2C_NAME_SIZE,
+		"SMBus SCH adapter at %04x", sch_smba);
+
+	retval = i2c_add_adapter(&sch_adapter);
+	if (retval) {
+		dev_err(&dev->dev, "Couldn't register adapter!\n");
+		release_region(sch_smba, SMBIOSIZE);
+		sch_smba = 0;
+	}
+
+	return retval;
+}
+
+static void __devexit sch_remove(struct pci_dev *dev)
+{
+	if (sch_smba) {
+		i2c_del_adapter(&sch_adapter);
+		release_region(sch_smba, SMBIOSIZE);
+		sch_smba = 0;
+	}
+}
+
+static struct pci_driver sch_driver = {
+	.name		= "sch_smbus",
+	.id_table	= sch_ids,
+	.probe		= sch_probe,
+	.remove		= __devexit_p(sch_remove),
+	.dynids.use_driver_data = 1,
+};
+
+static int __init i2c_sch_init(void)
+{
+	return pci_register_driver(&sch_driver);
+}
+
+static void __exit i2c_sch_exit(void)
+{
+	pci_unregister_driver(&sch_driver);
+}
+
+MODULE_AUTHOR("Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("Intel SCH SMBus driver");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_sch_init);
+module_exit(i2c_sch_exit);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 70eb3c8..e5a53da 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2413,6 +2413,8 @@
 #define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
 #define PCI_DEVICE_ID_INTEL_82443GX_2	0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
+#define PCI_DEVICE_ID_INTEL_SCH_LPC	0x8119
+#define PCI_DEVICE_ID_INTEL_SCH_IDE	0x811a
 #define PCI_DEVICE_ID_INTEL_82454GX	0x84c4
 #define PCI_DEVICE_ID_INTEL_82450GX	0x84c5
 #define PCI_DEVICE_ID_INTEL_82451NX	0x84ca
-- 
1.5.2.5


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
