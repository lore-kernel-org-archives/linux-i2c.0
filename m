Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E892D9ECA
	for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112707; cv=none; b=NyLlCM17sVjPUREzCQitVWQ+FZZ44CPb+710Qem15z6wg7dPnxtOBsIhm/8mzDB6GNC0sfCso+HKBc0yzGmFNVq8A6DvGKGkS2K5xuMWrmKTzPT/Uk0Hzc/vRtXg7R3F8YFeXzMI4ecSdfH9yxcjfz46dAAlbWL0+nxVjdiplRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112707; c=relaxed/simple;
	bh=O8MDKZM6orbok+3kIkwxaUSh/e4nFOYJeY8hZUI/E60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KvX+c8V2iPPlKiQloERJuhe2qHVn6yBuaw5cMqEKmSXy6ZNANLZohjv1ByTMI+RiOSgbosS3GkGqkQ/KNUSnK6wlsSbwPNCmwiwdq0idCahRK1sN+2YlF7d3pj0fzP1tnm5ApfIPc6CNiSJ2q4sv34k/9Cz9SpvOg0C3R35mHkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IONcRzMZ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IONcRzMZ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-88c72646f03so1228982b3a.2
        for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 18:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792112705; x=1792717505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2FqaMzaGINgzjJOw7zufrrcqxjVM6pp3g9UOy5lEX8=;
        b=IONcRzMZRqog6BoQgnHuzD5yvx41J1B5NXNpjuL/sqqj1+xZVB5c59/3dzDlDl1058
         l2JXphvYFWmyUYSsKxp7PiKZn1+YXoxUETY1St0bU3ZCyqWnnS7mR5SQ1br7xUBEPHko
         m//YgfCyEVi9h080c5eX0FLjazEkmLo0ZajVK2LRy/en/5lwQEx8Ufx8EiXeoXw9rqYU
         d667dWjHZBJm8LQnOzL4aWKpgG/05FaB3HH8rSkqXU8ovYes8j85ang0AcD/cS4Eog7c
         oQEsZtxtqB2yeBgV0GQFGuYT2UTlf0Ltea/deqPpqQaMee3+TddlVIFl2bio/5xAzavE
         z27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792112705; x=1792717505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W2FqaMzaGINgzjJOw7zufrrcqxjVM6pp3g9UOy5lEX8=;
        b=Aj46v4bzSAhKDZFZd+PBvf72L4etsH846PPJWVcr+SYUs/IGYJfVpnz75ga2bB1/Cl
         hmER+AMpwVWPWEc14FH2l2eueXhgynjNddF4HQ8Ppyapbo0XaLYfwLLeE2W7WjqMakta
         aREpsc/jPyqU5tDv/SGxib2qHjwxfvBiXrWER7eHCxtdr9HsPlRIMsPs4Ux7Q/sKCoGn
         2b+EdTYzp5qVYY8KbcYMG/ZJtZI/aOpxURggkA+G25MAb/yJBKWupDGWzUJ4YF2NIRLv
         lyAE9fhQfD6BV55ght5mWmzUAokArJeyDFZoA0DjjtslzSvvnQ/Apv6bzN3NUN6J5ShL
         a5Zg==
X-Forwarded-Encrypted: i=1; AKwUvByZl5U3irTQrdgxC9dg8/7p6Age8JLstjAi0VjpbluVBuBoSdnRbVGETPep4uaRKYehyBEs0pswSFI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9NnqFRqr/8oimm5ZfUjrUaXp0i2GPfLxWgpA5W5b2nzUnjzJb
	F7jk66YCHAKhvcWOZb9RQzgbnv0WaXd9qg/jTZZt0F1tb3U82IzEIzLa
X-Gm-Gg: AYBFou2KX4a1X+bY1yHUmuA8d5D+JcAIrc4+OEbgGxqcN1HHIF+hLkOsbDICjJp8Lr9
	JDufAoqGOcflfals2t1yiuSIui+siTOmdaWp4jR4tglMpaO2h8WK60fUzB0/8lNjgoyR+ZxLYnj
	WpRHoh6pa1IYfNMMDr09Tbg0gE0d7GlqkpFIqWEu6QuPdMfFHLkf8EBdQq22lsFZXlH6OszUUdU
	PWqB/T3qZiEaHpFZDsZzHfmIsjhboOaokYWzJq9vWRVegtA5qMRlwt71WDZdaJIeLf7sYmBADu/
	QdVHBmrjwi0jsyNH5JaO8SSDljY4OTEkAPhpvAmo2lxNt4MqBgCm3JraygpPBvJZX0AW5Esvpt4
	d0kHcxF10opdLhtsviC5BbEpViSGCW1g3erPeI5clmKhOv/WrRNWyHmQ7uFx5bSYD7cUW9YL+0h
	khJ6zSbUTCx4Y2N4XhvWiw4I9LWLeBqnlZkOF+yNVaOwManLWdqcaWdRNc7eHxRHfFZ7zaFoTAM
	/FDvbwCO6QibwuivWRLE6If4IZyxdALW1/3X/JFcGX0a2dLjSyboLKs
X-Received: by 2002:a05:6a00:983:b0:89e:8423:6863 with SMTP id d2e1a72fcca58-89e84236d2emr3324731b3a.37.1792112704665;
        Thu, 15 Oct 2026 18:05:04 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5735e513sm302821b3a.27.2026.10.15.18.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 18:05:03 -0700 (PDT)
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
Subject: [PATCH v12 1/3] dt-bindings: i2c: nuvoton,ma35d1-i2c: Add MA35D1 I2C controller
Date: Fri, 16 Oct 2026 09:04:46 +0800
Message-Id: <20261016010448.324856-2-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261016010448.324856-1-zychennvt@gmail.com>
References: <20261016010448.324856-1-zychennvt@gmail.com>
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

