Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D97C7EE2D
	for <linux-i2c@archiver.kernel.org>; Wed, 31 May 2023 16:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjEaQYv (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 31 May 2023 12:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEaQYu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 31 May 2023 12:24:50 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27018E2
        for <linux-i2c@vger.kernel.org>; Wed, 31 May 2023 09:24:50 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1q4OP4-0001N8-0V;
        Wed, 31 May 2023 16:10:26 +0000
Date:   Wed, 31 May 2023 17:10:14 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Qii Wang <qii.wang@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
Cc:     =?utf-8?B?6YOt5bCP5qGl?= <joe@gainstrong.cn>
Subject: [PATCH 1/2] dt-bindings: i2c: i2c-mt65xx: add additional clocks
Message-ID: <5f15212060f82fb94239174c4e4b46c151645fe8.1685549360.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Add pck and mck clocks which are needed to access I2C registers on MT7981.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
index fda0467cdd954..550795f6573c5 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
@@ -78,6 +78,8 @@ properties:
       - const: dma
       - const: arb
       - const: pmic
+      - const: mck
+      - const: pck
 
   clock-div:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.40.1

