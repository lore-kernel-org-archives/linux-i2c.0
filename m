From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [RFC 01/11] i2c: add quirk structure to describe adapter flaws
Date: Fri,  9 Jan 2015 18:21:31 +0100
Message-ID: <1420824103-24169-2-git-send-email-wsa@the-dreams.de>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420824103-24169-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The number of I2C adapters which are not fully I2C compatible is rising,
sadly. Drivers usually do handle the flaws, still the user receives only
some errno for a transfer which normally can be expected to work. This
patch introduces a formal description of flaws. One advantage is that
the core can check before the actual transfer if the messages could be
transferred at all. This is done in the next patch. Another advantage is
that we can pass this information to the user so the restrictions are
exactly known and further actions can be based on that. This will be
done later after some stabilization period for this description.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 include/linux/i2c.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index e3a1721c8354..f8a642713706 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -447,6 +447,40 @@ int i2c_recover_bus(struct i2c_adapter *adap);
 int i2c_generic_gpio_recovery(struct i2c_adapter *adap);
 int i2c_generic_scl_recovery(struct i2c_adapter *adap);
 
+/**
+ * struct i2c_adapter_quirks - describe flaws of an i2c adapter
+ * @flags: see I2C_ADAPTER_QUIRK_* for possible flags
+ * @max_num_msgs: maximum number of messages per transfer
+ * @max_write_len: maximum length of a write message
+ * @max_read_len: maximum length of a read message
+ * @max_comb_write_len: maximum length of a write in a combined message
+ * @max_comb_read_len: maximum length of a read in a combined message
+ *
+ * Note about combined messages: Some I2C controllers can only send one
+ * message per transfer, plus something called combined message or
+ * write-then-read. This is a (usually) small write message followed by
+ * a read message and barely enough to access register based slaves like
+ * EEPROMs. There is a flag to support this mode. It implies max_num_msg = 2
+ * and does the length checks with max_comb_*_len because combined message mode
+ * usually has its own limitations. Read/write flags of the messages are also
+ * checked to be proper. Because of HW implementation, some controllers can
+ * actually do write-then-anything. To support that, write-then-read has been
+ * broken out into write-first and read-second.
+ */
+struct i2c_adapter_quirks {
+	u64 flags;
+	int max_num_msgs;
+	u16 max_write_len;
+	u16 max_read_len;
+	u16 max_comb_write_len;
+	u16 max_comb_read_len;
+};
+
+#define I2C_ADAPTER_QUIRK_COMB_WRITE_FIRST	BIT(0)
+#define I2C_ADAPTER_QUIRK_COMB_READ_SECOND	BIT(1)
+#define I2C_ADAPTER_QUIRK_COMB_WRITE_THEN_READ	(I2C_ADAPTER_QUIRK_COMB_WRITE_FIRST | \
+						I2C_ADAPTER_QUIRK_COMB_READ_SECOND)
+
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
@@ -472,6 +506,7 @@ struct i2c_adapter {
 	struct list_head userspace_clients;
 
 	struct i2c_bus_recovery_info *bus_recovery_info;
+	struct i2c_adapter_quirks *quirks;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
-- 
2.1.3
