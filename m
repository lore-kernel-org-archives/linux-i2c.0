Return-Path: <SRS0=YXQZ=CN=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA511C43461
	for <linux-i2c@archiver.kernel.org>; Fri,  4 Sep 2020 19:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300C520BED
	for <linux-i2c@archiver.kernel.org>; Fri,  4 Sep 2020 19:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ee header.i=@mail.ee header.b="hePSwgnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgIDTjP (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:39:15 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:43848 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgIDTjP (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 4 Sep 2020 15:39:15 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Sep 2020 15:39:14 EDT
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id E5A8A14CABA;
        Fri,  4 Sep 2020 22:33:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.ee; s=20150108;
        t=1599248031; bh=ubICt9xksEEhwxkgC0Mdeef1nGy2ibTY1aiD6wEybEU=;
        h=Date:From:To:Cc:Subject;
        b=hePSwgnrh3GZhnc0bnnelG38+iLEHuCovnNgH5pWcD4KiXA+X/ztCDnvnvZm98B/h
         AafnB9yzGrl7ls5o6K+pDjfgjJSV5aEY6SdCcHU+uHSzy4KtlM3CE9N0jNQoKAeqRS
         jzruNl6Z2szipMVmuPgJMwvLWqzkUdndjLT9gjRQ=
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id C528D14CAB9;
        Fri,  4 Sep 2020 22:33:51 +0300 (EEST)
Received: from hp15 (unknown [185.176.221.195])
        (Authenticated sender: arzamas-16@mail.ee)
        by mail.inbox.eu (Postfix) with ESMTPA id 0563A1BE00DE;
        Fri,  4 Sep 2020 22:33:49 +0300 (EEST)
Date:   Fri, 4 Sep 2020 22:33:45 +0300
From:   Boris Lysov <arzamas-16@mail.ee>
To:     linux-i2c@vger.kernel.org
Cc:     qii.wang@mediatek.com, robh+dt@kernel.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: i2c: i2c-mt65xx: Update binding example
Message-ID: <20200904223345.3daea5ad@hp15>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: 6N1mkZY9ZDPk1R69OhvTBA4ysStOWvPn+eak0RRcgAiJPFLiYg==
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Example uses values for MT6589 SoC, but MT6577 was specified in "compatible" property.

Signed-off-by: Boris Lysov <arzamas-16@mail.ee>
---
 Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
index 7f0194fdd0cc..acf3d4d28b98 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
@@ -36,7 +36,7 @@ Optional properties:
 Example:
 
 	i2c0: i2c@1100d000 {
-			compatible = "mediatek,mt6577-i2c";
+			compatible = "mediatek,mt6589-i2c";
 			reg = <0x1100d000 0x70>,
 			      <0x11000300 0x80>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;
-- 
2.28.0
