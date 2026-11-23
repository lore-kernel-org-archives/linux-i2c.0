Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795410662;
	b=jHiZ4bn0ckCGxXXaU2RlulRRZ8nF1zO+U3c2vKungaXkK0Xg+4IffODZunexMJNjqRdf
	 qW3hd7MpG7tLQSK9QlTMsbUTHjPYhCaVQsIqxMGU64AcDQAaXrkVx7nSLx328wlaZNT9L
	 8yEZo8iK1Pt/vf5VExkDvWITyvuHlArv52sOeDOrTxiPTtX2CNI+ATGE5zf0Is4x9D7da
	 z11DSxDEO+9EJOvInD/yRIc+oibV0B3yg/9giKsgQvwTacZp0Hoc9D6LUgNBvydGlEKVV
	 ungnPKkwaY6szPQW23cAHwHeXOZhKfx5TBk5QCySatRncZf18IBn3O55tRT+5XMK7xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410662;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iesDrvecprqj1brWwbrs25SuyK5gHClIHsr42f7gvQs=;
	b=pvGpEXMajxeZA3JL67avFfFeqIpNwfGOfDp+ftzdHqegJnvSk06GR/BQYijerlIsVB/Z
	 iLF9LyKaEK0PnMDQQ2KrRQAQsyW3aKz0NQTkPR0bplBXIfhIoRffVCkitN6BeGCE0NBBW
	 G1trKO7XS1pZXHHOUELVNHi2GfR2RuPuPeCP+iOvMpIVu5cbR4ONrlxZM9wFwt7tttEvZ
	 uWGzccNO+ODifi1W5dKBDOweSP36OITbhXlBoBWVkfDSD1Vt996j2pUAh4LJi0Z+aHzLy
	 t4oQjgQzgi5sqzUvArYvhb1sRJ4utlnTI+lRPXWeUA+Y0ZTTVlw4DCxOHTuqDWxPTkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HsQVSx6m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C16606A338;
	Mon, 23 Nov 2026 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HsQVSx6m
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795410661;
	b=Lzw/bJ6T+7NA+WS7RqIu6IyfzrC1H6aNHCWD/sbS9zYODui4qHeGULtQwAOAXSiAQ+gx
	 l7yvovsD0o97mwJVJ+pDFm5m4JFRbF8g6sD9gtwW3RixU6UPu0YyxHCQ5YamheSAqI0Hx
	 9+r9fOvmXteWp0+hJlSKRvAGTmRZfi6UF/37XVcFhTe6P8ObDz8EXWi7/IvuaUalxFHd5
	 fdQ39g/VAM2oE4vNT8OmXFqedrV4AI5lenioMqpL9COcEAxtOxGOd5YiDLQViEohOoRed
	 emTsrQ0Q2OdouX36UcxkHXoSo1m2ZrNpLadAd7tCQVeFmFoyevrei+Z7VM6aHd2YHjw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795410661;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iesDrvecprqj1brWwbrs25SuyK5gHClIHsr42f7gvQs=;
	b=ZHQ03uCNHALTfFGI1X+ePwEsZnZpa9ROUqn+KpJhKmd3W9u77ALGJgH5z3HCQELUrnVB
	 4P3ML+5NAVTuhTeeh6ro+Xze2D87+VmJesl+hhbVAJl323CvJ4zfUIennGW4nRTIoD61R
	 WYNxJLoAxSG4EvELFJoKU4SasgSgZedi8qtRznHEi3YT/dyUmjAuTSeZ+9KksL8SqKDZI
	 Z0SPqrltLi0aqoylpNkLayDLLt5CFKHaLmn/IY2IS7EECof3cQGUszysbg9j62JJJo9BX
	 5ep9Y1zfecIZvDe3XRtMfAK6vCtmshG3MglN7aT5Lm5U6XynWuNKNxrWH4Wdn0FPkiA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B7D4D1F000CA;
	Mon, 23 Nov 2026 05:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795410661;
	bh=iesDrvecprqj1brWwbrs25SuyK5gHClIHsr42f7gvQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HsQVSx6m1V3MPRgyoZyGje/pUry1BcWFAxJ9q9XIv+/STLiA2aw3AgDfMN7zuk8MP
	 eqirJz+EBO9ncVD729HmQFQigOKKKhtQzS6QLBg+PUZTwn54UFyEstKSOyzOFZ6Bou
	 geSqD9crO02w8dig+XweESTu0riSclmPaAdpP8wOaXAQnD1P3KZcwyeZfATVzxoLOS
	 syc6SU/hZOwNhrbMyKi0ooNNTlDT6k9SrLatf8YRPJCZW9G3nD46qGd+EfjwtFo+YK
	 w0VNKmabz4NiCkRfMwhyyslieaJdREVfdAwPCb+DRT9IY3+XbElEf2+4A67TdQIQqQ
	 oehCYc/f9lORQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3F0C44C35A;
	Mon, 23 Nov 2026 05:10:53 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 08:10:37 +0300
Subject: [PATCH v7 1/2] dt-bindings: i2c: Add Cortina Systems CS7542 I2C
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
Message-Id: <20261123-cs75xx-i2c-v7-1-42080ecf30be@gmail.com>
References: <20261123-cs75xx-i2c-v7-0-42080ecf30be@gmail.com>
In-Reply-To: <20261123-cs75xx-i2c-v7-0-42080ecf30be@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795410652; l=1877;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=Mzt932NWHbMP6cNTGXOVF/25Jv1slV/2vvPLoA2toCU=;
 b=2tl3xJcvvYkzaLDpD6OPx3Kioh7YkbIeIFOrypeoevgitlqd3X5WID8y+HaPvOT/G6eVEjdPb
 Q2aEwENKPmiCQr4FNp82Gm37XOQQ0HN4NTPb15txPYxPx14v+MqOaMC
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


