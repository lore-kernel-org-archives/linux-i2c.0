From: Dimitris Papastamos <dp-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH] drivers: i2c-core: Add trace events for i2c_master_send()/i2c_master_recv()
Date: Thu, 27 Jan 2011 11:01:06 +0000
Message-ID: <1296126066-15951-1-git-send-email-dp@opensource.wolfsonmicro.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add basic trace events for i2c_master_send() and i2c_master_recv() so we
can observe the I2C activity without filling up the dmesg ring buffer.  It
also makes it easy to enable and disable tracing of the i2c-core.

Signed-off-by: Dimitris Papastamos <dp-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 drivers/i2c/i2c-core.c     |    4 +++
 include/trace/events/i2c.h |   55 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 include/trace/events/i2c.h

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index f0bd5bc..2c2bb45 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -42,6 +42,8 @@
 
 #include "i2c-core.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/i2c.h>
 
 /* core_lock protects i2c_adapter_idr, and guarantees
    that device detection, deletion of detected devices, and attach_adapter
@@ -1366,6 +1368,7 @@ int i2c_master_send(const struct i2c_client *client, const char *buf, int count)
 	msg.buf = (char *)buf;
 
 	ret = i2c_transfer(adap, &msg, 1);
+	trace_i2c_master_send(&msg, ret);
 
 	/* If everything went ok (i.e. 1 msg transmitted), return #bytes
 	   transmitted, else error code. */
@@ -1394,6 +1397,7 @@ int i2c_master_recv(const struct i2c_client *client, char *buf, int count)
 	msg.buf = buf;
 
 	ret = i2c_transfer(adap, &msg, 1);
+	trace_i2c_master_recv(&msg, ret);
 
 	/* If everything went ok (i.e. 1 msg transmitted), return #bytes
 	   transmitted, else error code. */
diff --git a/include/trace/events/i2c.h b/include/trace/events/i2c.h
new file mode 100644
index 0000000..cdf64e8
--- /dev/null
+++ b/include/trace/events/i2c.h
@@ -0,0 +1,55 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM i2c
+
+#if !defined(_TRACE_I2C_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_I2C_H
+
+#include <linux/ktime.h>
+#include <linux/tracepoint.h>
+
+struct i2c_msg;
+
+DECLARE_EVENT_CLASS(i2c_master,
+
+	TP_PROTO(struct i2c_msg *msg, int ret),
+
+	TP_ARGS(msg, ret),
+
+	TP_STRUCT__entry(
+		__field(	u16,	addr	)
+		__field(	u16,	len	)
+		__field(	u16,	flags	)
+		__field(	int,	ret	)
+	),
+
+	TP_fast_assign(
+		__entry->addr = msg->addr;
+		__entry->len = msg->len;
+		__entry->flags = msg->flags;
+		__entry->ret = ret;
+	),
+
+	TP_printk("addr=%x len=%x flags=%x ret=%d", (u16)__entry->addr,
+		  (u16)__entry->len, (u16)__entry->flags, (int)__entry->ret)
+);
+
+DEFINE_EVENT(i2c_master, i2c_master_send,
+
+	TP_PROTO(struct i2c_msg *msg, int ret),
+
+	TP_ARGS(msg, ret)
+
+);
+
+DEFINE_EVENT(i2c_master, i2c_master_recv,
+
+	TP_PROTO(struct i2c_msg *msg, int ret),
+
+	TP_ARGS(msg, ret)
+
+);
+
+#endif /* _TRACE_I2C_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.7.3.5
