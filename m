From: Jan Kandziora <jjj@gmx.de>
Subject: [PATCH v4 2/2] add w1_ds28e17 driver for the DS28E17 Onewire to I2C master bridge
Date: Wed, 19 Jul 2017 22:14:09 +0200
Message-ID: <20170719201409.5968-2-jjj@gmx.de>
References: <20170719201409.5968-1-jjj@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719201409.5968-1-jjj@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Evgeniy Polyakov <zbr@ioremap.net>, Linux-I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

This subpatch adds a driver for the DS28E17 Onewire to I2C master bridge.

Signed-off-by: Jan Kandziora <jjj@gmx.de>
---
Changes in v4 against v3 in this subpatch:
  - adapted to linux-4.12.0

Changes in v3 against v2 in this subpatch:
  - fixed a bug in using the i2c_adapter_quirks structure

Changes in v2 against v1 in this subpatch:
  - added error handling in w1_f19_error()
  - added struct i2c_adapter_quirks
  - removed unnecessary checks of I2C address and read count
  - cleaned up error codes
    + EOPNOTSUPP for read/write count == 0
    + ETIMEDOUT for busy timeout
    + ENXIO for no reply of I2C slave
    + EAGAIN for I2C invalid start condition
    + EIO for all w1 errors
  - devm_kzalloc() instead of kzalloc()
  - i2c speed to be set as 100, 400, 900 instead of 0, 1, 2
  - added driver parameter documentation
  - added sysfs documentation
  - Kconfig fixed

 Documentation/ABI/testing/sysfs-driver-w1_ds28e17 |  21 +
 Documentation/w1/slaves/00-INDEX                  |   2 +
 Documentation/w1/slaves/w1_ds28e17                |  68 ++
 drivers/w1/slaves/Kconfig                         |  15 +
 drivers/w1/slaves/Makefile                        |   1 +
 drivers/w1/slaves/w1_ds28e17.c                    | 772 ++++++++++++++++++++++
 drivers/w1/w1_family.h                            |   1 +
 7 files changed, 880 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-w1_ds28e17
 create mode 100644 Documentation/w1/slaves/w1_ds28e17
 create mode 100644 drivers/w1/slaves/w1_ds28e17.c

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_ds28e17 b/Documentation/ABI/testing/sysfs-driver-w1_ds28e17
new file mode 100644
index 0000000..b97b101
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-w1_ds28e17
@@ -0,0 +1,21 @@
+What:		/sys/bus/w1/devices/19-<id>/speed
+Date:		Jul 2016
+KernelVersion:	4.7
+Contact:	Jan Kandziora <jjj@gmx.de>
+Description:	When written, this file sets the I2C speed on the connected
+		DS28E17 chip. When read, it reads the current setting from
+		the DS28E17 chip.
+		Valid values: 100, 400, 900 [kBaud].
+		Default 100, can be set by w1_ds28e17.speed= module parameter.
+Users:		w1_ds28e17 driver
+
+What:		/sys/bus/w1/devices/19-<id>/stretch
+Date:		Jul 2016
+KernelVersion:	4.7
+Contact:	Jan Kandziora <jjj@gmx.de>
+Description:	When written, this file sets the multiplier used to calculate
+		the busy timeout for I2C operations on the connected DS28E17
+		chip. When read, returns the current setting.
+		Valid values: 1 to 9.
+		Default 1, can be set by w1_ds28e17.stretch= module parameter.
+Users:		w1_ds28e17 driver
diff --git a/Documentation/w1/slaves/00-INDEX b/Documentation/w1/slaves/00-INDEX
index 8d76718..68946f8 100644
--- a/Documentation/w1/slaves/00-INDEX
+++ b/Documentation/w1/slaves/00-INDEX
@@ -10,3 +10,5 @@ w1_ds2438
 	- The Maxim/Dallas Semiconductor ds2438 smart battery monitor.
 w1_ds28e04
 	- The Maxim/Dallas Semiconductor ds28e04 eeprom.
+w1_ds28e17
+	- The Maxim/Dallas Semiconductor ds28e17 1-Wire-to-I2C Master Bridge.
diff --git a/Documentation/w1/slaves/w1_ds28e17 b/Documentation/w1/slaves/w1_ds28e17
new file mode 100644
index 0000000..e82e16e
--- /dev/null
+++ b/Documentation/w1/slaves/w1_ds28e17
@@ -0,0 +1,68 @@
+Kernel driver w1_ds28e17
+========================
+
+Supported chips:
+  * Maxim DS28E17 1-Wire-to-I2C Master Bridge
+
+supported family codes:
+	W1_FAMILY_DS28E17	0x19
+
+Author: Jan Kandziora <jjj@gmx.de>
+
+
+Description
+-----------
+The DS28E17 is a Onewire slave device which acts as an I2C bus master.
+
+This driver creates a new I2C bus for any DS28E17 device detected. I2C buses
+come and go as the DS28E17 devices come and go. I2C slave devices connected to
+a DS28E17 can be accessed by the kernel or userspace tools as if they were
+connected to a "native" I2C bus master.
+
+
+An udev rule like the following
+-------------------------------------------------------------------------------
+SUBSYSTEM=="i2c-dev", KERNEL=="i2c-[0-9]*", ATTRS{name}=="w1-19-*", \
+        SYMLINK+="i2c-$attr{name}"
+-------------------------------------------------------------------------------
+may be used to create stable /dev/i2c- entries based on the unique id of the
+DS28E17 chip.
+
+
+Driver parameters are:
+
+speed:
+	This sets up the default I2C speed a DS28E17 get configured for as soon
+	it is connected. The power-on default	of the DS28E17 is 400kBaud, but
+	chips may come and go on the Onewire bus without being de-powered and
+	as soon the "w1_ds28e17" driver notices a freshly connected, or
+	reconnected DS28E17 device on the Onewire bus, it will re-apply this
+	setting.
+
+	Valid values are 100, 400, 900 [kBaud]. Any other value means to leave
+	alone the current DS28E17 setting on detect. The default value is 100.
+
+stretch:
+	This sets up the default stretch value used for freshly connected
+	DS28E17 devices. It is a multiplier used on the calculation of the busy
+	wait time for an I2C transfer. This is to account for I2C slave devices
+	which make heavy use of the I2C clock stretching feature and thus, the
+	needed timeout cannot be pre-calculated correctly. As the w1_ds28e17
+	driver checks the DS28E17's busy flag in a loop after the precalculated
+	wait time, it should be hardly needed to tweak this setting.
+
+	Leave it at 1 unless you get ETIMEDOUT errors and a "w1_slave_driver
+	19-00000002dbd8: busy timeout" in the kernel log.
+
+	Valid values are 1 to 9. The default is 1.
+
+
+The driver creates sysfs files /sys/bus/w1/devices/19-<id>/speed and
+/sys/bus/w1/devices/19-<id>/stretch for each device, preloaded with the default
+settings from the driver parameters. They may be changed anytime. In addition a
+directory /sys/bus/w1/devices/19-<id>/i2c-<nnn> for the I2C bus master sysfs
+structure is created.
+
+
+See https://github.com/ianka/w1_ds28e17 for even more information.
+
diff --git a/drivers/w1/slaves/Kconfig b/drivers/w1/slaves/Kconfig
index fb68465..b94c55c 100644
--- a/drivers/w1/slaves/Kconfig
+++ b/drivers/w1/slaves/Kconfig
@@ -140,6 +140,21 @@ config W1_SLAVE_DS28E04
 
 	  If you are unsure, say N.
 
+config W1_SLAVE_DS28E17
+	tristate "1-wire-to-I2C master bridge (DS28E17)"
+	select CRC16
+	depends on I2C
+	help
+	  Say Y here if you want to use the DS28E17 1-wire-to-I2C master bridge.
+	  For each DS28E17 detected, a new I2C adapter is created within the
+	  kernel. I2C devices on that bus can be configured to be used by the
+	  kernel and userspace tools as on any other "native" I2C bus.
+
+	  This driver is also available as a module. If so, the module
+	  will be called w1_ds28e17.
+
+	  If you are unsure, say N.
+
 config W1_SLAVE_BQ27000
 	tristate "BQ27000 slave support"
 	help
diff --git a/drivers/w1/slaves/Makefile b/drivers/w1/slaves/Makefile
index 54c63e4..5ec927b 100644
--- a/drivers/w1/slaves/Makefile
+++ b/drivers/w1/slaves/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_W1_SLAVE_DS2780)	+= w1_ds2780.o
 obj-$(CONFIG_W1_SLAVE_DS2781)	+= w1_ds2781.o
 obj-$(CONFIG_W1_SLAVE_BQ27000)	+= w1_bq27000.o
 obj-$(CONFIG_W1_SLAVE_DS28E04)	+= w1_ds28e04.o
+obj-$(CONFIG_W1_SLAVE_DS28E17)	+= w1_ds28e17.o
diff --git a/drivers/w1/slaves/w1_ds28e17.c b/drivers/w1/slaves/w1_ds28e17.c
new file mode 100644
index 0000000..3e217e9
--- /dev/null
+++ b/drivers/w1/slaves/w1_ds28e17.c
@@ -0,0 +1,772 @@
+/*
+ *	w1_ds28e17.c - w1 family 19 (DS28E17) driver
+ *
+ * Copyright (c) 2016 Jan Kandziora <jjj@gmx.de>
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2. See the file COPYING for more details.
+ */
+
+#include <linux/crc16.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+#define CRC16_INIT 0
+
+#include "../w1.h"
+#include "../w1_int.h"
+#include "../w1_family.h"
+
+
+/* Module setup. */
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Jan Kandziora <jjj@gmx.de>");
+MODULE_DESCRIPTION("w1 family 19 driver for DS28E17, 1-wire to I2C master bridge");
+MODULE_ALIAS("w1-family-" __stringify(W1_FAMILY_DS28E17));
+
+
+/* Default I2C speed to be set when a DS28E17 is detected. */
+static int i2c_speed = 100;
+module_param_named(speed, i2c_speed, int, (S_IRUSR | S_IWUSR));
+MODULE_PARM_DESC(speed, "Default I2C speed to be set when a DS28E17 is detected");
+
+/* Default I2C stretch value to be set when a DS28E17 is detected. */
+static char i2c_stretch = 1;
+module_param_named(stretch, i2c_stretch, byte, (S_IRUSR | S_IWUSR));
+MODULE_PARM_DESC(stretch, "Default I2C stretch value to be set when a DS28E17 is detected");
+
+/* DS28E17 device command codes. */
+#define W1_F19_WRITE_DATA_WITH_STOP      0x4B
+#define W1_F19_WRITE_DATA_NO_STOP        0x5A
+#define W1_F19_WRITE_DATA_ONLY           0x69
+#define W1_F19_WRITE_DATA_ONLY_WITH_STOP 0x78
+#define W1_F19_READ_DATA_WITH_STOP       0x87
+#define W1_F19_WRITE_READ_DATA_WITH_STOP 0x2D
+#define W1_F19_WRITE_CONFIGURATION       0xD2
+#define W1_F19_READ_CONFIGURATION        0xE1
+#define W1_F19_ENABLE_SLEEP_MODE         0x1E
+#define W1_F19_READ_DEVICE_REVISION      0xC4
+
+/* DS28E17 status bits */
+#define W1_F19_STATUS_CRC     0x01
+#define W1_F19_STATUS_ADDRESS 0x02
+#define W1_F19_STATUS_START   0x08
+
+/*
+ * Maximum number of I2C bytes to transfer within one CRC16 protected onewire
+ * command.
+ * */
+#define W1_F19_WRITE_DATA_LIMIT 255
+
+/* Maximum number of I2C bytes to read with one onewire command. */
+#define W1_F19_READ_DATA_LIMIT 255
+
+/* Constants for calculating the busy sleep. */
+#define W1_F19_BUSY_TIMEBASES { 90, 23, 10 }
+#define W1_F19_BUSY_GRATUITY  1000
+
+/* Number of checks for the busy flag before timeout. */
+#define W1_F19_BUSY_CHECKS 1000
+
+
+/* Slave specific data. */
+struct w1_f19_data {
+	u8 speed;
+	u8 stretch;
+	struct i2c_adapter adapter;
+};
+
+
+/* Wait a while until the busy flag clears. */
+static int w1_f19_i2c_busy_wait(struct w1_slave *sl, size_t count)
+{
+	const unsigned long timebases[3] = W1_F19_BUSY_TIMEBASES;
+	struct w1_f19_data *data = sl->family_data;
+	unsigned int checks;
+
+	/* Check the busy flag first in any case.*/
+	if (w1_touch_bit(sl->master, 1) == 0)
+		return 0;
+
+	/*
+	 * Do a generously long sleep in the beginning,
+	 * as we have to wait at least this time for all
+	 * the I2C bytes at the given speed to be transferred.
+	 */
+	usleep_range(timebases[data->speed] * (data->stretch) * count,
+		timebases[data->speed] * (data->stretch) * count
+		+ W1_F19_BUSY_GRATUITY);
+
+	/* Now continusly check the busy flag sent by the DS28E17. */
+	checks = W1_F19_BUSY_CHECKS;
+	while ((checks--) > 0) {
+		/* Return success if the busy flag is cleared. */
+		if (w1_touch_bit(sl->master, 1) == 0)
+			return 0;
+
+		/* Wait one non-streched byte timeslot. */
+		udelay(timebases[data->speed]);
+	}
+
+	/* Timeout. */
+	dev_warn(&sl->dev, "busy timeout\n");
+	return -ETIMEDOUT;
+}
+
+
+/* Utility function: result. */
+static size_t w1_f19_error(struct w1_slave *sl, u8 w1_buf[])
+{
+	/* Warnings. */
+	if (w1_buf[0] & W1_F19_STATUS_CRC)
+		dev_warn(&sl->dev, "crc16 mismatch\n");
+	if (w1_buf[0] & W1_F19_STATUS_ADDRESS)
+		dev_warn(&sl->dev, "i2c device not responding\n");
+	if ((w1_buf[0] & (W1_F19_STATUS_CRC | W1_F19_STATUS_ADDRESS)) == 0
+			&& w1_buf[1] != 0) {
+		dev_warn(&sl->dev, "i2c short write, %d bytes not acknowledged\n",
+			w1_buf[1]);
+	}
+
+	/* Check error conditions. */
+	if (w1_buf[0] & W1_F19_STATUS_ADDRESS)
+		return -ENXIO;
+	if (w1_buf[0] & W1_F19_STATUS_START)
+		return -EAGAIN;
+	if (w1_buf[0] != 0 || w1_buf[1] != 0)
+		return -EIO;
+
+	/* All ok. */
+	return 0;
+}
+
+
+/* Utility function: write data to I2C slave, single chunk. */
+static int __w1_f19_i2c_write(struct w1_slave *sl,
+	const u8 *command, size_t command_count,
+	const u8 *buffer, size_t count)
+{
+	u16 crc;
+	int error;
+	u8 w1_buf[2];
+
+	/* Send command and I2C data to DS28E17. */
+	crc = crc16(CRC16_INIT, command, command_count);
+	w1_write_block(sl->master, command, command_count);
+
+	w1_buf[0] = count;
+	crc = crc16(crc, w1_buf, 1);
+	w1_write_8(sl->master, w1_buf[0]);
+
+	crc = crc16(crc, buffer, count);
+	w1_write_block(sl->master, buffer, count);
+
+	w1_buf[0] = ~(crc & 0xFF);
+	w1_buf[1] = ~((crc >> 8) & 0xFF);
+	w1_write_block(sl->master, w1_buf, 2);
+
+	/* Wait until busy flag clears (or timeout). */
+	if (w1_f19_i2c_busy_wait(sl, count + 1) < 0)
+		return -ETIMEDOUT;
+
+	/* Read status from DS28E17. */
+	w1_read_block(sl->master, w1_buf, 2);
+
+	/* Check error conditions. */
+	error = w1_f19_error(sl, w1_buf);
+	if (error < 0)
+		return error;
+
+	/* Return number of bytes written. */
+	return count;
+}
+
+
+/* Write data to I2C slave. */
+static int w1_f19_i2c_write(struct w1_slave *sl, u16 i2c_address,
+	const u8 *buffer, size_t count, bool stop)
+{
+	int result;
+	int remaining = count;
+	const u8 *p;
+	u8 command[2];
+
+	/* Check input. */
+	if (count == 0)
+		return -EOPNOTSUPP;
+
+	/* Check whether we need multiple commands. */
+	if (count <= W1_F19_WRITE_DATA_LIMIT) {
+		/*
+		 * Small data amount. Data can be sent with
+		 * a single onewire command.
+		 */
+
+		/* Send all data to DS28E17. */
+		command[0] = (stop ? W1_F19_WRITE_DATA_WITH_STOP
+			: W1_F19_WRITE_DATA_NO_STOP);
+		command[1] = i2c_address << 1;
+		result = __w1_f19_i2c_write(sl, command, 2, buffer, count);
+	} else {
+		/* Large data amount. Data has to be sent in multiple chunks. */
+
+		/* Send first chunk to DS28E17. */
+		p = buffer;
+		command[0] = W1_F19_WRITE_DATA_NO_STOP;
+		command[1] = i2c_address << 1;
+		result = __w1_f19_i2c_write(sl, command, 2, p,
+			W1_F19_WRITE_DATA_LIMIT);
+		if (result < 0)
+			return result;
+
+		/* Resume to same DS28E17. */
+		if (w1_reset_resume_command(sl->master))
+			return -EIO;
+
+		/* Next data chunk. */
+		p += W1_F19_WRITE_DATA_LIMIT;
+		remaining -= W1_F19_WRITE_DATA_LIMIT;
+
+		while (remaining > W1_F19_WRITE_DATA_LIMIT) {
+			/* Send intermediate chunk to DS28E17. */
+			command[0] = W1_F19_WRITE_DATA_ONLY;
+			result = __w1_f19_i2c_write(sl, command, 1, p,
+					W1_F19_WRITE_DATA_LIMIT);
+			if (result < 0)
+				return result;
+
+			/* Resume to same DS28E17. */
+			if (w1_reset_resume_command(sl->master))
+				return -EIO;
+
+			/* Next data chunk. */
+			p += W1_F19_WRITE_DATA_LIMIT;
+			remaining -= W1_F19_WRITE_DATA_LIMIT;
+		}
+
+		/* Send final chunk to DS28E17. */
+		command[0] = (stop ? W1_F19_WRITE_DATA_ONLY_WITH_STOP
+			: W1_F19_WRITE_DATA_ONLY);
+		result = __w1_f19_i2c_write(sl, command, 1, p, remaining);
+	}
+
+	return result;
+}
+
+
+/* Read data from I2C slave. */
+static int w1_f19_i2c_read(struct w1_slave *sl, u16 i2c_address,
+	u8 *buffer, size_t count)
+{
+	u16 crc;
+	int error;
+	u8 w1_buf[5];
+
+	/* Check input. */
+	if (count == 0)
+		return -EOPNOTSUPP;
+
+	/* Send command to DS28E17. */
+	w1_buf[0] = W1_F19_READ_DATA_WITH_STOP;
+	w1_buf[1] = i2c_address << 1 | 0x01;
+	w1_buf[2] = count;
+	crc = crc16(CRC16_INIT, w1_buf, 3);
+	w1_buf[3] = ~(crc & 0xFF);
+	w1_buf[4] = ~((crc >> 8) & 0xFF);
+	w1_write_block(sl->master, w1_buf, 5);
+
+	/* Wait until busy flag clears (or timeout). */
+	if (w1_f19_i2c_busy_wait(sl, count + 1) < 0)
+		return -ETIMEDOUT;
+
+	/* Read status from DS28E17. */
+	w1_buf[0] = w1_read_8(sl->master);
+	w1_buf[1] = 0;
+
+	/* Check error conditions. */
+	error = w1_f19_error(sl, w1_buf);
+	if (error < 0)
+		return error;
+
+	/* Read received I2C data from DS28E17. */
+	return w1_read_block(sl->master, buffer, count);
+}
+
+
+/* Write to, then read data from I2C slave. */
+static int w1_f19_i2c_write_read(struct w1_slave *sl, u16 i2c_address,
+	const u8 *wbuffer, size_t wcount, u8 *rbuffer, size_t rcount)
+{
+	u16 crc;
+	int error;
+	u8 w1_buf[3];
+
+	/* Check input. */
+	if (wcount == 0 || rcount == 0)
+		return -EOPNOTSUPP;
+
+	/* Send command and I2C data to DS28E17. */
+	w1_buf[0] = W1_F19_WRITE_READ_DATA_WITH_STOP;
+	w1_buf[1] = i2c_address << 1;
+	w1_buf[2] = wcount;
+	crc = crc16(CRC16_INIT, w1_buf, 3);
+	w1_write_block(sl->master, w1_buf, 3);
+
+	crc = crc16(crc, wbuffer, wcount);
+	w1_write_block(sl->master, wbuffer, wcount);
+
+	w1_buf[0] = rcount;
+	crc = crc16(crc, w1_buf, 1);
+	w1_buf[1] = ~(crc & 0xFF);
+	w1_buf[2] = ~((crc >> 8) & 0xFF);
+	w1_write_block(sl->master, w1_buf, 3);
+
+	/* Wait until busy flag clears (or timeout). */
+	if (w1_f19_i2c_busy_wait(sl, wcount + rcount + 2) < 0)
+		return -ETIMEDOUT;
+
+	/* Read status from DS28E17. */
+	w1_read_block(sl->master, w1_buf, 2);
+
+	/* Check error conditions. */
+	error = w1_f19_error(sl, w1_buf);
+	if (error < 0)
+		return error;
+
+	/* Read received I2C data from DS28E17. */
+	return w1_read_block(sl->master, rbuffer, rcount);
+}
+
+
+/* Do an I2C master transfer. */
+static int w1_f19_i2c_master_transfer(struct i2c_adapter *adapter,
+	struct i2c_msg *msgs, int num)
+{
+	struct w1_slave *sl = (struct w1_slave *) adapter->algo_data;
+	int i = 0;
+	int result = 0;
+
+	/* Start onewire transaction. */
+	mutex_lock(&sl->master->bus_mutex);
+
+	/* Select DS28E17. */
+	if (w1_reset_select_slave(sl)) {
+		i = -EIO;
+		goto error;
+	}
+
+	/* Loop while there are still messages to transfer. */
+	while (i < num) {
+		/*
+		 * Check for special case: Small write followed
+		 * by read to same I2C device.
+		 */
+		if (i < (num-1)
+			&& msgs[i].addr == msgs[i+1].addr
+			&& !(msgs[i].flags & I2C_M_RD)
+			&& (msgs[i+1].flags & I2C_M_RD)
+			&& (msgs[i].len <= W1_F19_WRITE_DATA_LIMIT)) {
+			/*
+			 * The DS28E17 has a combined transfer
+			 * for small write+read.
+			 */
+			result = w1_f19_i2c_write_read(sl, msgs[i].addr,
+				msgs[i].buf, msgs[i].len,
+				msgs[i+1].buf, msgs[i+1].len);
+			if (result < 0) {
+				i = result;
+				goto error;
+			}
+
+			/*
+			 * Check if we should interpret the read data
+			 * as a length byte. The DS28E17 unfortunately
+			 * has no read without stop, so we can just do
+			 * another simple read in that case.
+			 */
+			if (msgs[i+1].flags & I2C_M_RECV_LEN) {
+				result = w1_f19_i2c_read(sl, msgs[i+1].addr,
+					&(msgs[i+1].buf[1]), msgs[i+1].buf[0]);
+				if (result < 0) {
+					i = result;
+					goto error;
+				}
+			}
+
+			/* Eat up read message, too. */
+			i++;
+		} else if (msgs[i].flags & I2C_M_RD) {
+			/* Read transfer. */
+			result = w1_f19_i2c_read(sl, msgs[i].addr,
+				msgs[i].buf, msgs[i].len);
+			if (result < 0) {
+				i = result;
+				goto error;
+			}
+
+			/*
+			 * Check if we should interpret the read data
+			 * as a length byte. The DS28E17 unfortunately
+			 * has no read without stop, so we can just do
+			 * another simple read in that case.
+			 */
+			if (msgs[i].flags & I2C_M_RECV_LEN) {
+				result = w1_f19_i2c_read(sl,
+					msgs[i].addr,
+					&(msgs[i].buf[1]),
+					msgs[i].buf[0]);
+				if (result < 0) {
+					i = result;
+					goto error;
+				}
+			}
+		} else {
+			/*
+			 * Write transfer.
+			 * Stop condition only for last
+			 * transfer.
+			 */
+			result = w1_f19_i2c_write(sl,
+				msgs[i].addr,
+				msgs[i].buf,
+				msgs[i].len,
+				i == (num-1));
+			if (result < 0) {
+				i = result;
+				goto error;
+			}
+		}
+
+		/* Next message. */
+		i++;
+
+		/* Are there still messages to send/receive? */
+		if (i < num) {
+			/* Yes. Resume to same DS28E17. */
+			if (w1_reset_resume_command(sl->master)) {
+				i = -EIO;
+				goto error;
+			}
+		}
+	}
+
+error:
+	/* End onewire transaction. */
+	mutex_unlock(&sl->master->bus_mutex);
+
+	/* Return number of messages processed or error. */
+	return i;
+}
+
+
+/* Get I2C adapter functionality. */
+static u32 w1_f19_i2c_functionality(struct i2c_adapter *adapter)
+{
+	/*
+	 * Plain I2C functions only.
+	 * SMBus is emulated by the kernel's I2C layer.
+	 * No "I2C_FUNC_SMBUS_QUICK"
+	 * No "I2C_FUNC_SMBUS_READ_BLOCK_DATA"
+	 * No "I2C_FUNC_SMBUS_BLOCK_PROC_CALL"
+	 */
+	return I2C_FUNC_I2C |
+		I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA |
+		I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_PROC_CALL |
+		I2C_FUNC_SMBUS_WRITE_BLOCK_DATA |
+		I2C_FUNC_SMBUS_I2C_BLOCK |
+		I2C_FUNC_SMBUS_PEC;
+}
+
+
+/* I2C adapter quirks. */
+static const struct i2c_adapter_quirks w1_f19_i2c_adapter_quirks = {
+	.max_read_len = W1_F19_READ_DATA_LIMIT,
+};
+
+/* I2C algorithm. */
+static const struct i2c_algorithm w1_f19_i2c_algorithm = {
+	.master_xfer    = w1_f19_i2c_master_transfer,
+	.functionality  = w1_f19_i2c_functionality,
+};
+
+
+/* Read I2C speed from DS28E17. */
+static int w1_f19_get_i2c_speed(struct w1_slave *sl)
+{
+	struct w1_f19_data *data = sl->family_data;
+	int result = -EIO;
+
+	/* Start onewire transaction. */
+	mutex_lock(&sl->master->bus_mutex);
+
+	/* Select slave. */
+	if (w1_reset_select_slave(sl))
+		goto error;
+
+	/* Read slave configuration byte. */
+	w1_write_8(sl->master, W1_F19_READ_CONFIGURATION);
+	result = w1_read_8(sl->master);
+	if (result < 0 || result > 2) {
+		result = -EIO;
+		goto error;
+	}
+
+	/* Update speed in slave specific data. */
+	data->speed = result;
+
+error:
+	/* End onewire transaction. */
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return result;
+}
+
+
+/* Set I2C speed on DS28E17. */
+static int __w1_f19_set_i2c_speed(struct w1_slave *sl, u8 speed)
+{
+	struct w1_f19_data *data = sl->family_data;
+	const int i2c_speeds[3] = { 100, 400, 900 };
+	u8 w1_buf[2];
+
+	/* Select slave. */
+	if (w1_reset_select_slave(sl))
+		return -EIO;
+
+	w1_buf[0] = W1_F19_WRITE_CONFIGURATION;
+	w1_buf[1] = speed;
+	w1_write_block(sl->master, w1_buf, 2);
+
+	/* Update speed in slave specific data. */
+	data->speed = speed;
+
+	dev_info(&sl->dev, "i2c speed set to %d kBaud\n", i2c_speeds[speed]);
+
+	return 0;
+}
+
+static int w1_f19_set_i2c_speed(struct w1_slave *sl, u8 speed)
+{
+	int result;
+
+	/* Start onewire transaction. */
+	mutex_lock(&sl->master->bus_mutex);
+
+	/* Set I2C speed on DS28E17. */
+	result = __w1_f19_set_i2c_speed(sl, speed);
+
+	/* End onewire transaction. */
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return result;
+}
+
+
+/* Sysfs attributes. */
+
+/* I2C speed attribute for a single chip. */
+static ssize_t speed_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct w1_slave *sl = dev_to_w1_slave(dev);
+	int result;
+
+	/* Read current speed from slave. Updates data->speed. */
+	result = w1_f19_get_i2c_speed(sl);
+	if (result < 0)
+		return result;
+
+	/* Return current speed value. */
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t speed_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct w1_slave *sl = dev_to_w1_slave(dev);
+	int error;
+
+	/* Valid values are: "100", "400", "900" */
+	if (count < 3 || count > 4 || !buf)
+		return -EINVAL;
+	if (count == 4 && buf[3] != '\n')
+		return -EINVAL;
+	if (buf[1] != '0' || buf[2] != '0')
+		return -EINVAL;
+
+	/* Set speed on slave. */
+	switch (buf[0]) {
+	case '1':
+		error = w1_f19_set_i2c_speed(sl, 0);
+		break;
+	case '4':
+		error = w1_f19_set_i2c_speed(sl, 1);
+		break;
+	case '9':
+		error = w1_f19_set_i2c_speed(sl, 2);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (error < 0)
+		return error;
+
+	/* Return bytes written. */
+	return count;
+}
+
+static DEVICE_ATTR_RW(speed);
+
+
+/* Busy stretch attribute for a single chip. */
+static ssize_t stretch_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct w1_slave *sl = dev_to_w1_slave(dev);
+	struct w1_f19_data *data = sl->family_data;
+
+	/* Return current stretch value. */
+	return sprintf(buf, "%d\n", data->stretch);
+}
+
+static ssize_t stretch_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct w1_slave *sl = dev_to_w1_slave(dev);
+	struct w1_f19_data *data = sl->family_data;
+
+	/* Valid values are '1' to '9' */
+	if (count < 1 || count > 2 || !buf)
+		return -EINVAL;
+	if (count == 2 && buf[1] != '\n')
+		return -EINVAL;
+	if (buf[0] < '1' || buf[0] > '9')
+		return -EINVAL;
+
+	/* Set busy stretch value. */
+	data->stretch = buf[0] & 0x0F;
+
+	/* Return bytes written. */
+	return count;
+}
+
+static DEVICE_ATTR_RW(stretch);
+
+
+/* All attributes. */
+static struct attribute *w1_f19_attrs[] = {
+	&dev_attr_speed.attr,
+	&dev_attr_stretch.attr,
+	NULL,
+};
+
+static const struct attribute_group w1_f19_group = {
+	.attrs		= w1_f19_attrs,
+};
+
+static const struct attribute_group *w1_f19_groups[] = {
+	&w1_f19_group,
+	NULL,
+};
+
+
+/* Slave add and remove functions. */
+static int w1_f19_add_slave(struct w1_slave *sl)
+{
+	struct w1_f19_data *data = NULL;
+
+	/* Allocate memory for slave specific data. */
+	data = devm_kzalloc(&sl->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	sl->family_data = data;
+
+	/* Setup default I2C speed on slave. */
+	switch (i2c_speed) {
+	case 100:
+		__w1_f19_set_i2c_speed(sl, 0);
+		break;
+	case 400:
+		__w1_f19_set_i2c_speed(sl, 1);
+		break;
+	case 900:
+		__w1_f19_set_i2c_speed(sl, 2);
+		break;
+	default:
+		/*
+		 * A i2c_speed module parameter of anything else
+		 * than 100, 400, 900 means not to touch the
+		 * speed of the DS28E17.
+		 * We assume 400kBaud, the power-on value.
+		 */
+		data->speed = 1;
+	}
+
+	/*
+	 * Setup default busy stretch
+	 * configuration for the DS28E17.
+	 */
+	data->stretch = i2c_stretch;
+
+	/* Setup I2C adapter. */
+	data->adapter.owner      = THIS_MODULE;
+	data->adapter.algo       = &w1_f19_i2c_algorithm;
+	data->adapter.algo_data  = sl;
+	strcpy(data->adapter.name, "w1-");
+	strcat(data->adapter.name, sl->name);
+	data->adapter.dev.parent = &sl->dev;
+	data->adapter.quirks     = &w1_f19_i2c_adapter_quirks;
+
+	return i2c_add_adapter(&data->adapter);
+}
+
+static void w1_f19_remove_slave(struct w1_slave *sl)
+{
+	struct w1_f19_data *family_data = sl->family_data;
+
+	/* Delete I2C adapter. */
+	i2c_del_adapter(&family_data->adapter);
+
+	/* Free slave specific data. */
+	devm_kfree(&sl->dev, family_data);
+	sl->family_data = NULL;
+}
+
+
+/* Declarations within the w1 subsystem. */
+static struct w1_family_ops w1_f19_fops = {
+	.add_slave = w1_f19_add_slave,
+	.remove_slave = w1_f19_remove_slave,
+	.groups = w1_f19_groups,
+};
+
+static struct w1_family w1_family_19 = {
+	.fid = W1_FAMILY_DS28E17,
+	.fops = &w1_f19_fops,
+};
+
+
+/* Module init and remove functions. */
+static int __init w1_f19_init(void)
+{
+	return w1_register_family(&w1_family_19);
+}
+
+static void __exit w1_f19_fini(void)
+{
+	w1_unregister_family(&w1_family_19);
+}
+
+module_init(w1_f19_init);
+module_exit(w1_f19_fini);
+
diff --git a/drivers/w1/w1_family.h b/drivers/w1/w1_family.h
index 869a3ff..f675638 100644
--- a/drivers/w1/w1_family.h
+++ b/drivers/w1/w1_family.h
@@ -25,6 +25,7 @@
 #define W1_FAMILY_SMEM_81	0x81
 #define W1_FAMILY_DS2405	0x05
 #define W1_THERM_DS18S20 	0x10
+#define W1_FAMILY_DS28E17	0x19
 #define W1_FAMILY_DS28E04	0x1C
 #define W1_COUNTER_DS2423	0x1D
 #define W1_THERM_DS1822  	0x22
-- 
2.13.2
