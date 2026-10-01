Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE52A4848AE
	for <linux-i2c@vger.kernel.org>; Thu,  1 Oct 2026 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841117; cv=none; b=qPxgYG0tctFfeBTOY36M1MY+5n4COucZTNhBdTLwR+62W/oXt8NvnFK+r3j38NQygD544gXG3v2RI/BgTR69fcGo75U0GXrfYGAj6FgZqsWmV/JtndCtb8AmreYXZG4O4cY7+3/xl+ZpqJEgEs2YMWEu/hs6vDC/IzXdslYdyuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841117; c=relaxed/simple;
	bh=O8MDKZM6orbok+3kIkwxaUSh/e4nFOYJeY8hZUI/E60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RzQB7y0swXBSoAEl04m07frt9FuLRBBGPTb47mlB3FYCUubGQxKDkUtFNNsaw19i3nqxgCiMk0Ydv649Q2AWDaGBdKdsqKG0CAQKRGxhfdQY/GeHIwMJ1Mks/aizXk/K4qN8mjxCA/XrsIWG/C+w6Va5I+QZ5829D8Cw4QRR9iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvAe9Sc2; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvAe9Sc2"
Received: by mail-pz2-f39.google.com with SMTP id d2e1a72fcca58-8807e5b8fa9so3889351b3a.0
        for <linux-i2c@vger.kernel.org>; Thu, 01 Oct 2026 00:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790841115; x=1791445915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2FqaMzaGINgzjJOw7zufrrcqxjVM6pp3g9UOy5lEX8=;
        b=BvAe9Sc2eTAae9G4oxPdEQOZlgTIwenrxNaGl6xqz3VibE6aRc3c3T4TmwssnvjtVz
         tBwFuh2/YY0EayhotapN2f9+qgGT9P8Pm9Ds5bSNLLpW9l0IFJiG2aCnIbtEXDdY5DvP
         jfhl+8BHdK7uglcTRgAj6LQG1N4DXuco8pyzD4EKCRtcwGojE1Obirj0zQMgHKDcgc1j
         5xumkfLcXJ/lapn7WOGtE/t9xloIPIeXM8JlFm2AN+iJybqhlRchEMJ2H+xkxaHAtfyX
         Nk/ffZ0i3QoQX0Ejb5YICb2e4EqXWKBAEMzy0hYKsS49GwCqdV6NiRBiaZVYjiqjwhBu
         Twfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790841115; x=1791445915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W2FqaMzaGINgzjJOw7zufrrcqxjVM6pp3g9UOy5lEX8=;
        b=I6RHFazMFCEYlTQNfRACOZ2s/AmRYKnVbUg0ftCizHm3FPtqQh2imKtBf4sV+lSypT
         HDNqKySxNJlRa+G5DVe+Ist9erY5Nl8HOp0irzPxkn3qhlLTnS0zpGvRv4lItJqvDQ8L
         klG5hyKVXyphWqSLGHOSDG0ajZ3OtVXiui38MB4rlXgetWijiQFt2/5Ugwegr7kBhwse
         ngvNNSEGdgtoywHTm1/SOFGpq2pztkGKMCMzj9dmFcK9jq9Lxauqp5d0brqjEG1Pi0ov
         Pcu6bT9CCiNYmlwXSYfmLIjvVF5+EPU4M2QhaV0ZccpHsQBeQvQ9lAYlkh+RF1eqjdiL
         uVVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzygHaXeJ4d+umglJ5KURpclyYVrMn9DllzaYn9PRnMcp3EOeLexLiTvU+tOcnt/A3xOWKRRLvD6Xw=@vger.kernel.org
X-Gm-Message-State: AFuF++kQC4AUbWProT7+C+P5Um8/4Auo0PMMxEVuM/MuoElqy85IyJs1
	5BocKAxUTyNIlRv5nFP8V9/z/NwY6CUA1b0dZ2/McF5tE657BzWMrv3c
X-Gm-Gg: AYBFou3Q2pdKnHvH+dtfAJoJgf9Vq71rN8YOJY0UA/Ry7os+uGBDVwLVGVb9uBnJG1K
	buDgfGtxqVyUfcyvc0Iur1p9mP7X2ZPJtwoNy32aJeNABkHkMFYTCdF753TKYEZRr8pIPP35PY8
	+HAqA4p7CDUFB/eYYyhx5iKLLjkiZH9ORaSJcYBc7N17YmMIFIk1JJjzu4A5ixCkU3W+AFmhkDn
	gyJsRPOk3auTATcNykIxNlc+Pv4kRAZ70rg1P7TgnkDVNP0ebMNRa8cbfvO5SiUvJnrbkFxC3Jm
	GbeX54wc4lGwPxUK4MXM9eUUxP3BF/eBLcSiSsQxydiZcTbIBxZQC8JTjV/xkEhowU8yPLZ9Fxr
	gZ7n0md3PlSEFyL1WJGntmtOPkCUydVVuxNNhdZJZ0EW0dzv66ljW9OmjjBlEcdkA5Us2JZeG81
	IA68frUX1AQENIao5xWSWUCVC5C7ZqwDYRzIDxA6Xd2cXUjYB5dQQvqnNWPzmIoylaIdJ13ahwX
	uIxH63wUEwA5E7+DXYT8IAgS4M/0V3vIto9Nay6sc+Z38XVK/1vorxg
X-Received: by 2002:a05:6a00:218e:b0:879:2a08:99bb with SMTP id d2e1a72fcca58-8874dd6acddmr3330370b3a.56.1790841115325;
        Thu, 01 Oct 2026 00:51:55 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88819db440csm666843b3a.60.2026.10.01.00.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:51:54 -0700 (PDT)
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
Subject: [PATCH v11 1/3] dt-bindings: i2c: nuvoton,ma35d1-i2c: Add MA35D1 I2C controller
Date: Thu,  1 Oct 2026 15:50:59 +0800
Message-Id: <20261001075101.489660-2-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261001075101.489660-1-zychennvt@gmail.com>
References: <20261001075101.489660-1-zychennvt@gmail.com>
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

