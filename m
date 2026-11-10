Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794298780;
	b=qpqIurZEUGjuBn4uJJhJywCVaaqYaPDEiWmh05EQMNr4zcyA7i0hWcRLCAnVjderTPrY
	 hPOh1y98DNNDOcUR2qbdKxplk9lVbJZ9xbXSAHV8xxjGdhFEno0qd7/f4/0bcPSLNiQyY
	 uL6keLeXUCQ57F+sQHNY0CsJb84XhDrlCRJs/Bslc/tlh96S9NaiPv5Gaco9VJhnU3e6T
	 wvYHEzsDwEmWJFMODbpd0NBPmDzDevQxCq+TSOp4U73BA+FxthUIr5VLmS0sLrYjVp8EA
	 4bqiACMN0cFLWcDT36qc+gVYa5KI2japgUfFvihzTfXMLBZZZK3Vn5qqAjxeFYQs7Gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298780;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	b=O09NN9Fl8xwJASuV/TjjH+JgtvZufnzjTYXR3+Y5Mseb9X04XPN/1tb0ZqECYeg8ekFE
	 5C+VFLbnmwlElfTbXRLA3E/vxmor4187W+zf0H+8/guzI2RdfGVkWuIgAYZ6fA35luDi1
	 KKTbkXH5oOfjpq2I2669B/9P+7wnK7Po9LryHYP82f3JG4Bu5pfTOCEt9TiwO+VmxHno5
	 M6XMAWIQZNbEACuBAhtCdJEiTRlM3DtKv+LiDpuMQn3A0c6S/iuWEzLXzn/sleSc+Wykz
	 zH63nPTtQSO8KyeLNIEcmsc0tbuUicWCAsYmkAp39SR9zPC1//Z5OBA8wM7lBE9MHRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZAFdKLh/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D90C60A2622;
	Tue, 10 Nov 2026 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZAFdKLh/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794298780;
	b=W8d8Y0jCZRqBmBDtgfrtNupf9PZ1cc2druSV/QTRUVo4ZpPUS2KuO06G3VG+sKhvzOmi
	 axyJtK3jXEgYZNu6y3TaAvKA0jxliZg7beoJ4P08x4c+fdqwij02x/HGDn6RXMyRXzYo/
	 DIC7O1gzt1PmSJ/j1PmID8s5hsAdOHWXc+tgVbNMUq8E6y4MxJHk5+cGv5MuK3v1cQJvS
	 YKLca/s9IGYMCIOFkOTJ6DEr3U1+OTQIiPjQBgC/BdFIpPupro/KHsGGj4JIqe6OlyFnN
	 N+fwzbFTNXpEJjGvBPIyvcJ4njp8seb3HAm5HYzFdynAqpCwn61DL5BPQ8v8BkFbqiQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794298780;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	b=S76XXbJ27MVyhzUfzbAS0AKZ0zC1AOyPS1H4Etpu5yJNyUZzjGc0KMGndv01kE6hKU+Y
	 a2ThD3WLBaBKo9oBeOKWp+T9VeYeJUtxtQVdolJ4nQcv4oGX2jNpf0sTw2vJXqVmzqgXl
	 ZgtfgfVl1RF0cNBsg1+jnm0WwwSwqTuvhLBfqY8BM98Fnz3Fx5jGsOg5Nk7thRr5qJigb
	 zvIMSXnZJybEvD4Utc5pMVdKXOLaY4TUOlBnCCZOtCBTdlmu1OQX0pwjILzzptmGN+vB6
	 q274qlEMuCGKO1V2k9Emowhd49wf8CLeO6isu+kSgTfaNipogO0K4TIdgN+ZmuJMKgg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 25AEC1F008A2;
	Tue, 10 Nov 2026 08:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794298780;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZAFdKLh/wRJff2Fnpc6k5eMvaWOa7/vQVd1K3hf/7zuEm/6m4GqUCQZuCPc+yEM/h
	 wI1qFu1Fd7HA6vfju9yq/epde++kzNOKBtjEzABK2LlmItNg65b9utrHnhm6jhmDvQ
	 HZlcgVjC5vR/N/nDmyFSPbzGdbIzDOb4j6IfkQGPSpk6+lMXxR9hQlrDPDZdfB7xRj
	 spJehndg1V2vJroHXIpxjsYVJ5+DE3A02ru5fdS0JjH6tbkR7G15uXLJg3WtLzuLSp
	 aXuuEC0Oi0j3ay9sKSmJZ+nadhZi2XoqiR4XIiuxl2zM7sf8q0QINqL6ZjviWhC84s
	 mqRl0ve3uZ6zw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 91DDE48A36;
	Tue, 10 Nov 2026 08:19:38 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 10 Nov 2026 08:19:33 +0000
Subject: [PATCH v8 1/2] dt-bindings: i2c: add Amlogic A9 I2C controller
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
Message-Id: <20261110-a9-i2c-v8-1-1e9d2682f86b@amlogic.com>
References: <20261110-a9-i2c-v8-0-1e9d2682f86b@amlogic.com>
In-Reply-To: <20261110-a9-i2c-v8-0-1e9d2682f86b@amlogic.com>
To: Junyi Zhao <junyi.zhao@amlogic.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Xianwei Zhao <xianwei.zhaol@amlogic.com>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794298777; l=1772;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=Sz+UB7O1ObrX0Ep7OtBMUUtSVaLagIleTbf9GlXMQy8=;
 b=ZemSN64rnYCKJWWftuWVcVw2dywgjig/XExYyS9+5LJceYpktptJw38F1NZyXTzvxNDbcJdKD
 1h6l7HWg7+OALX6OJwKgGWECZZ1BlBqbZg9mZefeOZY/m8c+2d0Zq68
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


