Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793674364;
	b=NhjBdcpLqLppajGhzU4UPxnWOGww00gfgzkVHzBMH//0FtnheAXCYyuPyOcxN+1Efj7t
	 a9PdfNU0KAIjCEAJ60JwJNZNQte1/4zK04h7g+9sur5F+byFtOb0HgdY290CW/+AImTdg
	 1cRAfWYOucmDbPNl6iX4wyGyOE1gcpduJon2zyIeipdrN3dFX1sxTP+5/zkYvgeTfXGuq
	 AoqnxuaoneGPtH2rqNwyE92sQV0kj1u0tFVtjX4ZTBGmTFZbeEsDxf8IiwsLlhaxi+jCi
	 r0zU3TYNIKt0V7SI+zjZbNyomaeGUqV0eBxoLNQFPNskMhehWQDdR3QvNibI+2mGWrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674364;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	b=IDHvwRjy6t2YsrgGo4Q4zKJmSys4b4YlPC5uvWysiAoNqPQuehRk2TL5jhSvwnad0TFH
	 MMxg+YehClMteWNXcpjvJcwY2ahPAvjOukN+ILgudyrdd4f2C8Gz/hynaGjqy21OofWgv
	 dwN3SbVJ0UMaiJTAoh/cSW60235moRxc2aCp2GPK9upPxvgvxdzQdPehB4sr43khWTKHN
	 yDdxa2dplWRU66rShKDqNK/OTFTFgYV0Luli7r89qfgoLnAv81lSIcsM1LieRJVUsSXNY
	 uUG5dKelOqWT8+2aS5v6a7TjaFRzhzPD6JNpYU5Gmwf5SoFTpwt+M21WOq4x7ncgS0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZF33uj0P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD164606A327;
	Tue,  3 Nov 2026 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZF33uj0P
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793674363;
	b=Wzr1kkHTXmw2t6ybmt/PjiIfMITBGNkzmfYgAH5FYqPGasTrrWj0+bkyqY6X8SeOsTMB
	 Rd1s94F6XMrC1mQcjnk/cORHJgwADiw3plR+aQGgekNL0b16Gvlci0f2U1q4wShIxI8AV
	 gqI4mmy/fv/5aLbF4m27+HRnzvii+PnF0A2q+lls7+4ya4mfBO9+GjRVS6/VuDSPs17PT
	 X8gk+YCGL3u51/ZDeSs4IQ5K4ReC5Q+LVHxoPG9srhFot8DEO4bdC/VFywv74f7luVeFR
	 eF5eVN9pUgmyEa+PL5Ghf4ki+Fe6RFkyF8FeJNZETC69+/0pHGY+L0KAQK6VIeu1q8A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793674363;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	b=KjoUhtyjxSh7O55wm5eDq4UJrWjTHzwCRb6FBCb3vQSzS8oblb8gCloTmPHJSbLAmLQk
	 Sf6+NEQXiDIbroYwYIMEZbWUdJSEIsRFuEj/Eg0UZt2WaKpClKCsvsH3vR5wJdGuJzhUI
	 rFb1HnIo85Fzc576UVq4e7vnWypZrF0Wg2WOpDALUPmqsFfWLM+tx+28WTQHAcNs0CFca
	 MiSZmU6UkJQahBG+9DZZEXzbIXL/0j0LyxH/XLYNRt2x99njT33ROFHQGtkTDukQ+WDIz
	 xEuZVSJ+1h1vy5MSibvxQyweCCsBFEYO5roQaMhAF3gtdYi0AX9M5o32iU3l/lVg/tw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 12D931F00919;
	Tue,  3 Nov 2026 02:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793674363;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZF33uj0PzCSjw77b3ZkdVPLX0/r69alTZTDaRXqrGNDfTsCGIJgPH02gmS0HC2H/k
	 xVjOSYTE8Np8U0/n4/KVrxoZZOCWxMO9rB1T0cdqdT3HY8sZeNrxtARcwBm0HkvwZ4
	 vk0xsE4mlXoERN3wruzzpa8YI1zr4IlmZ8oMEWEgCfs7/tLXMpi6ERwyJrebr23ZIY
	 yzgKfZcoh4mLKiOzXSxEkf6IoukEUNGEbIGXUd4ooz2KjUjJ6v2L1YG0jyywTL+dsk
	 cKN+G3QeY11GHhg101jFPRGHMzkopDtPDL5rpHg8vvSjw37sBNe8HjDHLrctb5VXyK
	 1c+cHvCZRR93A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 94C3246724;
	Tue,  3 Nov 2026 02:52:42 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 03 Nov 2026 02:52:37 +0000
Subject: [PATCH v5 1/2] dt-bindings: i2c: add Amlogic A9 I2C controller
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
Message-Id: <20261103-a9-i2c-v5-1-86f2dcd179d8@amlogic.com>
References: <20261103-a9-i2c-v5-0-86f2dcd179d8@amlogic.com>
In-Reply-To: <20261103-a9-i2c-v5-0-86f2dcd179d8@amlogic.com>
To: Junyi Zhao <junyi.zhao@amlogic.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Xianwei Zhao <xianwei.zhaol@amlogic.com>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793674360; l=1772;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=Sz+UB7O1ObrX0Ep7OtBMUUtSVaLagIleTbf9GlXMQy8=;
 b=kr2LxbDlUScN8iC/AFpWrtMjpomSJf/k3a/RSAvQYAO6W6Inh1FiN5mZCD9znK9eDiVh65Pmy
 VJwp9qJnBmOBMf6eeYUhdIijzyKNg1FcS6XREUoJj3EwQbFybsipGuh
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
Content-Transfer-Encoding: 7bit

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add a Device Tree binding for the I2C controller found on the
Amlogic A9 SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/i2c/amlogic,a9-i2c.yaml    | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/amlogic,a9-i2c.yaml b/Documentation/devicetree/bindings/i2c/amlogic,a9-i2c.yaml
new file mode 100644
index 000000000000..31ddc6d23732
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/amlogic,a9-i2c.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/amlogic,a9-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic A9 I2C Controller
+
+maintainers:
+  - Xianwei Zhao <xianwei.zhao@amlogic.com>
+  - Junyi Zhao <junyi.zhao@amlogic.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    const: amlogic,a9-i2c
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
+  dmas:
+    items:
+      - description: DMA controller phandle and request line for RX
+      - description: DMA controller phandle and request line for TX
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
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
+    i2c@3a4400 {
+        compatible = "amlogic,a9-i2c";
+        reg = <0x3a4400 0x3c>;
+        interrupts = <0 164 1>;
+        clocks = <&clkc_periphs 11>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };

-- 
2.52.0


