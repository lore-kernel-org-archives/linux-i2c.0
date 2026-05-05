Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12813ACA59
	for <linux-i2c@vger.kernel.org>; Tue,  5 May 2026 05:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777959158; cv=none; b=qzdNHMPs8mlBvHLGRFblZzFyomCrBV7F9rO8FCVe1jlWTI0+KDddGmbWetedSaZdfhtuYzPhx9elIcm1jEZMWZuviFFsknY+jNrI4LFmXg5gefV46jPcu1L0AKsqwq3uYOp8ERIZsgxw+5Ztl++lu7cq5lI7UsllQfyTxQ2suWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777959158; c=relaxed/simple;
	bh=Zf/Oi6MhLnJyKz8VujhJqisPDWxr4yB5R7/vc6z2gm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XbfKLFkyUhCP7D8eLgBMY3+CVGE/dY0G7co0B4ZN2K1jBp55o2fV8LzgTFL42Rz7txapvMIEIwlK+oc9CXjAjmfw5K/exQnd/Dm4fb4KABoqs5P+scQuMLeCrUiYONh6mDJcPHs8UPmCDH2GqxjKmsauSM2kTUYNw3RQ4aLsUVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSIXBVPK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSIXBVPK"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ab39b111b9so20527145ad.1
        for <linux-i2c@vger.kernel.org>; Mon, 04 May 2026 22:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777959156; x=1778563956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIV0LcEpykTmV5tvFks4fy+hbUPeuDUPjcF4e2eUCYw=;
        b=GSIXBVPKHX/AYVuI1oPlaIDd3cdFODFlO1V7PZxcykKZDJMM2ApvnbDkbPRgGmLSdE
         McH9C+o4mKvkU/iMDFfXBEyCW4q5LZyqp1OzlaMwWJZ/J/uyLh4RQfxW04zHJ428ttS5
         GVfIhyR6AGNAZYqw6XDHDIAPPMIYpbdvhRPKVOcBOyBYPZIJIGdyslOhzzj+BtNkQ3wX
         t1DdmlUPEpQY3ZLX6Yc6SHrweFx58do5TlGQCv8Y4ahJGGXnWGweSVAfBFCrAwNPwrVp
         0+ssyN2sVRSVib/7fP5mTG2jlMc/Wh78lX8RetNFz4XN4mAoxaop825glqkwt+Iezkl6
         zJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777959156; x=1778563956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIV0LcEpykTmV5tvFks4fy+hbUPeuDUPjcF4e2eUCYw=;
        b=GxZRP/hpDPbILVXq2hN/fmKfdo4s5i4vFOVjDtuMjiv3Kg07RgwP1d+iUOM0f9+FUl
         ekFr+JcYRsbLvIGZO8MWn8yjIWoR3g2LIm/FoIFhj5JkSylUKkQwr9Ov6ul4OuSfq32Y
         PcrVghRzBDa9k7uJF6x+/bYDUi3QOfmGLcUYpc6Gi6fYoSHEdErWR4C9RQynRL+EDYdZ
         BRrwIh7wMIbvsmQlCzQUzdUPb1RaDVUaJAmBNPzTqRrJTFmegSF6KEf2Yah6hZ5sfGyz
         Rla/rDEcHbeTcQxo6tGgFYre/FoY+ulheD/UQofha1CRJJW4mAVpivkBOOh2kFAoZPt5
         n9Iw==
X-Forwarded-Encrypted: i=1; AFNElJ84HBkYfy11w0H0l97o1aIOZtfOpy1IFcbc6d7DmbIqv82OJtMKOkS9fURcbyGYMKpRFIw1ghZKyng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM1xiZsqqU4GFtvfSyGWh+zs+zpxSQpIbg7RjJzeA8EeD1gTG6
	VMMTykasgjodG5pyp/XyUHBr9O4J87Aq2kGaCOmzkeQ9URh+rEGUJFU/D4f80icpe8M=
X-Gm-Gg: AeBDietgX3xqNDNuvKdUZBb43SmILdzvQTl6MEovksT8C4fddyryxTh/GMXSER98Jf5
	w+mZLgceiAY3j03vC1uL0HkLAv8EuBq7EAeJklLmOUgkzgjRFAw9v8HTA9cf9aW8hL4i6fBLyHq
	m1NCXxFjGUE/ul7mcizgWna9wo3M+oV56/mLTfp46nYtOVX1vbjx1/9Sr/uoBFXsDUIIYizO5aB
	jEZNeFwtBPnFa30X1GIRHWzVamdqnKuMl3BbsuUoBQlmpKSD6Su2vWJHmzTsTUTORgRQuyB99vP
	kCve8MZAAtt76l5N7rlUw0L3XGtm5aYnDFPPTzkB7mhOY+pMjxgUS9PwM/d8UgJA7fevwa2gz96
	JodlY5GtC+Eofi9+tpnrFaxTaApRGuibajCnuGuDJeWHJ+KzFe23Lem86xwu/OyGDjMg1uloF1O
	YuEV7piiQb0aMg7bcITPsNBqn1U49Sg68EI1R4eQayyt/zdpeXBtK8GjLojSJRsYl3Gn3EirpXW
	6/qju1vuLfQUTdiDPIRyg==
X-Received: by 2002:a17:902:e547:b0:2ae:6259:5aff with SMTP id d9443c01a7336-2ba535ae6c3mr15910545ad.6.1777959155886;
        Mon, 04 May 2026 22:32:35 -0700 (PDT)
Received: from chaitanya-virtualbox.. ([103.249.241.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caaadb1esm128161535ad.20.2026.05.04.22.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:32:35 -0700 (PDT)
From: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
To: wsa@kernel.org,
	thor.thayer@linux.intel.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Subject: [PATCH] dt-bindings: i2c: convert altera i2c to dt-schema
Date: Tue,  5 May 2026 11:02:01 +0530
Message-ID: <20260505053201.5795-1-chaitanya.msabnis@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Altera SoftIP I2C Controller bindings from legacy text
format to modern dt-schema (YAML).

The hardware constraints and properties remain identical. The example
node was updated to use a standard 32-bit address space to clear
compilation warnings.

Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
---
 .../bindings/i2c/altr,softip-i2c-v1.0.yaml    | 62 +++++++++++++++++++
 .../devicetree/bindings/i2c/i2c-altera.txt    | 39 ------------
 2 files changed, 62 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/altr,softip-i2c-v1.0.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.txt

diff --git a/Documentation/devicetree/bindings/i2c/altr,softip-i2c-v1.0.yaml b/Documentation/devicetree/bindings/i2c/altr,softip-i2c-v1.0.yaml
new file mode 100644
index 000000000000..d04570680c05
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/altr,softip-i2c-v1.0.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/altr,softip-i2c-v1.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera I2C Controller
+
+maintainers:
+  - Thor Thayer <thor.thayer@linux.intel.com>
+  - Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
+
+description:
+  Altera's synthesizable logic block I2C Controller for use in Altera's FPGAs.
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    const: altr,softip-i2c-v1.0
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
+  fifo-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Size of the RX and TX FIFOs in bytes.
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
+    i2c@80000 {
+        compatible = "altr,softip-i2c-v1.0";
+        reg = <0x80000 0x40>;
+        interrupt-parent = <&intc>;
+        interrupts = <0 43 4>;
+        clocks = <&clk_0>;
+        clock-frequency = <100000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        fifo-size = <4>;
+
+        eeprom@51 {
+            compatible = "atmel,24c32";
+            reg = <0x51>;
+            pagesize = <32>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/i2c/i2c-altera.txt b/Documentation/devicetree/bindings/i2c/i2c-altera.txt
deleted file mode 100644
index 767664f448ec..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-altera.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-* Altera I2C Controller
-* This is Altera's synthesizable logic block I2C Controller for use
-* in Altera's FPGAs.
-
-Required properties :
- - compatible : should be "altr,softip-i2c-v1.0"
- - reg        : Offset and length of the register set for the device
- - interrupts : <IRQ> where IRQ is the interrupt number.
- - clocks     : phandle to input clock.
- - #address-cells = <1>;
- - #size-cells = <0>;
-
-Recommended properties :
- - clock-frequency : desired I2C bus clock frequency in Hz.
-
-Optional properties :
- - fifo-size : Size of the RX and TX FIFOs in bytes.
- - Child nodes conforming to i2c bus binding
-
-Example :
-
-	i2c@100080000 {
-		compatible = "altr,softip-i2c-v1.0";
-		reg = <0x00000001 0x00080000 0x00000040>;
-		interrupt-parent = <&intc>;
-		interrupts = <0 43 4>;
-		clocks = <&clk_0>;
-		clock-frequency = <100000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		fifo-size = <4>;
-
-		eeprom@51 {
-			compatible = "atmel,24c32";
-			reg = <0x51>;
-			pagesize = <32>;
-		};
-	};
-
-- 
2.43.0

