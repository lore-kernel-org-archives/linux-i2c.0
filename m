Return-Path: <SRS0=Pt51=EI=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835BDC2D0A3
	for <linux-i2c@archiver.kernel.org>; Mon,  2 Nov 2020 11:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 366DB222B9
	for <linux-i2c@archiver.kernel.org>; Mon,  2 Nov 2020 11:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgKBLr7 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 2 Nov 2020 06:47:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7031 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgKBLpx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 2 Nov 2020 06:45:53 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CPrhW4vdwzhf2W;
        Mon,  2 Nov 2020 19:45:47 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 2 Nov 2020
 19:45:39 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Khalil Blaiech <kblaiech@mellanox.com>,
        Wolfram Sang <wsa@kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] i2c: mlxbf: Fix build error with CONFIG_ACPI disabled
Date:   Mon, 2 Nov 2020 20:12:34 +0800
Message-ID: <20201102121234.1343672-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

drivers/i2c/busses/i2c-mlxbf.c: In function ‘mlxbf_i2c_acpi_probe’:
drivers/i2c/busses/i2c-mlxbf.c:2296:8: error: implicit declaration of function ‘acpi_device_uid’; did you mean ‘cpu_device_up’? [-Werror=implicit-function-declaration]
  uid = acpi_device_uid(adev);
        ^~~~~~~~~~~~~~~
        cpu_device_up

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/i2c/busses/i2c-mlxbf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mlxbf.c b/drivers/i2c/busses/i2c-mlxbf.c
index ee59e0da082d..cd8a909431a9 100644
--- a/drivers/i2c/busses/i2c-mlxbf.c
+++ b/drivers/i2c/busses/i2c-mlxbf.c
@@ -2272,6 +2272,7 @@ static const struct acpi_device_id mlxbf_i2c_acpi_ids[] = {
 
 MODULE_DEVICE_TABLE(acpi, mlxbf_i2c_acpi_ids);
 
+#ifdef CONFIG_ACPI
 static int mlxbf_i2c_acpi_probe(struct device *dev, struct mlxbf_i2c_priv *priv)
 {
 	const struct acpi_device_id *aid;
@@ -2305,6 +2306,12 @@ static int mlxbf_i2c_acpi_probe(struct device *dev, struct mlxbf_i2c_priv *priv)
 
 	return ret;
 }
+#else
+static int mlxbf_i2c_acpi_probe(struct device *dev, struct mlxbf_i2c_priv *priv)
+{
+	return -ENODEV;
+}
+#endif
 
 static int mlxbf_i2c_of_probe(struct device *dev, struct mlxbf_i2c_priv *priv)
 {
-- 
2.25.1

