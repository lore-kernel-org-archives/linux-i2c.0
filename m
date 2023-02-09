Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35F8C636CC
	for <linux-i2c@archiver.kernel.org>; Thu,  9 Feb 2023 01:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjBIBnp (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 8 Feb 2023 20:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBIBno (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Feb 2023 20:43:44 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07DA3DBCD;
        Wed,  8 Feb 2023 17:43:42 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 09 Feb 2023 10:43:42 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 726EB2058B4F;
        Thu,  9 Feb 2023 10:43:42 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 9 Feb 2023 10:43:53 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id AD7F73D57;
        Thu,  9 Feb 2023 10:43:41 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Wolfram Sang <wsa@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] dt-bindings: i2c: uniphier: Add resets property
Date:   Thu,  9 Feb 2023 10:43:40 +0900
Message-Id: <20230209014340.17979-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

UniPhier I2C controller allows reset control support.
Add resets property to the controller as optional.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/i2c/socionext,uniphier-fi2c.yaml       | 3 +++
 .../devicetree/bindings/i2c/socionext,uniphier-i2c.yaml        | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/socionext,uniphier-fi2c.yaml b/Documentation/devicetree/bindings/i2c/socionext,uniphier-fi2c.yaml
index c76131902b77..4bbe9e775da1 100644
--- a/Documentation/devicetree/bindings/i2c/socionext,uniphier-fi2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/socionext,uniphier-fi2c.yaml
@@ -29,6 +29,9 @@ properties:
     minimum: 100000
     maximum: 400000
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/i2c/socionext,uniphier-i2c.yaml b/Documentation/devicetree/bindings/i2c/socionext,uniphier-i2c.yaml
index ddde08636ab0..5abf496edb59 100644
--- a/Documentation/devicetree/bindings/i2c/socionext,uniphier-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/socionext,uniphier-i2c.yaml
@@ -29,6 +29,9 @@ properties:
     minimum: 100000
     maximum: 400000
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.25.1

