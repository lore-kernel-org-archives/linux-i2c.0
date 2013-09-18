From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: mv64xxx: Do not use writel_relaxed()
Date: Wed, 18 Sep 2013 14:51:40 +0200
Message-ID: <1379508700-30400-1-git-send-email-treding@nvidia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The driver is used on PowerPC which don't provide writel_relaxed(). This
breaks the c2k and prpmc2800 default configurations. To fix the build,
turn the calls to writel_relaxed() into writel(). The impacts for ARM
should be minimal.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 7f3a474..5aead74 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -234,9 +234,9 @@ static int mv64xxx_i2c_offload_msg(struct mv64xxx_i2c_data *drv_data)
 		ctrl_reg |= MV64XXX_I2C_BRIDGE_CONTROL_WR |
 		    (msg->len - 1) << MV64XXX_I2C_BRIDGE_CONTROL_TX_SIZE_SHIFT;
 
-		writel_relaxed(data_reg_lo,
+		writel(data_reg_lo,
 			drv_data->reg_base + MV64XXX_I2C_REG_TX_DATA_LO);
-		writel_relaxed(data_reg_hi,
+		writel(data_reg_hi,
 			drv_data->reg_base + MV64XXX_I2C_REG_TX_DATA_HI);
 
 	} else {
-- 
1.8.4
