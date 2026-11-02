Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793605694;
	b=dxoEbP9SwwT08/BxDcJ0Gl19EEuiXao6iSteHeG0X0TVibR2l+Bt//2Mnxlh8KEVUGxM
	 zTaU1YHtWDis4q5J6WxIrsSV+GECp0kYR0R93PwYGtOJnMqz/ZJurbX1LYbKcD8CxZUT7
	 xU7APLpxirx8EOPqhhUS0DIpJciEJP+gw9TvTH17dAhRh2qkhMEcgRix/VNl3RY3fyuHD
	 2uXycqNa9sMYjF/UZZn2nyuwhcqwSjBY8ftyMfamNkrMGaOQD0vWgObp3n5IPzYkJEc0+
	 skTPNvCoIoZVOTKeuZOw6sRJXEKdpALg09d7qntN7Y1BVe89XNBLZRiUp9wCpEdDm1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605694;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	b=CotTaog4p0ZEji8B3fpZNBeDwCVfF1mOpgKxxo3uGSYHVzli6GXz0cofxgaX+QX8W43z
	 YwuwpwK7jdut86BlJQGBtaLuAQPiKInBO59b4dN9Ds9WqGaQoiQghufwsiSbTh9lQVHaS
	 x3/Brwi5iWHu+JViCD1Vz04DIh6ptru64W+F4KdJQkxvRIuVPVD0bvTo4V3hhMXagADKj
	 BulgvW6dcDT5kpCCV9q1loiVOwHQiOypGDhi+u8DD1BqNpUNUt0zZ4EZuMYfg5rQaVOoP
	 rVUk4mHZOWd/u8xkKrhJMgC2x0enToS9oP7WPlMVEd2bP0MCycRpEWRZg0L3Dl4VX3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFnUArU5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C58606A326;
	Mon,  2 Nov 2026 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFnUArU5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793605693;
	b=2aVnclzH9QDgAfo5sw0zaNp5TG1L7zD7DxH+o6Bsvbd2qoBrQfyEwmoVfOmQ2H+bm7yQ
	 BRZHJzvMMoNws9PZKjU67sP8Ghqc5bcmbQI2IOaY+zmJNHR6LGz7ilFPC8baiL+Kscg4l
	 g06k7LToHD3WR/lqKRAYAyApW2qfpYrNKOAERvsJB3zCOFKgdFIZLmS7E3QJN/yb2PEi3
	 4SWfvxTjfLL7NldD7gtp1mELwJe2VT7cBnUDaOsJsjJ43vLbdsSIJ2WCcmCqA3tj945cy
	 whEM9Mcs9095CPRdoVGnAXtR/BXOd43yXYMnqtbPNYCAvnZ7DH7EC/8z6xw73c9GTzw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793605693;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	b=RgEtvbaRJsIs/4q7DLf6g811dQz2KX1eY1uQYLZlEt4MfcSWUJDGpFPXd4bk4w0PoReb
	 HQcMWWQ6Li0BajAARtPu6zwAHucltZouccLfVFrP6PeoIKQehqpmDmjH6ex9mqkMaWNIH
	 bJL0mjOMMweBAzk5SmjwwKm9dJFHnAqbTmiE2XM8kv6RmDmKwQfaBD3j24TPhZAe5NFOk
	 7CC1MAghOT+L/EXZp264TPma6+gpaPBSeCfEl7LX5mKYi+lMR8J2uLFf4VDaRJN93IaJB
	 uaUHBoBIF8d+HThuwskofSDggIErVh4MMKoudJ+Z+qRS8kD+2nqxhs/fkqrlh3+idIQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7CCC41F00A15;
	Mon,  2 Nov 2026 07:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793605693;
	bh=kNMpvUIklLoqq2U8w19NKhZcvl6ucrqllQnFyuCL2rA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BFnUArU516smxMVMPmr9QtuOSrlRXMj8rR8gM8eS0Jf9Q4czUbkEGGsNpVEoj4T+b
	 kzhelQEmn2Iyxz/0/tSxZZkyeL3CfuQiMrMyAgAfnVdVmI5WIF6e1WL+XUiSHCZ8yb
	 ON0kMtQGZHuNFyY7mRBHrzGnNzIEv75Avbp5PWX69WeuGcRaKgwn2KSqfsE9tf70z/
	 pAeUTUlgNPfeJ2nsOluS8TjAD81pAENY+Hs5ATVph/0swaczOHPKlevbkgqgrgb2y8
	 DdK7V/VzFVM2oZgqd+u3HOVCcuQrzS1bVOLD1OpcSsM9hM2XzRUORa2V0BKgkiZnLv
	 N0of9bjYiyPTQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DB78A463EB;
	Mon,  2 Nov 2026 07:48:11 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 02 Nov 2026 07:48:05 +0000
Subject: [PATCH v4 1/2] dt-bindings: i2c: add Amlogic A9 I2C controller
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
Message-Id: <20261102-a9-i2c-v4-1-5a169215b8e9@amlogic.com>
References: <20261102-a9-i2c-v4-0-5a169215b8e9@amlogic.com>
In-Reply-To: <20261102-a9-i2c-v4-0-5a169215b8e9@amlogic.com>
To: Junyi Zhao <junyi.zhao@amlogic.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Xianwei Zhao <xianwei.zhaol@amlogic.com>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793605689; l=1772;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=Sz+UB7O1ObrX0Ep7OtBMUUtSVaLagIleTbf9GlXMQy8=;
 b=av5Ql9+8d9vLT3ZQYaKplKx2KQx0t1LZ2lKkdNcJiyi6LqOZ06R3jNzZPe2YT+6OwK5363yym
 h4IvLCPjkHaDuRPHx/V3khEQkj9Dc6Ly9V35wPmF3InXjTayIhBYKEd
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


