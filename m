From: Hoan Tran <hotran@apm.com>
Subject: [PATCH] i2c: xgene-slimpro: Support v2
Date: Mon, 23 Oct 2017 15:12:20 -0700
Message-ID: <1508796740-2294-1-git-send-email-hotran@apm.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:48753 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdJWWMb (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 23 Oct 2017 18:12:31 -0400
Received: by mail-pg0-f66.google.com with SMTP id v78so12855037pgb.5
        for <linux-i2c@vger.kernel.org>; Mon, 23 Oct 2017 15:12:31 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, patches@apm.com, Hoan Tran <hotran@apm.com>

This patch supports xgene-slimpro-i2c v2 which uses the non-cachable memory
as the PCC shared memory.

Signed-off-by: Hoan Tran <hotran@apm.com>
---
 drivers/i2c/busses/i2c-xgene-slimpro.c | 45 +++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
index 7e89ba6..31314d8 100644
--- a/drivers/i2c/busses/i2c-xgene-slimpro.c
+++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
@@ -129,6 +129,11 @@ struct slimpro_i2c_dev {
 #define to_slimpro_i2c_dev(cl)	\
 		container_of(cl, struct slimpro_i2c_dev, mbox_client)
 
+enum slimpro_i2c_version {
+	XGENE_SLIMPRO_I2C_V1 = 0,
+	XGENE_SLIMPRO_I2C_V2 = 1,
+};
+
 /*
  * This function tests and clears a bitmask then returns its old value
  */
@@ -446,6 +451,15 @@ static u32 xgene_slimpro_i2c_func(struct i2c_adapter *adapter)
 	.functionality = xgene_slimpro_i2c_func,
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id xgene_slimpro_i2c_acpi_ids[] = {
+	{"APMC0D40", XGENE_SLIMPRO_I2C_V1},
+	{"APMC0D8B", XGENE_SLIMPRO_I2C_V2},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, xgene_slimpro_i2c_acpi_ids);
+#endif
+
 static int xgene_slimpro_i2c_probe(struct platform_device *pdev)
 {
 	struct slimpro_i2c_dev *ctx;
@@ -476,6 +490,17 @@ static int xgene_slimpro_i2c_probe(struct platform_device *pdev)
 		}
 	} else {
 		struct acpi_pcct_hw_reduced *cppc_ss;
+		int version = XGENE_SLIMPRO_I2C_V1;
+#ifdef CONFIG_ACPI
+		const struct acpi_device_id *acpi_id;
+
+		acpi_id = acpi_match_device(xgene_slimpro_i2c_acpi_ids,
+					    &pdev->dev);
+		if (!acpi_id)
+			return -EINVAL;
+
+		version = (int)acpi_id->driver_data;
+#endif
 
 		if (device_property_read_u32(&pdev->dev, "pcc-channel",
 					     &ctx->mbox_idx))
@@ -514,9 +539,15 @@ static int xgene_slimpro_i2c_probe(struct platform_device *pdev)
 		 */
 		ctx->comm_base_addr = cppc_ss->base_address;
 		if (ctx->comm_base_addr) {
-			ctx->pcc_comm_addr = memremap(ctx->comm_base_addr,
-						      cppc_ss->length,
-						      MEMREMAP_WB);
+			if (version == XGENE_SLIMPRO_I2C_V2)
+				ctx->pcc_comm_addr = (void __force *)ioremap(
+							ctx->comm_base_addr,
+							cppc_ss->length);
+			else
+				ctx->pcc_comm_addr = memremap(
+							ctx->comm_base_addr,
+							cppc_ss->length,
+							MEMREMAP_WB);
 		} else {
 			dev_err(&pdev->dev, "Failed to get PCC comm region\n");
 			rc = -ENOENT;
@@ -579,14 +610,6 @@ static int xgene_slimpro_i2c_remove(struct platform_device *pdev)
 };
 MODULE_DEVICE_TABLE(of, xgene_slimpro_i2c_dt_ids);
 
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id xgene_slimpro_i2c_acpi_ids[] = {
-	{"APMC0D40", 0},
-	{}
-};
-MODULE_DEVICE_TABLE(acpi, xgene_slimpro_i2c_acpi_ids);
-#endif
-
 static struct platform_driver xgene_slimpro_i2c_driver = {
 	.probe	= xgene_slimpro_i2c_probe,
 	.remove	= xgene_slimpro_i2c_remove,
-- 
1.9.1
