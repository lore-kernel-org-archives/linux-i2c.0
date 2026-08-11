Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24EF3F927A;
	Tue, 11 Aug 2026 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433451; cv=none; b=nx/vWk7FaC0BnIjrgVD1xb6EZp/+IqEyeINxJWIV7EfQivhBUhBNFmyDBxNQ9oCZwYmU2bY+qIJ48gbXFXQsxT/530U11wrAkuKy+q6DVErlQaU5ivWZM+vsvCPkI6+9cQcokhCN0FUrkwUIuM6Xga8cRXSh6gixA+YENGU4lG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433451; c=relaxed/simple;
	bh=hfHhiTgb4XN6+OmhxPjnbiGJhpiE+aEFIzGv7DFVI+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/07LMYeCo+szDRAGsWtswRouUv6gmUPvTpUe6fas5FyTYgaxQCwiR2cdi7RlGn+D/u8lO5nhzQa/bpSZRsHthDNAS3yWREOafTJRgA15qG7WVTH/RWXONmw54CJ7tkz6GooXn4ScZ1nD/obCQ2na3h+NoRJR3ca6EMrlsgPZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=gQLkzAzR; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="gQLkzAzR"
X-UUID: 8907bbd4955611f181a149c3f3c08161-20260811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=2hzHDIWE3mEzGndEe4qZhyai4rE2yhXImI+04A3g1jw=;
	b=gQLkzAzRI33wQ+CVDgUAi7N2g/yW2hXfxt9FIH9ovx7mtGVZskLf4PohuDNImIR9guydMPzgQ4HoV7Ermb9uQsO6sGLJFzfjiw9tXC10jRew2gz1sycJUpGSNvdFILDPb+uQIp4h50pYIq2gA08QsXijWjNBsYIsepArUhQdu4E=;
X-UUID: 8907bbd4955611f181a149c3f3c08161-20260811
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 793082442; Tue, 11 Aug 2026 15:30:32 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 5FEE01A22CA;
	Tue, 11 Aug 2026 15:30:32 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 656C9C600D2; Tue, 11 Aug 2026 15:30:31 +0800 (CST)
From: nina_kuo@novatek.com.tw
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ben_huang@novatek.com.tw,
	toby_chui@novatek.com.tw,
	shihpei_hsu@novatek.com.tw
Subject: [PATCH v7 1/3] dt-bindings: i2c: Add Novatek NT72676 I2C controller
Date: Tue, 11 Aug 2026 15:30:29 +0800
Message-Id: <20260811073031.1019576-2-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260811073031.1019576-1-nina_kuo@novatek.com.tw>
References: <20260811073031.1019576-1-nina_kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

Add Devicetree binding documentation for Novatek NT72676 I2C
controller.

Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/i2c/novatek,nt72676-i2c.yaml     | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml

diff --git a/Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml b/Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
new file mode 100644
index 000000000000..c9dd1c0d7957
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/novatek,nt72676-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT72676 I2C Controller
+
+maintainers:
+  - Ben Huang <ben_huang@novatek.com.tw>
+  - Jason JJ Wu <jason_jj_wu@novatek.com.tw>
+
+description:
+  Novatek NT72676 SoC provides two I2C controller variants, generic I2C and
+  STBC I2C.
+  The generic I2C controllers are accessible only by the host CPU and driven
+  by a 96 MHz AHB clock.
+  On the other hand, the STBC I2C controllers can be controlled by either the
+  host CPU or STBC (Standby Controller, an 8051-based microcontroller) and
+  driven by a 12 MHz STBC clock. Authentication with STBC is required before
+  the host CPU can access the STBC I2C controller registers.
+
+properties:
+  compatible:
+    enum:
+      - novatek,nt72676-i2c
+      - novatek,nt72676-stbc-i2c
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
+    default: 100000
+    enum: [ 100000, 400000 ]
+
+  novatek,stbc-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the STBC system controller registers used to authenticate
+      host access and switch ownership of the STBC I2C controller.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: novatek,nt72676-stbc-i2c
+    then:
+      required:
+        - novatek,stbc-syscon
+    else:
+      properties:
+        novatek,stbc-syscon: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c@fd000000 {
+      compatible = "novatek,nt72676-i2c";
+      reg = <0xfd000000 0x100>;
+      interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+      clock-frequency = <400000>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
+
+    i2c@fc040a00 {
+      compatible = "novatek,nt72676-stbc-i2c";
+      reg = <0xfc040a00 0x40>;
+      interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+      novatek,stbc-syscon = <&sysreg_system_controller>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
-- 
2.40.1

