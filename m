Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795509233;
	b=0m0fpEvZsZxppi0qbEYZxwj5JmiNI8cQ8GfjVas+EXLsvsTAzRBzBtM0sVVpqB125nrK
	 SgzNFgOoNZyNPxIzZ8CokF1nv9oZOUo6rclc+9Ko+EQ0IIgtnHlUzoArVqqglwc6CQexr
	 lfEDPCoh6uDN/sPo9orUKUtnD1tnOcBm8uiwOJ/04BC9ujTquM0JvB5m6cEB7Ii6gzEzj
	 Ip75KWbtdxt1JaII0gwopznrtxdhf4Bp9Xl/9F4pwdGHiv8dNb63uq8eOj/CFCSihmO0K
	 SFWU28bdTqJO5eQ8aNMHP+Rp6O56Eqm0fI6ztFae/TVSPF4UzJ6JgwRAmhBYdHNA4/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509233;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iesDrvecprqj1brWwbrs25SuyK5gHClIHsr42f7gvQs=;
	b=oKFLYor+9ZrhaShgXfGI+Fj70+sAbzDfMGPpIn45EySQWWsptn+xiHKoe/TYUSZD0ubJ
	 DXhd5qgOwwqwY18l8G/5SdfE08dc3li06nku82ZSlvGs6KRkvrXfEn8AC5JD2B6aUffVD
	 YVKNoS8RzXPkg1UALbagMVL2JBsA2v0BIZrbcT/3zrhWpwfH1wq6RfgJPMCe10hfMYP7t
	 w+qwpZ69NjtyEPX2B4z0sUflpmpRgC31Gau6crDyJhXhp2Xb2A7WWE26bK69WFz1x/bgj
	 5mruoMb1+lTf7aVG7MSEzfbBNDIMZKJervtFo9vS4tnKmabjWzHyCgOE4Awwf/d/Zew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/9z5nEq";
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB3606A33C;
	Tue, 24 Nov 2026 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/9z5nEq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795509233;
	b=Ds9SRDgSd5m5URYxUz+M6ypinE9wET3ioIOECpFVt3wnV4q9XiLpCPng3c8qYk9fb01x
	 zxLBGl4dXg+65pWibK1XjD2Dr6T/QrHvThkVXdZ9JoT7NrUq8kT3fOSDSK4L+KyMqeL//
	 +qX6RGCjNZc0hlLLmosU0aFTn4X+VBKN6peOj5PiROwtPpMHdqkTLP/yvDEMuwnPuysw1
	 s15WRXFjd5HvkicpIkluwEq73x7tlNaZih/QRV18dP4Faxhditnsm4/dkrm+kikY5jL5F
	 yC7//Oi+bpIdokBeDnyBlXByzHUNsnu7U87m14SfmtPEXFSMhGk7OcDDYKxjvW+B36A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795509233;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iesDrvecprqj1brWwbrs25SuyK5gHClIHsr42f7gvQs=;
	b=PYVRYiznC8iFxoMowl1MeQTyma0PUEZ8yeYJ7OT7iaTjokyNxIsbSmfOjxmN0h3XyyPS
	 5qPJG1j9ksp3DvcAHCSs9x+5LAMReg+u7vqYtTNg3YjYDysvyT+px/IX54LAr2MtprNpK
	 rtrTwI0H/APcjV3yQq6Ll040sPMloKQ4xMVmmSCCeaB8+mPa/MwnSjzakI3GxYDsesCRa
	 2ey6L3VkUm2OIId0RXH5Un/8JASZMX0IbDIbYiXk1VW0UjlFBJ45ZiSTbmYCfTSmKJTKA
	 IOXRalMoB/l3uwnlI3MtIAFNjwCWSIfSOk14inQKRlhvJSw6NzUv6l1/aqRR/mjFstw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 30E871F000C6;
	Tue, 24 Nov 2026 08:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795509233;
	bh=iesDrvecprqj1brWwbrs25SuyK5gHClIHsr42f7gvQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=U/9z5nEqtLv3wy+sA92RkVC8I7ovn8vYYCiJ11Q4pZeI20SgdvB1GoGU+5dF40ey8
	 6hgfwL09QY5lG5/DItt5LCx6QeYjSReyLUyeohBbJx6w8mP39n8lTaCXBLhUirRqn9
	 310ZyiYmSVGWryruYjVI/m8I+qPNfrsey6+X36QZuczPVzK8EYxMtZv9rISEgZmufJ
	 VAmntv3ZLBpBM1PkzVcErxfYQTBq65Wp1wDq77MVyZhDzQAWlRPMWYG2ay5XgsFUno
	 edKsfElbunDbPWxo0Zt/LDFXXT250ap88Ymdr2unPwsqAA/sWRtumE7/lPeIVAKD9q
	 Yk1NZu+t0/koA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B44704C955;
	Tue, 24 Nov 2026 08:33:42 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 11:33:42 +0300
Subject: [PATCH v8 1/2] dt-bindings: i2c: Add Cortina Systems CS7542 I2C
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
Message-Id: <20261124-cs75xx-i2c-v8-1-d0800b967886@gmail.com>
References: <20261124-cs75xx-i2c-v8-0-d0800b967886@gmail.com>
In-Reply-To: <20261124-cs75xx-i2c-v8-0-d0800b967886@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795509221; l=1877;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=Mzt932NWHbMP6cNTGXOVF/25Jv1slV/2vvPLoA2toCU=;
 b=PTWJcxCX9zi3Rsxe6/EDc6NUx7zfYiCnBUQXEiRBJAgW9lUoCz8OY+KXJYvKPug2pCZoOfm78
 crfxOkclq5VCE8H8qPXAhAP9NQjPId7M9iEU9YkXfLwFiYLfTtfmwCh
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
index 000000000..ef31284c1
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
+  clocks:
+    maxItems: 1
+
+  clock-frequency:
+    maximum: 400000
+    default: 100000
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c@f00700e8 {
+        compatible = "cortina,cs7542-i2c";
+        reg = <0xf00700e8 0x28>;
+        clocks = <&apb_clk>;
+        clock-frequency = <400000>;
+        interrupt-parent = <&intc>;
+        interrupts = <11>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };

-- 
2.53.0


