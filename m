Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793262820;
	b=LXv7Nlx0IrB20Qy65Cdht0vo2xllCvLWF3Rh1tMRPPdwjho0St9RlvFgJTd+G+Pcq8r2
	 ZXSwxJcNTTY8sbxX4Soo9w5ZvLzMyh4iwC9tmKB9/4JMylmhH5tlWrAwQhW029SBAeHkZ
	 sYcMGPhWKEVu7i3r4yE3CvxJ9YLNU4Lo7vG+sqeWGy/rCLJf4/Q7VLlova6jS/d59a4nm
	 P1UWoY0cVFbuvyYPTmPM404m6cF/MTKDAyZovajeIS7xh8mrpG0cS/GNGNciu/l8Z6VFN
	 9vxw3AMQlyMgaiDKt/e4tRYLek1uRss6rubgTiiFv1xndGn0QZwtRQdcOQyMUnpH0+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262820;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wfbg6tsOH+5dCqR6eRG5y+pRRouozsxb6eB2ua5FAlU=;
	b=LM8g1/+3MxmJc3Y++THvuggDqGGqOOME1uuAQsANSyZpe+Q0ILszOlbvVK92jPdUJ+T6
	 bWMRyHlvHAXdT75iZRATvJRHZZDxQ6G53/yFtPVQAZA3sBumpSZDo4zI8OXrvK2TMmG6Q
	 Pc3m5PmQ8eqsTthngXBw/PxXBRnSKkcdabdYQ/iZ3XAgnPmOo/Ii5PdSAh9qXc8IfqwBr
	 zbP/5J9I5UZGuX3DKU3XMFz2Z2VDHdsipTzcVoelSwDKBYFayKPdx9Gy3hE3+vp9vnos9
	 DdsYJeXgaUJjLYFEXo47YnZvtxmLPBDzTmbU8GHJSNjExBqEBu8EDmawCvD0RjcblgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ku5KAvPV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ECC606A31F;
	Thu, 29 Oct 2026 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ku5KAvPV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793262819;
	b=O6avYZVzfb8mu6p+Qd0in6LHmWBZPL3YJLnIHF/qFOlHHcle3mdFXqRJ6+yZyeB5WUj7
	 roxgr3k1rLfomqcEWzX+Gnep6J1B0KM3Xanb3zJRbkcuEmA543C7EimAimwmDYpkEiRNV
	 177Le3BbaC7eWSj5G1AK8sva7ABYNpj5JmxTXA+dODEDGXNq1niE0NNtBRwrIZ22CdUgW
	 5SlvdO98yUOEBiM9qgqwXM0RP7ky0DH7hshdxxhG9zOFVRxpRU/GXjfomC6VznrZOAyfM
	 xvaVALRldHIE1xdWi7Vh6Ul1sNPpUNWdJBPaLnr3uHRwxmHwpG8o0vtdwsGmaFqDugg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793262819;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wfbg6tsOH+5dCqR6eRG5y+pRRouozsxb6eB2ua5FAlU=;
	b=Uz6vt0BmlSFdSYFJSUiOXx2XSzjySRQ68UCQHn8WZ+mzKgDxF6/hm6nMbRuGXArcKh9j
	 TEfxoi5vVVr0/l49ZDp6nE92n77anUgK1oo22CJfxFrzOMAK84ZCGJwJ0rWXy2yrB4YQf
	 k+ycFdrwDfYxMG9ZpReZ5bA2AP4QQUm9qs3r7emPxxISvtD1O9VmPz8wA7Wt7vYv+N+aQ
	 SKEyLXg3VIJ+rVwvgqElDH4lit2M6ZrlWvHsgwgeNLNEu2nscRIjd2Vw5h8UpYSgk3Xbu
	 JyZbAnbOU8TMZURV5bL/zNmAwzsqx3I5M0zDyIuuWy9IF0FyI34oTxhbg01Qpce2/tw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B81401F031E0;
	Thu, 29 Oct 2026 08:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793262819;
	bh=wfbg6tsOH+5dCqR6eRG5y+pRRouozsxb6eB2ua5FAlU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ku5KAvPVzn5kgug5VlO5pFM01dkfJlKS3q7oFnPtx1ZBQ6RL4Xbs5+f8TUvxoWFvz
	 PM3J1STdrAdcfJQSTHVIibCgPqIG4XGUwmiQU/KpM7up3npkObPcO8UyeGmIf4swNI
	 ZU5fpUyXIe6DGBlKmggLWUdJPE7jf0yyd1IzBC5imiv8uNRX4arkelEEFk31S+EJpU
	 ugn2vvSmBdBbb/dtTLqpJN5RoCPILWHjQdYIr0KJq/2qdY1ZeIYSR1pt7/Os5Egbrd
	 bt5WSvHN66OjC/L5Q1PPazpy1IqTT28De2xW418kGhw+ePhTFuyTZeo4uQ68AXNo/h
	 QY0xmPpLbwqrg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 282E645798;
	Thu, 29 Oct 2026 08:33:38 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 29 Oct 2026 08:33:31 +0000
Subject: [PATCH v3 1/2] dt-bindings: i2c: add Amlogic A9 I2C controller
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
Message-Id: <20261029-a9-i2c-v3-1-7b30ccc00533@amlogic.com>
References: <20261029-a9-i2c-v3-0-7b30ccc00533@amlogic.com>
In-Reply-To: <20261029-a9-i2c-v3-0-7b30ccc00533@amlogic.com>
To: Junyi Zhao <junyi.zhao@amlogic.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Xianwei Zhao <xianwei.zhaol@amlogic.com>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793262816; l=1719;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=/oijmKmiPfKgJUJzYs/dQncbUdJ0Rw2jHh3oFq2y0wk=;
 b=K3lpRC3GsEy/4C7xa6a2wK8dpLUAkKyhjF28mJILjbzgr+/D3ksobgpAXTC6XiZjmTDjikxGY
 8p69WsNvLQ/Chgom/hRUwpPYlwbONwTYbVi9E0FRlrQxNYVPZF3rknh
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


