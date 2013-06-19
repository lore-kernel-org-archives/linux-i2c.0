From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH] i2c: mv64xxx: Fix transfer error code
Date: Wed, 19 Jun 2013 14:53:52 -0700
Message-ID: <1371678832-26889-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The driver returns -ENODEV as error code if it did not get an ACK
from the device. Per Documentation/i2c/fault-codes, it should
return -ENXIO.

Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 1a3abd6..6972032 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -227,7 +227,7 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)
 		/* Doesn't seem to be a device at other end */
 		drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
 		drv_data->state = MV64XXX_I2C_STATE_IDLE;
-		drv_data->rc = -ENODEV;
+		drv_data->rc = -ENXIO;
 		break;
 
 	default:
-- 
1.7.9.7
