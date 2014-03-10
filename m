From: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
Subject: [PATCH] i2c-cadence: Do not let signals interrupt I2C transfers
Date: Mon, 10 Mar 2014 12:12:34 +0100
Message-ID: <1394449954-10797-1-git-send-email-mike.looijmans@topic.nl>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: git-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Pressing CTRL-C while communicating with an I2C device leads to erratic
behaviour. The cause is that the controller will interrupt the I2C transfer
in progress, and leave the client device in an undefined state. Many
drivers do not handle error return codes on I2C transfers. The calling driver
has no way of telling how much of the transfer has actually completed, so
it cannot reliably determine the device's state.

The best solution here is to not handle signals in the I2C bus driver at all,
but always complete a transaction before returning control.

See for a related patch and discussion on this topic:
http://lkml.org/lkml/2014/1/9/246
---
 drivers/i2c/busses/i2c-cadence.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 86713d6..32ce2ee 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -452,16 +452,12 @@ static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
 			cdns_i2c_msend(id);
 
 		/* Wait for the signal of completion */
-		ret = wait_for_completion_interruptible_timeout(
-							&id->xfer_done, HZ);
-		if (ret < 1) {
+		ret = wait_for_completion_timeout(&id->xfer_done, HZ);
+		if (ret == 0) {
 			cdns_i2c_master_reset(adap);
-			if (!ret) {
-				dev_err(id->adap.dev.parent,
+			dev_err(id->adap.dev.parent,
 					"timeout waiting on completion\n");
-				return -ETIMEDOUT;
-			}
-			return ret;
+			return -ETIMEDOUT;
 		}
 		cdns_i2c_writereg(CDNS_I2C_IXR_ALL_INTR_MASK,
 				  CDNS_I2C_IDR_OFFSET);
-- 
1.7.9.5
