Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C243D377A86;
	Wed, 15 Jul 2026 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100929; cv=none; b=ZZlXam5dfe3ubFlhAEaH3my0X5Cj0N8apUHnfWIDjm+9YeZMu5/a668ugUa4jnRh9QH+7nT7s/aZcJolEjQxYP3tIOF0jCMBPum5ywLk9V/Fipd3wpED0A8RJVPHwVOVVL5FP5++VEmplrog2bscvHD7fZo6EDL7sWNBsP3Gk1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100929; c=relaxed/simple;
	bh=wuIOnk8cyus8Q25UtJcTT8OBANsJzOnLRyVQQefpOwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qvqk5lXzKWVLsz2L33afcsrN75TeSA3/SgGg2vFrJrtiVXpQsLZHf/B7igLrLa4fdNUpuStmAehVKYOfxntN2RedNu4rAXb14HNJIohwrllGXVC/WXNklXPOX7SL8VFlv8wEmiaz63WODqVYFrr1Nf3B29YgnyXy6MqG3f+ynA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=S9wgFoeF; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="S9wgFoeF"
X-UUID: bd01c8f4801f11f181a149c3f3c08161-20260715
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=jo0ybDepkKLaMFGqRBKnWx0O6kvEpTuj2jQJkrZuuXU=;
	b=S9wgFoeFoUwb9OKlJ7zr+iufNih0rotW4XZSgzpV/4LZMD+ynmPf6bkHX4z+lVAwO4dgKJBbTf0+vbcFD2SXIXoWQ5SEhvbOlF5BOxFG6wwnCyRzJbZW4p2f61O1MFr17ns/Hp2RRUbgTDany3cpigr1hBMCbfoWF9xlEKCa7xM=;
X-UUID: bd01c8f4801f11f181a149c3f3c08161-20260715
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 877515562; Wed, 15 Jul 2026 15:35:22 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id CFF5A1A1E1C;
	Wed, 15 Jul 2026 15:35:22 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id D2A58C600CC; Wed, 15 Jul 2026 15:35:21 +0800 (CST)
From: Nina_Kuo@novatek.com.tw
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
Subject: [PATCH v3 2/3] dt-bindings: i2c: Add Novatek NT726xx SoC I2C controller
Date: Wed, 15 Jul 2026 15:35:21 +0800
Message-Id: <20260715073521.147610-1-Nina_Kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260715073503.147552-1-Nina_Kuo@novatek.com.tw>
References: <20260715073503.147552-1-Nina_Kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

Add device tree documentation for Novatek NT726xx SoC I2C controller.

Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>
---
 .../bindings/i2c/novatek,nt726xx-i2c.yaml     | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml

diff --git a/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml b/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml
new file mode 100644
index 000000000000..866589c5ae51
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/novatek,nt726xx-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+maintainers:
+  - Ben Huang <ben_huang@novatek.com.tw>
+  - Jason JJ Wu <jason_jj_wu@novatek.com.tw>
+
+title: Novatek NT726xx Series SoC I2C master controller
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    const: novatek,nt72600-i2c
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
+  novatek,hwmods:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Name of each i2c pin, must be named with "i2cX". (X is
+                 an integer starting from 0, must be unique)
+
+  novatek,stbc-controllable:
+    type: boolean
+    description: Set if this i2c master, named as `stbc-i2c`, is
+      controllable by stbc (Standby controller, actually is an 8051
+      micro-processor) on Novatek NT726xx SoCs.
+      For these `stbc-i2c`s, the driven clock is only 12 MHz and the
+      authentication to stbc must be executed before controlling the
+      registers.
+
+    default: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - novatek,hwmods
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c0: i2c@10000000 {
+      compatible = "novatek,nt72600-i2c";
+      reg = <0x0 0x10000000 0x0 0x100>;
+      interrupts = <0 67 4>;
+      clock-frequency = <400000>;
+      novatek,hwmods = "i2c0";
+      #address-cells = <2>;
+      #size-cells = <2>;
+    };
+
+    stbc-i2c1: i2c@20000000 {
+      compatible = "novatek,nt72600-i2c";
+      reg = <0x0 0x20000000 0x0 0x100>;
+      interrupts = <0 77 4>;
+      novatek,hwmods = "i2c1";
+      novatek,stbc-controllable;
+      #address-cells = <2>;
+      #size-cells = <2>;
+    };
-- 
2.40.1

