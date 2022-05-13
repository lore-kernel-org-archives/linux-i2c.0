Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3692BC433F5
	for <linux-i2c@archiver.kernel.org>; Fri, 13 May 2022 09:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351812AbiEMJ45 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 13 May 2022 05:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347190AbiEMJ44 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 13 May 2022 05:56:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D27D1C925;
        Fri, 13 May 2022 02:56:55 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L03rW46XKzGplM;
        Fri, 13 May 2022 17:54:03 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 17:56:53 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 17:56:53 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-i2c@vger.kernel.org>
CC:     <matthias.bgg@gmail.com>, <sr@denx.de>, <wsa@the-dreams.de>
Subject: [PATCH -next 2/2] i2c: mt7621: Use devm_platform_get_and_ioremap_resource()
Date:   Fri, 13 May 2022 18:08:19 +0800
Message-ID: <20220513100819.2711845-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513100819.2711845-1-yangyingliang@huawei.com>
References: <20220513100819.2711845-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() to simplify
code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/i2c/busses/i2c-mt7621.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
index f117c3d9ca19..0d849379a236 100644
--- a/drivers/i2c/busses/i2c-mt7621.c
+++ b/drivers/i2c/busses/i2c-mt7621.c
@@ -270,18 +270,15 @@ static void mtk_i2c_init(struct mtk_i2c *i2c)
 
 static int mtk_i2c_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct mtk_i2c *i2c;
 	struct i2c_adapter *adap;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
 	i2c = devm_kzalloc(&pdev->dev, sizeof(struct mtk_i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
-	i2c->base = devm_ioremap_resource(&pdev->dev, res);
+	i2c->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(i2c->base))
 		return PTR_ERR(i2c->base);
 
-- 
2.25.1

