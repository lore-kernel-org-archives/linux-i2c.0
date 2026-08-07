Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A414483B6
	for <linux-i2c@vger.kernel.org>; Fri,  7 Aug 2026 06:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786082660; cv=none; b=nWlNY2DTP4R8Y1rbTCCo5vY9RCXtl9HkMe2QgKInAklrgkd3zWWdwEn8tnX/CIjiQa2aezXwYVR8PUuIcO5DlQMKab0wXzmjSj+6P6w5nzrcR2HVkk294k0z4djtBdp0XB3ZQMGI+zOblRWu4biZRAB8RP10peFOoqF2L9cvGjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786082660; c=relaxed/simple;
	bh=O8MDKZM6orbok+3kIkwxaUSh/e4nFOYJeY8hZUI/E60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dR8UbMt2dVarnt3g6RUNGPDDHTi2niJYXjhjDp8rInV/4dme9epEosdk90YHnATH6dz+A8buG+cOAa5d/PqmjyNYb2s8H5Fjp9y4BG5oO4jzfLt66QFNb9Q7947+yYtX+ijJz1v2RILoNdLhqCpgQMztyIisxtjAQkAjH0DDs6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qqw3XwCv; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqw3XwCv"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2952627a91.0
        for <linux-i2c@vger.kernel.org>; Thu, 06 Aug 2026 23:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786082658; x=1786687458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2FqaMzaGINgzjJOw7zufrrcqxjVM6pp3g9UOy5lEX8=;
        b=qqw3XwCvCbAdWBezv865uI8n07tFQHJC67kHVmkgktHV5d4fQTMrYkE0x4kzxWLhv6
         DWL2iya7PAHWhSfcAMYf4tUiPQHrips+BN500QJLPIjmQerNLfkfuJh/zLy8qVl7kLY4
         5J8grXhkm5ckkWCly+66Tg0dTRzCY34HF2cfddjwG27xwg9V4cJ68NsKNghXkxSjMAe2
         SVOGWbVjPqD3ZGE51zxIUohq1p2Gd2Xccpr8AYw6cABuP3wo2ygzOMIgwccnA5GNVV5W
         oG5cWuqoVrHuNjh6ugT3Yto6bYyM/XMHq4gkObXXuRWP1NfTqjMFS6ITOZAF3qB09tgD
         2iLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786082658; x=1786687458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W2FqaMzaGINgzjJOw7zufrrcqxjVM6pp3g9UOy5lEX8=;
        b=D04IP5Y0h4qWuZW4125f1M8oH8hrsXPT4VPLHBnDrpV90jfmCQMkPdzQOBKD03ORXc
         7G34aVTyxKfy3zhc4wD52pUs3y0mQ2wCG3iPIKmPHmSTXmzKEamslA4RW5Oo1mJI+Dkw
         PkOwbamV123rvMIP0oh66TgcaUDGGR7cYFSVez26we7CD1s0li9QNelyE+7zoa18DyTM
         shWP+H09X3IFnst6jKaBMMZFGfAZl4Q/WHrd3E9UCc5ADfYr8FlXH4DiMPyTmt2p5mHd
         M45Msz6snFwy7GreopjhitW63OujOSSPe68tufs/x7c1DT8WbjOpuqPUU476uPa0bgCk
         uOsA==
X-Forwarded-Encrypted: i=1; AHgh+Rof3MlTwjc9XMSjoiun4EQyc9MijMkK3cCVSneYlZbuD0m0wOTqB0wgqnfd/jJLHkbKRB6ub5BEDXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3gTDGIAmXA8FeiUR5VSD87ioQUvTdkRVqK1fbSdocVtmsSVG9
	l5/tR01EqHZ1qHLjGZz+3ed+3mdxE3gGCP3hbLwU/FHZStJQIZsM7wIY
X-Gm-Gg: AR+sD12B7o7N3lG6A97FBwAjYbY2NHzZzxu9MJwFXNaemsZtkkT1JkADSzxGRwbkDTb
	27bq/bqf9uPoIUJCy+cU6E0dAZyLX168jv3Djnsinn+C7/MuFZ6fXm6MMHhCTLpUfdS9brvVpPO
	FdpnQNdQehhneDb55cN1TuSmQbKjU7b8J3bpGTdZy7pramzS0I2nwHH2LBV0SMGpn3FpMwza5Se
	iECHLjE2LFjAlr4ke8qbDfZc9qf4JAJjRx20fQ8lY0P9sx4hdIENHYyCvto/zj/zQTdA7XJD9HJ
	y1sTL9rxmII6sxGTiQzar05fTykV/tlC5TvOWzqtuEMML4nDGpPUtVLJD90PNqvMIvBMblWANk1
	gXhhbU9fFXDWqajshkG9bq+M+/sXxNoGu7bFn+QgqeFTkZqE2PRatfKmqFcRXWQuhAmAuwAyiVH
	yomgJ2qO4Eo80LMqR5NOxXu4pEDllc3xe6bLMRwnoh9THfgjlpAiQGcowOu8MyrEbhcxES/tNlA
	uyoEWESJRYZtKFWOjRC7Vl6ZNEm4LWbLCJvQCz7gr75D2o=
X-Received: by 2002:a17:90a:d445:b0:37e:b6a:6cdf with SMTP id 98e67ed59e1d1-3903c66ba04mr21602395a91.20.1786082658367;
        Thu, 06 Aug 2026 23:04:18 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de9c0fsm3375588a91.5.2026.08.06.23.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 23:04:17 -0700 (PDT)
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
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Zi-Yu Chen <zychennvt@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v9 1/3] dt-bindings: i2c: nuvoton,ma35d1-i2c: Add MA35D1 I2C controller
Date: Fri,  7 Aug 2026 14:03:58 +0800
Message-Id: <20260807060400.2047517-2-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807060400.2047517-1-zychennvt@gmail.com>
References: <20260807060400.2047517-1-zychennvt@gmail.com>
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

