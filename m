Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C6D47ECCC
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571611; cv=none; b=dgPQr6lhw7lZqugwA5HmzlYoJqRbw9Lf+TKWTEBTtm7hdG9ItLMgAYPf+vf5Z/2+BUEU/e0ckRQBhP3NOBXL08JLnzBFAKQObPCs2tE8DEb5cgitGwM/3duiOcSLRe9w5BfUR6NZZMsl+ksEzUvk0HlBMDOJJ5X09pdeZ3k3hUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571611; c=relaxed/simple;
	bh=W60ZB1+wZuP8PnU4iGf0U+uZbFRfPX6nSzCaDbJOyEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MaxRj5jRNoaCd4wUCYB4M37N1yZzqMfr+OLhzu5lR+B/sFFUQRGxQhAIXSOs2i4+FmzYPc0qOKyB4UScw9G9wqEjRmnqribcNeb+oQLP9QpWgNFZbbMQgPz1Y2owZ1usNUhiaui3lswiYl39g5WXvsiWI44UP9LH8VK6zDQABRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQ7apMU1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQ7apMU1"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-367d88b9940so2024394a91.1
        for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778571605; x=1779176405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xf70jF6KOg/SiWMlOWjk6atZ2ryfC9YUcEG9Wm/SIo=;
        b=bQ7apMU1/u10H1dBFoP00bZoiUBM3gzG4Ei9OBVP3SV4dTn80szP19qeL6TWnR5wjj
         E43RP38ZnsMVyNywNfMJoceuzUpN68sT0JZH19eJt2KXXIQ3cnAp5VX6Q26R4o3rkSpr
         z/Ar9/g3gjrSEN8yhIE1qOgwF/5hrIe5g0q5TmztD0yOWuzznx4PbS8hGYkGGj6zQiAU
         9zLFvT5dnRRuI/mN+zvQtE3RC8uqUMFxGpRIVPcK4FgbAf68RYZeINyDhtBkWB4FPSEA
         0MXfvOsjkV+mq5h3a1gqeUOJNVcuIccbouxGC7KzaPS3gsKNuoDs3acMsKtqm/WOM1Rn
         JwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571605; x=1779176405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7xf70jF6KOg/SiWMlOWjk6atZ2ryfC9YUcEG9Wm/SIo=;
        b=CSJYUU0tfKxruk5K8xWxVsYJNdBT9FbeCYQHhp9IOaFw/cK3Bimu4d6pWwMRJqUszR
         W6OX17tZTQCxkqVR2sVFGX0nmxZa7umriHxa0pKsf8+iJBSD1pkXVjFxyJF5zvWBDNqY
         8GHYGJc/I0bMyOzuNunXf5lkx8HsD5o0oBB1TD8CUVA0m+RkrI1PJmnfFeZLZm/hnSaA
         gfPpxqLlc4hbFvUgc/k738TzsD295g9NdC0zm+3bcaBl29xGwzsf69mZe/2zSTVShJ4G
         WSHWR3mG/ccWNL8xlFbnt+YGWMvN/KaOPZ0fdPHqQj26LwYDou3O/v14niFqCiGUEfpx
         70JA==
X-Forwarded-Encrypted: i=1; AFNElJ+vK5PZp8Fz4Q7CgBz1H7ItxOxABVgSeync/aM3pw28a8Fz9/ERMNg7aVKoFurLnueoPM/3R1Zm2XU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztvr3/2buffrkFujrILgCxv/TuIsAOSaB4/0UpsDIDMteSPhWT
	8jWYw40ywd7a+laEXShcXouGNaB5CngC4QZ40V4PUpsYyUCH+da07I+Y
X-Gm-Gg: Acq92OFrHBDGuWXfzmADzrbiD0Ovfp+9G8blk79ABEMkVAOu+iiwUhHbJRIMNlR9AsY
	rBhkKxs/9AbiuqszseLYYPiNEqGCar1uKpLJEf7Kp6RqhVABqSAj7o1i3UbGZOXdjqT2ORCe5Yb
	U49gJc3/zoN46YlqbqfqDiUtTgoOFE1I6C9uUhuwcfSuKvz+5TL9q/2ZUbN+8SNJOazKzYZLNXk
	4Uwec7C7wxKgXqf4cHREVfga/OQtHyL/aEYz+7v1tgSXfwMJpEPIYuNH0bSqJd8WE25cXdhB3S9
	XSSFWXiwc9y5VC4ISCFEKM2Q7mfZzaxnAtIEJrJpxjkzvmQoyn9kN2rRUSbG9aXSIozOU9s+1H+
	ZrEe5FNGjmAXJWCWXQvASM9Zeas3cy2QjvPUqGCPoJxW5Sqo7fQ1U+P4bs7/8ivAoBZ70LU+Sh4
	A5sbfatUpVTR8JimJQMuqmQCkveE3G7jykIlK8cnGUNWMNiSV4VhTQ4aviEQ+USlYjS24rQUw5e
	v40HyFauA==
X-Received: by 2002:a17:90b:2808:b0:366:2668:b5b6 with SMTP id 98e67ed59e1d1-3664cd22759mr16575930a91.22.1778571604619;
        Tue, 12 May 2026 00:40:04 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d65ed459sm13264489a91.14.2026.05.12.00.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:40:04 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Jacky Huang <ychuang3@nuvoton.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/3] dt-bindings: i2c: nuvoton,ma35d1-i2c: Add MA35D1 I2C controller
Date: Tue, 12 May 2026 15:39:51 +0800
Message-Id: <20260512073953.564323-2-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512073953.564323-1-zychennvt@gmail.com>
References: <20260512073953.564323-1-zychennvt@gmail.com>
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
+      interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&clk I2C0_GATE>;
+      clock-frequency = <100000>;
+      resets = <&sys MA35D1_RESET_I2C0>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
-- 
2.34.1

