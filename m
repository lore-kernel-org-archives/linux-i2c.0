From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] i2c: img-scb: match return type of wait_for_completion_timeout
Date: Sun,  8 Feb 2015 08:12:35 -0500
Message-ID: <1423401155-8955-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Return type of wait_for_completion_timeout is unsigned long not int. ret in 
img_i2c_reset_bus() was exclusively used for wait_for_completion_timeout so 
its type is simply adjusted. In img_i2c_xfer an appropriately typed variable
is added and assignment fixed up.

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

Patch was compile tested with x86_64_defconfig + CONFIG_COMPILE_TEST=y
CONFIG_I2C_IMG=m

Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)

 drivers/i2c/busses/i2c-img-scb.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 0fcc169..4f3a153 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -988,7 +988,7 @@ out:
 static int img_i2c_reset_bus(struct img_i2c *i2c)
 {
 	unsigned long flags;
-	int ret;
+	unsigned long ret;
 
 	spin_lock_irqsave(&i2c->lock, flags);
 	reinit_completion(&i2c->msg_complete);
@@ -1007,6 +1007,7 @@ static int img_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	struct img_i2c *i2c = i2c_get_adapdata(adap);
 	bool atomic = false;
 	int i, ret;
+	unsigned long timeout;
 
 	if (i2c->mode == MODE_SUSPEND) {
 		WARN(1, "refusing to service transaction in suspended state\n");
@@ -1068,11 +1069,11 @@ static int img_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
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
