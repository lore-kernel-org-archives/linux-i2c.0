Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794894289;
	b=K8l9R/kgxzhuYZ/LBNrbJ1PN2hNEzwLO+2obeMAldPQ0R5IYL+2KtNsDEdZLf6jvP8MA
	 XM9GwcrW+8nt0JUvfHEGaximi/n7KhW2v7t6qx9LfHZHSNUKHBvG4T0yUXR0MHk2GqqVr
	 qMaqFdfuAS5GACNweCf+TsbWVcm4hPI0mqcjwOe2i+7r7qNWB4XoasqR3bysvwZpqwI4K
	 H8PRwmo4qyWJbqC26X5+INqSzmswfaZm9TVOKk278F00JDRoPkz40xjMq/pfc3RBgn2Qh
	 FkqBoVVAf1w2PondKp13al/pWWXMv7w3U/rDCpBJtSYZVV1cwl00Grha9DbzbM/64sw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794894289;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	b=yMWUcbXhnmAiRHN37C4+wrBpQ+U1vE0mrbqKLwNxhlD0nUuiexXq7mL6whZ7lm83P34x
	 pyhllY96St5gWLoAAvrqp+CBF7+0mAxFK4acFe6LjAjNpwu7A1eoT+thpFvKbSggxw8kP
	 1prtbWcwu5vImBfVgK9gCqRMq/UaLdlv6VxzoZ/TWsHUZYpKVyJsI6ASZClPc7Q6DYygj
	 cxXVeHUDfQ7exE1s8oaOLL8+ccoU52tK4qQvzNSbyFobcefEiO9XNedfAmhSxpgQ4YJES
	 v4qH+3sNJmUzMSvl3bdQJ6mU91BHQSj1VdDadCxR129LCr28wTyVYTWheBiP0ZgvI3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+tZHM5y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4FD606A31C;
	Tue, 17 Nov 2026 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+tZHM5y
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794894289;
	b=kJcy0eRcdoib1/18coylp8GNLOg0xytDI+zByQHgTIZORs7FKzR/806CR9ACFKAJ4nhB
	 vRkTKQyXr5Ml9ogcNaR2DVuQJhcawSYWmqHPnxDDbuIV/yBWnxyknbjYZCmt+MG2qQ8vB
	 LXOhG+JQkpayDfP9OqB87TyaoYw7m/XV+jxA7V7OkY2QDaqRU3/g/ttsihkH1QzGGr4Ca
	 YxbBmiwpselfBalw3LP03b2XTB5vpSsI87msOqKrCB70FLfN1s/0Pw9xnKYrq489yqdrb
	 aU/HR3xToiwZ2/6+3u6D3vx5P/J4uQUA6tY9C1OT4576rbfUMV/xmNe4LJ39tMRn5Dg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794894289;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	b=yCV/RAotFvpJy8gxoiunAwb2M6a5SIHm8nW2vvTLmjOOAY8fZW2dmqyhGf3Vos6sYiJR
	 u9IQi8ZTnl4YCUD6VxnhVt36K5Ag/1TwVPbSTtELk9rOostg2JyXWR3xpRBwQJ1BUGPP3
	 6T6eAxQyOLSyFOL1lkVzKK397FnxJAUd4sosCNYJe/rX54oxzi2WFXE5vTv7CxMR+l02C
	 7JVcvTUUZmYiyLcZujpZi+82KjV06C2OBOdYyr+eZW/Qm08DcY3ywiCH/sWpUCm9O/DH0
	 vNJGGc5u4EmVhrOTvAFr1dUWeETOtFrm6+rGTgoX7yvyxLa+nbnGMDKxLM1lSe88ZXA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B526B1F000C4;
	Tue, 17 Nov 2026 05:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794894289;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=M+tZHM5y7v5CGXUaf5sL0TYuqwPuJ3AtiWhEdBiXb4vQUpGep/7MRgAxTndy68EYF
	 9xINx/+5TrFNPWRsEm6VnC6KxqhGLttV2s6rVq8I/u02TPWyWFNJ4X5JtQc3QyYnJ4
	 CbYlUEmSW6VUxwyMghn6GZAeAp7yOIGVVz7KfaSZp0HV6Qv8TkmApn2QnktUwHbvzu
	 P0XCp1aoVeH+Op9U9bBjcOH41gQx4x0D6U8gyXTMr4vZhAwNTxccnAO46ZII0y4zRO
	 CrxkFs5XasuPfm+zkCHAzkeNFBMf9EFYboLOM0qoHCavM33TfczDG7oafkECOxzpqp
	 jTYFroEXp3h6g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 336944A6CB;
	Tue, 17 Nov 2026 05:44:48 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 17 Nov 2026 05:44:03 +0000
Subject: [PATCH v9 1/2] dt-bindings: i2c: add Amlogic A9 I2C controller
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
Message-Id: <20261117-a9-i2c-v9-1-7b303c894fea@amlogic.com>
References: <20261117-a9-i2c-v9-0-7b303c894fea@amlogic.com>
In-Reply-To: <20261117-a9-i2c-v9-0-7b303c894fea@amlogic.com>
To: Junyi Zhao <junyi.zhao@amlogic.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Xianwei Zhao <xianwei.zhaol@amlogic.com>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>, 
 Markus Elfring <Markus.Elfring@web.de>, linux-i2c@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794894285; l=1772;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=Sz+UB7O1ObrX0Ep7OtBMUUtSVaLagIleTbf9GlXMQy8=;
 b=LwQtZiDefog/mW5dkWxw9MvfHKtDkGobMBdj/9z6JwJYdJ7dU7R0fwa5XQKpnakw24/v+De2E
 Bh9fo/W5fFdAQmUQ74GatK9xlI2fp4MLlYv3DlYnRKgSdj2NY0jizp4
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


