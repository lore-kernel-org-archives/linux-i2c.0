Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CC5C433B4
	for <linux-i2c@archiver.kernel.org>; Tue,  4 May 2021 14:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B60613C3
	for <linux-i2c@archiver.kernel.org>; Tue,  4 May 2021 14:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhEDOw0 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 4 May 2021 10:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhEDOwU (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 4 May 2021 10:52:20 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0041C06138E
        for <linux-i2c@vger.kernel.org>; Tue,  4 May 2021 07:51:17 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:1ca1:e52f:3ec5:3ac5])
        by andre.telenet-ops.be with bizsmtp
        id 0erG2500B3aEpPb01erGnh; Tue, 04 May 2021 16:51:16 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ldwOJ-002nxb-P2; Tue, 04 May 2021 16:51:15 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ldwOJ-00HQUS-4X; Tue, 04 May 2021 16:51:15 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Chris Brandt <chris.brandt@renesas.com>
Cc:     devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/6] i2c: rcar: Drop "renesas,i2c-rcar"
Date:   Tue,  4 May 2021 16:51:08 +0200
Message-ID: <a847c1866a006b4a4fb24ce4c97131493696c524.1620138454.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620138454.git.geert+renesas@glider.be>
References: <cover.1620138454.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
Message-ID: <20210504145108.tFWtA5mkN_LGgdOqE9SSxT8WWOjomizKZdrusIsiLWQ@z>

The compatible value "renesas,i2c-rcar" was deprecated in commit
ad4a8dc3fec6485b ("i2c: rcar: Add per-Generation fallback bindings"),
and never had any users in upstream Linux.  Drop its match entry from
the driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/i2c/busses/i2c-rcar.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 327c092a4130bd20..bff9913c37b8b277 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -1013,7 +1013,6 @@ static const struct of_device_id rcar_i2c_dt_ids[] = {
 	{ .compatible = "renesas,i2c-r8a7794", .data = (void *)I2C_RCAR_GEN2 },
 	{ .compatible = "renesas,i2c-r8a7795", .data = (void *)I2C_RCAR_GEN3 },
 	{ .compatible = "renesas,i2c-r8a7796", .data = (void *)I2C_RCAR_GEN3 },
-	{ .compatible = "renesas,i2c-rcar", .data = (void *)I2C_RCAR_GEN1 },	/* Deprecated */
 	{ .compatible = "renesas,rcar-gen1-i2c", .data = (void *)I2C_RCAR_GEN1 },
 	{ .compatible = "renesas,rcar-gen2-i2c", .data = (void *)I2C_RCAR_GEN2 },
 	{ .compatible = "renesas,rcar-gen3-i2c", .data = (void *)I2C_RCAR_GEN3 },
-- 
2.25.1

