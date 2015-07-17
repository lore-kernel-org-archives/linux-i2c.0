From: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: [PATCH] i2c: viperboard: clean up inconsistent indenting
Date: Fri, 17 Jul 2015 13:01:23 +0100
Message-ID: <1437134483-18286-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>

Minor clean up of indenting, no functional change

Signed-off-by: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
---
 drivers/i2c/busses/i2c-viperboard.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-viperboard.c b/drivers/i2c/busses/i2c-viperboard.c
index 47e88ad..30cce15 100644
--- a/drivers/i2c/busses/i2c-viperboard.c
+++ b/drivers/i2c/busses/i2c-viperboard.c
@@ -391,11 +391,12 @@ static int vprbrd_i2c_probe(struct platform_device *pdev)
 			VPRBRD_USB_REQUEST_I2C_FREQ, VPRBRD_USB_TYPE_OUT,
 			0x0000, 0x0000, &vb_i2c->bus_freq_param, 1,
 			VPRBRD_USB_TIMEOUT_MS);
-	    if (ret != 1) {
-		dev_err(&pdev->dev,
-			"failure setting i2c_bus_freq to %d\n", i2c_bus_freq);
-		return -EIO;
-	    }
+		if (ret != 1) {
+			dev_err(&pdev->dev,
+				"failure setting i2c_bus_freq to %d\n",
+				i2c_bus_freq);
+			return -EIO;
+		}
 	} else {
 		dev_err(&pdev->dev,
 			"invalid i2c_bus_freq setting:%d\n", i2c_bus_freq);
-- 
2.1.4
