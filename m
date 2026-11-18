Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794995964;
	b=LkBCJ5+nPlerof91gH/gY8+wLHDwYjerrPV3R6jhka9aVGrMG5/iIKUHK5kcMBv1qcZ7
	 S2+Xmws1v4/OCdFC3foo+thrDWdLjRFyZ4T/Pwet7IWseM3heGHGvV++IN9/Ley4wL6O8
	 oKlcFpElKvcbElytkLpZy5+h1DXqkXny/fj3lOriu39SsXuHNALG2z5tN+s+dmJ6LUnnv
	 wh9CzBIlLMcm4S2OIqIA+r9VRBcNXA+JmfUQ4ophaOxDo4+qVBwUVmF449ArWNQF7vBmO
	 X5JV61kBpPrEEdZc3PC07hYhQrhisuDQLsgAYxG/6KQu8W/MCXHBOjet1XTM/SwDIgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995964;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hzfOUTtrb4gURy/ze3K34NDYNNCwcpFVgEVGom5qxcU=;
	b=YabB5Gi8rkIhz3+d+/LnPr5vh2OWY2YF7tZ4GGInHwh+LhdfA4R814kpe9DetEcKwcpq
	 ojUxoVo2yTy5SIWWaCx9gtsyNjA0QVjQmz/NzEhBEAQaMeVEtWAVb0Xst4e0chGuySTYg
	 njd2Km6XeigNteEPJOQO6l1w75qEis1CY9xLPB/tqjf9Le4xtjMPdeGRsvB7OQjsKvv2V
	 Yuxb87Gql7bpvjdc68XJRVtz19pHWRYgTHurJ7C8RO/+IQgVeQJeYl3xb/MzYViJ95zem
	 M5MdvXevaTbKUMlf7qe1fblk++MMeLZhH4g8g0M6AhlEuUcmPhppTgxFlcSgSwbhGfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYNUAt+J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA7606A31C;
	Wed, 18 Nov 2026 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYNUAt+J
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794995963;
	b=hBjEs4cp9Hkhl0nOZg7PAP18h6PtOdOQdf5jWDZed6pg1EYoxmpXRrq3rDsV5uYwN4KW
	 0v+uwIDGB9JUvvAOcw8l/u9f1SVlc3rdGE8DfuhyKhOGQRNMoi7yVQ0b4NzU9iS1UNIYy
	 Dx+bq0iYXfCtOtGbz3V9DmzA8ILoH9oPDnEw8mUkKRD8ctj7tXgjkS0ypeP/ekIHmeuRE
	 EiohC55cE9OcDesCdIGFJ8e5g+CaW4fqiatNGZbOpyeWwHno9hQN2VgdVUi9omT8+Aj6y
	 lmxsXhuq7A5Z/KGRq054CjR06EcNfXKJc07Km6mIDoRUmIsP/yMUpOwqIVGh+VpxE/Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794995963;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hzfOUTtrb4gURy/ze3K34NDYNNCwcpFVgEVGom5qxcU=;
	b=kiLbMZ3ZWZV5Rp7BMa6VNh9PbtucfSk5dEiyd+WdETJe7REEqKs+l9Swoo25+BgyvbC0
	 FFFTXDdUIqJuYB/IJJ/22ZFdLYyl5GBOeDZ5pMyx+0wpq1GMnkdo3O23MJNjJJRQK0L2C
	 0hXmritsF9vsUsUhSQbVkozV0QUY6f68tKoRM9ZoTNi5GkKu7LjDTf/sVQeCLoZmDhquP
	 TjHHrAy04a18te/yqlnm/3GA9lSmNrFeSnBpBvlkeeOo4VAX5gyPOYnApmvTi3UMRh4HM
	 3YXay44bW4NzaGCtn16FcLr/BQyweHYPz9NMc1bkLXNCCTgOVdM9ZLb2j74yXKMt4qQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 409741F000C4;
	Wed, 18 Nov 2026 09:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794995963;
	bh=hzfOUTtrb4gURy/ze3K34NDYNNCwcpFVgEVGom5qxcU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LYNUAt+J9tfZqneIu6AxW6U2vctfvtencgTN29AXEy98efJl+bfciwGXedBYHmOII
	 ZYNd1C+9gnCh/NekTtdI7iWscYgf0W4wAwiK8mzyE+Vv+Yv7wGoCRY+Ubwfn0eLyTG
	 3Yidewc+RsLIRgWPG7mOT4h6X3K3kAOj+y/Kw4P1kQRvHNtWWBaoWdf+/t11Tsi16w
	 XhErzTW7H5ada/8LwnsI1GyqeugmW40pyO/hzawn+pDu3Y9FD+ECqO4Ag8L6R/xdcz
	 QYX1sZA+SJvmd+UhKY+SV1LzxquZvSJc6Fxp0SqttaPhDSindBXJmjks4PJ0FBjwI7
	 9FyNtopwZ64Gw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B0FD44ACDE;
	Wed, 18 Nov 2026 09:59:22 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 18 Nov 2026 09:59:18 +0000
Subject: [PATCH v12 1/2] dt-bindings: i2c: add Amlogic A9 I2C controller
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
Message-Id: <20261118-a9-i2c-v12-1-fc83c53121e6@amlogic.com>
References: <20261118-a9-i2c-v12-0-fc83c53121e6@amlogic.com>
In-Reply-To: <20261118-a9-i2c-v12-0-fc83c53121e6@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794995960; l=1772;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=iah66EzLU1pEytVqMNVVA1xNmz2D/VOvKtLvjcbBFk4=;
 b=NUUGiwuu8R+EiZs7mBRBt4pBtx3gjWNLc9VC55v1I3Dtxf2C9knWF/pf7724GQjWE7DKnHKvD
 NaMrTw92yLcBme4NJvPkahJH2ae9TmWeVxeMn4MwVBAiI+Uo73rIxht
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


