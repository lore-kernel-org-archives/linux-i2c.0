From: =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: support for SiS964 south bridge
Date: Tue, 16 Aug 2011 22:59:24 +0200
Message-ID: <1313528364-13611-1-git-send-email-amaury.decreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Alexander Malysh <amalysh-S0/GAf8tV78@public.gmane.org>, "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This driver implement a support for the SiS964 chipset.
It's a fork of i2c-sis630 modified with the help of datasheets.

Signed-off-by: Amaury Decr=C3=AAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/i2c/busses/i2c-sis964 |   33 +++
 drivers/i2c/busses/Kconfig          |   12 +-
 drivers/i2c/busses/Makefile         |    1 +
 drivers/i2c/busses/i2c-sis964.c     |  544 +++++++++++++++++++++++++++=
++++++++
 include/linux/pci_ids.h             |    1 +
 5 files changed, 590 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/i2c/busses/i2c-sis964
 create mode 100644 drivers/i2c/busses/i2c-sis964.c

diff --git a/Documentation/i2c/busses/i2c-sis964 b/Documentation/i2c/bu=
sses/i2c-sis964
new file mode 100644
index 0000000..79ed17e
--- /dev/null
+++ b/Documentation/i2c/busses/i2c-sis964
@@ -0,0 +1,33 @@
+Kernel driver i2c-sis964
+
+Supported adapters:
+  * Silicon Integrated Systems Corp (SiS)
+	964 chipset (Datasheet given under NDA by SiS)
+  * Possible other SiS chipsets with the same registers and clocks
+
+Author:	Amaury Decr=C3=AAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+
+Module Parameters
+-----------------
+
+* force =3D [1|0] Forcibly enable the SIS964. DANGEROUS!
+		This can be interesting for chipsets not named
+		above to check if it works for you chipset, but DANGEROUS!
+
+* low_clock =3D [1|0] 	Set Host Master Clock to 28KHz
+
+Description
+-----------
+
+This SMBus driver is known to work on motherboards with the SiS964 chi=
pset.
+
+If you see something like this:
+
+00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS964 [MuTIOL Me=
dia IO] (rev 36)
+
+in your 'lspci' output , then this driver is for your chipset.
+
+Thank You
+---------
+Alexander Malysh <amalysh-S0/GAf8tV78@public.gmane.org>
+- Most of the code in this driver is a fork of i2c-sis630 which has be=
en written by him
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 646068e..109de39 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -189,8 +189,18 @@ config I2C_SIS630
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-sis630.
=20
+config I2C_SIS964
+	tristate "SiS 964"
+	depends on PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for the SiS
+	  964 SMBus (a subset of I2C) interfaces.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-sis964.
+
 config I2C_SIS96X
-	tristate "SiS 96x"
+	tristate "SiS 96x (but SiS964)"
 	depends on PCI
 	help
 	  If you say yes to this option, support will be included for the SiS
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index e6cf294..f8e230e 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_I2C_NFORCE2_S4985)	+=3D i2c-nforce2-s498=
5.o
 obj-$(CONFIG_I2C_PIIX4)		+=3D i2c-piix4.o
 obj-$(CONFIG_I2C_SIS5595)	+=3D i2c-sis5595.o
 obj-$(CONFIG_I2C_SIS630)	+=3D i2c-sis630.o
+obj-$(CONFIG_I2C_SIS964)	+=3D i2c-sis964.o
 obj-$(CONFIG_I2C_SIS96X)	+=3D i2c-sis96x.o
 obj-$(CONFIG_I2C_VIA)		+=3D i2c-via.o
 obj-$(CONFIG_I2C_VIAPRO)	+=3D i2c-viapro.o
diff --git a/drivers/i2c/busses/i2c-sis964.c b/drivers/i2c/busses/i2c-s=
is964.c
new file mode 100644
index 0000000..f22352e
--- /dev/null
+++ b/drivers/i2c/busses/i2c-sis964.c
@@ -0,0 +1,544 @@
+/*
+    Copyright (c) 2011 Amaury Decr=C3=AAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+
+    This program is free software; you can redistribute it and/or modi=
fy
+    it under the terms of the GNU General Public License as published =
by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
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
+   Changes:
+   11.08.2011
+	Fork of original i2c-sis630 - Alexander Malysh <amalysh-S0/GAf8tV78@public.gmane.org>
+	Patched for SiS964 with datasheets
+			- Amaury Decr=C3=AAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+*/
+
+/*
+   Supports:
+	SIS 964
+
+   Note: we assume there can only be one device, with one SMBus interf=
ace.
+*/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/acpi.h>
+#include <linux/io.h>
+
+/* SIS964 SMBus registers */
+#define SMB_STS			0xE0	/* status */
+#define SMB_EN			0xE1	/* status enable */
+#define SMB_CNT			0xE2	/* Control */
+#define SMBHOST_CNT		0xE3	/* Host Control */
+#define SMB_ADDR		0xE4	/* Address */
+#define SMB_CMD			0xE5	/* Command */
+#define SMB_PERRCHK		0xE6	/* Packet Error Check */
+#define SMB_COUNT		0xE7	/* Byte Count */
+#define SMB_BYTE		0xE8	/* ~0x8F data byte field */
+#define SMBDEV_ADDR		0xF0	/* Device Address */
+#define SMB_DB0			0xF1	/* Device byte0 */
+#define SMB_DB1			0xF2	/* Device byte1 */
+#define SMB_SAA			0xF3	/* Host slave alias address */
+#define SMB_PCOUNT		0xF4	/* processed byte count */
+
+/* register count for request_region */
+#define SIS964_SMB_IOREGION	21
+
+/* PCI address constants */
+/* acpi base address register  */
+#define SIS964_ACPI_BASE_REG	0x74
+/* bios control register */
+#define SIS964_BIOS_CTL_REG	0x40
+
+/* Other settings */
+#define MAX_TIMEOUT		500
+
+/* SIS964 constants */
+#define SIS964_QUICK		0x00
+#define SIS964_BYTE		0x01
+#define SIS964_BYTE_DATA	0x02
+#define SIS964_WORD_DATA	0x03
+#define SIS964_PCALL		0x04
+#define SIS964_BLOCK_DATA	0x05
+
+static struct pci_driver sis964_driver;
+
+/* insmod parameters */
+static int low_clock;
+static int force;
+module_param(low_clock, bool, 0);
+MODULE_PARM_DESC(low_clock, "Set Host Master Clock to 28KHz (default 5=
6KHz).");
+module_param(force, bool, 0);
+MODULE_PARM_DESC(force, "Forcibly enable the SIS964. DANGEROUS!");
+
+/* acpi base address */
+static unsigned short acpi_base;
+
+/* supported chips */
+static int supported[] =3D {
+	PCI_DEVICE_ID_SI_964,
+	0 /* terminates the list */
+};
+
+static inline u8 sis964_read(u8 reg)
+{
+	return inb(acpi_base + reg);
+}
+
+static inline void sis964_write(u8 reg, u8 data)
+{
+	outb(data, acpi_base + reg);
+}
+
+static int sis964_transaction_start(struct i2c_adapter *adap,
+					int ptl, u8 *oldclock)
+{
+	int temp;
+
+	/* Clear status register */
+	sis964_write(SMB_STS, 0xFF);
+
+	/* Make sure the SMBus host is ready to start transmitting. */
+	temp =3D sis964_read(SMB_CNT);
+	if ((temp & 0x03) !=3D 0x00) {
+		dev_dbg(&adap->dev, "SMBus not ready "
+		"to start transmitting (%02x).Resetting...\n", temp);
+		/* kill smbus transaction */
+		sis964_write(SMBHOST_CNT, 0x20);
+
+		temp =3D sis964_read(SMB_CNT);
+		if ((temp & 0x03) !=3D 0x00) {
+			dev_dbg(&adap->dev, "Failed! (%02x)\n", temp);
+			return -EBUSY;
+		}
+	}
+
+	/* save old clock, so we can prevent machine for hung */
+	*oldclock =3D sis964_read(SMB_CNT);
+
+	dev_dbg(&adap->dev, "saved clock 0x%02x\n", *oldclock);
+
+	/* disable timeout interrupt,
+	 * set Host Master Clock to 28KHz if requested */
+	if (low_clock)
+		sis964_write(SMB_CNT, 0x20);
+	else
+		sis964_write(SMB_CNT, (*oldclock & 0x20));
+
+	/* start the transaction by setting bit start and protocol */
+	sis964_write(SMBHOST_CNT, 0x10 | (ptl & 0x07));
+	udelay(30);
+
+	return 0;
+}
+
+static int sis964_transaction_wait(struct i2c_adapter *adap, int ptl)
+{
+	int temp, result =3D 0, timeout =3D 0;
+
+	/* We will always wait for a fraction of a second! */
+	do {
+		udelay(1000);
+		temp =3D sis964_read(SMB_STS);
+		/* check if block transmitted */
+		if (ptl =3D=3D SIS964_BLOCK_DATA && (temp & 0x10))
+			break;
+	} while (!(temp & 0x0e) && (timeout++ < MAX_TIMEOUT));
+
+	/* If the SMBus is still busy, we give up */
+	if (timeout > MAX_TIMEOUT) {
+		dev_dbg(&adap->dev, "SMBus Timeout (%02x)!\n", temp);
+		result =3D -ETIMEDOUT;
+	}
+
+	/* SMBERR_STS */
+	if (temp & 0x02) {
+		dev_dbg(&adap->dev, "Error: Failed bus transaction\n");
+		result =3D -ENXIO;
+	}
+
+	/* SMBCOL_STS */
+	if (temp & 0x04) {
+		dev_err(&adap->dev, "Bus collision!\n");
+		sis964_write(SMB_STS, temp & ~0x04);
+		result =3D -EIO;
+	}
+
+	return result;
+}
+
+static void sis964_transaction_end(struct i2c_adapter *adap, u8 oldclo=
ck)
+{
+	/* clear all status "sticky" bits */
+	sis964_write(SMB_STS, 0xFF);
+
+	dev_dbg(&adap->dev, "SMB_CNT before clock restore 0x%02x\n",
+		sis964_read(SMB_CNT));
+
+	/*
+	 * restore old Host Master Clock if low_clock is set
+	 */
+	if (low_clock)
+		sis964_write(SMB_CNT, oldclock & 0x20);
+
+	dev_dbg(&adap->dev, "SMB_CNT after clock restore 0x%02x\n",
+		sis964_read(SMB_CNT));
+}
+
+static int sis964_transaction(struct i2c_adapter *adap, int ptl)
+{
+	int result =3D 0, timeout =3D 0;
+	u8 oldclock =3D 0;
+
+	do {
+		result =3D sis964_transaction_start(adap, ptl, &oldclock);
+		if (result)
+			break;
+
+		result =3D sis964_transaction_wait(adap, ptl);
+		sis964_transaction_end(adap, oldclock);
+	} while (result =3D=3D -EIO && timeout++ < MAX_TIMEOUT);
+
+	if (timeout > MAX_TIMEOUT) {
+		dev_dbg(&adap->dev, "SMBus Collision Timeout !\n");
+		result =3D -ETIMEDOUT;
+	}
+
+	return result;
+}
+
+static int sis964_block_data(struct i2c_adapter *adap,
+				union i2c_smbus_data *data, int read_write)
+{
+	int i, len =3D 0, rc =3D 0;
+	u8 oldclock =3D 0;
+
+	if (read_write =3D=3D I2C_SMBUS_WRITE) {
+		len =3D data->block[0];
+		if (len < 0)
+			len =3D 0;
+		else if (len > 32)
+			len =3D 32;
+		sis964_write(SMB_COUNT, len);
+		for (i =3D 1; i <=3D len; i++) {
+			dev_dbg(&adap->dev, "set data 0x%02x\n",
+				data->block[i]);
+
+			/* set data */
+			sis964_write(SMB_BYTE+(i-1)%8, data->block[i]);
+			if (i =3D=3D 8 || (len < 8 && i =3D=3D len)) {
+				dev_dbg(&adap->dev,
+					"start trans len=3D%d i=3D%d\n", len, i);
+
+				/* first transaction */
+				rc =3D sis964_transaction_start(adap,
+						SIS964_BLOCK_DATA, &oldclock);
+				if (rc)
+					return rc;
+			} else if ((i-1)%8 =3D=3D 7 || i =3D=3D len) {
+				dev_dbg(&adap->dev,
+					"trans_wait len=3D%d i=3D%d\n", len, i);
+				if (i > 8) {
+					dev_dbg(&adap->dev,
+					"clear smbary_sts len=3D%d i=3D%d\n",
+					len, i);
+					/*
+					   If this is not first transaction,
+					   we must clear sticky bit.
+					   clear SMBARY_STS
+					*/
+					sis964_write(SMB_STS, 0x10);
+				}
+				rc =3D sis964_transaction_wait(adap,
+						SIS964_BLOCK_DATA);
+				if (rc) {
+					dev_dbg(&adap->dev, "trans_wait failed\n");
+					break;
+				}
+			}
+		}
+	} else {
+		/* read request */
+		data->block[0] =3D len =3D 0;
+		rc =3D sis964_transaction_start(adap,
+				SIS964_BLOCK_DATA, &oldclock);
+		if (rc)
+			return rc;
+		do {
+			rc =3D sis964_transaction_wait(adap, SIS964_BLOCK_DATA);
+			if (rc) {
+				dev_dbg(&adap->dev, "trans_wait failed\n");
+				break;
+			}
+			/* if this first transaction then read byte count */
+			if (len =3D=3D 0)
+				data->block[0] =3D sis964_read(SMB_COUNT);
+
+			/* just to be sure */
+			if (data->block[0] > 32)
+				data->block[0] =3D 32;
+
+			dev_dbg(&adap->dev, "block data read len=3D0x%x\n",
+				data->block[0]);
+
+			for (i =3D 0; i < 8 && len < data->block[0]; i++, len++) {
+				dev_dbg(&adap->dev, "read i=3D%d len=3D%d\n", i,
+					len);
+				data->block[len+1] =3D sis964_read(SMB_BYTE+i);
+			}
+
+			dev_dbg(&adap->dev, "clear smbary_sts len=3D%d i=3D%d\n",
+				len, i);
+
+			/* clear SMBARY_STS */
+			sis964_write(SMB_STS, 0x10);
+		} while (len < data->block[0]);
+	}
+
+	sis964_transaction_end(adap, oldclock);
+
+	return rc;
+}
+
+/* Return negative errno on error. */
+static s32 sis964_access(struct i2c_adapter *adap, u16 addr,
+			 unsigned short flags, char read_write,
+			 u8 command, int ptl, union i2c_smbus_data *data)
+{
+	int status;
+
+	switch (ptl) {
+	case I2C_SMBUS_QUICK:
+		sis964_write(SMB_ADDR, ((addr & 0x7f) << 1) |
+					(read_write & 0x01));
+		ptl =3D SIS964_QUICK;
+		break;
+	case I2C_SMBUS_BYTE:
+		sis964_write(SMB_ADDR, ((addr & 0x7f) << 1) |
+					(read_write & 0x01));
+		if (read_write =3D=3D I2C_SMBUS_WRITE)
+			sis964_write(SMB_CMD, command);
+		ptl =3D SIS964_BYTE;
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		sis964_write(SMB_ADDR, ((addr & 0x7f) << 1) |
+					(read_write & 0x01));
+		sis964_write(SMB_CMD, command);
+		if (read_write =3D=3D I2C_SMBUS_WRITE)
+			sis964_write(SMB_BYTE, data->byte);
+		ptl =3D SIS964_BYTE_DATA;
+		break;
+	case I2C_SMBUS_PROC_CALL:
+	case I2C_SMBUS_WORD_DATA:
+		sis964_write(SMB_ADDR, ((addr & 0x7f) << 1) |
+					(read_write & 0x01));
+		sis964_write(SMB_CMD, command);
+		if (read_write =3D=3D I2C_SMBUS_WRITE) {
+			sis964_write(SMB_BYTE, data->word & 0xff);
+			sis964_write(SMB_BYTE + 1,
+					(data->word & 0xff00) >> 8);
+		}
+		ptl =3D (ptl =3D=3D I2C_SMBUS_PROC_CALL ?
+				SIS964_PCALL : SIS964_WORD_DATA);
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+		sis964_write(SMB_ADDR, ((addr & 0x7f) << 1) |
+					(read_write & 0x01));
+		sis964_write(SMB_CMD, command);
+		ptl =3D SIS964_BLOCK_DATA;
+		return sis964_block_data(adap, data, read_write);
+	default:
+		dev_warn(&adap->dev, "Unsupported transaction %d\n",
+			 ptl);
+		return -EOPNOTSUPP;
+	}
+
+	status =3D sis964_transaction(adap, ptl);
+	if (status)
+		return status;
+
+	if ((ptl !=3D SIS964_PCALL) &&
+		((read_write =3D=3D I2C_SMBUS_WRITE) || (ptl =3D=3D SIS964_QUICK))) =
{
+		return 0;
+	}
+
+	switch (ptl) {
+	case SIS964_BYTE:
+	case SIS964_BYTE_DATA:
+		data->byte =3D sis964_read(SMB_BYTE);
+		break;
+	case SIS964_PCALL:
+	case SIS964_WORD_DATA:
+		data->word =3D sis964_read(SMB_BYTE) +
+				(sis964_read(SMB_BYTE + 1) << 8);
+		break;
+	}
+
+	return 0;
+}
+
+static u32 sis964_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK |
+		I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA |
+		I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_PROC_CALL |
+		I2C_FUNC_SMBUS_BLOCK_DATA;
+}
+
+static int __devinit sis964_setup(struct pci_dev *sis964_dev)
+{
+	unsigned char b;
+	struct pci_dev *dummy =3D NULL;
+	int retval =3D -ENODEV, i;
+
+	/* check for supported SiS devices */
+	for (i =3D 0; supported[i] > 0 && dummy =3D=3D NULL; i++)
+		dummy =3D pci_get_device(PCI_VENDOR_ID_SI, supported[i], dummy);
+
+	if (dummy) {
+		pci_dev_put(dummy);
+	} else if (force) {
+		dev_err(&sis964_dev->dev,
+			"WARNING: Can't detect SIS964 compatible device, but "
+			"loading because of force option enabled\n");
+	} else {
+		return -ENODEV;
+	}
+
+
+	/*
+	   Enable ACPI first , so we can accsess reg 74-75
+	   in acpi io space and read acpi base addr
+	*/
+	if (pci_read_config_byte(sis964_dev, SIS964_BIOS_CTL_REG, &b)) {
+		dev_err(&sis964_dev->dev, "Error: Can't read bios ctl reg\n");
+		goto exit;
+	}
+	/* if ACPI already enabled , do nothing */
+	if (!(b & 0x80) &&
+	    pci_write_config_byte(sis964_dev, SIS964_BIOS_CTL_REG, b | 0x80))=
 {
+		dev_err(&sis964_dev->dev, "Error: Can't enable ACPI\n");
+		goto exit;
+	}
+
+	/* Determine the ACPI base address */
+	if (pci_read_config_word(sis964_dev, SIS964_ACPI_BASE_REG,
+				&acpi_base)) {
+		dev_err(&sis964_dev->dev, "Error: Can't determine ACPI base address\=
n");
+		goto exit;
+	}
+
+	dev_dbg(&sis964_dev->dev, "ACPI base at 0x%04x\n", acpi_base);
+
+	retval =3D acpi_check_region(acpi_base + SMB_STS, SIS964_SMB_IOREGION=
,
+				   sis964_driver.name);
+	if (retval)
+		goto exit;
+
+	/* Everything is happy, let's grab the memory and set things up. */
+	if (!request_region(acpi_base + SMB_STS, SIS964_SMB_IOREGION,
+			    sis964_driver.name)) {
+		dev_err(&sis964_dev->dev, "SMBus registers 0x%04x-0x%04x already "
+			"in use!\n", acpi_base + SMB_STS, acpi_base + SMB_SAA);
+		goto exit;
+	}
+
+	retval =3D 0;
+
+exit:
+	if (retval)
+		acpi_base =3D 0;
+	return retval;
+}
+
+
+static const struct i2c_algorithm smbus_algorithm =3D {
+	.smbus_xfer	=3D sis964_access,
+	.functionality	=3D sis964_func,
+};
+
+static struct i2c_adapter sis964_adapter =3D {
+	.owner		=3D THIS_MODULE,
+	.class		=3D I2C_CLASS_HWMON | I2C_CLASS_SPD,
+	.algo		=3D &smbus_algorithm,
+};
+
+static const struct pci_device_id sis964_ids[] __devinitconst =3D {
+	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_964) },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, sis964_ids);
+
+static int __devinit sis964_probe(struct pci_dev *dev,
+					const struct pci_device_id *id)
+{
+	if (sis964_setup(dev)) {
+		dev_err(&dev->dev, "SIS964 comp. bus not detected, module not insert=
ed.\n");
+		return -ENODEV;
+	}
+
+	/* set up the sysfs linkage to our parent device */
+	sis964_adapter.dev.parent =3D &dev->dev;
+
+	snprintf(sis964_adapter.name, sizeof(sis964_adapter.name),
+		 "SMBus SIS964 adapter at %04x", acpi_base + SMB_STS);
+
+	return i2c_add_adapter(&sis964_adapter);
+}
+
+static void __devexit sis964_remove(struct pci_dev *dev)
+{
+	dev_dbg(&dev->dev, "sis964_remove");
+
+	if (acpi_base) {
+		i2c_del_adapter(&sis964_adapter);
+		release_region(acpi_base + SMB_STS, SIS964_SMB_IOREGION);
+		acpi_base =3D 0;
+	}
+}
+
+
+static struct pci_driver sis964_driver =3D {
+	.name		=3D "sis964_smbus",
+	.id_table	=3D sis964_ids,
+	.probe		=3D sis964_probe,
+	.remove		=3D __devexit_p(sis964_remove),
+};
+
+static int __init i2c_sis964_init(void)
+{
+	return pci_register_driver(&sis964_driver);
+}
+
+
+static void __exit i2c_sis964_exit(void)
+{
+	pci_unregister_driver(&sis964_driver);
+}
+
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Amaury Decr=C3=AAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("SiS964 SMBus driver");
+
+module_init(i2c_sis964_init);
+module_exit(i2c_sis964_exit);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ae96bbe..668f7ff 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -695,6 +695,7 @@
 #define PCI_DEVICE_ID_SI_961		0x0961
 #define PCI_DEVICE_ID_SI_962		0x0962
 #define PCI_DEVICE_ID_SI_963		0x0963
+#define PCI_DEVICE_ID_SI_964		0x0964
 #define PCI_DEVICE_ID_SI_965		0x0965
 #define PCI_DEVICE_ID_SI_966		0x0966
 #define PCI_DEVICE_ID_SI_968		0x0968
--=20
1.7.3.4
