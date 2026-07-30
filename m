Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C78B368D73;
	Thu, 30 Jul 2026 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785396645; cv=none; b=dr/EE+mg8utFh+EzUA5dCpLoZ/0jDn9L8wJJzfQExHTxDykO45iyAvPvl4XhP0pz1Vdj6HfmOFjTRMUuk2IACGbFRMdfdl64DVdfODX1O/wiE/bNseqVxE6i+V33LuXSG+phwTQuPM4b3dJp2Wdbcqo898eCfIW7eKzgMTXQMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785396645; c=relaxed/simple;
	bh=8cOyvtiEfVHi5A6eLnGrfu5DKpfFoGwjy9OBKfQXywI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FESMP+YwShoHyYZscXdtYrOwPPzgncohJ0ZIQUqiz/XBDfbTR/PPu+hrY5YXzP5FYPuh7jAA06sdwwK0ibimcYmq13AV1Q0EUpLEG4qseioIxlQ895eRjMZjvG2rZ4hYNLGk2b9G+wZfnU2xucWQJ95LyXskC70GdBhqIczntQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=omKx7aIq; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="omKx7aIq"
X-UUID: d8108c248be711f181a149c3f3c08161-20260730
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=Hts3/gnQr5hgJsfGYEvQmTkAbSXtBCVI5QdQap1f8Rc=;
	b=omKx7aIqnenYiiceoMDCYGYivT3OVHJ/sKWUJEGZ0EQZiqpx6AFWqsqd9ojo7T3Xzem/swcmL2eASC89cZatH2CbOLGws+5kT7v6Ev2Vd5CNyYU4YJJUDHKhzRfKx2LzU1iZgl5o1JZ2G12/MiqSIoq6ilwp4p+N16/JEbwakBw=;
X-UUID: d8108c248be711f181a149c3f3c08161-20260730
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1745790336; Thu, 30 Jul 2026 15:25:30 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 5CC2D1A22CA;
	Thu, 30 Jul 2026 15:25:30 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 6B6F9C600D0; Thu, 30 Jul 2026 15:25:29 +0800 (CST)
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
Subject: [PATCH v4 1/3] dt-bindings: i2c: Add Novatek NT72676 I2C controller
Date: Thu, 30 Jul 2026 15:25:27 +0800
Message-Id: <20260730072529.492398-2-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260730072529.492398-1-nina_kuo@novatek.com.tw>
References: <20260730072529.492398-1-nina_kuo@novatek.com.tw>
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
---
 .../bindings/i2c/novatek,nt72676-i2c.yaml     | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml

diff --git a/Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml b/Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
new file mode 100644
index 000000000000..8e2595f882c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
@@ -0,0 +1,87 @@
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
+description: |
+  Novatek NT72676 SoC provides two I2C controller variants: generic I2C and
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

