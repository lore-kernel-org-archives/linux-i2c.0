From: Dimitris Papastamos <dp-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH] drivers: i2c-core: Add trace events for i2c/smbus transfer functions
Date: Fri, 28 Jan 2011 14:31:14 +0000
Message-ID: <1296225074-26809-1-git-send-email-dp@opensource.wolfsonmicro.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add basic trace events for i2c_transfer() and i2c_smbus_xfer() so we
can observe the I2C/SMBus activity without filling up the dmesg ring buffer.

Signed-off-by: Dimitris Papastamos <dp-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 drivers/i2c/i2c-core.c     |    8 ++++-
 include/trace/events/i2c.h |   70 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletions(-)
 create mode 100644 include/trace/events/i2c.h

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index f0bd5bc..848f0fc 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -42,6 +42,8 @@
 
 #include "i2c-core.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/i2c.h>
 
 /* core_lock protects i2c_adapter_idr, and guarantees
    that device detection, deletion of detected devices, and attach_adapter
@@ -1289,7 +1291,7 @@ module_exit(i2c_exit);
 int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	unsigned long orig_jiffies;
-	int ret, try;
+	int ret, try, i;
 
 	/* REVISIT the fault reporting model here is weak:
 	 *
@@ -1330,6 +1332,8 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		/* Retry automatically on arbitration loss */
 		orig_jiffies = jiffies;
 		for (ret = 0, try = 0; try <= adap->retries; try++) {
+			for (i = 0; i < num; i++)
+				trace_i2c_transfer(adap->name, &msgs[i]);
 			ret = adap->algo->master_xfer(adap, msgs, num);
 			if (ret != -EAGAIN)
 				break;
@@ -2089,6 +2093,8 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
 		/* Retry automatically on arbitration loss */
 		orig_jiffies = jiffies;
 		for (res = 0, try = 0; try <= adapter->retries; try++) {
+			trace_i2c_smbus_xfer(adapter->name, addr, flags,
+					     read_write, command, protocol);
 			res = adapter->algo->smbus_xfer(adapter, addr, flags,
 							read_write, command,
 							protocol, data);
diff --git a/include/trace/events/i2c.h b/include/trace/events/i2c.h
new file mode 100644
index 0000000..2c1fb9b
--- /dev/null
+++ b/include/trace/events/i2c.h
@@ -0,0 +1,70 @@
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
+TRACE_EVENT(i2c_transfer,
+
+	TP_PROTO(const char *name, struct i2c_msg *msg),
+
+	TP_ARGS(name, msg),
+
+	TP_STRUCT__entry(
+		__string(	name,	name	)
+		__field(	u16,	addr	)
+		__field(	u16,	len	)
+		__field(	u16,	flags	)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->addr = msg->addr;
+		__entry->len = msg->len;
+		__entry->flags = msg->flags;
+	),
+
+	TP_printk("name=%s addr=%#x len=%#x flags=%#x", __get_str(name),
+		  (u16)__entry->addr, (u16)__entry->len, (u16)__entry->flags)
+);
+
+TRACE_EVENT(i2c_smbus_xfer,
+
+	TP_PROTO(const char *name, u16 addr, unsigned short flags,
+		 char read_write, u8 command, int protocol),
+
+	TP_ARGS(name, addr, flags, read_write, command, protocol),
+
+	TP_STRUCT__entry(
+		__string(	name,		name		)
+		__field(	u16,		addr		)
+		__field(	unsigned short,	flags		)
+		__field(	char,		read_write	)
+		__field(	u8,		command		)
+		__field(	int,		protocol	)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->addr = addr;
+		__entry->flags = flags;
+		__entry->read_write = read_write;
+		__entry->command = command;
+		__entry->protocol = protocol;
+	),
+
+	TP_printk("name=%s addr=%#x flags=%#x read_write=%#x command=%#x protocol=%#x",
+		  __get_str(name), (u16)__entry->addr,
+		  (unsigned short)__entry->flags, (char)__entry->read_write,
+		  (u8)__entry->command, (int)__entry->protocol)
+);
+
+#endif /* _TRACE_I2C_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.7.3.5
