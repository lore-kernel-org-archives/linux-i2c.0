From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Thu, 15 May 2008 22:36:39 +0200
Message-ID: <1210883799-25188-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add a new-style driver for most I2C EEPROMs, giving sysfs read/write
access to their data. Tested with various chips and clock rates.

Updates since last version:

 - revisited includes
 - made write-timeout a module parameter
 - array of clients is allocated dynamically
 - removed unnecessary indentation within code
 - formatted comments
 - replaced at24_ee_address with a simpler function
 - at24_ee_write now really waits till timeout
 - added simple checks of provided eeprom chip data in at24_probe
 - added comment in at24.h about double-checking custom data
 - minor fixes

Updates in this version:

 - move chip data out of the driver into a seperate .h-file
 - prefix defined constants with AT24_
 - make bin file readonly if requested by flags
 - introduce AT24_MAX_CLIENTS
 - bugfix: check correct retval in at24_ee_write

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---

As we now support device_ids, probably most of the chip data will come back
into the driver. This is yet to be done. Tested on two platforms by me and
another one by David. Builds also on x86.

 drivers/i2c/chips/Kconfig  |   26 ++
 drivers/i2c/chips/Makefile |    1 +
 drivers/i2c/chips/at24.c   |  571 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/at24.h   |  102 ++++++++
 4 files changed, 700 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/chips/at24.c
 create mode 100644 include/linux/i2c/at24.h

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index 2da2edf..ad776e3 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -14,6 +14,32 @@ config DS1682
 	  This driver can also be built as a module.  If so, the module
 	  will be called ds1682.
 
+config I2C_AT24
+	tristate "EEPROMs from most vendors"
+	depends on I2C && SYSFS && EXPERIMENTAL
+	help
+	  Enable this driver to get read/write support to most I2C EEPROMs,
+	  after you configure the driver to know about each eeprom on on
+	  your target board.  Use these generic chip names, instead of
+	  vendor-specific ones like at24c64 or 24lc02:
+
+	     24c00, 24c01, 24c02, spd (readonly 24c02), 24c04, 24c08,
+	     24c16, 24c32, 24c64, 24c128, 24c256, 24c512, 24c1024
+
+	  Unless you like data loss puzzles, always be sure that any chip
+	  you configure as a 24c32 (32 Kbits) or larger is NOT really a
+	  24c16 (16 Kbits) or smaller, and vice versa.  (Marking the chip
+	  as readonly won't help recover from this.)  Also, if your chip
+	  has any software write-protect mechanism you may want to make
+	  sure this driver won't turn it on by accident.
+
+	  If you use this with an SMBus adapter instead of an I2C adapter,
+	  full functionality is not availble.  Only smaller devices are
+	  supported (24c16 and below, max 4 KBytes).
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called at24.
+
 config SENSORS_EEPROM
 	tristate "EEPROM reader"
 	depends on EXPERIMENTAL
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index e47aca0..aa1a88c 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -10,6 +10,7 @@
 #
 
 obj-$(CONFIG_DS1682)		+= ds1682.o
+obj-$(CONFIG_I2C_AT24)		+= at24.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
 obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
 obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
diff --git a/drivers/i2c/chips/at24.c b/drivers/i2c/chips/at24.c
new file mode 100644
index 0000000..35c091c
--- /dev/null
+++ b/drivers/i2c/chips/at24.c
@@ -0,0 +1,571 @@
+/*
+ * at24.c - handle most I2C EEPROMs
+ *
+ * Copyright (C) 2005-2007 David Brownell
+ * Copyright (C) 2008 Wolfram Sang, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/log2.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/i2c/at24.h>
+
+/*
+ * I2C EEPROMs from most vendors are inexpensive and mostly interchangeable.
+ * Differences between different vendor product lines (like Atmel AT24C or
+ * MicroChip 24LC, etc) won't much matter for typical read/write access.
+ * There are also I2C RAM chips, likewise interchangeable.  One example
+ * would be the PCF8570, which acts like a 24c02 EEPROM (256 bytes).
+ *
+ * However, misconfiguration can lose data. "Set 16-bit memory address"
+ * to a part with 8-bit addressing will overwrite data.  Writing with too
+ * big a page size also loses data.  And it's not safe to assume that the
+ * conventional addresses 0x50..0x57 only hold eeproms ... a pcf8563 RTC
+ * uses 0x51, for just one example.
+ *
+ * Accordingly, explicit board-specific configuration data should be used
+ * in almost all cases.  (One partial exception is an SMBus used to access
+ * "SPD" data for DRAM sticks.  Those only use 24c02 EEPROMs.)
+ *
+ * So this driver uses "new style" I2C driver binding, expecting to be
+ * told what devices exist.  That may be in arch/X/mach-Y/board-Z.c or
+ * similar kernel-resident tables; or, configuration data coming from
+ * a bootloader.  Be sure to set the board_info "type" to identify the
+ * eeprom type.
+ *
+ * Other than binding model, current differences from "eeprom" driver are
+ * that this one handles write access and isn't restricted to 24c02 devices.
+ * It also handles larger devices (32 kbit and up) with two-byte addresess,
+ * which won't work on pure SMBus systems.
+ */
+
+struct at24_data {
+	struct at24_platform_data chip;
+	bool use_smbus;
+
+	/*
+	 * Lock protects against activities from other Linux tasks,
+	 * but not from changes by other I2C masters.
+	 */
+	struct mutex lock;
+	struct bin_attribute bin;
+
+	u8 *writebuf;
+	unsigned write_max;
+
+	/*
+	 * Some chips tie up multiple I2C addresses; dummy devices reserve
+	 * them for ourselves, and we'll use them with SMBus calls.
+	 */
+	struct i2c_client *client[];
+};
+
+/*-------------------------------------------------------------------------*/
+
+/*
+ * This parameter is to help this driver avoid blocking other drivers out
+ * of I2C for potentially troublesome amounts of time.  With a 100 KHz I2C
+ * clock, one 256 byte read takes about 1/43 second which is excessive;
+ * but the 1/170 second it takes at 400 KHz may be quite reasonable; and
+ * at 1 MHz (Fm+) a 1/430 second delay could easily be invisible.
+ *
+ * This value is forced to be a power of two so that writes align on pages.
+ */
+static unsigned io_limit = 128;
+module_param(io_limit, uint, 0);
+MODULE_PARM_DESC(io_limit, "maximum bytes per i/o (default 128)");
+
+/*
+ * Specs often allow 5 msec for a page write, sometimes 20 msec;
+ * it's important to recover from write timeouts.
+ */
+static unsigned write_timeout = 25;
+module_param(write_timeout, uint, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(write_timeout, "time (in ms) to try writes (default 25)");
+/*
+ * This routine supports chips which consume multiple I2C addresess.  It
+ * computes the addressing information to be used for a given r/w request.
+ */
+static struct i2c_client *at24_ee_address(struct at24_data *at24, u16 *addr,
+		unsigned *offset)
+{
+	struct at24_platform_data *chip = &at24->chip;
+	unsigned i;
+
+	if (*offset >= chip->byte_len)
+		return NULL;
+
+	if (chip->flags & AT24_EE_ADDR2) {
+		i = *offset >> 16;
+		*offset &= 0xffff;
+	} else {
+		i = *offset >> 8;
+		*offset &= 0xff;
+	}
+
+	if (unlikely(i > chip->i2c_addr_mask)) {
+		dev_err(&at24->client[0]->dev,
+			"requested client %u not available!\n", i);
+		return NULL;
+	}
+
+	*addr = at24->client[i]->addr;
+	return at24->client[i];
+}
+
+
+/*-------------------------------------------------------------------------*/
+
+static ssize_t at24_ee_read(struct at24_data *at24, char *buf, unsigned offset,
+		size_t count)
+{
+	struct i2c_msg msg[2];
+	u8 addr[2];
+	struct i2c_client *client;
+	int status;
+
+	memset(msg, 0, sizeof msg);
+
+	/*
+	 * REVISIT some multi-address chips don't rollover page reads to
+	 * the next slave address, so we may need to truncate the count.
+	 * Those chips might need another quirk flag...
+	 *
+	 * If the real hardware used four adjacent 24c02 chips and that
+	 * were misconfiged as one 24c08, that would be a similar effect:
+	 * one "eeprom" file not four, but larger reads would fail when
+	 * they crossed certain pages.
+	 */
+	if (count > io_limit)
+		count = io_limit;
+
+	/*
+	 * Slave address and byte offset derive from the offset.  Always
+	 * set the byte address; on a multi-master board, another master
+	 * may have changed the chip's "current" address pointer.
+	 */
+	client = at24_ee_address(at24, &msg[0].addr, &offset);
+	if (!client)
+		return -EINVAL;
+
+	/* Smaller eproms can work given some SMBus extension calls */
+	if (at24->use_smbus) {
+		if (count > 32)
+			count = 32;
+		status = i2c_smbus_read_i2c_block_data(client, offset,
+				count, buf);
+		dev_dbg(&client->dev, "smbus read %zd@%d --> %d\n",
+				count, offset, status);
+		return (status < 0) ? -EIO : status;
+	}
+
+	/*
+	 * When we have a better choice than SMBus calls, use a combined
+	 * I2C message.  Write address; then read up to io_limit data bytes.
+	 * Note that read page rollover helps us here (unlike writes).
+	 */
+	msg[0].buf = addr;
+	addr[1] = (u8) offset;
+	addr[0] = (u8) (offset >> 8);
+
+	if (at24->chip.flags & AT24_EE_ADDR2)
+		msg[0].len = 2;
+	else {
+		msg[0].len = 1;
+		msg[0].buf++;
+	}
+
+	msg[1].addr = client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].buf = buf;
+	msg[1].len = count;
+
+	status = i2c_transfer(client->adapter, msg, 2);
+	dev_dbg(&client->dev, "i2c read %zd@%d --> %d\n",
+			count, offset, status);
+
+	if (status == 2)
+		return count;
+	else if (status >= 0)
+		return -EIO;
+	else
+		return status;
+}
+
+static ssize_t at24_bin_read(struct kobject *kobj, struct bin_attribute *attr,
+		char *buf, loff_t off, size_t count)
+{
+	struct i2c_client *client;
+	struct at24_data *at24;
+	ssize_t retval = 0;
+
+	client = to_i2c_client(container_of(kobj, struct device, kobj));
+	at24 = i2c_get_clientdata(client);
+
+	if (unlikely(off >= at24->bin.size))
+		return 0;
+	if ((off + count) > at24->bin.size)
+		count = at24->bin.size - off;
+	if (unlikely(!count))
+		return count;
+
+	/*
+	 * Read data from chip, protecting against concurrent updates
+	 * from this host ... but not from other i2c masters.
+	 */
+	mutex_lock(&at24->lock);
+	do {
+		ssize_t	status;
+
+		status = at24_ee_read(at24, buf, off, count);
+		if (status <= 0) {
+			if (retval == 0)
+				retval = status;
+			break;
+		}
+		buf += status;
+		off += status;
+		count -= status;
+		retval += status;
+
+	} while (count);
+	mutex_unlock(&at24->lock);
+
+	return retval;
+}
+
+
+/*
+ * REVISIT:  export at24_bin{read,write}() to let other kernel code use
+ * eeprom data.  For example, it might hold a board's Ethernet address, or
+ * board-specific calibration data generated on the manufacturing floor.
+ */
+
+
+/*
+ * Note that if the hardware write-protect pin is pulled high, the whole
+ * chip is normally write protected.  But there are plenty of product
+ * variants here, including OTP fuses and partial chip protect.
+ *
+ * We only use page mode writes; the alternative is sloooow.  This routine
+ * writes at most one page.
+ */
+static ssize_t at24_ee_write(struct at24_data *at24, char *buf, loff_t off,
+		size_t count)
+{
+	struct i2c_client *client;
+	struct i2c_msg  msg;
+	unsigned offset = (unsigned) off;
+	ssize_t status = 0;
+	unsigned long timeout, write_time;
+	unsigned c0, c1;
+
+	/* Maybe adjust i2c address and offset */
+	client = at24_ee_address(at24, &msg.addr, &offset);
+	if (!client)
+		return -EINVAL;
+
+	/* write_max is at most a page */
+	if (count > at24->write_max)
+		count = at24->write_max;
+
+	/* Never roll over backwards, to the start of this page */
+	c0 = offset + count;
+	c1 = roundup(offset + 1, at24->chip.page_size);
+	if (c0 > c1)
+		count -= c1 - c0;
+
+	/* If we'll use i2c calls for i/o, set up the message */
+	if (!at24->use_smbus) {
+		msg.flags = 0;
+		msg.len = count + 1;
+		msg.buf = at24->writebuf;
+		if (at24->chip.flags & AT24_EE_ADDR2) {
+			msg.len++;
+			msg.buf[1] = (u8) offset;
+			msg.buf[0] = (u8) (offset >> 8);
+			memcpy(&msg.buf[2], buf, count);
+		} else {
+			msg.buf[0] = offset;
+			memcpy(&msg.buf[1], buf, count);
+		}
+	}
+
+	/*
+	 * Writes fail if the previous one didn't complete yet.  We'll
+	 * loop a few times until this one succeeds, waiting at least
+	 * long enough for one entire page write to work.
+	 */
+	timeout = jiffies + msecs_to_jiffies(write_timeout);
+	do {
+		write_time = jiffies;
+		if (at24->use_smbus) {
+			status = i2c_smbus_write_i2c_block_data(client,
+					offset, count, buf);
+			if (status == 0)
+				status = count;
+		} else {
+			status = i2c_transfer(client->adapter, &msg, 1);
+			if (status == 1)
+				status = count;
+		}
+		dev_dbg(&client->dev, "write %zd@%d --> %zd (%ld)\n",
+				count, offset, status, jiffies);
+
+		if (status == count)
+			return count;
+
+		/* REVISIT:  at HZ=100, this is sloooow */
+		msleep(1);
+	} while (time_before(write_time, timeout));
+
+	dev_err(&client->dev, "write %zd@%d, timeout %ld ticks\n",
+			count, offset, jiffies
+			- (timeout - msecs_to_jiffies(write_timeout)));
+	return -ETIMEDOUT;
+}
+
+static ssize_t at24_bin_write(struct kobject *kobj, struct bin_attribute *attr,
+		char *buf, loff_t off, size_t count)
+{
+	struct i2c_client *client;
+	struct at24_data *at24;
+	ssize_t retval = 0;
+
+	client = to_i2c_client(container_of(kobj, struct device, kobj));
+	at24 = i2c_get_clientdata(client);
+
+	if (unlikely(off >= at24->bin.size))
+		return -EFBIG;
+	if ((off + count) > at24->bin.size)
+		count = at24->bin.size - off;
+	if (unlikely(!count))
+		return count;
+
+	/*
+	 * Write data from chip, protecting against concurrent updates
+	 * from this host ... but not from other i2c masters.
+	 */
+	mutex_lock(&at24->lock);
+
+	/* buffer big enough to stick the address at the beginning */
+	at24->writebuf = kmalloc(at24->write_max + 2, GFP_KERNEL);
+	if (!at24->writebuf) {
+		retval = -ENOMEM;
+		count = 0;
+	}
+
+	while (count) {
+		ssize_t	status;
+
+		status = at24_ee_write(at24, buf, off, count);
+		if (status <= 0) {
+			if (retval == 0)
+				retval = status;
+			break;
+		}
+		buf += status;
+		off += status;
+		count -= status;
+		retval += status;
+	}
+
+	kfree(at24->writebuf);
+	at24->writebuf = NULL;
+	mutex_unlock(&at24->lock);
+
+	return retval;
+}
+
+/*-------------------------------------------------------------------------*/
+
+static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct at24_platform_data *chip;
+	bool writable;
+	bool use_smbus = false;
+	struct at24_data *at24;
+	int err;
+	unsigned i, var_size;
+	struct i2c_client *c;
+
+	chip = client->dev.platform_data;
+	if (!chip) {
+		err = -ENODEV;
+		goto fail;
+	}
+	if (!is_power_of_2(chip->byte_len))
+		dev_warn(&client->dev,
+			"byte_len looks suspicious (no power of 2)!\n");
+	if (!is_power_of_2(chip->page_size))
+		dev_warn(&client->dev,
+			"page_size looks suspicious (no power of 2)!\n");
+	if (!is_power_of_2(chip->i2c_addr_mask + 1))
+		dev_warn(&client->dev,
+			"i2c_addr_mask looks suspicious (unusual mask)!\n");
+
+	/* Use I2C operations unless we're stuck with SMBus extensions. */
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		if (chip->flags & AT24_EE_ADDR2) {
+			err = -ECOMM;
+			goto fail;
+		}
+		if (!i2c_check_functionality(client->adapter,
+				I2C_FUNC_SMBUS_I2C_BLOCK)) {
+			err = -EBADMSG;
+			goto fail;
+		}
+		use_smbus = true;
+	}
+
+	var_size = (chip->i2c_addr_mask + 1) * sizeof(struct i2c_client *);
+	at24 = kzalloc(sizeof(struct at24_data) + var_size, GFP_KERNEL);
+	if (!at24) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	mutex_init(&at24->lock);
+	at24->chip = *chip;
+	at24->use_smbus = use_smbus;
+
+	/*
+	 * Export the EEPROM bytes through sysfs, since that's convenient.
+	 * By default, only root should see the data (maybe passwords etc)
+	 */
+	at24->bin.attr.name = "eeprom";
+	at24->bin.attr.mode = S_IRUSR;
+	at24->bin.attr.owner = THIS_MODULE;
+	at24->bin.read = at24_bin_read;
+
+	at24->bin.size = at24->chip.byte_len;
+
+	writable = ((chip->flags & AT24_EE_READONLY) == 0);
+	if (writable) {
+		unsigned write_max = at24->chip.page_size;
+
+		at24->bin.write = at24_bin_write;
+		at24->bin.attr.mode |= S_IWUSR;
+
+		if (write_max > io_limit)
+			write_max = io_limit;
+		if (use_smbus && write_max > 32)
+			write_max = 32;
+		at24->write_max = write_max;
+	}
+
+	/*
+	 * REVISIT read a byte, to make sure the chip is actually
+	 * present (vs misconfiguration, or not-populated-here)
+	 */
+
+	at24->client[0] = client;
+	i2c_set_clientdata(client, at24);
+
+	/* use dummy devices for multiple-address chips */
+	if (chip->i2c_addr_mask) {
+		for (i = 1; i <= chip->i2c_addr_mask; i++) {
+			c = i2c_new_dummy(client->adapter, client->addr + i);
+			if (!c) {
+				dev_err(&client->dev, "addr %d unavail\n",
+						client->addr + i);
+				err = -ENOCSI;
+				goto cleanup;
+			}
+			at24->client[i] = c;
+		}
+	}
+
+	err = sysfs_create_bin_file(&client->dev.kobj, &at24->bin);
+	if (err)
+		goto cleanup;
+
+	dev_info(&client->dev, "%Zd byte %s EEPROM%s\n",
+		at24->bin.size, client->name,
+		writable ? " (writable)" : "");
+	dev_dbg(&client->dev,
+		"page_size %d, i2c_addr_mask %d, write_max %d%s\n",
+		at24->chip.page_size, at24->chip.i2c_addr_mask,
+		at24->write_max,
+		use_smbus ? ", use_smbus" : "");
+	return 0;
+
+cleanup:
+	if (chip->i2c_addr_mask) {
+		for (i = 1; i <= chip->i2c_addr_mask; i++) {
+			c = at24->client[i];
+			if (c)
+				i2c_unregister_device(c);
+		}
+	}
+
+	kfree(at24);
+fail:
+	dev_dbg(&client->dev, "probe err %d\n", err);
+	return err;
+}
+
+static int __devexit at24_remove(struct i2c_client *client)
+{
+	struct at24_data *at24;
+	struct i2c_client *c;
+	int i;
+
+	at24 = i2c_get_clientdata(client);
+	sysfs_remove_bin_file(&client->dev.kobj, &at24->bin);
+
+	if (at24->chip.i2c_addr_mask) {
+		for (i = 1; i <= at24->chip.i2c_addr_mask; i++) {
+			c = at24->client[i];
+			if (c)
+				i2c_unregister_device(c);
+		}
+	}
+
+	kfree(at24);
+	return 0;
+}
+
+/*-------------------------------------------------------------------------*/
+
+static const struct i2c_device_id at24_ids[] = {
+	{ "at24", 0, },
+	{ /* END OF LIST */ }
+};
+
+static struct i2c_driver at24_driver = {
+	.driver = {
+		.name = "at24",
+		.owner = THIS_MODULE,
+	},
+	.probe = at24_probe,
+	.remove = __devexit_p(at24_remove),
+	.id_table = at24_ids,
+};
+
+static int __init at24_init(void)
+{
+	io_limit = rounddown_pow_of_two(io_limit);
+	return i2c_add_driver(&at24_driver);
+}
+module_init(at24_init);
+
+static void __exit at24_exit(void)
+{
+	i2c_del_driver(&at24_driver);
+}
+module_exit(at24_exit);
+
+MODULE_DESCRIPTION("Driver for most I2C EEPROMs");
+MODULE_AUTHOR("David Brownell");
+MODULE_LICENSE("GPL");
+
diff --git a/include/linux/i2c/at24.h b/include/linux/i2c/at24.h
new file mode 100644
index 0000000..74635ee
--- /dev/null
+++ b/include/linux/i2c/at24.h
@@ -0,0 +1,102 @@
+
+#ifndef _LINUX_AT24_H
+#define _LINUX_AT24_H
+
+#include <linux/types.h>
+
+/*
+ * As seen through Linux I2C, differences between the most common types
+ * of I2C memory include:
+ *	- How many I2C addresses the chip consumes: 1, 2, 4...?
+ *	- Memory address space for one I2C address:  256 byte, or 64 KB?
+ *	- How full that memory space is:  16 bytes, 256, 32Kb, etc?
+ *	- What write page size does it support?
+ */
+
+struct at24_platform_data {
+	u32		byte_len;		/* size (sum of all addr) */
+	u16		page_size;		/* for writes */
+	u8		i2c_addr_mask;		/* for multi-addr chips */
+	u8		flags;			/* quirks, etc */
+#define	AT24_EE_ADDR2		0x0080		/* 16 bit addrs; <= 64 KB */
+#define	AT24_EE_READONLY	0x0040
+};
+
+/*
+ * If you use this macro to set up a custom eeprom type, please make sure you
+ * have double checked the parameters. Especially page_size needs extra care,
+ * as you risk data loss if your value is bigger than what the chip actually
+ * supports!
+ */
+#define AT24_PLATFORM_DATA(_name, _len, _page, _mask, _flags) \
+struct at24_platform_data at24_platform_data_##_name = {	\
+	.byte_len	= _len,		\
+	.page_size	= _page,	\
+	.i2c_addr_mask	= _mask,	\
+	.flags		= _flags,	\
+};
+
+/* 128 bit chip, I2C A0-A2 ignored */
+#define AT24_PLATFORM_DATA_24C00 \
+	AT24_PLATFORM_DATA(24c00, 128 / 8, 1, 0x07, 0)
+
+/* 1 Kbit chip, some have 16 byte pages: 24lc014, ... */
+#define AT24_PLATFORM_DATA_24C01 \
+	AT24_PLATFORM_DATA(24c01, 1024 / 8, 8, 0, 0)
+
+/* 2 Kbit chip, some have 16 byte pages: */
+#define AT24_PLATFORM_DATA_24C02 \
+	AT24_PLATFORM_DATA(24c02, 2048 / 8, 8, 0, 0)
+
+/* 2 Kbit chip, 24c02 in memory DIMMs, some have 16 byte pages */
+#define AT24_PLATFORM_DATA_SPD \
+	AT24_PLATFORM_DATA(spd, 2048 / 8, 8, 0, AT24_EE_READONLY)
+
+/* 2 Kbit chip, SRAM, not EEPROM!, no page size issues, write it all at once */
+#define AT24_PLATFORM_DATA_PCF8570 \
+	AT24_PLATFORM_DATA(pcf8570, 2048 / 8, 2048 / 8, 0, 0)
+
+/* 4 Kbit chip, I2C A0 is MEM A8 */
+#define AT24_PLATFORM_DATA_24C04 \
+	AT24_PLATFORM_DATA(24c04, 4096 / 8, 16, 0x01, 0)
+
+/*
+ * 8 Kbit chip, I2C A1-A0 is MEM A9-A8, works also with 24RF08
+ * (its quirk is handled at i2c-core-level)
+ */
+#define AT24_PLATFORM_DATA_24C08 \
+	AT24_PLATFORM_DATA(24c08, 8192 / 8, 16, 0x03, 0)
+
+/* 16 Kbit chip, I2C A2-A0 is MEM A10-A8 */
+#define AT24_PLATFORM_DATA_24C16 \
+	AT24_PLATFORM_DATA(24c16, 16384 / 8, 16, 0x07, 0)
+
+
+/* this second block of EEPROMS uses 16 bit memory addressing */
+
+/* 32 Kbits */
+#define AT24_PLATFORM_DATA_24C32 \
+	AT24_PLATFORM_DATA(24c32, 32768 / 8, 32, 0, AT24_EE_ADDR2)
+
+/* 64 Kbits */
+#define AT24_PLATFORM_DATA_24C64 \
+	AT24_PLATFORM_DATA(24c64, 65536 / 8, 32, 0, AT24_EE_ADDR2)
+
+/* 128 Kbits */
+#define AT24_PLATFORM_DATA_24C128 \
+	AT24_PLATFORM_DATA(24c128, 131072 / 8, 64, 0, AT24_EE_ADDR2)
+
+/* 256 Kbits */
+#define AT24_PLATFORM_DATA_24C256 \
+	AT24_PLATFORM_DATA(24c256, 262144 / 8, 64, 0, AT24_EE_ADDR2)
+
+/* 512 Kbits */
+#define AT24_PLATFORM_DATA_24C512 \
+	AT24_PLATFORM_DATA(24c512, 524288 / 8, 128, 0, AT24_EE_ADDR2)
+
+/* 1 Mbits, I2C A0 is MEM A16 */
+#define AT24_PLATFORM_DATA_24C1024 \
+	AT24_PLATFORM_DATA(24c1024, 1048576 / 8, 256, 0x01, AT24_EE_ADDR2)
+
+#endif /* _LINUX_AT24_H */
+
-- 
1.5.5.1


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
