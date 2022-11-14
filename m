Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A90C4332F
	for <linux-i2c@archiver.kernel.org>; Mon, 14 Nov 2022 00:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiKNAqt (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 13 Nov 2022 19:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKNAqs (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 13 Nov 2022 19:46:48 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352BBE0FD;
        Sun, 13 Nov 2022 16:46:47 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N9VxG3mcnz15Mbw;
        Mon, 14 Nov 2022 08:46:26 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 08:46:44 +0800
Received: from ubuntu1804.huawei.com (10.67.175.30) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 08:46:44 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <peda@axentia.se>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] i2c: mux: reg: Fix possible null-ptr-deref
Date:   Mon, 14 Nov 2022 08:43:22 +0800
Message-ID: <20221114004322.257455-1-tanghui20@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.30]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

It will cause null-ptr-deref when resource_size(res) invoked,
if platform_get_resource() returns NULL.

Fixes: b3fdd32799d8 ("i2c: mux: Add register-based mux i2c-mux-reg")
Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/i2c/muxes/i2c-mux-reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 0e0679f65cf7..d26de1017385 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -184,12 +184,12 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 		dev_info(&pdev->dev,
 			"Register not set, using platform resource\n");
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		mux->data.reg_size = resource_size(res);
 		mux->data.reg = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(mux->data.reg)) {
 			ret = PTR_ERR(mux->data.reg);
 			goto err_put_parent;
 		}
+		mux->data.reg_size = resource_size(res);
 	}
 
 	if (mux->data.reg_size != 4 && mux->data.reg_size != 2 &&
-- 
2.17.1

