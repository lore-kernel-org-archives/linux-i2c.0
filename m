Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795674733;
	b=Rb2np7MJJxOs6/CIkQXt0ubCfWVaZvOdvjie94kwkREIWJ63cpCLAtdw6Ss7p6MEhGzp
	 Sa+NtTOW8aYTCB/MN6CDpKe112+qodF961yDqkP7EpdUI1FmTH2+n90tM8bGRFNnqLRb2
	 9SGe9X6FAxhTokibgzIpnMEVzLJIiHQrLb+EPbAkxx8YbzWFLhLmvlzJQe5VJM3vUwFnc
	 8I+HmRkYm5pJaPDnAdpJ78S5l+UZyJmvbL+DiJ7DHMCR7zVoMxlNnUbHyQC+THfQakJF0
	 mGisSIkc+2Xde+bI2mDj9DeHX7zS9S3/e0R/SswFKR2172Uer9azyS3nWL4YkSBPJPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674733;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zhqVKW78IsVSo/xxxITMweMjOylvGKZBxUx2VVamPk0=;
	b=LY5zksss0PjDxgv2Sgqam5ZPijZ8WPl5Kl3zoSRdJLYVlbcsgBppU8xVieHdeWwy1tcj
	 hAAvOOT4/xgh0DKlsCgtW2ULNs25fE5ZaQS/fmZ9Lc0Hdn3NgOOiwVduxQ8T+A9fzOF0v
	 YjtTKwLGUJVCewI208T6Cy57/q7+vwkPqCyvBpplnWlcw9RE6VeBDbvso7gTZp0WhJztR
	 uruLDtBQixqmCiDLW7iTsMuj/qpcNggBPnrOrw6KbKZqOKXRUWlGdqbYajPiIw+5Ha7vC
	 OXDY4zGWfUBXFQHz96FIUCBfoN8PBWLtqRxIqTJYQwBFa5YeAtDX+apMtpy/XbscXCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHI7zjh0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD74E606A68C;
	Thu, 26 Nov 2026 06:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHI7zjh0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795674733;
	b=aprmstfouwmqbVizzoyFxU3UZCaHA300peahhKZsRiB5PsXf64QNZd4+vCFLIi19/8Sk
	 0+OjEUn8IsKRP6BloPhcbdXOVTt3VuliuOlYqw8qFxNFCCQ28Qh3Oy5JYEUCCskjbcS4w
	 /jtbsaD3N8euf1zD/Lh7A0NmGWSqg1jfnhcgFjfgGOp2BfPvhs0Khwwa9oIrZuYpBfrKc
	 dyWH2m9K7LfCOsdvkA3gsimyD5YGHtpCXp557DgUnToZ6wH2dIoNC0PxUkQvZoACyE60J
	 tDw8284M146z6Mj8sUUXVp4NjiAzATEQNkmSTPOYiIxjzgwGU9JzhDv1M8p5VWBT0hw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795674733;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zhqVKW78IsVSo/xxxITMweMjOylvGKZBxUx2VVamPk0=;
	b=Ax71CpVu1JyviMUuyw1ZyxBM4GOWCtvsNB4hDFJBJNNkZBub8H+jRrAwAIy5U4EQnClf
	 gNSOK9p+PcRJHhtRpbrLPN2M10p1/n3oP0J0jhmpUxOpYJ5+t5LTtfsAsGmMxQNyv/+Em
	 pijw9BoG1jp+57CjW7GVk+KMsamM1XkBee7Q8VEw+4dCIyvSvP4u+wxzRRG7nmSJ83SuG
	 AeodFl33jJ3UuWC8+86dY5yVKv5JudO3zvVpcutPLxUW7GA2akcnPsvQigIF/t5O5uVYP
	 7u03LmN1Vsa4w6MUYHCoMAHLgDAcWzNmfmkrX1bDrONmkL02iFMEDZ6Meoa6DhPX2og==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6E9791F01568;
	Thu, 26 Nov 2026 06:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795674733;
	bh=zhqVKW78IsVSo/xxxITMweMjOylvGKZBxUx2VVamPk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HHI7zjh0AxfoFmJI35S0vMPTGVFFxpdKACbboPTMcCwUQDzJYuBC7cNfFsc84bq/e
	 9FKhVm4AKcZR0uKg/LCHfHwUT6girQr5ZiOqfHk044jfVxBWpTVih5a1MdlVOoZG/w
	 f2mq+e5doQr0YklEaKiufrmz+NGsz5oxzq2YgKOk5TPutrSW2GKXB7eIeP+Fq/p/cr
	 gxD2EQu0O2TDzF5qVS6sxhHSYwmxJuMLj8tqTL1rlyhEptUub3JzQQJHoEqfS8F5wt
	 jWTDxRipFp1UVe8MRMKc7FFPX1tglSRbn0HSStKA5ay2aIXPZ2gpKyfHFQrUdy/0bv
	 LuvaLMCFEd8JA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D2E434D253;
	Thu, 26 Nov 2026 06:31:22 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 26 Nov 2026 06:31:17 +0000
Subject: [PATCH v13 1/2] dt-bindings: i2c: add Amlogic A9 I2C controller
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
Message-Id: <20261126-a9-i2c-v13-1-926e2072cc4f@amlogic.com>
References: <20261126-a9-i2c-v13-0-926e2072cc4f@amlogic.com>
In-Reply-To: <20261126-a9-i2c-v13-0-926e2072cc4f@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674680; l=1771;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=esNib6Pd+qDIMo/qiM5L3Tv0lFF6FFp/SPxb1xx3C/8=;
 b=utmac9iMD4FvQDAZ9xMSVqnFnxhVQbLoAf4+UlSe/0P1eHYA2q5VRU39DiCEcCcO+6mEdC4z/
 njENA1kG7DlD4we/RzZfYkoKF/MI4wY+Nn+Te4ywvkA7sPpJkwvf0S1
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
Content-Transfer-Encoding: 7bit

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add a Devicetree binding for the I2C controller found on the
Amlogic A9 SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/i2c/amlogic,a9-i2c.yaml    | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/amlogic,a9-i2c.yaml b/Documentation/devicetree/bindings/i2c/amlogic,a9-i2c.yaml
new file mode 100644
index 000000000000..e9a4f188aa6d
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
+        interrupts = <0 164 4>;
+        clocks = <&clkc_periphs 11>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };

-- 
2.52.0


