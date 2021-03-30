Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2774C433C1
	for <linux-i2c@archiver.kernel.org>; Tue, 30 Mar 2021 06:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B2461996
	for <linux-i2c@archiver.kernel.org>; Tue, 30 Mar 2021 06:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhC3GkP (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 30 Mar 2021 02:40:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14954 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhC3GkD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 30 Mar 2021 02:40:03 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8frx3ZxVzyNHW;
        Tue, 30 Mar 2021 14:37:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 14:39:46 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <wsa@kernel.org>, <thor.thayer@linux.intel.com>, <mani@kernel.org>,
        <bjorn.andersson@linaro.org>, <tiantao6@hisilicon.com>,
        <zhengdejin5@gmail.com>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH] i2c: hix5hd2: use the correct HiSilicon copyright
Date:   Tue, 30 Mar 2021 14:37:14 +0800
Message-ID: <1617086234-35270-1-git-send-email-fanghao11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

s/Hisilicon/HiSilicon/g.
It should use capital S, according to
https://www.hisilicon.com/en/terms-of-use.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
---
 drivers/i2c/busses/i2c-hix5hd2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index c45f226..aa00ba8 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Linaro Ltd.
- * Copyright (c) 2014 Hisilicon Limited.
+ * Copyright (c) 2014 HiSilicon Limited.
  *
  * Now only support 7 bit address.
  */
-- 
2.8.1

