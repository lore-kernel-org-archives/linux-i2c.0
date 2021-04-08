Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB74C433B4
	for <linux-i2c@archiver.kernel.org>; Thu,  8 Apr 2021 11:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51CA761130
	for <linux-i2c@archiver.kernel.org>; Thu,  8 Apr 2021 11:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhDHLGx (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 8 Apr 2021 07:06:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16407 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhDHLGw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 8 Apr 2021 07:06:52 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGJLr3mpgzkjXg;
        Thu,  8 Apr 2021 19:04:52 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.149) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 19:06:34 +0800
From:   Ye Weihua <yeweihua4@huawei.com>
To:     <linux@rempel-privat.de>, <kernel@pengutronix.de>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>
CC:     <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yangjihong1@huawei.com>,
        <zhangjinhao2@huawei.com>
Subject: [PATCH -next] i2c: imx: Fix PM reference leak in i2c_imx_reg_slave()
Date:   Thu, 8 Apr 2021 19:06:38 +0800
Message-ID: <20210408110638.200761-1-yeweihua4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The PM reference count is not expected to be incremented on return in
these functions.

However, pm_runtime_get_sync() will increment the PM reference count
even on failure. forgetting to put the reference again will result in
a leak.

Replace it with pm_runtime_resume_and_get() to keep the usage counter
balanced.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Weihua <yeweihua4@huawei.com>
---
 drivers/i2c/busses/i2c-imx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index b80fdc1f0092..dc5ca71906db 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -801,7 +801,7 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
 	i2c_imx->last_slave_event = I2C_SLAVE_STOP;
 
 	/* Resume */
-	ret = pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
+	ret = pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
 	if (ret < 0) {
 		dev_err(&i2c_imx->adapter.dev, "failed to resume i2c controller");
 		return ret;
@@ -1253,7 +1253,7 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
 	int result;
 
-	result = pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
+	result = pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
 	if (result < 0)
 		return result;
 
@@ -1496,7 +1496,7 @@ static int i2c_imx_remove(struct platform_device *pdev)
 	struct imx_i2c_struct *i2c_imx = platform_get_drvdata(pdev);
 	int irq, ret;
 
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0)
 		return ret;
 
-- 
2.17.1

