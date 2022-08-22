Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC092C38145
	for <linux-i2c@archiver.kernel.org>; Mon, 22 Aug 2022 19:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbiHVT5n (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 22 Aug 2022 15:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbiHVT5m (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 22 Aug 2022 15:57:42 -0400
Received: from mellanox.co.il (mail-il-dmz.mellanox.com [193.47.165.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84E7A4DF36
        for <linux-i2c@vger.kernel.org>; Mon, 22 Aug 2022 12:57:40 -0700 (PDT)
Received: from Internal Mail-Server by MTLPINE1 (envelope-from asmaa@mellanox.com)
        with SMTP; 22 Aug 2022 22:57:37 +0300
Received: from bu-vnc02.mtbu.labs.mlnx (bu-vnc02.mtbu.labs.mlnx [10.15.2.65])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 27MJvbmD027451;
        Mon, 22 Aug 2022 15:57:37 -0400
Received: (from asmaa@localhost)
        by bu-vnc02.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 27MJvbwb012778;
        Mon, 22 Aug 2022 15:57:37 -0400
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>, robh@kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v2 9/9] i2c-mlxbf.c: Update binding devicetree
Date:   Mon, 22 Aug 2022 15:57:25 -0400
Message-Id: <20220822195725.12656-10-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20220822195725.12656-1-asmaa@nvidia.com>
References: <20220822195725.12656-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

In the latest version of the i2c-mlxbf.c driver, the "Smbus block"
resource was broken down to 3 separate resources "Smbus timer",
"Smbus master" and "Smbus slave" to accommodate for BlueField-3
SoC registers' changes.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 .../bindings/i2c/mellanox,i2c-mlxbf.yaml      | 49 ++++++++++++++-----
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.yaml b/Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.yaml
index 93198d5d43a6..12dbe7e7967e 100644
--- a/Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.yaml
+++ b/Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.yaml
@@ -8,6 +8,7 @@ title: Mellanox I2C SMBus on BlueField SoCs
 
 maintainers:
   - Khalil Blaiech <kblaiech@nvidia.com>
+  - Asmaa Mnebhi <asmaa@nvidia.com>
 
 allOf:
   - $ref: /schemas/i2c/i2c-controller.yaml#
@@ -17,14 +18,19 @@ properties:
     enum:
       - mellanox,i2c-mlxbf1
       - mellanox,i2c-mlxbf2
+      - mellanox,i2c-mlxbf3
 
   reg:
     minItems: 3
+    maxItems: 6
     items:
       - description: Smbus block registers
       - description: Cause master registers
       - description: Cause slave registers
       - description: Cause coalesce registers
+      - description: Smbus timer registers
+      - description: Smbus master registers
+      - description: Smbus slave registers
 
   interrupts:
     maxItems: 1
@@ -35,6 +41,13 @@ properties:
       bus frequency used to configure timing registers;
       The frequency is expressed in Hz. Default is 100000.
 
+  resource_version:
+    enum: [ 0, 1 ]
+    description:
+      Version of the device tree. resource_version = 0 when the driver uses
+      Smbus block resource. resource_version = 1 when the driver uses Smbus
+      timer, Smbus master and Smbus slave resources.
+
 required:
   - compatible
   - reg
@@ -42,18 +55,6 @@ required:
 
 unevaluatedProperties: false
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - mellanox,i2c-mlxbf1
-
-then:
-  properties:
-    reg:
-      maxItems: 3
-
 examples:
   - |
     i2c@2804000 {
@@ -61,8 +62,13 @@ examples:
         reg = <0x02804000 0x800>,
               <0x02801200 0x020>,
               <0x02801260 0x020>;
+              <0x00000001 0x1>;
+              <0x02804000 0x40>,
+              <0x02804200 0x200>,
+              <0x02804400 0x200>,
         interrupts = <57>;
         clock-frequency = <100000>;
+        resource_version = <1>;
     };
 
   - |
@@ -72,6 +78,25 @@ examples:
               <0x02808e00 0x020>,
               <0x02808e20 0x020>,
               <0x02808e40 0x010>;
+              <0x02808800 0x040>;
+              <0x02808a00 0x200>,
+              <0x02808c00 0x200>,
         interrupts = <57>;
         clock-frequency = <400000>;
+        resource_version = <1>;
+    };
+
+  - |
+    i2c@2808800 {
+        compatible = "mellanox,i2c-mlxbf3";
+        reg = <0x00000001 0x1>,
+              <0x13404400 0x020>,
+              <0x13404420 0x020>,
+              <0x13404440 0x010>;
+              <0x13404480 0x40>,
+              <0x13404200 0x200>,
+              <0x13404000 0x200>,
+        interrupts = <35>;
+        clock-frequency = <400000>;
+        resource_version = <1>;
     };
-- 
2.30.1

