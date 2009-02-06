From: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Subject: [PATCH 1/2] i2c: add "reset" sysfs entry for adapters.
Date: Fri,  6 Feb 2009 16:23:17 +0100
Message-ID: <1233933798-17673-1-git-send-email-giometti@linux.it>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

It could happen that an i2c adapter may lock the bus due due
electrical problems, so the user may recover this stale state by using:

	$ echo 1 > /sys/class/i2c-adapter/i2c-0/reset

Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   21 +++++++++++++++++++++
 include/linux/i2c.h    |    2 ++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index b1c9abe..b0c4053 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -393,8 +393,29 @@ show_adapter_name(struct device *dev, struct device_attribute *attr, char *buf)
 	return sprintf(buf, "%s\n", adap->name);
 }
 
+static ssize_t
+write_adapter_reset(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct i2c_adapter *adap = to_i2c_adapter(dev);
+	unsigned long val;
+	int ret;
+
+	if (!adap->reset)
+		return -EINVAL;
+
+	ret = strict_strtoul(buf, 10, &val);
+	if (ret || val != 1)
+		return -EINVAL;
+
+	adap->reset(adap);
+
+	return count;
+}
+
 static struct device_attribute i2c_adapter_attrs[] = {
 	__ATTR(name, S_IRUGO, show_adapter_name, NULL),
+	__ATTR(reset, S_IWUSR, NULL, write_adapter_reset),
 	{ },
 };
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index fcfbfea..0f84345 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -369,6 +369,8 @@ struct i2c_adapter {
 	struct list_head clients;	/* DEPRECATED */
 	char name[48];
 	struct completion dev_released;
+
+	void (*reset)(struct i2c_adapter *);	/* user request adap reset */
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
-- 
1.5.6.3
