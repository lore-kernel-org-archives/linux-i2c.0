Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95375C433F5
	for <linux-i2c@archiver.kernel.org>; Fri, 30 Sep 2022 01:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiI3Bu0 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 29 Sep 2022 21:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiI3BuW (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 29 Sep 2022 21:50:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F31A101975;
        Thu, 29 Sep 2022 18:50:16 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MdtNh11VHzlWrH;
        Fri, 30 Sep 2022 09:45:56 +0800 (CST)
Received: from localhost.localdomain (10.157.217.52) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 09:50:14 +0800
From:   Tao Lan <taolan@huawei.com>
To:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     taolan <taolan@huawei.com>
Subject: [PATCH] i2c-hix5hd2: Add more debug info when transfer fail.
Date:   Fri, 30 Sep 2022 01:44:05 +0000
Message-ID: <20220930014405.5469-1-taolan@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.157.217.52]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

From: taolan <taolan@huawei.com>

The transfer result is checked, classified, and printed, which
facilitates debugging.
---
 drivers/i2c/busses/i2c-hix5hd2.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index 61ae58f57047..e6ab8b20cd01 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -366,8 +366,17 @@ static int hix5hd2_i2c_xfer(struct i2c_adapter *adap,
 			goto out;
 	}
 
-	ret = num;
+	if (i == num) {
+		ret = num;
+	} else {
+		/* Only one message, cannot access the device */
+		if (i == 1)
+			ret = -EREMOTEIO;
+		else
+			ret = i;
 
+		pr_warning("xfer message failed\n");
+	}
 out:
 	pm_runtime_mark_last_busy(priv->dev);
 	pm_runtime_put_autosuspend(priv->dev);
-- 
2.22.0

