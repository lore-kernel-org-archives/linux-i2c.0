From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/4] i2c: add helpers to ease DMA handling
Date: Thu, 15 Jun 2017 20:30:36 +0200
Message-ID: <20170615183039.22925-2-wsa+renesas@sang-engineering.com>
References: <20170615183039.22925-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:38205 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752640AbdFOSa7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 15 Jun 2017 14:30:59 -0400
In-Reply-To: <20170615183039.22925-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>

One helper checks if DMA is suitable and optionally creates a bounce
buffer, if not. The other function returns the bounce buffer and makes
sure the data is properly copied back to the message.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 include/linux/i2c.h | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 72d0ece70ed30d..7204d38eaff07c 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -33,7 +33,10 @@
 #include <linux/rtmutex.h>
 #include <linux/irqdomain.h>		/* for Host Notify IRQ */
 #include <linux/of.h>		/* for struct device_node */
+#include <linux/slab.h>
 #include <linux/swab.h>		/* for swab16 */
+#include <linux/mm.h>
+#include <linux/sched/task_stack.h>
 #include <uapi/linux/i2c.h>
 
 extern struct bus_type i2c_bus_type;
@@ -764,6 +767,68 @@ static inline u8 i2c_8bit_addr_from_msg(const struct i2c_msg *msg)
 	return (msg->addr << 1) | (msg->flags & I2C_M_RD ? 1 : 0);
 }
 
+/**
+ * i2c_check_msg_for_dma - check if a message is suitable for DMA
+ * @msg: the message to be checked
+ * @threshold: the amount of byte from which using DMA makes sense
+ * @ptr_for_bounce_buf: if not NULL, a bounce buffer will be attached to this
+ *			ptr, if needed. The bounce buffer must be freed by the
+ *			caller using i2c_release_bounce_buf().
+ *
+ * Return: -ERANGE if message is smaller than threshold
+ *	   -EFAULT if message buffer is not DMA capable and no bounce buffer
+ *		   was requested
+ *	   -ENOMEM if a bounce buffer could not be created
+ *	   0 if message is suitable for DMA
+ *
+ * Note: This function should only be called from process context! It uses
+ * helper functions which work on the 'current' task.
+ */
+static inline int i2c_check_msg_for_dma(struct i2c_msg *msg, unsigned int threshold,
+					u8 **ptr_for_bounce_buf)
+{
+	if (ptr_for_bounce_buf)
+		*ptr_for_bounce_buf = NULL;
+
+	if (msg->len < threshold)
+		return -ERANGE;
+
+	if (!virt_addr_valid(msg->buf) || object_is_on_stack(msg->buf)) {
+		pr_debug("msg buffer to 0x%04x is not DMA safe%s\n", msg->addr,
+			 ptr_for_bounce_buf ? ", trying bounce buffer" : "");
+		if (ptr_for_bounce_buf) {
+			if (msg->flags & I2C_M_RD)
+				*ptr_for_bounce_buf = kzalloc(msg->len, GFP_KERNEL);
+			else
+				*ptr_for_bounce_buf = kmemdup(msg->buf, msg->len,
+							      GFP_KERNEL);
+			if (!*ptr_for_bounce_buf)
+				return -ENOMEM;
+		} else {
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * i2c_release_bounce_buf - copy data back from bounce buffer and release it
+ * @msg: the message to be copied back to
+ * @bounce_buf: the bounce buffer obtained from i2c_check_msg_for_dma().
+ *		May be NULL.
+ */
+static inline void i2c_release_bounce_buf(struct i2c_msg *msg, u8 *bounce_buf)
+{
+	if (!bounce_buf)
+		return;
+
+	if (msg->flags & I2C_M_RD)
+		memcpy(msg->buf, bounce_buf, msg->len);
+
+	kfree(bounce_buf);
+}
+
 int i2c_handle_smbus_host_notify(struct i2c_adapter *adap, unsigned short addr);
 /**
  * module_i2c_driver() - Helper macro for registering a modular I2C driver
-- 
2.11.0
