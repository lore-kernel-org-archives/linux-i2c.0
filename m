From: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Subject: [PATCH] i2c-davinci: Fix use of default platform data if none supplied.
Date: Sat,  4 Sep 2010 12:07:48 -0400
Message-ID: <1283616468-6344-1-git-send-email-michael.williamson@criticallink.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, chaithrika-l0cyMroinI0@public.gmane.org, pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org, nageswari-l0cyMroinI0@public.gmane.org, dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There is a bug in the i2c-davinci device init routine that attempts
to use default platform data if none is supplied (e.g., is NULL).
This patch fixes the bug.

Signed-off-by: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 2222c87..6d4eeeb 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -235,10 +235,12 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
  */
 static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 {
-	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
+	struct davinci_i2c_platform_data *pdata;
 
-	if (!pdata)
-		pdata = &davinci_i2c_platform_data_default;
+	if (!dev->dev->platform_data)
+		dev->dev->platform_data = &davinci_i2c_platform_data_default;
+
+	pdata = dev->dev->platform_data;
 
 	/* put I2C into reset */
 	davinci_i2c_reset_ctrl(dev, 0);
-- 
1.7.0.4
