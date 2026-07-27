Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3453E2ABA
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140407; cv=none; b=DFPr4wVYko+0xPkrN35I8KUweoMLWN14umAvbFYtMJwus6af7skguhr/MfLE+XfIgMTRt2LH8mKe+myeNZ/1NYOvjiCZNIQijXHq1JCvzuyKLMZpQbxPJDTd5Ts1UCM5CGalEYSZhM9dlLoTj0/wSDcWosYLpecsSrHaN88/Ud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140407; c=relaxed/simple;
	bh=O8MDKZM6orbok+3kIkwxaUSh/e4nFOYJeY8hZUI/E60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lMvu3VkA5uQI5Bf40zecjLgrrw0p0eMSQKzPAM7fs3y1eCHOWUiJpmkezaxe7os/fZc94+0jp47NFxOF8u4kdHkIzaBiFY81+L6TNtzLvJ7VFBjxLIixIarFpo8bCcGnwuc6BsViwVBRlHVcEbzoQTLJjSdcYnjmFLkp3chdAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jf80d+3x; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf80d+3x"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cace91f112so25536085ad.0
        for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 01:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785140406; x=1785745206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2FqaMzaGINgzjJOw7zufrrcqxjVM6pp3g9UOy5lEX8=;
        b=jf80d+3x2edMcu1gqTiRf+D8mFjsPH16yL7qnVs429bWAuVpNuMqKRBw3vKSDru1Ur
         7BH6SwYatW9qjOvo3nIQBZ/ZFIIIhAF1gJNFk12uITdivuCbyB2Fb7eIfhWDwp/VDWwt
         4ub13CJo+4ul40L254hDw48/2rgNQNXoRWdyxREAqeAyqeJA5ABZeKBqWLScTuucybAw
         f+Rr05ENAQ5KZRuorf6h9MLj3SJ6Srw0Ht7tv+XZ33vcQGs19Z10owMXc2X/iJfuTpem
         N/822fO6bQSGEU9gKu8smMbxCaU1+qjy8UXyT4WOfuDQwHWsoc5IRX9AeGjH9ly/G+tx
         Lzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785140406; x=1785745206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W2FqaMzaGINgzjJOw7zufrrcqxjVM6pp3g9UOy5lEX8=;
        b=J7qyEp5uP5O3xb7m5TaUgnS7uSyB93zN3eab6zKZmk9J4xnBgMva7ADqvQXXZ63w6H
         YMYMPkeGwVVooJSnvq9/W+ozO+hNa7w/S3vUDMChS50FoeYLfDmQ7YlfanQHVwevBODO
         aQiYxr3GIfRhXpDZ0DH1CqNrDtWMWm4Bw3wuXftThjSvrnv3mfimtMqfNQ5hSj+X+qUU
         FhExpEhDubhwy/it30LllI6EI4MnmtK3VWfoPRvT0b2mkotRkvOA6A9mqmmCwNvFl9GJ
         Igwi5iFGF8kaFUnnJA4epCWsSZRZGTDWeZPnEuyDpthzHS/s8+NCtYltuclG4WFNiOPQ
         bBXg==
X-Forwarded-Encrypted: i=1; AHgh+RpJMu2KgJW0jsGq6KFuX9+3PeBBvWjb/rzPjdCBm6s5Idv5kZqqsF6euJkWKe1AtA7tjlaKkCM+mz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdN5tuA5U7AmvWBYW5i+iJ5CZpsTUPjx0Zampu96+YzbN7Pp+v
	g797S2zdj5iild2H5dFwq1zSjPHeW4W8nZVHJAKbGBLR1ORrmWRR1ZZ8
X-Gm-Gg: AR+sD11ulg+cYzk31rCh3bggYqZUQqA4RYLJ4wggNFrzsCiLOO0YYkVON1L3I+72QK9
	27NAltapKxDrksUUQaGuuwOqBlCc1PctwXSYc8bzX04q31ZOfPF0wMcmgsd4Q9KtT3TVS9TOLl9
	qD/DJ6xqufiIAupZnwZr407NlXSDhYGdi0+cqqIMfqwBqCTjLnGQx0vshRPPc8bAYs54MYi9kSY
	G5NHelOpHMC79RJngZKHJ2S86aP3Fyge7cnJGdNKlvt+txgeiQHLn4gWcOvqzUPTir/yIkiSaem
	T734wyDCfTQ0EiV2v1CJ0BlY3PT02x9vq15bKnewdRkgVZL0FBr2UGMjxaQL9zqG6a02erBkxwN
	MdMV3FyuT7DUidO2x1S5OQieDyUe54gI8/89SUzvwb4ZCUBbjRMs2lD8CbtI9uBDVvfk7GjbOp8
	yYhX5xkxRPnjmByNx8G9QvzrHmUFc7VOwKtVik5ZN154fK+hOPzIq+IEU/SKkM
X-Received: by 2002:a17:90b:5586:b0:38e:e9b:ffa7 with SMTP id 98e67ed59e1d1-38f295bd716mr7559866a91.28.1785140405661;
        Mon, 27 Jul 2026 01:20:05 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f292aed12sm2629156a91.4.2026.07.27.01.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 01:20:05 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Zi-Yu Chen <zychennvt@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v7 1/3] dt-bindings: i2c: nuvoton,ma35d1-i2c: Add MA35D1 I2C controller
Date: Mon, 27 Jul 2026 16:18:57 +0800
Message-Id: <20260727081859.1737223-2-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727081859.1737223-1-zychennvt@gmail.com>
References: <20260727081859.1737223-1-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the I2C controller
found in the Nuvoton MA35D1 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
 .../bindings/i2c/nuvoton,ma35d1-i2c.yaml      | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml

diff --git a/Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml b/Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
new file mode 100644
index 000000000000..0713e1c1ecb8
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/nuvoton,ma35d1-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 I2C Controller
+
+maintainers:
+  - Zi-Yu Chen <zychennvt@gmail.com>
+
+description:
+  The Nuvoton MA35D1 I2C controller supports controller and optional target mode.
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    const: nuvoton,ma35d1-i2c
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
+    description:
+      Desired I2C bus clock frequency in Hz. The absence of this property
+      indicates the default frequency 100 kHz.
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+
+    i2c0: i2c@40800000 {
+      compatible = "nuvoton,ma35d1-i2c";
+      reg = <0x40800000 0x1000>;
+      interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&clk I2C0_GATE>;
+      clock-frequency = <100000>;
+      resets = <&sys MA35D1_RESET_I2C0>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
-- 
2.34.1

