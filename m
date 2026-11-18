Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794986265;
	b=uBZXeRcSoGVYDSNS1QDl/3yXPvsePgjXPp4pMRLElIXe1iVsLpDGcGLxNiwTKSGhuJue
	 5Z4/72QQ0BMG1QfnqDNo75vNeG3S3cYU76rYm/D1UwZgFhsatUZGKs350vojKEeja+rFJ
	 iIxUpk26orJo9FuCbr2i0GHXhaiJB/rNALkKi5RvPRlPIkxVmkxRFJZhufK9UZxgD0Pyl
	 +zgW1j2FZ9wGIIWTehCBlxwVexStJuzDeJUjc9ZEjN0c4Y3sr8GSfxNQd1Xi6tJx3HXNR
	 EZKmfkWh+2jvepVwfUv0H8WRkNKLoE3Jzon1xE4hw87bS6ihun2Uh4JTFScg5fiI05w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986265;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hzfOUTtrb4gURy/ze3K34NDYNNCwcpFVgEVGom5qxcU=;
	b=D9zDkH5PFmILVWhDGZG+VdX0/iXolIiQPoBM7SYXdEPsMEMYT+DWutgG6PtOxnaZ5y7Y
	 TP4je/IeFCVYd1w5n/9l3RfaGdZ5LmlhLF0l1d8se1lfulByLw191B/qnwClr66JLfaar
	 lfPBeKpqJ43VvyQCtUDyUJS7EtjW/U9ArPnmVYMofTZYevlZHCRv3iBTX0CCb8ax2/6TF
	 kfzHGoKUB+WWzbdfNc7IsNzVRUzRg6Gd28F4r1VPyqgatsxq64E8NEs+D5XmMd1M153g4
	 U3Q4qdyN/7EAZn9k2H2kBkBbJsrbSlWfHA3GEVH3qyZxeN2w34w2eVTUaQwvj4Caa2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hc4Lmn8T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B8606A881;
	Wed, 18 Nov 2026 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hc4Lmn8T
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794986265;
	b=z3idMyvZctlEgRAB6lhoOKkl2LAjRMfXhvbC9rl7kan7sGj5wUeox4bSTs9qfkURe/vj
	 kWPA1bYp6wbHfZl8sq2+SleotqGB2zxo67kM9LwT+D3Z9v42jOe1DsIyQC1+mYvAEI0B+
	 HddTa/AQYwEgVEWT7deL0Xl5Bx+2yewnhDGIQHfJ/9BNL9OJ4mtrNvuYkMMj7wP7tFcCS
	 aP+c7G6uO80W9/CUNGO+UFCCjiJaLOVqIMQtjlUXMrmMfIUW3D9oJh6Q5NHZKUElJ66tE
	 RFDu2wHPezeW099l9rRjUpcyq39k7ddXiUmtJpFc4jWwzVlxzKry2DoushQvZwoZGQg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794986265;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hzfOUTtrb4gURy/ze3K34NDYNNCwcpFVgEVGom5qxcU=;
	b=zJTYbFp+MS4LTccOaBeimzHZCUHqTkALyicK+iiaWWXC1DHQyEq33/DkBILX+O6jkwBT
	 WAvyzO+Q/djA22q/qHTohpGp+QsLaSFYtBTM/mZoBC54R/qsBcREypQ37lGjx1PdfJ5E5
	 t2ORWUVthOATY3PHIEuthwHzjwEoF+FXhy8Qlq2ElqjmUgLPfdfH8wSjNi2KGRy2xNIxw
	 s7e1J70tlN/k/OaiQLvp7rkVL9yJDjgkrK/xCOdf5RgzaYLjwIQseBcoAaCG87XrUPi/Y
	 wde6Xf1sAXWrXRWCyPTrumrrdODS4DXEv2C6cYom/Fi3bobQPhCMygy1DrxFm3+h9AQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 62C2B1F000C6;
	Wed, 18 Nov 2026 07:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794986264;
	bh=hzfOUTtrb4gURy/ze3K34NDYNNCwcpFVgEVGom5qxcU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hc4Lmn8Tl5+dzqhFWeGOe0cLgqZONkgeZr1MTM4YYizQeS4fjrFfPJDpWY2mRmCd1
	 Jk7SxuxpnFi6ONmu1TjAzuPJlRfG/l+KRZQdujjyEvLCElTuvFNztnoKD/ukGo5pAL
	 b1+1fIf6JrLsPzfG4oZOJ9v0F1Lfiv4e3hgZKSmgeVnBJETxjshwn92VRpM624VbIS
	 juYITjez0ZokcZRLntfjAITfmaK/Xhun9oEASFfKf1exfzIFcIR2+Bkh6liTOYpQtP
	 Q1fGu64ZSrvrsKKJo0F7BQmqbnQK036OS95RoN1Q3V7e4pTJSF9Md0aBCjjMLgYAsr
	 af76ferXguhYw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D69974AC1C;
	Wed, 18 Nov 2026 07:17:43 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 18 Nov 2026 07:17:35 +0000
Subject: [PATCH v11 1/2] dt-bindings: i2c: add Amlogic A9 I2C controller
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
Message-Id: <20261118-a9-i2c-v11-1-68a3e79ff43a@amlogic.com>
References: <20261118-a9-i2c-v11-0-68a3e79ff43a@amlogic.com>
In-Reply-To: <20261118-a9-i2c-v11-0-68a3e79ff43a@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794986262; l=1772;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=iah66EzLU1pEytVqMNVVA1xNmz2D/VOvKtLvjcbBFk4=;
 b=W5D7jb8hVV5UVq7VsXJthzgTf919BkgYi1iy+eb99CIwcn/BI4tr2UvBNEjN2JviCbfNi8u+p
 wO7Yc8Rh3M7BxfURMGCyeV5NXT8CayPEOqA6Ug6jRej4mhKYm8mV7mG
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
Content-Transfer-Encoding: 7bit

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add a device tree binding for the I2C controller found on the
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


