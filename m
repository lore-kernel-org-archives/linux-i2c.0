From: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: misplaced parentheses?
Date: Sun, 15 Feb 2009 17:16:52 +0100
Message-ID: <49983FF4.1000102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I think below is what was intended? otherwise we could as well have written:

msg[0].flags = flags || (read_write == I2C_SMBUS_READ) ? I2C_M_RD : 0;

please review.
-------------------------->8------------------8<---------------------------
Fix misplaced parentheses

Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index b1c9abe..2d34a7a 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1831,7 +1831,8 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter * adapter, u16 addr,
 	case I2C_SMBUS_QUICK:
 		msg[0].len = 0;
 		/* Special case: The read/write field is used as data */
-		msg[0].flags = flags | (read_write==I2C_SMBUS_READ)?I2C_M_RD:0;
+		msg[0].flags = flags | (read_write == I2C_SMBUS_READ ?
+				I2C_M_RD : 0);
 		num = 1;
 		break;
 	case I2C_SMBUS_BYTE:
