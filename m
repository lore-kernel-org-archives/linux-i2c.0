Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793786466;
	b=ew285gIfg5fOGgxy7Trmw3UkBas0VaSewSiWkzktTiqkMcABRXs7JBhzSup8gV4dbe56
	 Fjh73FDU25L0c5JWAi88Msisl3S+repJqae2OniwT74nWG+J7hjB5X2NpErSp1AKN34z+
	 CV28OYn2NnjVC4YWNfZfxjdzOYeXlgvpEeXSO2BQKV4n/hIZJ+bGWppiNOjfSgWjsXE/M
	 Hx2sT2hkHK9fJWRlMRQ6IQSJinrx3t0rmHeVqyeEz3alTbGnFy7u09v5/95UoHDcHAbpz
	 NSP0bvrAdzioJDV7IYyuqz4PMZTKdDhsVA1XqS4OS5AWvsRGvsNXCo0Qe+8WIwV1FsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786466;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	b=JcPUyfQYTDOpJ7YuDZ/8gkPuFDwbfddXntra3wviURH/R8WP63oUM9U17i9HslHhwH7x
	 yDMh/awWJutc+Xbog+K7DVhqWHKDOXeUbHryDC/tJ8WGbffwepQCpMyjVQlO3tYmsayGW
	 RblKbz8S/0XcL5ovTqk4O4KqwhQAEWAd9SgpiHuxjWquje4Vk1q7KZbNt6f0i93VBKubC
	 rWmlItEqfFBI2taSVRXp4wbPakzJJXm5hx9g6/+gMZtysZXbxJnId6kxlfRQqQawvyfHP
	 XrFfuZ7wU+y7WoTZ1hSqNRIVeoZ7iAqB/odz8EPv71N76qiJCIJsr+A89sTkrJ62C8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqXuTlax;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B29606A329;
	Wed,  4 Nov 2026 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqXuTlax
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793786465;
	b=scNVdgp2rgL4qYKiFohA5AADhM7i3P1qyMfYtWuHqcFiDTnHc161r5kww2VYLRVNTsUw
	 /558y9Hz22RIlJZ560bha+t1nmmTfyDop/s1m9T8pqBayxw8S74oyNUJC/XXph/HuXwdA
	 +71TV/8LHQRwATjn1sYLxeEp/Xcg5s8b5nhwKyqb57rVzxUqyi2TJLEzgGEfRzwJlFkpo
	 cqhdymGVhuN+B0tkcOObNJtKTggiQqP9lhohIkJQWG1JytmvuBsIj2k17/hQQUa26ZLt3
	 kj7b5d77PRteG7QZlYeyEWur+fFJQ/b8uwAOZxbYMPR+MVv0kmbjUz0ZcEKEzkoALtQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793786465;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	b=uUaPcWr21hl0DxE/qQlMfqZgYVKhvqC4EqVwsoGpYrXVEaJYawhMwBgeACcvf5944kNJ
	 CH51uqg1ezcJC0dlpWD4fiLehEEU/FE0P5enkB/Yoe4CJUcQWLh5JeghIv5EzrJha5FTm
	 p2fkDLv3m4/biBQJrs/pAloiQF7QVtMElwnDSACLLmlkwHIPDeYQwr1NlyWFimElIrN9R
	 UjITaXHPCfAOIqghpo4HSZY4TfqaYTKky0Gc3K9iVI9fO/Ng+6/r9WWHRpN56m6B5M5ex
	 O4MA1v/06ncXrBG0N/emapgyM44rHtb8zGxs4cU6T91FVU47TLgNRmywF0QQkr/EzNA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6FDC01F0093A;
	Wed,  4 Nov 2026 10:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793786464;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cqXuTlax2xrNkjJikKcmq3GGRrC5XCO5Y0T1xKuY9UcD+1oO+1pSgf7bKEC0xTh38
	 CXHBC9jELYysMGXdE/v6CiQIt5BnopB4TRuO1F9prvp6EkjMFLiMjyiPFkRE0ggdAJ
	 U8nCN0X5EPKke1HoQaJUOLGwBcT0GLte/IxOmoUkQNfBdxPOKn52b17PXGIiyt8oKo
	 LgmfJVGTz3bTDAlrMZ/uQDYXsMWCXKYlJZqvMAShUb7t0pEEUJ1vVyDzamxk8BOaMV
	 Lj3ESnL8NKM4phWsCcZyH+d4H9vb0BZedkK00EfOzkak4i9uXDUL5EuLZvQayMdsvT
	 sYfJptCdxgLnA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DCEC146D9D;
	Wed,  4 Nov 2026 10:01:03 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 04 Nov 2026 10:00:59 +0000
Subject: [PATCH v7 1/2] dt-bindings: i2c: add Amlogic A9 I2C controller
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
Message-Id: <20261104-a9-i2c-v7-1-b31f2b53faf4@amlogic.com>
References: <20261104-a9-i2c-v7-0-b31f2b53faf4@amlogic.com>
In-Reply-To: <20261104-a9-i2c-v7-0-b31f2b53faf4@amlogic.com>
To: Junyi Zhao <junyi.zhao@amlogic.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Xianwei Zhao <xianwei.zhaol@amlogic.com>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793786462; l=1772;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=Sz+UB7O1ObrX0Ep7OtBMUUtSVaLagIleTbf9GlXMQy8=;
 b=WhtEilMMr8PFBI9Pb17tCw2h/eTSiut7hp/36JutLYvH6xzDA5FVFYAnrXIQWffZnoFVuReL8
 ZoSMrKJfqQFBC+BZT7oS260qrELYZMPCpVwQPCszgatkGwIhHxVh6t7
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


