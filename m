Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794761740;
	b=HTLpMxnR+GKaL5jfOn+uytgbX4DqzQyqWJ/c2Guvuki4xxVXK1eqx/GnCq4l867BqGKz
	 kFcf8NybwuzRXtur2T0WCkqjRb4+QlRlpGwfHjVVNq4313mdIia2tur2mmvVSNGSM7FpF
	 8MvF98WKjEP8bkY/ikX8WP6qSy7/EQWHAThvbPxx/8nykemSDv3d4TpZe0YLS4MPIWZax
	 dO8Qr8sBjmLI9Sv7ONfPXyBfNLkmMrWLRx3b2Zb0IoboH3s27ayRoO+C/v7QSUugGkAYa
	 wPwvETNfJIv8iEaRRvFN9HSNDsfWOYJfVA+7kzPAz8P0jewdV2ue9qqx3vxFMHd5ttg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794761740;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tdYE7Lz1hXw9g041ObApzQfqyHIfgtC9mdpdQYGD1us=;
	b=nPHlshDrdUO1XGtSVjeHiwYe3f+CICg8tvUUWuaRQOwCsEaWJv3FcC7w7aizIAR4VDjU
	 R+kodemshkhB5QOak7ScLrqiyUZHiUrztUCWQwDParD/cL4z4DqMdSDaCPPZhbybPiRlR
	 ua/q7z8Gk+COGK6IlVhQw3xyjfqiA6ID1QhWDjSOWqArHEmL1jggRlXaFUpiaxQp1t94U
	 ky1WW/lpv5yE+623w1qTm1IOzD8kTJDGjNdwwGrnoxyGQycdVws5zDxYjbOsXKxlUG7t9
	 w2k0X0kaZZsqZpRskU46uNovXvXg/HaYxxliAkMfGrsNhQG1JeJB9/ZuVv5lTMwr33w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxQPvEDv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB33606A31F;
	Sun, 15 Nov 2026 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxQPvEDv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794761740;
	b=p8+xcwliW7eVnvCDsF0SQI2W4L2BpjKUkOPcC4J2OiVa7cGNcOADGRap2YlX5GacV+XX
	 cal1ZdKZHlOReBDDqLzoYYaMVwXCp0+/Ulik0oxD4e5dpMypaQ33Nk97+kwLulmo2SJAH
	 +ceO2ibUA9nn/5pzoDa34eIfpDWSz8upGx5TRvSz43diXyXqR3CnX2dc+C3v66uBMAaYJ
	 dCZfhiKs/PKt9SqEc89R02+TKoMRjPep1bqncy6Z07iYF3vbF+V4Ef9wSuEwwQ0qFbH9m
	 PoQ8SwzPVgsOy/fqRQfM6fQ9vZ088L8LzjlKY3lCXIQtnPk6rrI0WHW4JnVKir1IlRw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794761740;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tdYE7Lz1hXw9g041ObApzQfqyHIfgtC9mdpdQYGD1us=;
	b=cAlMLuV7NMQE3pzwMrgbsE+z//FGbKYqgRFYZuey6jak6h9Jwbr5hDFsv7NTA2bfYh2K
	 DW82E/8u6qeKQ9J1m1Ego4vgJt1TKjVvvVk+XY4zg9jGZ4iDd0BOyKx3wwcWzIIdKO2gH
	 M2Ztpe5wyLYOK6hrRKpsnCGPfClHS1kYyN281vb2aXbpubXsr7lwPM96CHgy25u6SFzTF
	 GfR6HcclecAX9pc38chqVrPVHZY4JcUJe7Wx89lREs++SCufKeGUTVgyku1zVZHSAnhHs
	 XlfMDaKNaXFjcFcijEp4vVsl6q6aBKk43DS3p6jCIAJ5j2b+8fhmJ3diqqw+Y4ZJIMw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 81E281F000C4;
	Sun, 15 Nov 2026 16:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794761740;
	bh=tdYE7Lz1hXw9g041ObApzQfqyHIfgtC9mdpdQYGD1us=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bxQPvEDv+rFJMfF5lnoXJM9hyv++5pLTscAEoiDeVU3tJ6tl5OJ9+akVG/QAdmq0x
	 7nGWP37338ZRoiY2dGh2+9denyNBJ3hqbpvg7Gm0FbUHMlyqdZ+n8U9YS57uHQCF+J
	 U8o8JMvHX7G73/PzIuVpdo7qScwy0bHgf1h9i5+7IfCpAV61IRzsBbHW47jPM2yt/X
	 yU4211nxLxQxpdUb8ugZnkN6NxPyMOc5LEg/fvPnNn7FU+Kn+vd3uJKHIREnAjizOs
	 rPxhI/vodEXXrVmJ+TaAj1cTm4dvc4bt+2OPYbkTwKkns6IfTpr2y7m8d2QBOJkzKn
	 SDSI3gwHpDQiA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F0C864A102;
	Sun, 15 Nov 2026 16:55:38 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sun, 15 Nov 2026 19:55:37 +0300
Subject: [PATCH v4 1/2] dt-bindings: i2c: Add Cortina Systems CS7542 I2C
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
Message-Id: <20261115-cs75xx-i2c-v4-1-4b16eea98a78@gmail.com>
References: <20261115-cs75xx-i2c-v4-0-4b16eea98a78@gmail.com>
In-Reply-To: <20261115-cs75xx-i2c-v4-0-4b16eea98a78@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794761737; l=1877;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=rtrtjfERWRSSEQV4SOw9IuyiDTovzANcBqx4f0A6z4M=;
 b=9mKRLqx3p+39G3boGf8eJMBmiF5o0mKXufTeQTJN7V+fJVDkucDM6/04owpmronM1HD5oCbzO
 gVcdDkTvGo2BD1HZUceFv8uV9Zslr/7d3PGIo/y3l+h02te6RbYEj/J
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


