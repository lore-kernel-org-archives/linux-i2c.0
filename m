From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [RFC PATCH 2/3] i2c: mv64xxx: Fix bus hang on A0 version of the Armada XP SoCs
Date: Tue, 31 Dec 2013 17:44:52 +0100
Message-ID: <1388508293-9141-3-git-send-email-gregory.clement@free-electrons.com>
References: <1388508293-9141-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1388508293-9141-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The first variants of Armada XP SoCs (A0 stepping) have issues related
to the i2c controller which prevent to use the offload mechanism and
lead to a kernel hang during boot.

The commit introduces a new the compatible string
marvell,mv78230-a0-i2c for the i2c controller. When this compatible
string is used the driver disables the offload mechanism and the
kernel no more hangs on these SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 8be7e42aa4de..f424c0f89946 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -692,6 +692,10 @@ static const struct of_device_id mv64xxx_i2c_of_match_table[] = {
 	{ .compatible = "allwinner,sun4i-i2c", .data = &mv64xxx_i2c_regs_sun4i},
 	{ .compatible = "marvell,mv64xxx-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
 	{ .compatible = "marvell,mv78230-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
+	{
+		.compatible = "marvell,mv78230-a0-i2c",
+		.data = &mv64xxx_i2c_regs_mv64xxx
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mv64xxx_i2c_of_match_table);
@@ -783,6 +787,10 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 		drv_data->errata_delay = true;
 	}
 
+	if (of_device_is_compatible(np, "marvell,mv78230-a0-i2c")) {
+		drv_data->offload_enabled = false;
+		drv_data->errata_delay = true;
+	}
 out:
 	return rc;
 #endif
-- 
1.8.1.2
