Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AF6455619
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979896; cv=none; b=IeITfcjoRKZy/F+K4LyZ2q+EHIo/RHTEdbYPINM8pTTYpNgvDWRmzW3zAaBuFTabDE7RIPPhjxuoi1CgINuxqkf1Y/HM46UM/QV7uQgZGpYiVydoQ67a65czUlU8egGw18iz6IXTnv1XTKKr22Ug56SRnqE/JxGMsXgerbFKQBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979896; c=relaxed/simple;
	bh=O8MDKZM6orbok+3kIkwxaUSh/e4nFOYJeY8hZUI/E60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BR/Pd4dS0P0KuJMhfcG4hjfhxGzwHXPHJrBpvMqljky8Znpqw9zpPNwEQGQAiB5Rh0LB1NTybMNfhyni4jU39WtryPV+U2Kqs1PLUu4nfbLLnxuAgIRHckJUnz4eNACui95Ykp88VPEUAjPsu/bIHYLdLln7YzyqTKMTnzdaSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1MeM0yq; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1MeM0yq"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398c066106cso2091893a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 01:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789979895; x=1790584695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2FqaMzaGINgzjJOw7zufrrcqxjVM6pp3g9UOy5lEX8=;
        b=p1MeM0yqW47gxegI0tnczAc47ACvo5LADy0R7Y9r9+CsjAMTB3MB7CPC22wodtXw+W
         Y1EyOGHGOLlxaxvYLaYnr/MZ+ccD8SpU52btGcAtEP06jl4zsP/vvKWMh9jAtb2TaRnk
         NOl84JnteYRfjpqVVW8TskLbFP2Qpm1nXgcRfV4uFywomuA1dZUiapYg5orYMn023xHn
         P9OHldgc+eZrezm8+tAn8+926vZ9DzWVYrPztfrxapBFIU6s5GOQP66yp1ySF9r22jv+
         WW76QVy34z4JP2xPEXFWnzPCQwGMB6i5OLnvhzxwogFrmDsdNYfZN7grz36KLt+qLgbl
         kQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789979895; x=1790584695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W2FqaMzaGINgzjJOw7zufrrcqxjVM6pp3g9UOy5lEX8=;
        b=LR32lFetp9eulSSFvyABO9nfBkjMuN4USqjgve7XcCpj431kNnpKVux2bWakcmJCrh
         M84plDjo2azs20L8vRrCyNw3aaJd/aYYLzt9rEwjwI2hvBNC688g3rx43HkyoB5KinSp
         KyiXm/FL3gPo43xxHIMd4WFDvP9m2f5y04o654gIyr0RGrUPFlMQCRlnW0qjzmqTE+A2
         JbrDhUhFwGmY05L5veup1w01bEVIIxn5zAQ5F6Ahh8XzrDU5Sr4Lz3qoEAmHZ8ojzMAu
         LzI6D3SY7VqhAj6NhIlUFlUC8bLHIROrSokBziA3fsBrNg5TLS6TJU0gulyQDc4LWEji
         WLHg==
X-Forwarded-Encrypted: i=1; AKwUvBxYTk8bZtVheGgY06bc8yQZPDBtRcQLm+GM9rU+pypRhsVnWMgi9paiaJo2HDKXk7Y9bhfvC2U6Z6k=@vger.kernel.org
X-Gm-Message-State: AFuF++lI/7CTAJ7lXMg5aOjKLhwBOQC1LUl3+yRHSSxMfpBqlARrRPH8
	qomWTnuv2lDEdaTQUmVMYdFpgWwDc8AlPX77UfCpktIuyx1KCkZDD2U2
X-Gm-Gg: AYBFou0AOaOxmKQhPuOO9p4QxTrQA4aI2RYWwSa1YwbHo/kuJGxMVmMOfBrnnLnnjWG
	BU27oq8W1OXv9ur04plDyfVkhbk1veMVuxOtDbpQpLyqoYHov1Iv4Jec/7kxZkrYVBj3/pdRxy0
	6oymm8nlvCcKhdkDH3ImlI2gGJut6ZgX5aUSU97+ODiKgNCaJFougKW67bgL9FeQg1NHqbGw/8h
	PD3xn/qDCJ39MRJJaO5NntRCl2uiFlMLCGrPPfXQoyv3Q6zZWALNTP/v7aEJCQiiooQKaWgoRBU
	P5b6o5kEtUPNYQT+hZALN9rzY3G7ZnrTgJgW8QPp8+z8wNXQUgK/ctOQoWaI3P4iBTKJi1rQjYW
	ArI/TEVA3/Q4eSyZkQkEC4xNQaG2047421/d20yteFDTbmbJgZIf4tc18JT5VA0At7FsWtDNU/z
	Q1QsOOmN1TODdKLIBR/X/jk8315dLx75LTeb8X4lXmvpPJoX5T/5XriAckvbJHVVyzduh6TEJcU
	hFqI4QyCwueuUJznAvm9nQpvN4kZED1humyiPOREC2UmiQy7yGDBmHT
X-Received: by 2002:a17:90b:55d0:b0:39e:6a81:c921 with SMTP id 98e67ed59e1d1-39e6a81c9bbmr11542914a91.20.1789979894703;
        Mon, 21 Sep 2026 01:38:14 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca50694sm15121508a91.2.2026.09.21.01.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:38:14 -0700 (PDT)
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
Subject: [PATCH v10 1/3] dt-bindings: i2c: nuvoton,ma35d1-i2c: Add MA35D1 I2C controller
Date: Mon, 21 Sep 2026 16:37:51 +0800
Message-Id: <20260921083753.1109826-2-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921083753.1109826-1-zychennvt@gmail.com>
References: <20260921083753.1109826-1-zychennvt@gmail.com>
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

