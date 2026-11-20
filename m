Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795157414;
	b=wqa7prG5ZIhC2v6i5FsGKeSjqe0F82ijkMlpIc9hlJ6Bzxv7QQreGvSzrGbuW18bYOyB
	 WoiAGseihSI29iSgi0GjSF/HPPS6nlzolkR/vOEfA5XOE8u6J+Vhz4rfDPTQQ8jDKWE+O
	 c5IrfSGz98HTcQs/V4MpnUw/rtxk7pbop3LQuWH3U1w+9erISPgLVk4n9GXqnb9ochlrZ
	 kk1UPM0oPgkz0zMvJgY7XMSf5tXIjn6ZZpFLQ7Zl6V78Djo4JG0zow+thcWyC8IhIeNmg
	 RD/p1HCpDBK25E7uPr8eWBSchUUto2dLIZtP51okx22+ASpdw4REBs3VKQaHP53/MDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157414;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tdYE7Lz1hXw9g041ObApzQfqyHIfgtC9mdpdQYGD1us=;
	b=xTtyzx5b5XnAIE2GQQKpOJ07cfiupvn9io6CfMS7an93xldu1e85L72ldFD0rUmd5R78
	 Hnti2SZvYf8rZNH3SDOxg61avFgmkymCh/7jpbFjFP2MUwgMevTqprEChzAQ0QGC1/iKt
	 uCcx7zw28Qh9buJaYF2w6nR/i8nUaFZTeynIK3ja8xErW0FywkDjJQe0Wb/C36vfLHDtk
	 siNElPQKsDzDDIeG1mIXnzr87FhKaJbBRL/Qj+K3L6QIvDu3EW+U8hYyZ6ihTrqaLf5eI
	 HdMYYh8JeNybQh4A/9cN5fYlMLxLSWENCcSdTuSA3tYbEtm1Bxsrj4O3XYlcgSjbmlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dra/uNWN";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3398560A2602;
	Fri, 20 Nov 2026 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dra/uNWN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795157414;
	b=CooaHElJWqmk0iikafLjc0HGWVICwzHwhPibldhL3ECh0nmQ1Rq/V69hiIi6qfmy0k7R
	 UgQWqq7jKYpK5FaIb1KjWUw5OAZ0J4qrCSY1NUH5FkkYCZ4d2nHkJ0CSNTgNhQOpIQXaJ
	 TGo6i7iX2/lrm/x8VP2EuCklD8ojxV26QjvIvMFNr10154GtP9sDur2GF7iluEkpnEWUz
	 3yF1sNoVkUn22ZLn45aryGJSH3rzTgXxDSB22QAnATPisLwRSBY/zlg0CYfmEwMhG9dov
	 IiEMOH6XkqYF1zCmtlzgeTkHLUr/OgLj77GANZAk3seH2QBy67kPL5SOH9aEcPCLsHQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795157414;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tdYE7Lz1hXw9g041ObApzQfqyHIfgtC9mdpdQYGD1us=;
	b=3JtNKZ/IxjqH9AO+uG+T1EOUlP2UQjHnLUso64UHvODSDbzjy4WtFfjJ7bXuGeJBgCbt
	 L42zfn4U6aWP872G1IOr+VKDMfFmEs5y0kBeEIt2A4XTVk7VzkAMi6lcEa94+9HLYuDj+
	 WZ/n36bINaGIefsIY411FFkTaJFRG2IbRoVb9Ee2UcpANESZ4oSR8qb69uSQVKD4UVg5B
	 GbaTegJjeooeKrGpizWWVDgZ/BMUlbrHmojxJz+bWpl5Eagi+i4X4xEu/1ZjFOC+/So0u
	 rynZKsr2TuZ0EYFt+Pnu2hXEm3SjXmlV63jRmRCOE/Zc5PZTvJxlS/dHW9absIVfTWg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B454D1F000C6;
	Fri, 20 Nov 2026 06:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795157414;
	bh=tdYE7Lz1hXw9g041ObApzQfqyHIfgtC9mdpdQYGD1us=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dra/uNWNe5Z3CNSqhank6iiwTlarX54Vlhp5Yv+vXqWGAT7CTpojeexhtNGonfto5
	 SaZcACVhuYzmy1vITi8boOnoAlKvWTnTd7EtSFWcHFyLwL4Qf+/QFXt/wKi+uWmeBb
	 mML/JF76Nh3zBtTajRWlycWz1XnkkJPauMXfT1mp+CA411k1QLIi2x+o6Bsgour4R3
	 oqOBDkZb2/PsFJUvECq2IrBxmIGSj5ugFxsuvOb1fCCAe2IrqQYvjTK/s5FMnPbiux
	 PwtfnCR05Wdjnxxq3Y4wJags4JWxGHvMC9+uyDlbr/bGw6kNNefWLZcZDe2lsQojKd
	 0qZXOV9CD9UCQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 46AD749725;
	Fri, 20 Nov 2026 06:50:11 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 09:49:44 +0300
Subject: [PATCH v5 1/2] dt-bindings: i2c: Add Cortina Systems CS7542 I2C
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
Message-Id: <20261120-cs75xx-i2c-v5-1-03bec242a549@gmail.com>
References: <20261120-cs75xx-i2c-v5-0-03bec242a549@gmail.com>
In-Reply-To: <20261120-cs75xx-i2c-v5-0-03bec242a549@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795157410; l=1877;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=rtrtjfERWRSSEQV4SOw9IuyiDTovzANcBqx4f0A6z4M=;
 b=WvqxN3plu4y+ajpANgKaDHdLTTEp18Tm505MOL5RKfD2hymHMruyPXDqrxXVnrpTOJ7aGgFGq
 +gf6KUSfln7DILcKM6qAfRkasOiaMsLJWsd7lek3cY2M0YehdpSlvul
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


