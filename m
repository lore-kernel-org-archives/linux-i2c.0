Return-Path: <SRS0=Xd2p=IE=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1C3C4332E
	for <linux-i2c@archiver.kernel.org>; Sat,  6 Mar 2021 07:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2BA6502C
	for <linux-i2c@archiver.kernel.org>; Sat,  6 Mar 2021 07:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhCFHvr (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sat, 6 Mar 2021 02:51:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13134 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhCFHvh (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 6 Mar 2021 02:51:37 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DsxZz6HsTz16Gld;
        Sat,  6 Mar 2021 15:49:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 6 Mar 2021 15:51:23 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <wsa@kernel.org>, <linux-i2c@vger.kernel.org>
CC:     <linuxarm@openeuler.org>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: [PATCH 1/3] i2c: core: add managed function for adding i2c adapters
Date:   Sat, 6 Mar 2021 15:49:04 +0800
Message-ID: <1615016946-55670-2-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1615016946-55670-1-git-send-email-yangyicong@hisilicon.com>
References: <1615016946-55670-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Some I2C controller drivers will only unregister the I2C
adapter in their .remove() callback, which can be done
by simply using a managed variant to add the I2C adapter.

So add the managed functions for adding the I2C adapter.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/i2c/i2c-core-base.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h         |  1 +
 2 files changed, 40 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 63ebf72..61486dc 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1550,6 +1550,38 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
 }
 EXPORT_SYMBOL(i2c_add_adapter);
 
+static void devm_i2c_del_adapter(struct device *dev, void *ptr);
+
+/**
+ * devm_i2c_add_adapter - device-managed variant of i2c_add_adapter()
+ * @dev: managing device for adding this I2C adapter
+ * @adapter: the adapter to add
+ * Context: can sleep
+ *
+ * Add adapter with dynamic bus number, same with i2c_add_adapter()
+ * but the adapter will be auto deleted on driver detach.
+ */
+int devm_i2c_add_adapter(struct device *dev, struct i2c_adapter *adapter)
+{
+	struct i2c_adapter **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_i2c_del_adapter, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = i2c_add_adapter(adapter);
+	if (!ret) {
+		*ptr = adapter;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(devm_i2c_add_adapter);
+
 /**
  * i2c_add_numbered_adapter - declare i2c adapter, use static bus number
  * @adap: the adapter to register (with adap->nr initialized)
@@ -1703,6 +1735,13 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 }
 EXPORT_SYMBOL(i2c_del_adapter);
 
+static void devm_i2c_del_adapter(struct device *dev, void *ptr)
+{
+	struct i2c_adapter *adapter = *((struct i2c_adapter **)ptr);
+
+	i2c_del_adapter(adapter);
+}
+
 static void i2c_parse_timing(struct device *dev, char *prop_name, u32 *cur_val_p,
 			    u32 def_val, bool use_def)
 {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 5662265..10bd0b0 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -844,6 +844,7 @@ static inline void i2c_mark_adapter_resumed(struct i2c_adapter *adap)
  */
 #if IS_ENABLED(CONFIG_I2C)
 int i2c_add_adapter(struct i2c_adapter *adap);
+int devm_i2c_add_adapter(struct device *dev, struct i2c_adapter *adapter);
 void i2c_del_adapter(struct i2c_adapter *adap);
 int i2c_add_numbered_adapter(struct i2c_adapter *adap);
 
-- 
2.8.1

