From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: slave: add 8 bit seconds counter backend
Date: Mon, 19 Oct 2015 22:09:53 +0200
Message-ID: <1445285393-3478-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36522 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754493AbbJSUKK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 19 Oct 2015 16:10:10 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Something simple to show and explain at ELCE15. Not for inclusion!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

As promised, here is the driver from my talk. Educational only!

 drivers/i2c/Kconfig                |  3 ++
 drivers/i2c/Makefile               |  1 +
 drivers/i2c/i2c-slave-8bitseccnt.c | 66 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 drivers/i2c/i2c-slave-8bitseccnt.c

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 78fbee46362828..c43e00e88b86a3 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -118,6 +118,9 @@ if I2C_SLAVE
 config I2C_SLAVE_EEPROM
 	tristate "I2C eeprom slave driver"
 
+config I2C_SLAVE_8BIT_SEC_CNT
+	tristate "I2C 8 bit second counter slave driver"
+
 endif
 
 config I2C_DEBUG_CORE
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 45095b3d16a914..19e8be1020865a 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_MUX)		+= i2c-mux.o
 obj-y				+= algos/ busses/ muxes/
 obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
+obj-$(CONFIG_I2C_SLAVE_8BIT_SEC_CNT)	+= i2c-slave-8bitseccnt.o
 obj-$(CONFIG_I2C_SLAVE_EEPROM)	+= i2c-slave-eeprom.o
 
 ccflags-$(CONFIG_I2C_DEBUG_CORE) := -DDEBUG
diff --git a/drivers/i2c/i2c-slave-8bitseccnt.c b/drivers/i2c/i2c-slave-8bitseccnt.c
new file mode 100644
index 00000000000000..6049989523de6c
--- /dev/null
+++ b/drivers/i2c/i2c-slave-8bitseccnt.c
@@ -0,0 +1,66 @@
+/*
+ * I2C slave mode 8 bit seconds counter backend :)
+ *
+ * Copyright (C) 2015 by Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
+ * Copyright (C) 2015 by Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/timekeeping.h>
+
+static int i2c_slave_8bit_seconds_slave_cb(struct i2c_client *client,
+				     enum i2c_slave_event event, u8 *val)
+{
+	switch (event) {
+	case I2C_SLAVE_READ_REQUESTED:
+	case I2C_SLAVE_READ_PROCESSED:
+		/* Always get the most recent value */
+		*val = get_seconds() & 0xff;
+		break;
+
+	case I2C_SLAVE_WRITE_REQUESTED:
+	case I2C_SLAVE_WRITE_RECEIVED:
+	case I2C_SLAVE_STOP:
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int i2c_slave_8bit_seconds_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	return i2c_slave_register(client, i2c_slave_8bit_seconds_slave_cb);
+};
+
+static int i2c_slave_8bit_seconds_remove(struct i2c_client *client)
+{
+	i2c_slave_unregister(client);
+	return 0;
+}
+
+static const struct i2c_device_id i2c_slave_8bit_seconds_id[] = {
+	{ "slave-8bit_seconds", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, i2c_slave_8bit_seconds_id);
+
+static struct i2c_driver i2c_slave_8bit_seconds_driver = {
+	.driver = {
+		.name = "i2c-slave-8bit_seconds",
+	},
+	.probe = i2c_slave_8bit_seconds_probe,
+	.remove = i2c_slave_8bit_seconds_remove,
+	.id_table = i2c_slave_8bit_seconds_id,
+};
+module_i2c_driver(i2c_slave_8bit_seconds_driver);
+
+MODULE_AUTHOR("Wolfram Sang <wsa@sang-engineering.com>");
+MODULE_DESCRIPTION("I2C slave mode 8 bit seconds counter backend");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4
