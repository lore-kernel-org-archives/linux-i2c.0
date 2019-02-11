From: John Sperbeck <jsperbeck@google.com>
Subject: [PATCH v2] i2c: core-smbus: don't trace smbus_reply data on errors
Date: Sun, 10 Feb 2019 19:40:21 -0800
Message-ID: <20190211034021.242932-1-jsperbeck@google.com>
References: <20190205190849.GA2686@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205190849.GA2686@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: jsperbeck@google.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, rostedt@goodmis.org
List-Id: linux-i2c@vger.kernel.org

If an smbus transfer fails, there's no guarantee that the output
buffer was written.  So, avoid trying to show the output buffer when
tracing after an error.  This was 'mostly harmless', but would trip
up kasan checking if left-over cruft in byte 0 is a large length,
causing us to read from unwritten memory.

Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 drivers/i2c/i2c-core-smbus.c | 2 +-
 include/trace/events/smbus.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 9cd66cabb84f..132119112596 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -585,7 +585,7 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 trace:
 	/* If enabled, the reply tracepoint is conditional on read_write. */
 	trace_smbus_reply(adapter, addr, flags, read_write,
-			  command, protocol, data);
+			  command, protocol, data, res);
 	trace_smbus_result(adapter, addr, flags, read_write,
 			   command, protocol, res);
 
diff --git a/include/trace/events/smbus.h b/include/trace/events/smbus.h
index d2fb6e1d3e10..a4892a187842 100644
--- a/include/trace/events/smbus.h
+++ b/include/trace/events/smbus.h
@@ -138,9 +138,9 @@ TRACE_EVENT_CONDITION(smbus_reply,
 	TP_PROTO(const struct i2c_adapter *adap,
 		 u16 addr, unsigned short flags,
 		 char read_write, u8 command, int protocol,
-		 const union i2c_smbus_data *data),
-	TP_ARGS(adap, addr, flags, read_write, command, protocol, data),
-	TP_CONDITION(read_write == I2C_SMBUS_READ),
+		 const union i2c_smbus_data *data, int res),
+	TP_ARGS(adap, addr, flags, read_write, command, protocol, data, res),
+	TP_CONDITION(res >= 0 && read_write == I2C_SMBUS_READ),
 	TP_STRUCT__entry(
 		__field(int,	adapter_nr		)
 		__field(__u16,	addr			)
-- 
2.20.1.791.gb4d0f1c61a-goog
