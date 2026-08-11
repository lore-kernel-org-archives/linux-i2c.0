Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945713F3287;
	Tue, 11 Aug 2026 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786429790; cv=none; b=gWfuGY/XgWe9Te4a1M4WE+wNxQhe/AE6qMIbhQ7lM7aHcHNRs+V3Sr6JaXjIuJ9NMwg1EhpgkhJUn0nJFe3tpqeB5GMgW+H2/ZhYHJd66sX7whCfN21TryGtLHX9r7TdgfdP4escgoMpESuDeacUgiod5l7o1Um2xKXC3qBZ3yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786429790; c=relaxed/simple;
	bh=rxbnkO5Bo9eMuXTx/7aC8GXRAwV4Vgxstp+S/wWtRJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ET5FRa+MCVzDdJV7KdQhxS4MQPjzWVDAy2y1KToODtJ1S764Qc79MhrH3ugFUWAstUuC6+coE+zhJpJd9mQE4AucoaRsnQYxsetujqgbimQDlDRBOFmSlqCCCoHLR9tPGf5L6vD5PJXVM9V8YQjfQ/uKIePrUqstl9yLaC+ZmCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff/NyR1F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff/NyR1F"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 352E9C2BCF7;
	Tue, 11 Aug 2026 06:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786429790;
	bh=rxbnkO5Bo9eMuXTx/7aC8GXRAwV4Vgxstp+S/wWtRJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ff/NyR1FN50F4B2rrNlK4y4oUH9BwfVNRofg73n4e+xOIv+g8dgEpVg+dKoJFlwDg
	 MGcYb5QEJvfZ8L7rW4IcYEgVjlKcnil6enhhbCRxyfl9Dm9FzKL8YQa2L4WRenuT4x
	 ZLRc4rJLIhm8D6lE6S0Cnm1h6TiQpaKb6IMz9vD6NJ1T4YDDLVNAoiSF6AqBOy4A/K
	 3OiO+XxQVJk3ggn4KK7n1njwS0DSuBIyogTKIpFYZzZTG4Yw5aiXj8evHkckgyqoR/
	 5IP/leX2PNpLK4sqqDrjocHSZU6k19gZ5uI6yAsX9H9ynELJBA5/wh4iSPUmnKuUaz
	 AnUY7SZlPLmqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BBAC5AD7B;
	Tue, 11 Aug 2026 06:29:50 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Tue, 11 Aug 2026 14:29:48 +0800
Subject: [PATCH v5 1/4] dt-bindings: i2c: add support for AE350 I2C
 controller
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-atciic100-v5-1-1d306c21dba3@andestech.com>
References: <20260811-atciic100-v5-0-1d306c21dba3@andestech.com>
In-Reply-To: <20260811-atciic100-v5-0-1d306c21dba3@andestech.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Ben Zong-You Xie <ben717@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15-dev-09770
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786429789; l=2147;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=bq3xzDJ/OIuUwfBkMViZX6pvpmLXUhLZ07QGmtn5ZDY=;
 b=jLQ0aV2x15w7MTRX/V+ERzbSHB3sC2BMYjnGoGn5kladTHrDAZW/eeYb/kKShILU4286x9sVH
 CWF2HlU6y4FAD3ercY0Q8wV70E6dKPeNlqeQjQI4vFtub8gJpQgiIcv
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com

From: Ben Zong-You Xie <ben717@andestech.com>

Document device tree bindings for the I2C controller on Andes AE350
platform.

The ATCIIC100 is a dedicated I2C controller IP developed by
Andes Technology. This IP block is a core component of the Andes
AE350 platform, which serves as a reference architecture for SoC
designs. The QiLai SoC also integrates this I2C controller.

The binding introduces the following compatible strings:
- "andestech,qilai-i2c": For the implementation integrated into the
  Andes QiLai SoC.
- "andestech,ae350-i2c": As a fallback compatible string representing
  the base IP design used across the AE350 platform architecture.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/i2c/andestech,ae350-i2c.yaml          | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/andestech,ae350-i2c.yaml b/Documentation/devicetree/bindings/i2c/andestech,ae350-i2c.yaml
new file mode 100644
index 000000000000..59a521fb249b
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/andestech,ae350-i2c.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/andestech,ae350-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andes I2C controller on AE350 platform
+
+maintainers:
+  - Ben Zong-You Xie <ben717@andestech.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - andestech,qilai-i2c
+          - const: andestech,ae350-i2c
+      - const: andestech,ae350-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c@f0a00000 {
+        compatible = "andestech,ae350-i2c";
+        reg = <0xf0a00000 0x100000>;
+        interrupts = <6 IRQ_TYPE_LEVEL_HIGH>;
+    };

-- 
2.34.1


