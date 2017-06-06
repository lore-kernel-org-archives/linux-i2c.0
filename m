From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 1/4] i2c: add helper to determine if DMA is favoured
Date: Tue,  6 Jun 2017 11:20:31 +0200
Message-ID: <20170606092034.1516-2-wsa+renesas@sang-engineering.com>
References: <20170606092034.1516-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55289 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751246AbdFFJUr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 6 Jun 2017 05:20:47 -0400
In-Reply-To: <20170606092034.1516-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

We not only check if the buffer is DMA capable. We also require a
threshold value to see if it makes sense to setup DMA. Since most
I2C transactions are small, the cost for DMA might be too high.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/i2c.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 72d0ece70ed30d..f0b835ba2ecd10 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -34,6 +34,8 @@
 #include <linux/irqdomain.h>		/* for Host Notify IRQ */
 #include <linux/of.h>		/* for struct device_node */
 #include <linux/swab.h>		/* for swab16 */
+#include <linux/mm.h>
+#include <linux/sched/task_stack.h>
 #include <uapi/linux/i2c.h>
 
 extern struct bus_type i2c_bus_type;
@@ -764,6 +766,33 @@ static inline u8 i2c_8bit_addr_from_msg(const struct i2c_msg *msg)
 	return (msg->addr << 1) | (msg->flags & I2C_M_RD ? 1 : 0);
 }
 
+/**
+ * i2c_check_msg_for_dma() - check if a message is suitable for DMA
+ * @msg: the message to be checked
+ * @dma_threshold: the amount of byte from which using DMA makes sense
+ *
+ * Return: -ERANGE if message is smaller than threshold
+ * 	   -EFAULT if message buffer is not DMA capable
+ * 	   0 if message is suitable for DMA
+ *
+ * Note: This function should only be called from process context! It uses
+ * helper functions which work on the 'current' task.
+ */
+static inline int i2c_check_msg_for_dma(struct i2c_msg *msg, unsigned int dma_threshold)
+{
+	if (msg->len < dma_threshold)
+		return -ERANGE;
+
+#if !defined(CONFIG_DMA_API_DEBUG)
+	if (!virt_addr_valid(msg->buf) || object_is_on_stack(msg->buf)) {
+		pr_debug("msg buffer to 0x%04x might not be DMA capable\n",
+			 msg->addr);
+		return -EFAULT;
+	}
+#endif
+	return 0;
+}
+
 int i2c_handle_smbus_host_notify(struct i2c_adapter *adap, unsigned short addr);
 /**
  * module_i2c_driver() - Helper macro for registering a modular I2C driver
-- 
2.11.0
