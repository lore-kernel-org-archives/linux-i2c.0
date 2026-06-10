Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD4E33F58E
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 03:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781060663; cv=none; b=GP0bZAhNmqWnnqFlEuNrS4NHlht52slrJzQI1kkbDTxHDrrDd3htUUv3/RyBndwfGzl5kp7Ot8y77eee5M6sqW55tI6Lf4kcHXKpuule1DPU9yDCmP/Mtf5z/grU2bBQE+GA3PbfJBOL0NGe7zZlDHd4eA0VrGFW83LOmiRXf/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781060663; c=relaxed/simple;
	bh=j6TERrnebUEQt6LyebRQ5rWCD1wXS7acJa0BJlTn7vE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YzDfnJwAhWYLMFbOOl3ZmTsHHmNx07EroIaKvumVHaCYNzIRWl7H/3ttFlEefsi/hivtZz6PqSGFE14We+w/dQTmJEW8oEwIpVHFp1BCIUfDU0GizT6H1hyaJZ0RG/zB6FQfB+BW8SpZv8gExYKmxNT5kFGxhKVnOxdyIvHZ+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSkpS3+m; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSkpS3+m"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c859a374903so2183992a12.3
        for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 20:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781060661; x=1781665461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aX/h3JPBtDP5eEo8S5UCA3kPcg5M0Mv68w4Fd4D5N/M=;
        b=ZSkpS3+mMw27AfXMxIsnecuPsO+B2+vSUWFkDTKXBrYXnovbQR1YYq63txsYVeTkyW
         ke7gyZLKkyZ1xXOHmRIMb3MsZBrXklzoFoToYE8/LZ7BbEYMocM1DPPIJv+xnmAGryzC
         uL1pa2+ZFAXf/IqNei+QdCMFcZ+SF6JIBJM8ZsMt1DC058tWQX9B5X0FUi5qDx2P4BNl
         /hHWDXy59CRebaLOi6PX4dChkFYJqOE4DTSW3+ophj8zmP4gesLUtUVcv45KFYVFAFGu
         YDouwpw9r7VRdT4xJrExRdnvKvNB4fcKTI3Jsqz2kv9ZcBYpSnF9FftPQJVq5JNCk32n
         onbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781060661; x=1781665461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aX/h3JPBtDP5eEo8S5UCA3kPcg5M0Mv68w4Fd4D5N/M=;
        b=Ar+6L4WkawoBZZF1os49vy1CfE/QBOaKX3WNBDxhQxA6Zi0X/e4RVo0NGk0F8xqeyG
         irUcZBxP0bwFo0XCzLGS+kdJD7aHwG0Qf9dMClEXqnLDlzxuIGQ0nwboaVGUyEd88hdV
         MQRL5/to/4sFqtdAFOsxFxED0Tw/+6Dpe+RFp/KUAkwyaP+VymPNWat+cucQmncLNNWW
         4Fjq/lLa/FSQjJdn6Oruq7bt5TL+Pv2ygcuRfK91BALLjx46TwEDQhlr68ALOplzIhuP
         BXtCaLNVy4Or6LdxD1WxtA2LK/wGnd3gYi+lZ+/wYMg/4X/uQqjIJY9Xl+Fk+PjU0hof
         cggQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zQhfHM585PAmgPGwLvYeQRn+l2mI7OLzqO8Z3VrSPcr4sWLHd/YLrGfkKEIbGAGsinWCJFEKvjRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO3Yj4raSjPVyEOTeI11Bo7ribT2HwCSte5ujsC9u07hNjsIQz
	uACSZDCt7qLxbrzCXL8O7mrQxq/dYQVuV7hsO10xjPAjjS8MRk6E82tu
X-Gm-Gg: Acq92OG72JGZQvEDQeHq3tyArKmUbXv9btpbdYKKZIfmUluCJeub3gdeQDlKfCpljPi
	Gras9lMcQUk5Y4Qn20fMe+E9vb3qiHa3gRLSIO5ATjfZ8Do4X0jEy9SlfkH3e9Kvw3jWGT0VAQY
	Bhobv36FU7mQciwUmMcUHRgOaxT5RPwljD9GLunAIVHBNMwCyRhXulLa8gE/2dNpHQah6MQ50np
	JZbDAxAqf0IXYR9WlIOMo7RKIkkjKSsYSMHbqUwohNdyDvJA0O9BUJAIAnalrrRa+hOyT9rlUQ2
	rOAbNXEOdXK4Kzau8BQ9gw9T4wqMouyeZ27DayZcFYbv19b7yFeVdRQXSdAdk2Ri+ovb5PHRAWC
	/2VaNAhIxWIWBuQ5azVK6EUi4nNiZzhY2lNN+Seni4kRlGs7zVTnx1KA+zWsLtH8/L6jUoNa2Cz
	OkB4VGjPbBDm3po8qBXdW8djocyHXzDyuchkvRxaclLfXT+QYf5osw7QLf6IzS/4aYlLKiU5XjS
	Fe1hBJc8QPPDzAJRD3x
X-Received: by 2002:a05:6a20:d524:b0:3b4:88e7:87c7 with SMTP id adf61e73a8af0-3b53bc648aemr7501936637.17.1781060661587;
        Tue, 09 Jun 2026 20:04:21 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a61b3sm19927082a12.17.2026.06.09.20.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 20:04:20 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/3] dt-bindings: i2c: nuvoton,ma35d1-i2c: Add MA35D1 I2C controller
Date: Wed, 10 Jun 2026 11:02:06 +0800
Message-Id: <20260610030208.2020275-2-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610030208.2020275-1-zychennvt@gmail.com>
References: <20260610030208.2020275-1-zychennvt@gmail.com>
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
index 000000000000..f2c004049d86
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

