From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 5/5] i2c: mv64xxx: refactor initialization for new msgs
Date: Thu, 13 Feb 2014 21:36:33 +0100
Message-ID: <1392323793-4125-6-git-send-email-wsa@the-dreams.de>
References: <20140213094117.GA3934@katana>
 <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392323793-4125-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

We now have a central place to put this code to.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 3af5266..be4b0a1 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -175,11 +175,6 @@ mv64xxx_i2c_prepare_for_io(struct mv64xxx_i2c_data *drv_data,
 {
 	u32	dir = 0;
 
-	drv_data->msg = msg;
-	drv_data->byte_posn = 0;
-	drv_data->bytes_left = msg->len;
-	drv_data->aborting = 0;
-	drv_data->rc = 0;
 	drv_data->cntl_bits = MV64XXX_I2C_REG_CONTROL_ACK |
 		MV64XXX_I2C_REG_CONTROL_INTEN | MV64XXX_I2C_REG_CONTROL_TWSIEN;
 
@@ -205,11 +200,6 @@ static int mv64xxx_i2c_offload_msg(struct mv64xxx_i2c_data *drv_data)
 	if (!drv_data->offload_enabled)
 		return -EOPNOTSUPP;
 
-	drv_data->msg = msg;
-	drv_data->byte_posn = 0;
-	drv_data->bytes_left = msg->len;
-	drv_data->aborting = 0;
-	drv_data->rc = 0;
 	/* Only regular transactions can be offloaded */
 	if ((msg->flags & ~(I2C_M_TEN | I2C_M_RD)) != 0)
 		return -EINVAL;
@@ -420,6 +410,12 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)
 
 static void mv64xxx_i2c_send_start(struct mv64xxx_i2c_data *drv_data)
 {
+	drv_data->msg = drv_data->msgs;
+	drv_data->byte_posn = 0;
+	drv_data->bytes_left = drv_data->msg->len;
+	drv_data->aborting = 0;
+	drv_data->rc = 0;
+
 	/* Can we offload this msg ? */
 	if (mv64xxx_i2c_offload_msg(drv_data) < 0) {
 		/* No, switch to standard path */
-- 
1.8.5.1
