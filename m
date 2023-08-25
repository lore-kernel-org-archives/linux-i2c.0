Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BFDC3DA6F
	for <linux-i2c@archiver.kernel.org>; Fri, 25 Aug 2023 14:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbjHYOYe (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 25 Aug 2023 10:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343769AbjHYOY1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 25 Aug 2023 10:24:27 -0400
Received: from mx4.sionneau.net (mx4.sionneau.net [51.15.250.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7150410FF;
        Fri, 25 Aug 2023 07:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sionneau.net;
        s=selectormx4; t=1692973459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jaf5NgrM5yQG3fDgEPBnmr8NNF29E1ndjI5yLwiZ82o=;
        b=EJp2BMNZU8bT7lSHcTwelBpk6+nRLrxABYwfE8IX7yzhsb7GxxqluowFbWJy7Kw1pDWrR0
        fVAjXRwZRSeXsQ8lTZOtuk+RsJeawVyPxK+lK2w/sfWWXS2ObFy3z3MI6ECMRsBeOGX2X6
        JGK23WG1sCGlMvHmbLR7JGA5OIdfk60=
Received: from fallen-ThinkPad-X260.home (91-171-21-26.subs.proxad.net [91.171.21.26])
        by mx4.sionneau.net (OpenSMTPD) with ESMTPSA id 7ad8a692 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 25 Aug 2023 14:24:19 +0000 (UTC)
From:   Yann Sionneau <yann@sionneau.net>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yann Sionneau <yann@sionneau.net>
Subject: [PATCH] i2c: at91: Use dev_err_probe() instead of dev_err()
Date:   Fri, 25 Aug 2023 16:24:15 +0200
Message-Id: <20230825142415.37476-1-yann@sionneau.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Change return dev_err_probe() into
if (IS_ERR(x)) { dev_err(...); return PTR_ERR(x); }

Also, return the correct error instead of hardcoding -ENODEV
This change has also the advantage of handling the -EPROBE_DEFER situation.

Signed-off-by: Yann Sionneau <yann@sionneau.net>
---
 drivers/i2c/busses/i2c-at91-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at91-core.c
index 05ad3bc3578a..b7bc17b0e5f0 100644
--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -227,10 +227,9 @@ static int at91_twi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dev);
 
 	dev->clk = devm_clk_get(dev->dev, NULL);
-	if (IS_ERR(dev->clk)) {
-		dev_err(dev->dev, "no clock defined\n");
-		return -ENODEV;
-	}
+	if (IS_ERR(dev->clk))
+		return dev_err_probe(dev->dev, PTR_ERR(dev->clk), "no clock defined\n");
+
 	clk_prepare_enable(dev->clk);
 
 	snprintf(dev->adapter.name, sizeof(dev->adapter.name), "AT91");
-- 
2.34.1

