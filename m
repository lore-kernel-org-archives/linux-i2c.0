Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA2FC43470
	for <linux-i2c@archiver.kernel.org>; Mon,  5 Apr 2021 09:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1CF61057
	for <linux-i2c@archiver.kernel.org>; Mon,  5 Apr 2021 09:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbhDEJDe (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 5 Apr 2021 05:03:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15541 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbhDEJDd (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 5 Apr 2021 05:03:33 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FDPky3y7lzPnpf
        for <linux-i2c@vger.kernel.org>; Mon,  5 Apr 2021 17:00:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 5 Apr 2021 17:03:24 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <linux-i2c@vger.kernel.org>
Subject: [PATCH drivers/i2c 3/3] i2c: nomadik: Fix space errors
Date:   Mon, 5 Apr 2021 17:03:50 +0800
Message-ID: <1617613430-11921-4-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617613430-11921-1-git-send-email-tiantao6@hisilicon.com>
References: <1617613430-11921-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Fix the following checkpatch errors:

  ERROR: space prohibited before that ',' (ctx:WxW)
  #280: FILE: drivers/i2c/busses/i2c-nomadik.c:280:
  +	i2c_clr_bit(dev->virtbase + I2C_CR , I2C_CR_PE);
  	                                   ^
  ERROR: space prohibited before that ',' (ctx:WxW)
  #528: FILE: drivers/i2c/busses/i2c-nomadik.c:528:
  +	i2c_set_bit(dev->virtbase + I2C_CR , I2C_CR_PE);
 	                                   ^

No functional changes.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Zihao Tang <tangzihao1@hisilicon.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/i2c/busses/i2c-nomadik.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index a3363b2..dc77e1c 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -277,7 +277,7 @@ static int init_hw(struct nmk_i2c_dev *dev)
 		goto exit;
 
 	/* disable the controller */
-	i2c_clr_bit(dev->virtbase + I2C_CR , I2C_CR_PE);
+	i2c_clr_bit(dev->virtbase + I2C_CR, I2C_CR_PE);
 
 	disable_all_interrupts(dev);
 
@@ -525,7 +525,7 @@ static int write_i2c(struct nmk_i2c_dev *dev, u16 flags)
 			dev->virtbase + I2C_CR);
 
 	/* enable the controller */
-	i2c_set_bit(dev->virtbase + I2C_CR , I2C_CR_PE);
+	i2c_set_bit(dev->virtbase + I2C_CR, I2C_CR_PE);
 
 	init_completion(&dev->xfer_complete);
 
-- 
2.7.4

