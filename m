From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Subject: [PATCH 1/13] include/linux/i2c.h: introduce macros for i2c_msg initialization
Date: Sun,  7 Oct 2012 17:38:31 +0200
Message-ID: <1349624323-15584-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1349624323-15584-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349624323-15584-1-git-send-email-Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shubhrajyoti-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>

This patch introduces some macros for describing how an i2c_msg is being
initialized.  There are three macros: I2C_MSG_READ, for a read message,
I2C_MSG_WRITE, for a write message, and I2C_MSG_OP, for some other kind of
message, which is expected to be very rarely used.

Signed-off-by: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>

---
 include/linux/i2c.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 94aed0c..885ebea 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -556,6 +556,12 @@ struct i2c_msg {
 	__u8 *buf;		/* pointer to msg data			*/
 };
 
+#define I2C_MSG_OP(_addr, _buf, _len, _flags) \
+	{ .addr = _addr, .buf = _buf, .len = _len, .flags = _flags }
+
+#define I2C_MSG_WRITE(addr, buf, len) I2C_MSG_OP(addr, buf, len, 0)
+#define I2C_MSG_READ(addr, buf, len)  I2C_MSG_OP(addr, buf, len, I2C_M_RD)
+
 /* To determine what functionality is present */
 
 #define I2C_FUNC_I2C			0x00000001
