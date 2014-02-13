From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 1/5] i2c: mv64xxx: put offload check into offload prepare function
Date: Thu, 13 Feb 2014 21:36:29 +0100
Message-ID: <1392323793-4125-2-git-send-email-wsa@the-dreams.de>
References: <20140213094117.GA3934@katana>
 <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392323793-4125-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

It makes code simpler to read and prepares a reorganization needed for a
bugfix.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index b8c5187..ba64978 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -204,6 +204,9 @@ static int mv64xxx_i2c_offload_msg(struct mv64xxx_i2c_data *drv_data)
 	unsigned long ctrl_reg;
 	struct i2c_msg *msg = drv_data->msgs;
 
+	if (!drv_data->offload_enabled)
+		return -EOPNOTSUPP;
+
 	drv_data->msg = msg;
 	drv_data->byte_posn = 0;
 	drv_data->bytes_left = msg->len;
@@ -433,8 +436,7 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 
 		drv_data->msgs++;
 		drv_data->num_msgs--;
-		if (!(drv_data->offload_enabled &&
-				mv64xxx_i2c_offload_msg(drv_data))) {
+		if (mv64xxx_i2c_offload_msg(drv_data) < 0) {
 			drv_data->cntl_bits |= MV64XXX_I2C_REG_CONTROL_START;
 			writel(drv_data->cntl_bits,
 			drv_data->reg_base + drv_data->reg_offsets.control);
-- 
1.8.5.1
