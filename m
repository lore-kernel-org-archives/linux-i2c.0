Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1CFC433EF
	for <linux-i2c@archiver.kernel.org>; Mon, 25 Jul 2022 01:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiGYBeC (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 24 Jul 2022 21:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYBeB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 24 Jul 2022 21:34:01 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D71EDF62;
        Sun, 24 Jul 2022 18:33:59 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 840FA1E80D0F;
        Mon, 25 Jul 2022 09:29:01 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vMySZcugWuCM; Mon, 25 Jul 2022 09:28:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id D04B31E80D05;
        Mon, 25 Jul 2022 09:28:58 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     wsa@kernel.org
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        xupengfei@nfschina.com
Subject: [PATCH v2] i2c/busses/drivers/img: remove unnecessary (void*) conversions.
Date:   Mon, 25 Jul 2022 09:33:36 +0800
Message-Id: <20220725013335.3624-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <YtzbQZKJk+qS9PMs@shikoro>
References: <YtzbQZKJk+qS9PMs@shikoro>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

remove unnecessary void* type casting.

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
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

