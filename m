Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68F8C43462
	for <linux-i2c@archiver.kernel.org>; Thu,  8 Apr 2021 12:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD60C6113B
	for <linux-i2c@archiver.kernel.org>; Thu,  8 Apr 2021 12:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhDHM7i (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 8 Apr 2021 08:59:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16050 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhDHM7f (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 8 Apr 2021 08:59:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGLqj71yTzPnhZ;
        Thu,  8 Apr 2021 20:56:33 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 20:59:10 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <orsonzhai@gmail.com>, <zhang.lyra@gmail.com>, <wsa@kernel.org>,
        <zhengdejin5@gmail.com>, <linhua.xu@unisoc.com>,
        <andriy.shevchenko@linux.intel.com>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yangjihong1@huawei.com>, <zhangjinhao2@huawei.com>,
        <--lihuafei1@huawei.com>
Subject: [PATCH -next] i2c: sprd: Fix PM reference leak in sprd_i2c_master_xfer()
Date:   Thu, 8 Apr 2021 20:59:15 +0800
Message-ID: <20210408125915.137089-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it failed.
Forgetting to putting operation will result in reference leak here. Fix
it by replacing it with pm_runtime_resume_and_get to keep usage counter
balanced.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 drivers/i2c/busses/i2c-sprd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index 2917fecf6c80..8ead7e021008 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -290,7 +290,7 @@ static int sprd_i2c_master_xfer(struct i2c_adapter *i2c_adap,
 	struct sprd_i2c *i2c_dev = i2c_adap->algo_data;
 	int im, ret;
 
-	ret = pm_runtime_get_sync(i2c_dev->dev);
+	ret = pm_runtime_resume_and_get(i2c_dev->dev);
 	if (ret < 0)
 		return ret;
 
@@ -576,7 +576,7 @@ static int sprd_i2c_remove(struct platform_device *pdev)
 	struct sprd_i2c *i2c_dev = platform_get_drvdata(pdev);
 	int ret;
 
-	ret = pm_runtime_get_sync(i2c_dev->dev);
+	ret = pm_runtime_resume_and_get(i2c_dev->dev);
 	if (ret < 0)
 		return ret;
 
-- 
2.17.1

