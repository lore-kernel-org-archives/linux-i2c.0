Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B753B42F2;
	Thu, 17 Sep 2026 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635550; cv=none; b=P6//FoYDy8smlQQIw6eas4rZ5B95vpSi4le8WjiQYtAFxN7F/St2COtghEJRIBU7eUf84hdoBwQDb9IrkO+9hfcPXPQjJYjc/PthiDDvn1m8SpriZY20PIlXI9+ff5mJ3B947qwXaUAUyBSEd7ldjQvxSuTqssTZp66KcNrvvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635550; c=relaxed/simple;
	bh=5x2SMNb7+b5GXtdGVw28NhZvWXSIR43M9sEtz7TZVr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tC3dqxs8Xhf7EcRBHLBcLx3qQfTHxu/v7mpJi9vNlbc5Ib2aY9KOJx2zyYavpU/ru7Mdp9S1zT/CG7vFhp1/fIgDXsWlycAc2W/zbBG0mCFpgpUF4cLrGbqj+DbYp23si4P7JqOH2KgqDlrbBunjo0zEMFibGEpfHWdKdPHLubY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D342200054;
	Thu, 17 Sep 2026 10:59:01 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0728120009B;
	Thu, 17 Sep 2026 10:59:01 +0200 (CEST)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CB7AA1800068;
	Thu, 17 Sep 2026 16:58:59 +0800 (+08)
From: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	peda@lysator.liu.se,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	Shiv Prakash Gupta <shivprakash.gupta@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: i2c: Add NXP PCA9641 I2C bus master arbiter
Date: Thu, 17 Sep 2026 14:28:51 +0530
Message-Id: <20260917085852.552079-2-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917085852.552079-1-shivprakash.gupta@nxp.com>
References: <20260917085852.552079-1-shivprakash.gupta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Add device tree binding schema for the NXP PCA9641 2-to-1 I2C bus
master arbiter.

The PCA9641 arbitrates between two upstream I2C masters competing for a
single downstream slave bus using a lock/grant ownership model. The
binding supports an optional 'interrupts' property for interrupt-assisted
arbitration.

Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
- Add Acked-by from Conor Dooley (no functional changes to the binding).

 .../devicetree/bindings/i2c/nxp,pca9641.yaml  | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nxp,pca9641.yaml

diff --git a/Documentation/devicetree/bindings/i2c/nxp,pca9641.yaml b/Documentation/devicetree/bindings/i2c/nxp,pca9641.yaml
new file mode 100644
index 000000000000..649a3f6d1776
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/nxp,pca9641.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/nxp,pca9641.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PCA9641 2-to-1 I2C bus master arbiter
+
+maintainers:
+  - Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
+
+description: |
+  The PCA9641 is a 2-to-1 I2C bus master arbiter that manages two upstream
+  I2C masters competing for a single downstream slave bus. It uses a
+  lock/grant ownership model: a master requests the downstream bus by setting
+  LOCK_REQ, waits for the arbiter to assert LOCK_GRANT, then explicitly
+  connects to the bus via BUS_CONNECT before issuing transactions.
+
+  Key features compared to the PCA9541:
+    - Lock/grant ownership model (LOCK_REQ + LOCK_GRANT bits in CONTR register)
+    - BUS_CONNECT bit must be set explicitly after receiving LOCK_GRANT
+    - Reserve Time register (RT): guarantees bus ownership for 1-255 ms
+    - INT0 and INT1 interrupt outputs (one per upstream master) and INT_IN
+      interrupt input that propagates downstream slave interrupts upstream
+    - 16-bit shared mailbox (MB_LO + MB_HI) for inter-master communication
+    - ID register (read-only, value 0x38) to distinguish from PCA9541
+    - Four address pins (AD0-AD3) allowing up to 112 unique I2C addresses
+
+properties:
+  compatible:
+    const: nxp,pca9641
+
+  reg:
+    maxItems: 1
+    description:
+      7-bit I2C slave address of the PCA9641 on the upstream bus. The address
+      is set by hardware pins AD0-AD3 at power-on or hardware reset.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Optional interrupt from the INT0 or INT1 output pin. When provided the
+      driver uses interrupt-assisted arbitration (waits on LOCK_GRANT interrupt)
+      instead of polling the CONTR register. Either INT0 or INT1 can be
+      connected depending on which upstream master port is used.
+
+  i2c-arb:
+    type: object
+    $ref: /schemas/i2c/i2c-controller.yaml
+    unevaluatedProperties: false
+    description:
+      I2C bus node representing the downstream slave bus controlled by the
+      PCA9641. Downstream slave devices are declared as child nodes here.
+
+required:
+  - compatible
+  - reg
+  - i2c-arb
+
+additionalProperties: false
+
+examples:
+  - |
+    /* Minimal example: polling mode (no interrupt wiring) */
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        i2c-arbiter@74 {
+            compatible = "nxp,pca9641";
+            reg = <0x74>;
+
+            i2c-arb {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                eeprom@50 {
+                    compatible = "atmel,24c32";
+                    reg = <0x50>;
+                };
+            };
+        };
+    };
+
+  - |
+    /* Interrupt mode: INT0 wired to SoC GPIO */
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        i2c-arbiter@70 {
+            compatible = "nxp,pca9641";
+            reg = <0x70>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+
+            i2c-arb {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                temperature-sensor@48 {
+                    compatible = "national,lm75";
+                    reg = <0x48>;
+                };
+            };
+        };
+    };
-- 
2.34.1

