Return-Path: <SRS0=ODjb=C3=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA64C43464
	for <linux-i2c@archiver.kernel.org>; Fri, 18 Sep 2020 08:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006812176B
	for <linux-i2c@archiver.kernel.org>; Fri, 18 Sep 2020 08:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIRIWY (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 18 Sep 2020 04:22:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45948 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbgIRIWY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 18 Sep 2020 04:22:24 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5695AB154419F3BBBE38;
        Fri, 18 Sep 2020 16:22:21 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 16:22:13 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <wsa@the-dreams.de>, <codrin.ciubotariu@microchip.com>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next] i2c: at91: Use devm_platform_get_and_ioremap_resource()
Date:   Fri, 18 Sep 2020 16:21:40 +0800
Message-ID: <20200918082140.32258-1-bobo.shaobowang@huawei.com>
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
driver core platform instead of duplicated analogue.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/i2c/busses/i2c-at91-core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at91-core.c
index e14edd236108..5b7781302852 100644
--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -207,19 +207,16 @@ static int at91_twi_probe(struct platform_device *pdev)
 
 	dev->dev = &pdev->dev;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem)
-		return -ENODEV;
+	dev->base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
+	if (IS_ERR(dev->base))
+		return PTR_ERR(dev->base);
+
 	phy_addr = mem->start;
 
 	dev->pdata = at91_twi_get_driver_data(pdev);
 	if (!dev->pdata)
 		return -ENODEV;
 
-	dev->base = devm_ioremap_resource(&pdev->dev, mem);
-	if (IS_ERR(dev->base))
-		return PTR_ERR(dev->base);
-
 	dev->irq = platform_get_irq(pdev, 0);
 	if (dev->irq < 0)
 		return dev->irq;
-- 
2.17.1

