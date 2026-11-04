Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760295;
	b=kSU6jG/IGlpxRyG6nG5gRkT4nLnlIoqTJkRF46SL1RoQkARvE41ZdJ8ftQ/m6ORz1WO2
	 QaF7DUvhGfVS1cYoG98VAjFmgMk4xcYxRdsltCtMwGNhgG/uYEsOt2JJZ87TFWOZYiOPW
	 lmZm1M6QoVyWszgipGEAMnxoZoqONc19rcnEv80jxp2t6z+EGza3PPQ4i+8NgiZ3liXwz
	 z1ZP3xQdv4HTrreRBje5y7M3o3c428VKcuX1gtkwAWw2q3aidohWUilk+/xqwkHItxvjn
	 vnx77qwZR52RAydqVUvZvD9SSyvVyTXRiScWhEjw4pAEod/R/7PY9hh03dmfQVoTKpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760295;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	b=Nu8jejTXY1WSo3lluBM4Mkv0rNYwRI8ENFtS5yIY9A8l2up6ly8jjBQ9CrcqbeIiWcDr
	 rkP7ef8dJEs+mJHLlrQe6Rgw5Np2/lX1hJZdtzBNsj5jMgbe02e4hvk5NrujzmegFYqg+
	 ++uNUyjMHD5cMp7sd+7YCuGxwc1OLZ8HNfiIvM6MxVgZ0+j7vnA4uyRqRvTczq05AxNnd
	 kcInat0DVwke5grcc5TQ4YoP4098mC2CfZbZe6y0KxubmCTsKmYrqozGrIqzho1C38VWA
	 vZ9EmG/mb+5Z03xMs9+hNSc0gtpjucIr/mOron0eYkvZExu32T8O7s4OJzpy4v4FzOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCsmJtmV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC7D606A31B;
	Wed,  4 Nov 2026 02:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCsmJtmV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760294;
	b=R0flO3upQKZwU+aIZp8G9swgjrutBK6yOlPb4Y3Xicas+Rp+c8u04Yq8Iby1cuhNDx6A
	 2J+Ijb2/EomktTDbwr/vD4aWqoQaaM0f5iti/O8l3TZVb+NMWBHqv+/ccwXCbueq5z+ug
	 5y/Uu2xi6XMXXw2+zAt1h8mQliVxYFMYPVkBW/yfDizBdLmmEEGcwCqAJGzrtjYxDtJ7l
	 LZFnODVpvNLRLZZUcCPg+CxDC0wPDEigP7UqGLMsD4IczXU8GEf3AOQmQ6pggEdDbu+oL
	 0JAptJtD31ud521d41FTDNIbculg42oHklrbam1HF5CM7U3292A6p838flxzxRCHh/w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760294;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	b=eKT7k9p2H6YhHmtO3OodKKMubrntj5Y8a7epiZbt9hysFnZ46lksLChIBwHB1NKXtjwN
	 +p+ci1C5CiM9UOAaqwxJsasJYjSpxlWgk0sqlMR2k5y2fXmR8hhLukAHFZAbzyRQUBmoV
	 YBs+ImiAM9+s4L0FrXzd4CCer4PTKGaWxT3Qaa6VdUSHaAKE8M3cS1oiBkCM9mJ4VHvZJ
	 7iJpQ7JHNHqF4Uq0pJ8lrH7I2I0P/It9t2UNeZQQIimRu1Q8uE50IBIxTHn35nV4nzbzk
	 Yb5mln8MRJN8pyIDBHFA2Op5Vj7rq2q7Rwa5XX3J4eQCQ16gBnrQl/iSC2OfUkRapbg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0DBCE1F0093A;
	Wed,  4 Nov 2026 02:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760294;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QCsmJtmV3WkrbneNNkOAb4DBciDcMSmuzKZPxcRKmWGuK+ODPf/xN+XQSdJaUTj4d
	 PdlFj1jaur5GEDvYRL32QFTm6qONWi39C5OUHjCKsU/DIPycKpENl6Tjy6ic97PMqu
	 D1Akpp4B0KiaPPRpEMANNaSKBsme+oxyaoRXx+SBzdiwG6oDpE60R0EKpFEBCZ5UKg
	 9Ot48Knx5OpX6V5cZZldvNMaWmQU0RO1vuMxkfZFokypn7X0sRazBNBh3AYtnuCthx
	 EbGllubFFSCvcRFdj+QgOZGLr2BY2OXuBzzIecXwQ/5h0LulBB3cFC+1uZn3RWf2tf
	 LPRkmVovkbjZA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7430446BDE;
	Wed,  4 Nov 2026 02:44:53 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 04 Nov 2026 02:44:49 +0000
Subject: [PATCH v6 1/2] dt-bindings: i2c: add Amlogic A9 I2C controller
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
Message-Id: <20261104-a9-i2c-v6-1-baa6171f26f8@amlogic.com>
References: <20261104-a9-i2c-v6-0-baa6171f26f8@amlogic.com>
In-Reply-To: <20261104-a9-i2c-v6-0-baa6171f26f8@amlogic.com>
To: Junyi Zhao <junyi.zhao@amlogic.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Xianwei Zhao <xianwei.zhaol@amlogic.com>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760291; l=1772;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=Sz+UB7O1ObrX0Ep7OtBMUUtSVaLagIleTbf9GlXMQy8=;
 b=JlXbRzi78UAxY76JCSiT50f9RrKCV/K77CdIlhpwYQkxpEvnYIlJ2D55Nbu9hju9eGqtBvjXs
 7TZuGHPQV0iCd4rpKBcP4+Gd7Xq+RhMrDB8R/wU3tEREWWAMuIR6zSF
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


