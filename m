From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH v2] i2c: img-scb: fixup of wait_for_completion_timeout return handling
Date: Mon,  9 Feb 2015 10:15:21 -0500
Message-ID: <1423494921-2708-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Return type of wait_for_completion_timeout is unsigned long not int. 
Appropriately typed/named variable are added and assignment fixed up.

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

v2: int ret is an idiom - thus rather than just changing the type, rename
    the variable, as suggested by Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>.

Patch was compile tested with x86_64_defconfig + CONFIG_COMPILE_TEST=y
CONFIG_I2C_IMG=m

Patch is against 3.19.0-rc7 (localversion-next is -next-20150209)

 drivers/i2c/busses/i2c-img-scb.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 0fcc169..6e4e990 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -988,15 +988,16 @@ out:
 static int img_i2c_reset_bus(struct img_i2c *i2c)
 {
 	unsigned long flags;
-	int ret;
+	unsigned long timeout;
 
 	spin_lock_irqsave(&i2c->lock, flags);
 	reinit_completion(&i2c->msg_complete);
 	img_i2c_reset_start(i2c);
 	spin_unlock_irqrestore(&i2c->lock, flags);
 
-	ret = wait_for_completion_timeout(&i2c->msg_complete, IMG_I2C_TIMEOUT);
-	if (ret == 0)
+	timeout = wait_for_completion_timeout(&i2c->msg_complete,
+					      IMG_I2C_TIMEOUT);
+	if (timeout == 0)
 		return -ETIMEDOUT;
 	return 0;
 }
@@ -1007,6 +1008,7 @@ static int img_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	struct img_i2c *i2c = i2c_get_adapdata(adap);
 	bool atomic = false;
 	int i, ret;
+	unsigned long timeout;
 
 	if (i2c->mode == MODE_SUSPEND) {
 		WARN(1, "refusing to service transaction in suspended state\n");
@@ -1068,11 +1070,11 @@ static int img_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			img_i2c_write(i2c);
 		spin_unlock_irqrestore(&i2c->lock, flags);
 
-		ret = wait_for_completion_timeout(&i2c->msg_complete,
-						  IMG_I2C_TIMEOUT);
+		timeout = wait_for_completion_timeout(&i2c->msg_complete,
+						      IMG_I2C_TIMEOUT);
 		del_timer_sync(&i2c->check_timer);
 
-		if (ret == 0) {
+		if (timeout == 0) {
 			dev_err(adap->dev.parent, "i2c transfer timed out\n");
 			i2c->msg_status = -ETIMEDOUT;
 			break;
-- 
1.7.10.4
