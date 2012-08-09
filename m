From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH] i2c: (i2c-diolan-u2c) Fix master_xfer return code
Date: Thu,  9 Aug 2012 08:47:20 -0700
Message-ID: <1344527240-18266-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The master_xfer function returns 0 on success. It should return the number of
successful transactions.

Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-diolan-u2c.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i2c-diolan-u2c.c
index aedb94f..dae3ddf 100644
--- a/drivers/i2c/busses/i2c-diolan-u2c.c
+++ b/drivers/i2c/busses/i2c-diolan-u2c.c
@@ -405,6 +405,7 @@ static int diolan_usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 			}
 		}
 	}
+	ret = num;
 abort:
 	sret = diolan_i2c_stop(dev);
 	if (sret < 0 && ret >= 0)
-- 
1.7.9.7
