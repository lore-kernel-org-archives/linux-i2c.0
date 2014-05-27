From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 2/2] i2c: sh_mobile: add compatibles for additional SoC
Date: Tue, 27 May 2014 14:17:32 +0200
Message-ID: <1401193052-8582-2-git-send-email-wsa@the-dreams.de>
References: <1401193052-8582-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401193052-8582-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

Signed-off-by: Wolfram Sang <wsa-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index c29be2bba6ea..8b5e79cb4468 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -634,6 +634,9 @@ static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 	{ .compatible = "renesas,rmobile-iic", .data = &default_dt_config },
 	{ .compatible = "renesas,iic-r8a7790", .data = &rcar_gen2_dt_config },
 	{ .compatible = "renesas,iic-r8a7791", .data = &rcar_gen2_dt_config },
+	{ .compatible = "renesas,iic-r8a7792", .data = &rcar_gen2_dt_config },
+	{ .compatible = "renesas,iic-r8a7793", .data = &rcar_gen2_dt_config },
+	{ .compatible = "renesas,iic-r8a7794", .data = &rcar_gen2_dt_config },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
-- 
2.0.0.rc2
