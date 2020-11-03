Return-Path: <SRS0=IO5a=EJ=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8899FC388F9
	for <linux-i2c@archiver.kernel.org>; Tue,  3 Nov 2020 19:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C2F621556
	for <linux-i2c@archiver.kernel.org>; Tue,  3 Nov 2020 19:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kvzCvsy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgKCTyq (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 3 Nov 2020 14:54:46 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19373 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgKCTyq (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 3 Nov 2020 14:54:46 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa1b5860000>; Tue, 03 Nov 2020 11:54:46 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 19:54:46 +0000
Received: from vdi.nvidia.com (10.124.1.5) by mail.nvidia.com (172.20.187.18)
 with Microsoft SMTP Server id 15.0.1473.3 via Frontend Transport; Tue, 3 Nov
 2020 19:54:45 +0000
From:   Khalil Blaiech <kblaiech@nvidia.com>
To:     <linux-i2c@vger.kernel.org>
CC:     <kblaiech@nvidia.com>, <wsa+renesas@sang-engineering.com>
Subject: [PATCH i2c-next v2 1/6] i2c: mlxbf: Add CONFIG_ACPI to guard ACPI function call
Date:   Tue, 3 Nov 2020 14:54:38 -0500
Message-ID: <93942ac7e4e5443325d9f024901db5872ec0d16d.1604432921.git.kblaiech@nvidia.com>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <cover.1604432921.git.kblaiech@nvidia.com>
References: <cover.1604432921.git.kblaiech@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604433286; bh=nxAEo6PKYr+oZqpgT3/Vpg7LzdaBIBMyeGaSPx8T4lI=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=kvzCvsy8kPuvKgHdWdMJv/F9inZp5isBhK4LX6M9griwyLow85ff0JisM+ZSSmc0j
         UE4PvjSTYcwTaBk5R0s/Qsy3dl90ckvx9oqw9rMmUzgPtzeB+0iA+HU43ficRaO4n9
         9Fx78CQbHdyto/ryuCKHGcvyoc8zv6djYO4OWjOCk6yTkZVtsKTn0KA38Gm/zTJTHq
         HY4meXYg3SLhaB7giI0uRCXPIqAnoNWrmkBWkVGFjpKLOpbyRUrauGgnR6wF8VWuVE
         3SgfMNuadXCFhxr5ZeAg6N1LtSgeB1kBylMS8o5btwxz9+lWUz6jXIIn/Zlysvia4/
         Dg20iyimGh/FQ==
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The build fails with "implicit declaration of function
'acpi_device_uid'" error. Thus, protect ACPI function calls
from being called when CONFIG_ACPI is disabled.

Fixes: b5b5b32081cd206b ("i2c: mlxbf: I2C SMBus driver for Mellanox BlueField SoC")
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Khalil Blaiech <kblaiech@nvidia.com>
---
 drivers/i2c/busses/i2c-mlxbf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mlxbf.c b/drivers/i2c/busses/i2c-mlxbf.c
index ee59e0d..e18f595 100644
--- a/drivers/i2c/busses/i2c-mlxbf.c
+++ b/drivers/i2c/busses/i2c-mlxbf.c
@@ -2264,6 +2264,7 @@ static const struct of_device_id mlxbf_i2c_dt_ids[] = {
 
 MODULE_DEVICE_TABLE(of, mlxbf_i2c_dt_ids);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id mlxbf_i2c_acpi_ids[] = {
 	{ "MLNXBF03", (kernel_ulong_t)&mlxbf_i2c_chip[MLXBF_I2C_CHIP_TYPE_1] },
 	{ "MLNXBF23", (kernel_ulong_t)&mlxbf_i2c_chip[MLXBF_I2C_CHIP_TYPE_2] },
@@ -2305,6 +2306,12 @@ static int mlxbf_i2c_acpi_probe(struct device *dev, struct mlxbf_i2c_priv *priv)
 
 	return ret;
 }
+#else
+static int mlxbf_i2c_acpi_probe(struct device *dev, struct mlxbf_i2c_priv *priv)
+{
+	return -ENOENT;
+}
+#endif /* CONFIG_ACPI */
 
 static int mlxbf_i2c_of_probe(struct device *dev, struct mlxbf_i2c_priv *priv)
 {
@@ -2473,7 +2480,9 @@ static struct platform_driver mlxbf_i2c_driver = {
 	.driver = {
 		.name = "i2c-mlxbf",
 		.of_match_table = mlxbf_i2c_dt_ids,
+#ifdef CONFIG_ACPI
 		.acpi_match_table = ACPI_PTR(mlxbf_i2c_acpi_ids),
+#endif /* CONFIG_ACPI  */
 	},
 };
 
-- 
2.1.2

