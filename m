Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1420EC48BE8
	for <linux-i2c@archiver.kernel.org>; Fri, 18 Jun 2021 11:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8BF2613D6
	for <linux-i2c@archiver.kernel.org>; Fri, 18 Jun 2021 11:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhFRLG0 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 18 Jun 2021 07:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhFRLG0 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 18 Jun 2021 07:06:26 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01F9C061767
        for <linux-i2c@vger.kernel.org>; Fri, 18 Jun 2021 04:04:16 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:104a:f93d:b771:fc40])
        by laurent.telenet-ops.be with bizsmtp
        id Jb4C2500H47PYg101b4CXE; Fri, 18 Jun 2021 13:04:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1luCIG-000yA5-87; Fri, 18 Jun 2021 13:04:12 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1luCIF-007GWP-NA; Fri, 18 Jun 2021 13:04:11 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/5] dt-bindings: i2c: renesas,iic: Always declare generic compatibility
Date:   Fri, 18 Jun 2021 13:04:07 +0200
Message-Id: <760fec5fa71bfff4c7bfe944cfc385f9d8e1945b.1624013699.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1624013699.git.geert+renesas@glider.be>
References: <cover.1624013699.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

According to the Hardware User's Manual, automatic transmission for PMIC
control (DVFS) is not available on the R-Car E3 and RZ/G2E SoC.
Experiments showed this really means that support for automatic DVFS is
not present, while the IIC automatic transmission feature itself is
still available, albeit not super useful.

Hence there is no longer a reason not to declare compatibility with the
R-Car Gen3-specific and generic versions, and the corresponding
paragraph can be dropped.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.

 Documentation/devicetree/bindings/i2c/renesas,iic.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,iic.txt b/Documentation/devicetree/bindings/i2c/renesas,iic.txt
index 93d412832e66b682..5de808f79b0630c2 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,iic.txt
+++ b/Documentation/devicetree/bindings/i2c/renesas,iic.txt
@@ -37,11 +37,6 @@ Required properties:
 			When compatible with "renesas,rmobile-iic" it should
 			be the last compatibility string listed.
 
-			The r8a77990 (R-Car E3) and r8a774c0 (RZ/G2E)
-			controllers are not considered compatible with
-			"renesas,rcar-gen3-iic" or "renesas,rmobile-iic"
-			due to the absence of automatic transmission registers.
-
 - reg             : address start and address range size of device
 - interrupts      : interrupt of device
 - clocks          : clock for device
-- 
2.25.1

