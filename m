Return-Path: <SRS0=zHkP=CY=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08656C43461
	for <linux-i2c@archiver.kernel.org>; Tue, 15 Sep 2020 01:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8594212CC
	for <linux-i2c@archiver.kernel.org>; Tue, 15 Sep 2020 01:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgIOBkw (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 14 Sep 2020 21:40:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12257 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726019AbgIOBkv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Sep 2020 21:40:51 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 221BE5FC45AD4AAEE1C0;
        Tue, 15 Sep 2020 09:40:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 15 Sep 2020 09:40:40 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <wsa@kernel.org>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] i2c: Switch to using the new API kobj_to_dev()
Date:   Tue, 15 Sep 2020 09:38:18 +0800
Message-ID: <1600133898-35883-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Switch to using the new API kobj_to_dev().

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 include/linux/i2c.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index fc55ea4..5662265 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -344,7 +344,7 @@ const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
 
 static inline struct i2c_client *kobj_to_i2c_client(struct kobject *kobj)
 {
-	struct device * const dev = container_of(kobj, struct device, kobj);
+	struct device * const dev = kobj_to_dev(kobj);
 	return to_i2c_client(dev);
 }
 
-- 
2.7.4

