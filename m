From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: [PATCH] i2c-EEPROM: In kernel memory accessor interface
Date: Mon,  7 Jan 2013 19:10:33 +0200
Message-ID: <1357578633-15920-1-git-send-email-panto@antoniou-consulting.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In kernel users need to access the EEPROM using the i2c_client
interface. Extend at24 to use it via the command interface.

Signed-off-by: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
---
 drivers/misc/eeprom/at24.c | 23 ++++++++++++++++++
 include/linux/i2c/eeprom.h | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)
 create mode 100644 include/linux/i2c/eeprom.h

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2baeec5..40b1a95 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
+#include <linux/i2c/eeprom.h>
 
 /*
  * I2C EEPROMs from most vendors are inexpensive and mostly interchangeable.
@@ -672,6 +673,27 @@ static int at24_remove(struct i2c_client *client)
 	return 0;
 }
 
+static int at24_command(struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	struct at24_data *at24;
+	const struct memory_accessor **maccp;
+
+	/* only supporting a single command */
+	if (cmd != I2C_EEPROM_GET_MEMORY_ACCESSOR)
+		return -ENOTSUPP;
+
+	/* rudimentary check */
+	if (arg == NULL)
+		return -EINVAL;
+
+	at24 = i2c_get_clientdata(client);
+
+	maccp = arg;
+	*maccp = &at24->macc;
+
+	return 0;
+}
+
 /*-------------------------------------------------------------------------*/
 
 static struct i2c_driver at24_driver = {
@@ -682,6 +704,7 @@ static struct i2c_driver at24_driver = {
 	.probe = at24_probe,
 	.remove = at24_remove,
 	.id_table = at24_ids,
+	.command = at24_command,
 };
 
 static int __init at24_init(void)
diff --git a/include/linux/i2c/eeprom.h b/include/linux/i2c/eeprom.h
new file mode 100644
index 0000000..1393980
--- /dev/null
+++ b/include/linux/i2c/eeprom.h
@@ -0,0 +1,59 @@
+/*
+ * i2c/eeprom.h
+ *
+ * In-kernel interface for accessing eeprom memory.
+ *
+ * Copyright (C) 2012 Texas Instruments Inc.
+ *                    Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef I2C_EEPROM_H
+#define I2C_EEPROM_H
+
+#include <linux/types.h>
+#include <linux/memory.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+
+/*
+ * The method called in the client is
+ *
+ * int command(struct i2c_client *client, unsigned int cmd, void *arg);
+ *
+ * A single command is supported, which returns a pointer to the memory
+ * accessor already available, but which was only accessible via platform
+ * callbacks. We can't use platform callbacks anymore for device tree
+ * platforms, hence this interface.
+ *
+ */
+
+/* interface commands */
+#define I2C_EEPROM_GET_MEMORY_ACCESSOR	1
+
+static inline struct memory_accessor *
+i2c_eeprom_get_memory_accessor(struct i2c_client *client)
+{
+	int ret;
+	struct memory_accessor *macc;
+
+	/* verify that the i2c client's driver has a command method */
+	if (!client || !client->driver || !client->driver->command)
+		return ERR_PTR(-ENOTSUPP);
+
+	macc = NULL;
+	ret = client->driver->command(client, I2C_EEPROM_GET_MEMORY_ACCESSOR,
+			&macc);
+	if (ret != 0)
+		return ERR_PTR(ret);
+
+	if (macc == NULL)
+		return ERR_PTR(-ENOTSUPP);
+
+	return macc;
+}
+
+#endif
-- 
1.7.12
