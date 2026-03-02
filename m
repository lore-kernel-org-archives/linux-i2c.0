Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AB8274FFD
	for <linux-i2c@vger.kernel.org>; Mon,  2 Mar 2026 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772417329; cv=none; b=D/vlnM+svDV9s129ovPOL613BxkoFwjt0+UfhTbX1VJBcJhmgpheqJ2EioGq6qouewi4NwIjWZPzAlftZ3hZUI3E53svNGiN6bJOr+t2+/rp0hNltEcxB62Uv6S8omPruZyCvaLF44Ty9vTAL4++ahG40vXy2V5U3qKfGWPDes4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772417329; c=relaxed/simple;
	bh=hLgMJPltUcNaEyZZ4ZTYi+0iQ8sDPrCOqrNiMe0EZe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QP7M/nf24M0E/Y2y+hCAUcfexiyEO/+vNRFXzPL3oxYcU93BcreYYEfOIeJX8ZNtOqgDrfWFVVCRNicXJoKcuGpLillXWdAW6K0qa3/ggZ8SXe62Y69Xfyd9kv3Tu5n8sNGAIt5+O88VKpM+JWFJ5PmuR+BlYYlyifufBm91kqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOkkCIdO; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOkkCIdO"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82746ed8cb1so1789741b3a.3
        for <linux-i2c@vger.kernel.org>; Sun, 01 Mar 2026 18:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772417327; x=1773022127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9X0pQB0h7RMWoFe0LdtBhzPyvjyQ0F+JKWx4b1TrX0=;
        b=IOkkCIdOaiq0mvTrK9TUQnG7tg9Yr3W/5jS3dMIihuddnCn2yxPj+w0Qs9bfuM6QtF
         MQIwI33BKc4PjclGEaVLFZEIzStlbOBrSeel6h7IhnVhWtoOnmGf0OaHAvTAWyKH0aYb
         yk/cKQ1nLgRbXe3c6QLP4SQ6Xb9XxP3wDGtsQwrSnnTDkWu6CnxS3+N8OFXrVxfVi/FZ
         oN9UkyG2exRPPq0IUqxRYCwb51HnQZM7dIeN6LFu+utEX6seBg6GC38JwnaKWO3n1OzX
         mg2j8ZDdpBoU3CjPWg0MNFV1NIOgSmC8Zu0/lc8vHnxdyxM/KsEGPwX9vN5TAwxZhJGd
         k8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772417327; x=1773022127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F9X0pQB0h7RMWoFe0LdtBhzPyvjyQ0F+JKWx4b1TrX0=;
        b=EudQc7+2sa/UFa7tgmo/peCJQium7pVFmGWtTAeAAWHyPdfRIv2YUWD09jCIO4+C9+
         oxNeKTan2zAuulCMFYSwewioUrWvAgHKl3eVP8QoJj06FuwpMTR8Dsxnr2wIbmaDxEG9
         1Fj/zIXOT0CFbOvNeONmR1BTfUWFiq6ml/GK5KBBLeGYgdpsL7P19hyp3lk0/PS1X295
         bt9HJfzV+BM7Ksk2z1+/Gu/vE0ggTt98Mcx3YrjQ8GkLjkfYI6kAgZv14VBmtO2ExrZi
         xTtIGGaDX0CxhAH/NowR8kPqR52ipBa3ATCBd87lacWRhLVrr5oYTOTHis9DHYgoIZIM
         YsnA==
X-Forwarded-Encrypted: i=1; AJvYcCU8ZmH2mLczSWXdWaYwS8CBWbJ67kBjseZ7wJYg1u1URQYIBCfZ14UGasTPEBHhEeSyYPWJ0Kt6xUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25F7x5njfi1Z+5vhtSy1XfQejX93CQrwEHRidC1xOPhxcVHpr
	zN4Fadj/TzLvxsGTgRKQaTdUhM+tDi+7Y5cCf3CjtrP/Yb+7ERKVfXnhpjBBlg==
X-Gm-Gg: ATEYQzyP2Wc8D+8/m+LeGbfVaBdIsrcckKEgLLuBqgYHbQSAfJidvu3Dyvi/vfv5VF9
	Twp16e+wF1W4EirQt4qHKn0jdrRorwLY1Aeq1yYFDoqd/yVV8X9J6i/8M/fA/bq/mge1rYz4jH9
	TzP/+nk38hAf3KUtiBrTlmFD/kJPeEUPiXakeBgAy9XmiMTq2mebWmSgVC+ey5lNwf4kLDAEG+J
	rZT/Ft2ig8M3rz1+rEsjM6Vd4RQMAgPVl8Db7hWmbvzu3JLSGIL8RMr+ZmGZ6At+hO8xV3g0I5e
	uT9vLG1PTHZTpnmmE28g2dVsEMco00hX4yK+oTsiQ2CoD9/pAmlSxCW4k9+pvoijtJozw6MdpFn
	bqa+SoDDI2JHGPXAyfFMzBsIsdqQRa1VKm25CCXlTYki1C7kcXKQgVR9HK0INC4f2dzPFXnGW1c
	OWcJ+Hh+j8PmWuzn2yOQwnqSs8YS4wHnsxkoimf+wGXMk3sux3/+OluXYT1vA0NYNx9ufOV1GgI
	+j2dfu/QA==
X-Received: by 2002:a05:6a21:118e:b0:394:5d0d:9217 with SMTP id adf61e73a8af0-395c3ae7761mr9855958637.44.1772417327548;
        Sun, 01 Mar 2026 18:08:47 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35987523629sm2764697a91.7.2026.03.01.18.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 18:08:47 -0800 (PST)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: andi.shyti@kernel.org,
	ychuang3@nuvoton.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	zychennvt@gmail.com
Subject: [PATCH 1/3] dt-bindings: i2c: nuvoton,ma35d1-i2c: Add MA35D1 I2C controller
Date: Mon,  2 Mar 2026 02:08:20 +0000
Message-Id: <20260302020822.13936-2-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302020822.13936-1-zychennvt@gmail.com>
References: <20260302020822.13936-1-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the I2C controller
found in the Nuvoton MA35D1 SoC.

Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
 .../bindings/i2c/nuvoton,ma35d1-i2c.yaml      | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml

diff --git a/Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml b/Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
new file mode 100644
index 000000000000..fa8b01e2c5b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
@@ -0,0 +1,65 @@
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
+description: |
+  The Nuvoton MA35D1 I2C controller supports master mode and optional
+  slave mode operation. The controller is configured via Device Tree
+  and supports interrupt-driven I2C transfers.
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
+      reg = <0x40800000 0x10000>;
+      interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&clk I2C0_GATE>;
+      clock-frequency = <100000>;
+      resets = <&sys MA35D1_RESET_I2C0>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
-- 
2.34.1

