From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] i2c: designware: fix race between subsequent xfers
Date: Thu,  6 Jun 2013 15:43:35 +0200
Message-ID: <1370526216-10060-1-git-send-email-christian.ruppert@abilis.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The designware block is not always properly disabled in the case of
transfer errors. Interrupts from aborted transfers might be handled
after the data structures for the following transfer are initialised but
before the hardware is set up. This might corrupt the data structures to
the point that the system is stuck in an infinite interrupt loop (where
FIFOs are never emptied).
This patch cleanly disables the designware-i2c hardware at the end of
every transfer, successful or not.

Signed-off-by: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 6c0e776..65c0c7a 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -588,10 +588,20 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete, HZ);
 	if (ret == 0) {
 		dev_err(dev->dev, "controller timed out\n");
+		/* i2c_dw_init implicitly disables the adapter */
 		i2c_dw_init(dev);
 		ret = -ETIMEDOUT;
 		goto done;
-	} else if (ret < 0)
+	}
+
+	/*
+	 * We must disable the adapter before unlocking the &dev->lock mutex
+	 * below. Otherwise the hardware might continue generating interrupts
+	 * which in turn causes a race condition with the following transfer.
+	 */
+	__i2c_dw_enable(dev, false);
+
+	if (ret < 0)
 		goto done;
 
 	if (dev->msg_err) {
@@ -601,8 +611,6 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	/* no error */
 	if (likely(!dev->cmd_err)) {
-		/* Disable the adapter */
-		__i2c_dw_enable(dev, false);
 		ret = num;
 		goto done;
 	}
-- 
1.7.1
