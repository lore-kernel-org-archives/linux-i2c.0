Received: from ms2.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D18C336EDA;
	Thu, 10 Sep 2026 03:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789009296; cv=none; b=KTV1KpfjiNFNV0xp3pYDWzewTFnBkNExqLK7oD3RiX5Q9wykFhnI4Y1sXZ361ATSBNi/ORHpqvyGjb6ukb9ZGhV6GjQ9QN/o8/kZZmb93buP66y9A1BDodSTFYXhWv++WMg1+3HDP4bxcnouIeWzJiFDK+UWiF9jN+MVKL4vv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789009296; c=relaxed/simple;
	bh=EEqiWU7cZvXAzZ9csQjQnedtLTAVMQ0aBVt+/XCpE6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3e7F1FM327E8QVYZN7Xm8PBQwaO0OQ7quYrwki9STga+1jaVEtj54w3X+JWATNKhF/MgCVZc3V9DRliLsD6Ax5/c+OkIUc8sg8LkvR6flSwR/1QL+OrY3YPbDSB0GusRb87uY1gtSverND3kVsh5sWiYppj9sbGCbi+kSbFOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=A5k4To6p; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="A5k4To6p"
X-UUID: e87934ceacc311f191248d90cf864ef8-20260910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=ohXBQ9cjjLeOILIUCU8A0Er0GcQi4hKc916yvsLLEuk=;
	b=A5k4To6pWe/QkfNlvb911bZEM/4VVBtLZSWMdpSDjMkpIp7h2WMJXLqdo23/69OTtBIQaCoiPcwG3grnubIvSto7Me0qynQbIvxyNtej+tNqZc0d5KgtS6r/7j0pEelsQuDciyqO5oAHo0L6KGn5pDIEMQxHkW21xN/uJ4cXuH8=;
X-UUID: e87934ceacc311f191248d90cf864ef8-20260910
Received: from spmgt1 [(172.20.13.10)] by ms2.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 132575931; Thu, 10 Sep 2026 11:01:24 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.20.160])
	by spmgt1 (Postfix) with ESMTP id 6B9EE1A22CB;
	Thu, 10 Sep 2026 11:01:24 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 0E7EAC600DC; Thu, 10 Sep 2026 11:01:23 +0800 (CST)
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
Subject: [PATCH v9 1/3] dt-bindings: i2c: Add Novatek NT72676 I2C controller
Date: Thu, 10 Sep 2026 11:01:20 +0800
Message-Id: <20260910030123.215609-2-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260910030123.215609-1-nina_kuo@novatek.com.tw>
References: <20260910030123.215609-1-nina_kuo@novatek.com.tw>
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
 .../bindings/i2c/novatek,nt72676-i2c.yaml     | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml

diff --git a/Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml b/Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
new file mode 100644
index 000000000000..7d9275b1039c
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
@@ -0,0 +1,76 @@
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
+description: >
+  Novatek NT72676 SoC provides multiple I2C controller instances that share
+  the same register layout and transfer programming model.
+
+  Generic I2C controllers are directly accessible by the host CPU and driven
+  by a 96 MHz AHB clock.
+
+  STBC I2C controllers are driven by a 12 MHz clock from the STBC (Standby
+  Controller, an 8051-based microcontroller). Before accessing an STBC I2C
+  controller, the host CPU must authenticate with the STBC and switch
+  ownership of the controller to the host CPU. The presence of the
+  novatek,stbc-syscon property identifies an STBC I2C controller requiring
+  this initialization sequence.
+
+properties:
+  compatible:
+    const: novatek,nt72676-i2c
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
+    description: >
+      Phandle to the STBC system controller used to authenticate host
+      access and switch ownership of the STBC I2C controller to the host
+      CPU during initialization.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c@fc040a00 {
+      compatible = "novatek,nt72676-i2c";
+      reg = <0xfc040a00 0x40>;
+      interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&stbc_i2c_clock>;
+      clock-frequency = <400000>;
+      novatek,stbc-syscon = <&stbc>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
-- 
2.40.1

