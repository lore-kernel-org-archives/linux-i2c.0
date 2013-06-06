From: Bin Gao <bin.gao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: i2c: introduce i2c helper i2c_find_client_by_name()
Date: Thu, 6 Jun 2013 11:33:46 -0700
Message-ID: <20130606183346.GA13259@bingao-desk1.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

i2c: introduce i2c helper i2c_find_client_by_name()

There is a requirement to get the i2c_client pointer dynamically without
knowing the bus and slave address. But we do know the client name,
i.e. the name in the i2c_board_info. This patch is to fit this requirement.

A good example is that an ISP(Imaging Signal Processor) driver needs
register i2c camera sensor devices via v4l2, so it has to unregister
all i2c clients that were previously registered by calling
i2c_register_board_info(), and then re-register. For this case we
can use this helper to get i2c_client by passing the client name.

Signed-off-by: Bin Gao <bin.gao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   17 +++++++++++++++++
 include/linux/i2c.h    |    1 +
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 48e31ed..17683de6 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2326,6 +2326,23 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
 }
 EXPORT_SYMBOL(i2c_smbus_xfer);
 
+static int match_name(struct device *dev, void *data)
+{
+	const char *name = data;
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return !strncmp(client->name, name, strlen(client->name));
+}
+
+struct i2c_client *i2c_find_client_by_name(char *name)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&i2c_bus_type, NULL, name, match_name);
+	return dev ? to_i2c_client(dev) : NULL;
+}
+EXPORT_SYMBOL_GPL(i2c_find_client_by_name);
+
 MODULE_AUTHOR("Simon G. Vogl <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>");
 MODULE_DESCRIPTION("I2C-Bus main module");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index e988fa9..7d8bf02 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -509,6 +509,7 @@ extern void i2c_clients_command(struct i2c_adapter *adap,
 extern struct i2c_adapter *i2c_get_adapter(int nr);
 extern void i2c_put_adapter(struct i2c_adapter *adap);
 
+extern struct i2c_client *i2c_find_client_by_name(char *name);
 
 /* Return the functionality mask */
 static inline u32 i2c_get_functionality(struct i2c_adapter *adap)
-- 
1.7.4.4
