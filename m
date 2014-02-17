From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: rcar: add compatible entry for r8a7791
Date: Mon, 17 Feb 2014 11:47:38 +0100
Message-ID: <1392634058-12375-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

Signed-off-by: Wolfram Sang <wsa-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
---
 drivers/i2c/busses/i2c-rcar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 0282d4d..cc60bc6 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -638,6 +638,7 @@ static const struct of_device_id rcar_i2c_dt_ids[] = {
 	{ .compatible = "renesas,i2c-r8a7778", .data = (void *)I2C_RCAR_GEN1 },
 	{ .compatible = "renesas,i2c-r8a7779", .data = (void *)I2C_RCAR_GEN1 },
 	{ .compatible = "renesas,i2c-r8a7790", .data = (void *)I2C_RCAR_GEN2 },
+	{ .compatible = "renesas,i2c-r8a7791", .data = (void *)I2C_RCAR_GEN2 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_i2c_dt_ids);
-- 
1.8.5.1
