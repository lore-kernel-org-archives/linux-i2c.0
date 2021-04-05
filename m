Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C20AC433B4
	for <linux-i2c@archiver.kernel.org>; Mon,  5 Apr 2021 08:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355F06138B
	for <linux-i2c@archiver.kernel.org>; Mon,  5 Apr 2021 08:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhDEIS1 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 5 Apr 2021 04:18:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15480 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhDEIS0 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 5 Apr 2021 04:18:26 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FDNlX2T7XzwQrw;
        Mon,  5 Apr 2021 16:16:08 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Mon, 5 Apr 2021 16:18:15 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <wsa@kernel.org>
CC:     <linux-i2c@vger.kernel.org>
Subject: [PATCH] i2c: core: Fix spacing error by checkpatch
Date:   Mon, 5 Apr 2021 16:18:42 +0800
Message-ID: <1617610722-11498-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Fix the following checkpatch error:
 #614: FILE: drivers/i2c/i2c-core-base.c:614:
 +	len = acpi_device_modalias(dev, buf, PAGE_SIZE -1);
 	                                               ^
No functional changes.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 7039b8a..e4d4a34 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -612,7 +612,7 @@ modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
 	if (len != -ENODEV)
 		return len;
 
-	len = acpi_device_modalias(dev, buf, PAGE_SIZE -1);
+	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
 	if (len != -ENODEV)
 		return len;
 
-- 
2.7.4

