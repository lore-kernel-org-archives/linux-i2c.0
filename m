Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19911C433B4
	for <linux-i2c@archiver.kernel.org>; Sat, 17 Apr 2021 20:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9278610CD
	for <linux-i2c@archiver.kernel.org>; Sat, 17 Apr 2021 20:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbhDQU6n (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sat, 17 Apr 2021 16:58:43 -0400
Received: from mxout04.lancloud.ru ([45.84.86.114]:47444 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbhDQU6n (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 17 Apr 2021 16:58:43 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru B7FC3212A89A
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: [PATCH 1/2] i2c: iop3xx: fix deferred probing
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     <linux-i2c@vger.kernel.org>
References: <dfa042b7-8b80-ee2b-451b-7cedaeadfd02@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <cf1cf230-b8d9-9eaa-96be-dc7f380a0d00@omprussia.ru>
Date:   Sat, 17 Apr 2021 23:58:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <dfa042b7-8b80-ee2b-451b-7cedaeadfd02@omprussia.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

When adding the code to handle platform_get_irq*() errors in Commit
489447380a29 ("[PATCH] handle errors returned by platform_get_irq*()"),
the actual error code was enforced to be -ENXIO in the driver for some
strange reason. This didn't matter much until the deferred probing was
introduced -- which requires an actual error code to be propagated
upstream from the failure site.

While fixing this, also stop overriding the errors from request_irq() to
-EIO (done since the pre-git era).

Fixes: 489447380a29 ("[PATCH] handle errors returned by platform_get_irq*()")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
 drivers/i2c/busses/i2c-iop3xx.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux/drivers/i2c/busses/i2c-iop3xx.c
===================================================================
--- linux.orig/drivers/i2c/busses/i2c-iop3xx.c
+++ linux/drivers/i2c/busses/i2c-iop3xx.c
@@ -467,16 +467,14 @@ iop3xx_i2c_probe(struct platform_device
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		ret = -ENXIO;
+		ret = irq;
 		goto unmap;
 	}
 	ret = request_irq(irq, iop3xx_i2c_irq_handler, 0,
 				pdev->name, adapter_data);
 
-	if (ret) {
-		ret = -EIO;
+	if (ret)
 		goto unmap;
-	}
 
 	memcpy(new_adapter->name, pdev->name, strlen(pdev->name));
 	new_adapter->owner = THIS_MODULE;
