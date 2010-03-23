From: Arnaud Patard <apatard-4qZELD6FgxhWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] i2c-imx: fix error handling
Date: Tue, 23 Mar 2010 17:28:28 +0100
Message-ID: <m3r5nbkno3.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--=-=-=



- Return -ETIMEDOUT on bus busy error
- Fix timeout test "time_after(jiffies, orig_jiffies + HZ / 1000)" :
  By default, HZ=100 on arm. This means that this test has no chances to
  work and may result in a dead loop. Set timeout to 500ms.
- Don't try to send a new message if we failed to transmit
  previous one. This was preventing to recover from error on my system

Signed-off-by: Arnaud Patard <apatard-4qZELD6FgxhWk0Htik3J/w@public.gmane.org>
---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=fix_i2c_imx_error_handling.patch

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 32375bd..ced8a38 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -145,10 +145,10 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 				"<%s> I2C Interrupted\n", __func__);
 			return -EINTR;
 		}
-		if (time_after(jiffies, orig_jiffies + HZ / 1000)) {
+		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> I2C bus is busy\n", __func__);
-			return -EIO;
+			return -ETIMEDOUT;
 		}
 		schedule();
 	}
@@ -443,6 +443,8 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 			result = i2c_imx_read(i2c_imx, &msgs[i]);
 		else
 			result = i2c_imx_write(i2c_imx, &msgs[i]);
+		if (result)
+			goto fail0;
 	}
 
 fail0:

--=-=-=--
