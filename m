Return-Path: <SRS0=IO5a=EJ=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E52C388F9
	for <linux-i2c@archiver.kernel.org>; Tue,  3 Nov 2020 19:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B8E21556
	for <linux-i2c@archiver.kernel.org>; Tue,  3 Nov 2020 19:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dbhT/ER9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgKCT4M (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 3 Nov 2020 14:56:12 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19475 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgKCT4M (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 3 Nov 2020 14:56:12 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa1b5db0000>; Tue, 03 Nov 2020 11:56:11 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 19:56:11 +0000
Received: from vdi.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 3 Nov 2020 19:56:10 +0000
From:   Khalil Blaiech <kblaiech@nvidia.com>
To:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <kblaiech@nvidia.com>, <wsa+renesas@sang-engineering.com>,
        <robh+dt@kernel.org>
Subject: [PATCH i2c-next v2 6/6] dt-bindings: i2c: Convert DT file to YAML schema
Date:   Tue, 3 Nov 2020 14:56:08 -0500
Message-ID: <c81a0679413dd77e68bdf7e3023d1a54e62f26ea.1604432921.git.kblaiech@nvidia.com>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <cover.1604432921.git.kblaiech@nvidia.com>
References: <cover.1604432921.git.kblaiech@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604433371; bh=TLWU+Tykj3XfZ+ZojiWDG4tqqPP3sdNWaq+bAyVLq8s=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=dbhT/ER9lmxzuxRW+MQrDftuZO7hhHRgkLlB9qK3fG0GkFgrrYrwIo/ZC9aSdobZy
         GM0SvtJH7YZtvz8Q9DB7I7cXD01uXl5SG5ZySOM561ygcv9F5rxpCbuKAfIdg/xnCq
         KnUzi6nT71NXF7jZssgJ8z4xX5OQoYk3lyibqtT+XMMERz+yr1sw7C00hdpmwI/Ekw
         Xxd0TS6dPR1b613Xc20SxxvFI20wdbvj82OIcAoFcv0ox7ndJHeQqSl/xnZ0N0uMKR
         DWWKAwHkZicDK+wYcpR4bC+JIf5RpYXgSWKGVEqinreUy20wEU61xKYx0vwtv/fFEM
         1uoVgw1swgsfw==
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Write the devicetree binding text file associated with
the Mellanox BlueField I2C controller in schema file,
JSON compatible subset of YAML. Besides, add an entry
within MAINTAINERS file.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Khalil Blaiech <kblaiech@nvidia.com>
---
 .../devicetree/bindings/i2c/mellanox,i2c-mlxbf.txt | 42 ------------
 .../bindings/i2c/mellanox,i2c-mlxbf.yaml           | 80 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 3 files changed, 81 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.yaml

diff --git a/Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.txt b/Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.txt
deleted file mode 100644
index 566ea86..0000000
--- a/Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Device tree configuration for the Mellanox I2C SMBus on BlueField SoCs
-
-Required Properties:
-
-- compatible : should be "mellanox,i2c-mlxbf1" or "mellanox,i2c-mlxbf2".
-
-- reg : address offset and length of the device registers. The
-	registers consist of the following set of resources:
-		1) Smbus block registers.
-		2) Cause master registers.
-		3) Cause slave registers.
-		4) Cause coalesce registers (if compatible isn't set
-		   to "mellanox,i2c-mlxbf1").
-
-- interrupts : interrupt number.
-
-Optional Properties:
-
-- clock-frequency : bus frequency used to configure timing registers;
-			allowed values are 100000, 400000 and 1000000;
-			those are expressed in Hz. Default is 100000.
-
-Example:
-
-i2c@2804000 {
-	compatible = "mellanox,i2c-mlxbf1";
-	reg =	<0x02804000 0x800>,
-		<0x02801200 0x020>,
-		<0x02801260 0x020>;
-	interrupts = <57>;
-	clock-frequency = <100000>;
-};
-
-i2c@2808800 {
-	compatible = "mellanox,i2c-mlxbf2";
-	reg =	<0x02808800 0x600>,
-	        <0x02808e00 0x020>,
-		<0x02808e20 0x020>,
-		<0x02808e40 0x010>;
-	interrupts = <57>;
-	clock-frequency = <400000>;
-};
diff --git a/Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.yaml b/Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.yaml
new file mode 100644
index 0000000..3eb7457
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/mellanox,i2c-mlxbf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mellanox I2C SMBus on BlueField SoCs
+
+maintainers:
+  - Khalil Blaiech <kblaiech@nvidia.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mellanox,i2c-mlxbf1
+      - mellanox,i2c-mlxbf2
+
+  reg:
+    minItems: 3
+    maxItems: 4
+    items:
+      - description: Smbus block registers
+      - description: Cause master registers
+      - description: Cause slave registers
+      - description: Cause coalesce registers
+
+  interrupts:
+    maxItems: 1
+
+  clock-frequency:
+    enum: [ 100000, 400000, 1000000 ]
+    description:
+      bus frequency used to configure timing registers;
+      The frequency is expressed in Hz. Default is 100000.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - mellanox,i2c-mlxbf1
+
+then:
+  properties:
+    reg:
+      maxItems: 3
+
+examples:
+  - |
+    i2c@2804000 {
+        compatible = "mellanox,i2c-mlxbf1";
+        reg = <0x02804000 0x800>,
+              <0x02801200 0x020>,
+              <0x02801260 0x020>;
+        interrupts = <57>;
+        clock-frequency = <100000>;
+    };
+
+  - |
+    i2c@2808800 {
+        compatible = "mellanox,i2c-mlxbf2";
+        reg = <0x02808800 0x600>,
+              <0x02808e00 0x020>,
+              <0x02808e20 0x020>,
+              <0x02808e40 0x010>;
+        interrupts = <57>;
+        clock-frequency = <400000>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 551587f..40569fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11166,6 +11166,7 @@ MELLANOX BLUEFIELD I2C DRIVER
 M:	Khalil Blaiech <kblaiech@nvidia.com>
 L:	linux-i2c@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.yaml
 F:	drivers/i2c/busses/i2c-mlxbf.c
 
 MELLANOX ETHERNET DRIVER (mlx4_en)
-- 
2.1.2

