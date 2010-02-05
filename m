From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-tiny-usb: Fix a comment on bus frequency
Date: Fri, 5 Feb 2010 18:42:07 +0100
Message-ID: <20100205184207.2fbb5e79@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Till Harbaum <Till-zicpKgigMvpAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The description of the delay parameter is incomplete, it suggests that
there is a direct relation between the delay value and the bus
frequency. In fact, due to additional delays in the i2c bitbanging
code, the i2c clock is always much slower.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Till Harbaum <Till-zicpKgigMvpAfugRpC6u6w@public.gmane.org>
---
 drivers/i2c/busses/i2c-tiny-usb.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- linux-2.6.33-rc6.orig/drivers/i2c/busses/i2c-tiny-usb.c	2010-02-05 18:34:53.000000000 +0100
+++ linux-2.6.33-rc6/drivers/i2c/busses/i2c-tiny-usb.c	2010-02-05 18:39:59.000000000 +0100
@@ -31,11 +31,13 @@
 #define CMD_I2C_IO_BEGIN	(1<<0)
 #define CMD_I2C_IO_END		(1<<1)
 
-/* i2c bit delay, default is 10us -> 100kHz */
+/* i2c bit delay, default is 10us -> 100kHz max
+   (in practice, due to additional delays in the i2c bitbanging
+   code this results in a i2c clock of about 50kHz) */
 static unsigned short delay = 10;
 module_param(delay, ushort, 0);
-MODULE_PARM_DESC(delay, "bit delay in microseconds, "
-		 "e.g. 10 for 100kHz (default is 100kHz)");
+MODULE_PARM_DESC(delay, "bit delay in microseconds "
+		 "(default is 10us for 100kHz max)");
 
 static int usb_read(struct i2c_adapter *adapter, int cmd,
 		    int value, int index, void *data, int len);

-- 
Jean Delvare
