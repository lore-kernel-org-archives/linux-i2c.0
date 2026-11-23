Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795409490;
	b=eorRGnX8V9N5W4lhTK/QIwL9+ULCzOZ8xyia0ehVm6yMZo0uXkt9zDTZktd5ZaQvc1ca
	 h5QB3c2YF3W38U2yoULM5lrDIiBkkjtGXXgSeEBK7mR4pYmfgN0BvrXIgu1xDNrQWB3Rj
	 FkMWCP+niRudwD/eHReFP9uFDDePGHFFMqW7bP0HV9HorDgX/nK7w21gFEX1G12ySn2cG
	 9OYksoV6Kh9mzQRiFxqDaypfJYMp5U0f0m+p/64E61ZRkF9VDR94UXUdarsKCEqjlA+W7
	 DQqgvNO1hfIPmhgouNI9TyyTkfYXYast3ulZ1vGMgJGLiFMl+nHShcWpes3mUcWAjPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409490;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tdYE7Lz1hXw9g041ObApzQfqyHIfgtC9mdpdQYGD1us=;
	b=UlonbuOS9LpKsXlPtvioyT2KjPH+weN0Oa3Qgik4yzNgR3DyDW72PCtBI0Mjwt0F5Czg
	 BbSB1TJfxqx3X3wdIppfAGybj1xui6p5Zn1GVaz5wEA3J8+f+Pux480UKglFrFCK9V+z8
	 VziG9xWotBPDiu1doAx8GfbJHehimnLYxpi+nC1Y7cgyXOcXpfLs4WDI5I7Ab8m0oM0nC
	 wqHQ660B3oVEav2S3XF+kwBNpdhSc4CUm6X4KKFPtK0xLjaNO18wT0RF7Vqz0Xe+HxtiW
	 juJHbrxB+Wejbtx1VydQuueyWmfPLSmnFr09EHM9GbMLicfBDHgqCwMw2l/vzjCU1rQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6KQ94il;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351D3606A320;
	Mon, 23 Nov 2026 04:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6KQ94il
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795409489;
	b=uaCtF+48IEGsTYUv+R5iyQzwi34Rmg8ajUBKUonm9cOER98Aunhbu4rdmYlkCPJNxpZv
	 8dBy71IXVlmLa76ib9sH7dLDKGGIRXDtin8ooTwCoFKsZkzmvVPi4wO+YV5k3TVNJEFmE
	 ORt5afwKupdouDGoDRfiZ2V2rMKaZMTWxVEetVwl8+KEgNHG37WddvfVQgu5CtNmozP0y
	 J2pxRUxsr0mepvONADEjB3QURD1Rci6CWxHqqr4NSfAvQvd54L29LaOp+UcjlAeffb1Jt
	 /JdxPzztrfKV63ksFx00lYRiNVUHLr7GAdeXDH1qfLS8/K+3yQEOfS1N0j6IJ2+41AQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795409489;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tdYE7Lz1hXw9g041ObApzQfqyHIfgtC9mdpdQYGD1us=;
	b=RiUC3hrFZ+b1shy20wwM6uSUU3YUTbv4PtNMvhWX16r6s2oC9Lj7WNbMGwF7NFSX8VqA
	 SJygbJ6vcjyNy6X0zJDbIYS3WYG/z1///SvMPQZ1GyLdmMwUh1HZL/35t7sm5Dt48R0sB
	 AWDbwhokmXVooVKTD49UOv4DrOk8I380U1tVWQjLF+OUKceC5uOztqEso1rq/yEeKkHQM
	 625iwQvR7kmwSXvipz9kc7tx1bD6+bIM90MeZtU4Ii8dnAylahDyHP4HNRbgpxpyaoK9+
	 Tw+PXO7H1IV7cH2G3Zc4+XkRLTI901FY0wVXmRqrWX6fRCfZLNDCwv1BYwBr+Qjj/ew==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E91F11F000C6;
	Mon, 23 Nov 2026 04:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795409489;
	bh=tdYE7Lz1hXw9g041ObApzQfqyHIfgtC9mdpdQYGD1us=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=U6KQ94ilIbJ19oBbaYSiAL74qyb7ORJ74Iqg7VrOO7bEdJMCxDv8pmWdFxFeuR5Sn
	 xWoBTOis4J9fNiNUR+zr9mk7lIrJ1uQbWKkfSg2OFlJ+ElKN3FYL4Aspv3byI0/5S+
	 5h+9hY07WDqhflXg5igJEBc47XqG7DjI5rI2b9h2sg6lFR5w5sonBW+kaFw/8jWbeh
	 z5SGoUc9iCo0UlgWVlX3o+/ffVMDgkFDj+CMHCGcJ4pRFNvd9oVBKlRnbv2sxa6Wv4
	 cU1V1w6b4S7fsxlgWWxTObh543y4T4/bQc0TwmiySYjAM3jGU68NNhcj/Q3rt45bBM
	 ODnX44cqzbb2w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6C9794C345;
	Mon, 23 Nov 2026 04:51:25 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 07:51:08 +0300
Subject: [PATCH v6 1/2] dt-bindings: i2c: Add Cortina Systems CS7542 I2C
 controller
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-cs75xx-i2c-v6-1-2504375e4342@gmail.com>
References: <20261123-cs75xx-i2c-v6-0-2504375e4342@gmail.com>
In-Reply-To: <20261123-cs75xx-i2c-v6-0-2504375e4342@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795409484; l=1877;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=rtrtjfERWRSSEQV4SOw9IuyiDTovzANcBqx4f0A6z4M=;
 b=GX9eBd7NZbhCv5sgcuOgenekiuygX0PPlZsSXWd2qAXwtAF+P5Al8+tMu0d0QjU9/D8bXSmZF
 ZBkj3NGqwMqBXsgs9a7oG/KetCRUvy+e+rajjs2aFivbaAX153ybcTI
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Add a binding for the I2C ("Bi-Wire") controller of the Cortina Systems
CS75xx SoCs.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 .../bindings/i2c/cortina,cs7542-i2c.yaml           | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/cortina,cs7542-i2c.yaml b/Documentation/devicetree/bindings/i2c/cortina,cs7542-i2c.yaml
new file mode 100644
index 000000000..095e24379
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/cortina,cs7542-i2c.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/cortina,cs7542-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina Systems CS7542 I2C controller
+
+maintainers:
+  - Fil Dunsky <filipp.dunsky@gmail.com>
+
+description:
+  The I2C ("Bi-Wire") controller of the Cortina Systems CS75xx (Goldengate
+  G2) SoCs. It transfers one byte per command and runs from the peripheral
+  (APB) clock through a 16-bit prescaler.
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    const: cortina,cs7542-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency:
+    maximum: 400000
+    default: 100000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c@f00700e8 {
+        compatible = "cortina,cs7542-i2c";
+        reg = <0xf00700e8 0x28>;
+        interrupt-parent = <&intc>;
+        interrupts = <11>;
+        clocks = <&apb_clk>;
+        clock-frequency = <400000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };

-- 
2.53.0


