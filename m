From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] i2c: designware: prevent signals from aborting I2C transfers
Date: Wed, 22 May 2013 13:03:11 +0300
Message-ID: <1369216991-13334-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

If a process receives signal while it is waiting for I2C transfer to
complete, an error is returned to the caller and the transfer is aborted.
This can cause the driver to fail subsequent transfers. Also according to
commit d295a86eab2 (i2c: mv64xxx: work around signals causing I2C
transactions to be aborted) I2C drivers aren't supposed to abort
transactions on signals.

To prevent this switch to use wait_for_completion_timeout() instead of
wait_for_completion_interruptible_timeout() in the designware I2C driver.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index c41ca63..db20a28 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -580,14 +580,13 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	i2c_dw_xfer_init(dev);
 
 	/* wait for tx to complete */
-	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete, HZ);
+	ret = wait_for_completion_timeout(&dev->cmd_complete, HZ);
 	if (ret == 0) {
 		dev_err(dev->dev, "controller timed out\n");
 		i2c_dw_init(dev);
 		ret = -ETIMEDOUT;
 		goto done;
-	} else if (ret < 0)
-		goto done;
+	}
 
 	if (dev->msg_err) {
 		ret = dev->msg_err;
-- 
1.7.10.4
