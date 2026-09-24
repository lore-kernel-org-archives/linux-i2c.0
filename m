Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B65743F4B1;
	Thu, 24 Sep 2026 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239190; cv=none; b=Fd0wemd0zmWGg9AbcL51suoABIB9WKz1f/tW+rWlaOaeQHwpEcK2aazHrGe/8nttPrw2jd1cnPNs74Npks82qAwag5EANK54YouCOIlUAr6d0A6uLQEhGEv6seOboiWvlZJ//7EgpRJUwa4G8+PzZ+FwDXoZaqbESi9TGxas6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239190; c=relaxed/simple;
	bh=tyHH4L3DGufAt8GupUTrMc0T9R0V1+3nBPRA9FAGefA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jHKQp9ArtNcx0FK6wDZ2wNSCrDtKnlDijLAnCIaXpziqyf+o03eG1G8OmVhoKFTPhEvtpYOohw7mAGE0fI62crVQizMwBbNCoYZKLGU4fqlKH7G4g+nDNlROOMQT8MrB1f7ypuRXEcAcyyhckGtNNIBC/chV9ODsZ2bNo+c3T8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=un87LFM/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="un87LFM/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41C2FC2BCF7;
	Thu, 24 Sep 2026 08:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790239190;
	bh=tyHH4L3DGufAt8GupUTrMc0T9R0V1+3nBPRA9FAGefA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=un87LFM/SdM7zUUyWttCvejIYVBRbyv7CxziDIiwCGvhZk67/hoiIZn2NSt/4Kf//
	 qohxgCQJAkq9SDqVQS7i6SXGU47egkrhL/+E5+oCTSFtLzG5FH7ti4ti+ZC6XdsmEQ
	 mYLBpc2Qk/4ib1NwixT7KUa9rdaBdZKGfeLf5KYLPb4b2H3zhZdQFBb9qHZqecbP1M
	 F7beG36OKfKsO07tTPtoycTZ7eK33Mi2YV2Qdbk08J6H5IzJNioab5mG3zmle3kMRz
	 VWLUDI4bGsTGSZRFYgx8B1NH5rNgPfPmOEKLwGzgV0W+AKIDnCAo8KMKfojkJZOTZk
	 +nOvkmI/qyN8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD25C9830E;
	Thu, 24 Sep 2026 08:39:50 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 24 Sep 2026 08:39:34 +0000
Subject: [PATCH 1/3] dt-bindings: i2c: add Amlogic A9 I2C controller
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-a9-i2c-v1-1-b8ad9b46f4a8@amlogic.com>
References: <20260924-a9-i2c-v1-0-b8ad9b46f4a8@amlogic.com>
In-Reply-To: <20260924-a9-i2c-v1-0-b8ad9b46f4a8@amlogic.com>
To: Junyi Zhao <junyi.zhao@amlogic.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Xianwei Zhao <xianwei.zhaol@amlogic.com>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790239188; l=1829;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=8nPKQyYtI2lpcMKTMVFToJQCxayAS/dbNUlO8hvofKk=;
 b=0Wk7LfDx9kVpBCfkt8bPhxBnKK64RuxW6FmEd5xylS3bXhpniIAl7TFFAB1fprg47pGF5cSaK
 GwESv07Ekr+C2FQ0YCx4uGDV1c3o1/tKM/quDnq4n6jKgHLJ8TOs1v/
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add a Device Tree binding for the I2C controller found on the
Amlogic A9 SoC.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/i2c/amlogic,a9-i2c.yaml    | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/amlogic,a9-i2c.yaml b/Documentation/devicetree/bindings/i2c/amlogic,a9-i2c.yaml
new file mode 100644
index 000000000000..681241a52680
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/amlogic,a9-i2c.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/amlogic,a9-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic A9 I2C Controller
+
+maintainers:
+  - Xianwei Zhao <xianwei.zhaol@amlogic.com>
+  - Junyi Zhao <junyi.zhaol@amlogic.com>
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
+        interrupts = <1 164 1>;
+        clocks = <&clkc_periphs 11>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        eeprom@52 {
+            compatible = "atmel,24c32";
+            reg = <0x52>;
+        };
+    };

-- 
2.52.0


