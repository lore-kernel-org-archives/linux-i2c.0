Return-Path: <SRS0=DpqV=C2=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFE5C43461
	for <linux-i2c@archiver.kernel.org>; Thu, 17 Sep 2020 19:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB36208B8
	for <linux-i2c@archiver.kernel.org>; Thu, 17 Sep 2020 19:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600370117;
	bh=gcd7sEKUfLOWTqRsxROmRui6fiY5OolvkQO+RXTqltc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1l06TfaLIOciN5IPr84a/aJV3IDXnfKh2QTNZLADxeVipNtmYas1gZ2rsVk44uN3F
	 yD48hBmZ50j8bfJN/V9y7JKflvzNdKN68MAK6XyBBZsNhyGurqVs09k3ZaXH+8A/GK
	 0VqZ4pDIZjRluLbTE4mQJ+tZmIMjaWlQNXR5JcsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgIQTO1 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 17 Sep 2020 15:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgIQTNg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Sep 2020 15:13:36 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62FDD20853;
        Thu, 17 Sep 2020 19:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600370015;
        bh=gcd7sEKUfLOWTqRsxROmRui6fiY5OolvkQO+RXTqltc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=X1voo5UyLtHuTlypQysQHaRJ8QlLBNsMnv79JqESiOm9Tw8GBVclDMyvbkTUw4vKJ
         sEk0g/52paqP1qx8tIXMLFXkzWmTVW7W3Pr2lPfT1njUsvT+AjxsoMdlSuAr+IFzH1
         0lvxdjgIbFDOGkS40vjJ93nmDheof/Hby1LEpgA8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Wolfram Sang <wolfram@the-dreams.de>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] dt-bindings: i2c: imx: Add properties and use unevaluatedProperties
Date:   Thu, 17 Sep 2020 21:13:20 +0200
Message-Id: <20200917191321.28741-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917191321.28741-1-krzk@kernel.org>
References: <20200917191321.28741-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Additional properties actually might appear (e.g. power-domains) so
describe all typical properties, reference generic i2c schema and use
unevaluatedProperties to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: i2c@30a20000:
    '#address-cells', '#size-cells', 'pmic@25' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. Drop address/size cells

Changes since v2:
1. None

Changes since v1:
1. Add more properties and include /schemas/i2c/i2c-controller.yaml#
---
 Documentation/devicetree/bindings/i2c/i2c-imx.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.yaml b/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
index 810536953177..a0c87307ca07 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
@@ -9,6 +9,9 @@ title: Freescale Inter IC (I2C) and High Speed Inter IC (HS-I2C) for i.MX
 maintainers:
   - Wolfram Sang <wolfram@the-dreams.de>
 
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -75,7 +78,7 @@ required:
   - interrupts
   - clocks
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.17.1

