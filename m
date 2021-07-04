Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC58C07E95
	for <linux-i2c@archiver.kernel.org>; Sun,  4 Jul 2021 14:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9DF613DD
	for <linux-i2c@archiver.kernel.org>; Sun,  4 Jul 2021 14:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhGDOuc (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 4 Jul 2021 10:50:32 -0400
Received: from mxout01.lancloud.ru ([45.84.86.81]:39548 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhGDOuc (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 4 Jul 2021 10:50:32 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru DDDBC20CDDE4
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: [PATCH v2 5/5] i2c: xlp9xx: fix main IRQ check
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     <linux-i2c@vger.kernel.org>
CC:     George Cherian <gcherian@marvell.com>
References: <3712e871-bf2f-32c5-f9c2-2968c42087f8@omp.ru>
Organization: Open Mobile Platform
Message-ID: <88b0915b-de45-1ef3-0b03-ec9c2ff3ce88@omp.ru>
Date:   Sun, 4 Jul 2021 17:47:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <3712e871-bf2f-32c5-f9c2-2968c42087f8@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Iff platform_get_irq() returns 0 for the main IRQ, the driver's probe()
method will return 0 early (as if the method's call was successful).
Let's consider IRQ0 valid for simplicity -- devm_request_irq() can always
override that decision...

Fixes: 2bbd681ba2b ("i2c: xlp9xx: Driver for Netlogic XLP9XX/5XX I2C controller")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
 drivers/i2c/busses/i2c-xlp9xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/i2c/busses/i2c-xlp9xx.c
===================================================================
--- linux.orig/drivers/i2c/busses/i2c-xlp9xx.c
+++ linux/drivers/i2c/busses/i2c-xlp9xx.c
@@ -517,7 +517,7 @@ static int xlp9xx_i2c_probe(struct platf
 		return PTR_ERR(priv->base);
 
 	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq <= 0)
+	if (priv->irq < 0)
 		return priv->irq;
 	/* SMBAlert irq */
 	priv->alert_data.irq = platform_get_irq(pdev, 1);
