From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 4/5] i2c: mv64xxx: directly call send_start when initializing transfer
Date: Thu, 13 Feb 2014 21:36:32 +0100
Message-ID: <1392323793-4125-5-git-send-email-wsa@the-dreams.de>
References: <20140213094117.GA3934@katana>
 <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392323793-4125-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Calling the state machine with a definite state which is only used in
this context is superfluous. Do it directly.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 9c37b59..3af5266 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -97,7 +97,6 @@ enum {
 enum {
 	MV64XXX_I2C_ACTION_INVALID,
 	MV64XXX_I2C_ACTION_CONTINUE,
-	MV64XXX_I2C_ACTION_SEND_START,
 	MV64XXX_I2C_ACTION_SEND_RESTART,
 	MV64XXX_I2C_ACTION_OFFLOAD_RESTART,
 	MV64XXX_I2C_ACTION_SEND_ADDR_1,
@@ -467,10 +466,6 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 			drv_data->reg_base + drv_data->reg_offsets.control);
 		break;
 
-	case MV64XXX_I2C_ACTION_SEND_START:
-		mv64xxx_i2c_send_start(drv_data);
-		break;
-
 	case MV64XXX_I2C_ACTION_SEND_ADDR_1:
 		writel(drv_data->addr1,
 			drv_data->reg_base + drv_data->reg_offsets.data);
@@ -628,12 +623,11 @@ mv64xxx_i2c_execute_msg(struct mv64xxx_i2c_data *drv_data, struct i2c_msg *msg,
 
 	spin_lock_irqsave(&drv_data->lock, flags);
 
-	drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
 	drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_START_COND;
 
 	drv_data->send_stop = is_last;
 	drv_data->block = 1;
-	mv64xxx_i2c_do_action(drv_data);
+	mv64xxx_i2c_send_start(drv_data);
 	spin_unlock_irqrestore(&drv_data->lock, flags);
 
 	mv64xxx_i2c_wait_for_completion(drv_data);
-- 
1.8.5.1
