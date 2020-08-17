Return-Path: <SRS0=ecy2=B3=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7878CC433E1
	for <linux-i2c@archiver.kernel.org>; Mon, 17 Aug 2020 12:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579682063A
	for <linux-i2c@archiver.kernel.org>; Mon, 17 Aug 2020 12:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZgLMcPaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHQMTl (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:19:41 -0400
Received: from www.zeus03.de ([194.117.254.33]:45670 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgHQMTj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 17 Aug 2020 08:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=wwTDOknCa1MVxbKplTjaRq5b+tt
        U+ilFP0JANQFMUfY=; b=ZgLMcPaT4/2wgVer0cwZTTedXGcnXwHGNH5avOVx8mA
        cL6TTh+xvCcS6ps8YXT0EGPmYTPnsNRHJmBUGDNmrnFI+UMMe4jj3b/QeMR6j0OJ
        FC9tr4GPfjKRICq6gYZ33oGS4O1YZqUpYgGgN8m/sqPAX2z5DBnxiiUaZDDAVs6U
        =
Received: (qmail 2678416 invoked from network); 17 Aug 2020 14:19:34 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Aug 2020 14:19:34 +0200
X-UD-Smtp-Session: l3s3148p1@qHSLyBGtJo0gAwDPXwRyAFDAMTTCvAzI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] i2c: rcar: in slave mode, clear NACK earlier
Date:   Mon, 17 Aug 2020 14:19:30 +0200
Message-Id: <20200817121930.4474-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Currently, a NACK in slave mode is set/cleared when SCL is held low by
the IP core right before the bit is about to be pushed out. This is too
late for clearing and then a NACK from the previous byte is still used
for the current one. Now, let's clear the NACK right after we detected
the STOP condition following the NACK.

Fixes: de20d1857dd6 ("i2c: rcar: add slave support")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 284dc3edb9a1..0f73f0681a6e 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -594,6 +594,7 @@ static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
 	/* master sent stop */
 	if (ssr_filtered & SSR) {
 		i2c_slave_event(priv->slave, I2C_SLAVE_STOP, &value);
+		rcar_i2c_write(priv, ICSCR, SIE | SDBS); /* clear our NACK */
 		rcar_i2c_write(priv, ICSIER, SAR);
 		rcar_i2c_write(priv, ICSSR, ~SSR & 0xff);
 	}
-- 
2.20.1

