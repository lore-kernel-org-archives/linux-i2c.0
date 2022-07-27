Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827B6C04A68
	for <linux-i2c@archiver.kernel.org>; Wed, 27 Jul 2022 08:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiG0Icw (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 27 Jul 2022 04:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiG0Icv (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 27 Jul 2022 04:32:51 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58ED71F2ED;
        Wed, 27 Jul 2022 01:32:49 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 5AB2F1E80D89;
        Wed, 27 Jul 2022 16:32:56 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IVxWMSiBoFAM; Wed, 27 Jul 2022 16:32:53 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id BC7991E80D05;
        Wed, 27 Jul 2022 16:32:53 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] i2c/busses/drivers/img: Remove unnecessary (void*) conversions
Date:   Wed, 27 Jul 2022 16:32:39 +0800
Message-Id: <20220727083239.5396-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Remove unnecessary void* type castings.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/i2c/busses/i2c-img-scb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 8e987945ed45..d72211cfda03 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -913,7 +913,7 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
 
 static irqreturn_t img_i2c_isr(int irq, void *dev_id)
 {
-	struct img_i2c *i2c = (struct img_i2c *)dev_id;
+	struct img_i2c *i2c = dev_id;
 	u32 int_status, line_status;
 	/* We handle transaction completion AFTER accessing registers */
 	unsigned int hret;
-- 
2.18.2

