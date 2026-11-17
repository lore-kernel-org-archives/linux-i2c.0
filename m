Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794916743;
	b=Z/dGpV4sAZdrQo/j6/WBWpaFO3rQFVbOdkVUSmRP+nxRhdArDwqPM428x44utmLi7Rp+
	 INLOKjPYJ945bQpUO8BLhwOzTc4CPuGMzkJyPK7VPATgHiDXBnwlXlwXHyPyBQKZvCRVf
	 0xpIZBLZnXa8v7QS8J77iSDXAn0Hk0iqmzj1lioZlvrRRE25xMeVjKTsxTPivRvSWyO4x
	 6keY1fIlAOpvyLpLkor937g7AfYSOOIJRnnXVs+jcAXniWxHu0RtYk8lysQnT96QknSNt
	 Z/L37KU4c4ZvPumfpMK06f8iH3oV4WJgWmKZP2ssvaE1UMA75G2Qh5aGQ7RZ8EePPsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916743;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hzfOUTtrb4gURy/ze3K34NDYNNCwcpFVgEVGom5qxcU=;
	b=oCQsyAenUAEL8nemG5ScLels9rmBNJCWMZS+X6KAFPO3Kr/2sGzYjd0UIZy+T6Y3uuyx
	 MNECWXYVLM3FwWdip+0U2k7NzRRc3sEjSSDZ6sr86PKzCO7fq/lKKBs92Tjg/Wng2FEpz
	 rDI55hGWIwqpuHzu4jQsTfSXMAE9R31wYgUecmWuZbetcq1C84xqxjECD6ZcEb5RDT23w
	 +BdZIjLXcx4bBXpTxX47v8YZ5NniuCyAoZU8Vx+9E0SD2qgUmgu3YuZHbVXDVS45FN3A5
	 UeGLKHetEZR35s2SQcoJx5Ml9Vp7mnfUWz8RynkRhOPFZrXfzUSgHoz8q22i1AieAzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d4NuoOmU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3059606A31C;
	Tue, 17 Nov 2026 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d4NuoOmU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794916743;
	b=Be+Rb4G2jpVf42MkQ+fNnG9AkkhwrP37RiYuRSGtB2F5jrLPBdJe8Tg1i5c5UwCiT05f
	 wGys3LIn30DiX4EKShR2pttifWI/CHcRDn6HholTSgsIawbn6lf7/G4dhndGfJp7dZMKL
	 wFzJXqS4WbG009laz9mLpwZkcyhNunSeIuypYiWLFm6UNNIKxAs6wxnUv8BOPNnqH8GMV
	 w/InSGmdhoMJ/RCZfk9kJG/6a+qhv5JYQ7kVNA4z5hZXVuetpVWDkIvYBfy0395GNymBK
	 6wLfEQOZzuLB01Oh1HYicdX3xNnZ6wsxLVbsrvGQ9IxPTZ0aNHJtj6BStq+If0Sb67A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794916743;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hzfOUTtrb4gURy/ze3K34NDYNNCwcpFVgEVGom5qxcU=;
	b=x+RFpTC+Ip363HimUqyZmjx51kbKjoWEw3FOM/J8tBMmwQ6ypDIJEIAX3Z5rE0A7+QdS
	 qlyqydz5mRyCfwwsEoT6NrH6wbNwYOSiN5yRkLdduSzikggE5noZjuXFKafLHIrJoY6bf
	 OX0wNucequG/ZK07+doYHRxu9hUd4Bdc4BWPLkMRfVzWvKoo/0C/BrxeeFgi7bhgI/Aqo
	 xBCsdtpN6yOmbuH7a6Zl4GinXTPjpPdOaglB+aGsNxcekNidSbYeOAdOPy4nliSRqjjCB
	 /wo7dpPaVbADeGGNGnevI87iLlq3MsQ9TlV0LVE4KpCsC+l5TV32nV/53rfmSjV0AJg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CAD111F000C5;
	Tue, 17 Nov 2026 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794916743;
	bh=hzfOUTtrb4gURy/ze3K34NDYNNCwcpFVgEVGom5qxcU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=d4NuoOmUdWtwhAdSqUiCa3+LozeP0ncJpDDouO7f0DID5KaIviZ8QdB3PdR4KT44n
	 VI9w6MlowIEYnJgYMXYT+cBOn7AF+VT8gJLAcuy9exexeX/zjV1Xvf0F2fARldQGf1
	 YALvP3S+YE1AJrYV8FfT5uqCNrmIrwM/3Ik9d6Z9RX5o5xorVh8C+wDg7BsLC2Nj1A
	 cwSed25Caqv4lQ2cQQuL2rlM/kAXEDd0Lpvy1SYulgIvjRe0GMgoABERwOokWiqp8s
	 h932hfw4yZq0LcOpIzJQlqAwxY9Km9LDtGM6J4MmhIkn/wSE60h+cpFcpe5u0tkYKZ
	 cnV//nYSp2PYQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 46C3F4A829;
	Tue, 17 Nov 2026 11:59:02 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 17 Nov 2026 11:58:56 +0000
Subject: [PATCH v10 1/2] dt-bindings: i2c: add Amlogic A9 I2C controller
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
Message-Id: <20261117-a9-i2c-v10-1-33ea9aefce20@amlogic.com>
References: <20261117-a9-i2c-v10-0-33ea9aefce20@amlogic.com>
In-Reply-To: <20261117-a9-i2c-v10-0-33ea9aefce20@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794916741; l=1772;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=iah66EzLU1pEytVqMNVVA1xNmz2D/VOvKtLvjcbBFk4=;
 b=3GGZM+bn2Jmb5O7qdF184r5WouD9/Zl9wk+Q45sX98ioLD2maUiU7hrGTya/C2U1NxYbB/4UT
 ZMMeZ5+mod3CZf89+JN+Xa08ts5JRbRNFa1y9Glc9RmN4VOkI4ueZoq
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
Content-Transfer-Encoding: 7bit

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add a device tree binding for the I2C controller found on the
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


