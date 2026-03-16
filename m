Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061BE3191CE
	for <linux-i2c@vger.kernel.org>; Mon, 16 Mar 2026 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773643069; cv=none; b=SdWBT2fZtnXcUh6UwxEFfS2g4DiNqVrlRvfnh0q4wJlSYbN+mFR4hbNhQhonOXEJUu6n1DqDDUNFbhzHv+q1tLK4HtLwfY9TleQrAlfcWaK+tH0/Z1V6YozZ5BT74+FNiQsjdY3lCeKDvlIrYgDwb1f+MkT135EpvZvl4vu9wJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773643069; c=relaxed/simple;
	bh=W60ZB1+wZuP8PnU4iGf0U+uZbFRfPX6nSzCaDbJOyEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZW+jp/xSlTHRYBEm9MfFS98SxHQZFCOzT5ZfAadnnApgFOmGOjskZzCcfPdJEBOW/TMW6qnwHtCJ7eJn+YV51c0ZDcb4Ure1klVKqahD4OVIyqRPKiNhMLUjZAZQSamRVH2Dsxys+HkUrA3+L7DYWdkc+iiXeGgGcOFIvPQlvDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMw837E8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMw837E8"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae3a2f6007so32293835ad.2
        for <linux-i2c@vger.kernel.org>; Sun, 15 Mar 2026 23:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773643067; x=1774247867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xf70jF6KOg/SiWMlOWjk6atZ2ryfC9YUcEG9Wm/SIo=;
        b=kMw837E8SWANCde1DbAHPrZdkKAC+3mJ4TzcGhg5ZQHT1hm3CijuTvgX8W7QcVz7+Q
         mZTQ+yBu6yYadvLestd310rKouiqDnPBrxxuXVdFK2XRGp5udHl12Y/uzaJLEgj4DHmq
         M3puXT80Z5zLixLt8pJFQFSHPKWQvEro3fUYTbwnnGeCtsFK4+6+4P0ZEnU/kyAprraL
         Uo9k/LZxs8Q70CFhftT5I5PwqGQIptlR6es7dqNsNURAUTr30y66xXPAsYti7GJxMv9f
         z35nOs5IH0g4awiUrxylrKEAEe90BqU5hk34JZZMIfYzkOnKNL9vsGqKLS0mdIvHy+GA
         fI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773643067; x=1774247867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7xf70jF6KOg/SiWMlOWjk6atZ2ryfC9YUcEG9Wm/SIo=;
        b=CwAmST+aQU29FaZygU2snEsuieEBfCU+DFpgNO5IcKMUDCUuF9OE0q47HPiFkYan/4
         mhKqm//HC5y/sc1wUwQfZdiSWULLX8/YvSkEuT5scwTrGNDpq8A55J/lmZWr8iLy+akr
         5/shzkK1DvpfooXJWpSzyZHHSSR0WpcqtZbYbwC8p3I2XszQ1i9Kg45/Gp3s65ucRWMS
         MjbtEL+lFJ8f3ArATNcVSGhwGWzofNSZ1VXKFDaTueIkurI+HsvCTJQFhXB43CCH2GpI
         7MZVBZxG+EXueHOOA96XSIYP51kzhOW33vxcz8yQTlrgCWvtAZCPtqsPiwFerNjbE/qo
         xrGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5PVLk9j4uriRIRlittO2l+e/XTxqwkZVpiAjLqSPhIR80RjM5ofZTwhPskjI+YzK6ulf2Gkgv8aE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw12uCi9a3PqZHm8on3qUCA9YKiflyM4csFJK9riBGlG199ZQRi
	4758QtzGbHOjzuV0RDYfPR9D8DT3Ueu5/QA4HVlTVWSESs8nMS/BdfxgE8JGFA==
X-Gm-Gg: ATEYQzykEyyAddHl0oT9uEhj3U4oUv+SRPhHlRjDv3d1+ipp7lV95UIc0+CGqan6SXQ
	9jhs4tOwQSjjDVyy/5shUKQjMJ+ElLAT11hddzRV/hAb9LJiyR7jvwZIdi3mabwaBN0y6HJesQL
	puuuQrcDTqklMd1Z4ZT3Q5Jo9qgb6657UUxX0XcLA6gKD4f5wdmUU4jRB6prGy4MQ3ttRYO0hwf
	Ch8+ptDN2sZgbW3ThuYPa4s76c6t+pGZ3agvxdetSbgM9WNaZ+St45I67gASWhV+p4iqzN7QEpj
	htimvZDxrk/MeFpJxwL01dW7VKe6AqCo08X/kEyHJyGQRWcmfFlXT0rQ5qUMcDEKunxzHbm0TKD
	naOqbs+YV6xu5Nj30rRYKnYxM6Z6UV6IbUgE1tvvZqXCpy5iulF01YSnb4K5F0o6cdBlIgq9m9t
	1wnU0eMX9eL4AW3MHjaXgAY8oVIpZ34X1yH74tS3vxahTTEgVSX8fwoIvV80QDFtFXGgAogHR4s
	dA0ZavzcNJtPyY7vxfh
X-Received: by 2002:a17:902:d50e:b0:2ae:47c9:68aa with SMTP id d9443c01a7336-2aecac9da99mr123353785ad.52.1773643067321;
        Sun, 15 Mar 2026 23:37:47 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56cdf4sm122845295ad.8.2026.03.15.23.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 23:37:47 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: andi.shyti@kernel.org,
	ychuang3@nuvoton.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	zychennvt@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 1/3] dt-bindings: i2c: nuvoton,ma35d1-i2c: Add MA35D1 I2C controller
Date: Mon, 16 Mar 2026 06:37:24 +0000
Message-Id: <20260316063726.41048-2-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316063726.41048-1-zychennvt@gmail.com>
References: <20260316063726.41048-1-zychennvt@gmail.com>
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

