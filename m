Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2881FF7C7;
	Fri,  5 Jun 2026 03:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780631782; cv=none; b=MevN4SY5EiwZfw0bXP72kNMPswqBaDCt0xaJdjPEchm6fvXqHuB0wVa6QTyY4EBXksg1sItmh1Cl7ncT7VReiwP8UhFXdH1SzeDY/pcbKNbnYmsXJYnClyb0niY28RmCrwGHDfp0LHP4/WDwArC5oxFEOqpLWE6UMxnXlygMcT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780631782; c=relaxed/simple;
	bh=7c89BS+VNbIa+0Whwd0sxq68fNhpgW7IR4iX9AohOWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=udc5VOYXACdyrOxz6hvisTu8Nkif71TpfH7cIPLjVAg9MvsB38ciYcGqf8hXwUwhKqa+ntUEHUy2/scv1JwTxI5HxzVXXWWnzFmTIL/epblPjDd2DRXs7/CsATKUw6qwhIiesybEX1uMOMVK64699ELvXWhLjssaJmChpBZ9FDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=AxnUFD5q; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="AxnUFD5q"
X-UUID: 807126ca609211f183c5f7e20ac2d237-20260605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=ZiKbxCrmj8v/AwxY1wsSxC1cQs2ji+J4G3xaNYtk9QU=;
	b=AxnUFD5qaiDensw+eM230mqtVqgJW+FdYhZPc5R5/sZQFQgV8qJ5QJ8HG0AkEjzF/eH14YM1LD9PsqSFtVZs/g+C1hmyFAa4WGnufD11YSwr5goc9wsAeEsImrXOnLkxfRmN/b3L0w7i/wOiK9hA85qv1D8dskRN9uIKYrd4/0I=;
X-UUID: 807126ca609211f183c5f7e20ac2d237-20260605
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1412589812; Fri, 05 Jun 2026 11:56:16 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 35E7A1B315E;
	Fri,  5 Jun 2026 11:56:16 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 9059CC60082; Fri,  5 Jun 2026 11:56:14 +0800 (CST)
From: SP_ISW1_AT@novatek.com.tw
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: SP_ISW1_AT@novatek.com.tw,
	ben_huang@novatek.com.tw,
	toby_chui@novatek.com.tw,
	shihpei_hsu@novatek.com.tw
Subject: [PATCH 2/3] dt-bindings: i2c: add Novatek NT726xx SoC i2c controller
Date: Fri,  5 Jun 2026 11:56:14 +0800
Message-Id: <20260605035614.383387-1-SP_ISW1_AT@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260605035558.383330-1-SP_ISW1_AT@novatek.com.tw>
References: <20260605035558.383330-1-SP_ISW1_AT@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

Add device tree documentation for Novatek NT726xx SoC i2c controller.

Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
Signed-off-by: Novatek i2c <SP_ISW1_AT@novatek.com.tw>
---
v2:
- Add Novatek i2c to Signed-off-by email list.
- Remove confidential related statements and HTML messages.
- Fix the potential issues in the device tree document and
  i2c driver source codes.
- Fix typos.

v1:
https://lore.kernel.org/lkml/20260604060411.355675-1-SP_ISW1_AT@novatek.com.tw/T/#t
---
 .../bindings/i2c/novatek,nt726xx-i2c.yaml     | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml

diff --git a/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml b/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml
new file mode 100644
index 000000000000..d9dfdaaec205
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml
@@ -0,0 +1,48 @@
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
+title: Novatek NT726xx SoC I2C master controller
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    const: novatek,nt726xx-i2c
+
+  reg:
+    maxItems: 4
+
+  interrupts:
+    maxItems: 3
+
+  clock-frequency:
+    description: Operation clock frequency of i2c in Hz.
+    default: 100000
+    enum: [ 100000, 400000 ]
+
+  novatek,hwmods:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Name of each i2c pin, must be named with "i2cX". (X is
+                 an integer starting from 0)
+    minItems: 1
+
+  novatek,stbc:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Set if this i2c master controlled by stbc.
+    minItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - novatek,hwmods
+
+unevaluatedProperties: false
-- 
2.40.1

