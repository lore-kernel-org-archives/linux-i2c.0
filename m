From: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
Subject: [PATCH] dt-bindings: i2c: Add armada-38x i2c binding
Date: Fri, 22 Sep 2017 14:04:29 +1200
Message-ID: <20170922020429.20941-1-kalyan.kinthada@alliedtelesis.co.nz>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:42870 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdIVCEk (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Sep 2017 22:04:40 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: wsa@the-dreams.de, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>, Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>

All armada-38x variants(380, 385, 388) SoCs have an issue
in i2c controller which violates the i2c repeated start timing.

This errata is fixed in the i2c-mv64xxx driver but enabled
only for devices with compatible string "marvell,mv78230-i2c".

This patch introduces a new compatible string
"marvell,armada-38x-i2c" for the i2c controller on armada-38x SoCs
so that the workaound is enabled.

Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
---
 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
index 5c30026921..fc100b6bdb 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
@@ -14,6 +14,7 @@ Required properties :
                          very rare, initial version of the SoC which
                          had broken offload support.  Linux
                          auto-detects this and sets it appropriately.
+                     - "marvell,armada-38x-i2c"
  - interrupts      : The interrupt number
 
 Optional properties :
-- 
2.14.1
