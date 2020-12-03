Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55063C6369E
	for <linux-i2c@archiver.kernel.org>; Thu,  3 Dec 2020 01:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9AB020B80
	for <linux-i2c@archiver.kernel.org>; Thu,  3 Dec 2020 01:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgLCBpH (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 2 Dec 2020 20:45:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8993 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbgLCBpG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 2 Dec 2020 20:45:06 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cmdsn3Rd4zhld9;
        Thu,  3 Dec 2020 09:43:57 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 3 Dec 2020
 09:44:16 +0800
From:   Wang Xiaojun <wangxiaojun11@huawei.com>
To:     <kblaiech@nvidia.com>
CC:     <linux-i2c@vger.kernel.org>
Subject: [PATCH v2] i2c: mlxbf: Fix the return check of devm_ioremap and ioremap
Date:   Wed, 2 Dec 2020 20:46:47 -0500
Message-ID: <20201203014647.3468430-1-wangxiaojun11@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

devm_ioremap and ioremap may return NULL which cannot be checked
by IS_ERR.

Signed-off-by: Wang Xiaojun <wangxiaojun11@huawei.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
---
v2: fix the typo error.

 drivers/i2c/busses/i2c-mlxbf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mlxbf.c b/drivers/i2c/busses/i2c-mlxbf.c
index 33574d40ea9c..2fb0532d8a16 100644
--- a/drivers/i2c/busses/i2c-mlxbf.c
+++ b/drivers/i2c/busses/i2c-mlxbf.c
@@ -1258,9 +1258,9 @@ static int mlxbf_i2c_get_gpio(struct platform_device *pdev,
 		return -EFAULT;
 
 	gpio_res->io = devm_ioremap(dev, params->start, size);
-	if (IS_ERR(gpio_res->io)) {
+	if (!gpio_res->io) {
 		devm_release_mem_region(dev, params->start, size);
-		return PTR_ERR(gpio_res->io);
+		return -ENOMEM;
 	}
 
 	return 0;
@@ -1323,9 +1323,9 @@ static int mlxbf_i2c_get_corepll(struct platform_device *pdev,
 		return -EFAULT;
 
 	corepll_res->io = devm_ioremap(dev, params->start, size);
-	if (IS_ERR(corepll_res->io)) {
+	if (!corepll_res->io) {
 		devm_release_mem_region(dev, params->start, size);
-		return PTR_ERR(corepll_res->io);
+		return -ENOMEM;
 	}
 
 	return 0;
@@ -1717,9 +1717,9 @@ static int mlxbf_i2c_init_coalesce(struct platform_device *pdev,
 			return -EFAULT;
 
 		coalesce_res->io = ioremap(params->start, size);
-		if (IS_ERR(coalesce_res->io)) {
+		if (!coalesce_res->io) {
 			release_mem_region(params->start, size);
-			return PTR_ERR(coalesce_res->io);
+			return -ENOMEM;
 		}
 
 		priv->coalesce = coalesce_res;
-- 
2.25.1

