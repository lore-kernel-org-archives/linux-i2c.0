Return-Path: <SRS0=ODjb=C3=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC7EC43463
	for <linux-i2c@archiver.kernel.org>; Fri, 18 Sep 2020 08:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E5A20848
	for <linux-i2c@archiver.kernel.org>; Fri, 18 Sep 2020 08:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgIRIZ4 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 18 Sep 2020 04:25:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13293 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbgIRIZ4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 18 Sep 2020 04:25:56 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 861BA7C7D61215C724CB;
        Fri, 18 Sep 2020 16:25:48 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 16:25:41 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <wsa@kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next] i2c: efm32: Use devm_platform_get_and_ioremap_resource()
Date:   Fri, 18 Sep 2020 16:25:08 +0800
Message-ID: <20200918082508.32427-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Make use of devm_platform_get_and_ioremap_resource() provided by
driver core platform instead of duplicated analogue. dev_err() is
removed because it has been done in devm_ioremap_resource().

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/i2c/busses/i2c-efm32.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-efm32.c
index 838ce0947191..f6e13ceeb2b3 100644
--- a/drivers/i2c/busses/i2c-efm32.c
+++ b/drivers/i2c/busses/i2c-efm32.c
@@ -332,21 +332,15 @@ static int efm32_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "failed to determine base address\n");
-		return -ENODEV;
-	}
+	ddata->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(ddata->base))
+		return PTR_ERR(ddata->base);
 
 	if (resource_size(res) < 0x42) {
 		dev_err(&pdev->dev, "memory resource too small\n");
 		return -EINVAL;
 	}
 
-	ddata->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(ddata->base))
-		return PTR_ERR(ddata->base);
-
 	ret = platform_get_irq(pdev, 0);
 	if (ret <= 0) {
 		if (!ret)
-- 
2.17.1

