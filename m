From: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Subject: [PATCH 1/1] i2c pxa: try to reset controller if the bus is busy for too long.
Date: Wed, 18 Feb 2009 15:11:07 +0100
Message-ID: <1234966267-12458-1-git-send-email-giometti@linux.it>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index e29bde1..7dbe4dd 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -669,14 +669,22 @@ out:
 static int i2c_pxa_do_xfer(struct pxa_i2c *i2c, struct i2c_msg *msg, int num)
 {
 	long timeout;
+	int try_reset = 1;
 	int ret;
 
 	/*
 	 * Wait for the bus to become free.
 	 */
+retry:
 	ret = i2c_pxa_wait_bus_not_busy(i2c);
 	if (ret) {
 		dev_err(&i2c->adap.dev, "i2c_pxa: timeout waiting for bus free\n");
+		if (try_reset--) {
+			dev_info(&i2c->adap.dev, "i2c_pxa: controller reset\n");
+			i2c_pxa_reset(i2c);
+			goto retry;
+		}
+
 		goto out;
 	}
 
-- 
1.5.6.3
