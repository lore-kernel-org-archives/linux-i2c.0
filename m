Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6641C2D9EFF
	for <linux-i2c@vger.kernel.org>; Sat, 11 Apr 2026 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775906709; cv=none; b=RW0ee14QBLLXvSMGK1tVIPmRvCDTlVpzc24/tmyjIZqzC1TYeU5pZsQy6hqgQ7HjbvWSZARTyFk9xsrfH2hDCJ1mpK/i4v34pPfdnwTlmoqSGuADjM3blU7EnocGcKGV6uEeyk7KeqtIM3aGpRgYaENPkE3bMeS2XZeJkPo8qAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775906709; c=relaxed/simple;
	bh=1yPE/gK3AQpWAxImlrz/Yz1c3UZwvjy/qnL2N/sFFzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMD5qhHgZr31fpz0GBdlEFv46aIBOjE602bt5PQ+Opdk9RkhmPjXPFkYA4PJvcNaFHQBDJuXWOLZdenKVSBuvqyKvQYNSEjspbREkg1c4VBWwHxepNf7fYxvOdMBHjqnGmVqxCLl2+mEKULg5w7LEvHkBBGgQPKyAB5feSWGPQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/BBQcNL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/BBQcNL"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d965648a2so2488953a91.0
        for <linux-i2c@vger.kernel.org>; Sat, 11 Apr 2026 04:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775906707; x=1776511507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H+PTzjpNlpG45FMb1Ubuls/uy+BKWZbFk07TjWDhptw=;
        b=C/BBQcNLgp69ta+Y0BwrSVVw35yHReOZedVjW78RCR1oN2ip3pir1OdV5ypi4BEqB2
         PNwWiqrZVSCrXbPKdrdvbEPmHCcVA2Ir7rZzMnmwEaBqjsOBEyd7JumDRAbMQ1Xtz/FB
         YWH25TurucBv0LCSzUXbwTHaIZcff8fk8q95/Mw0WM+qmxZrgqsBu1yny615tXFMWNqZ
         igy7micDVXM1sx28+K4HACh5lkPd1n2MZjoVlGeeWnBO/FM8zVZx8dA8Me6z7jWVql0q
         DJGWIJx5u7vL8eRxH5nlWhi7qNyps0GcWr92LFvn0XAnfQi/WwzYF/iVcRxiLFxX4yp4
         3SsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775906707; x=1776511507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+PTzjpNlpG45FMb1Ubuls/uy+BKWZbFk07TjWDhptw=;
        b=c4vkby9Lvu/bGtAMXNDXCOQwa+JNRyS5VojVabbKLPLOaSX86AkNa1F30OYqiDEIc7
         bPR2c35QMTNDvlzf78pDbyrNSLiBMmlTBmklwDNAMdfmwbrj+f5W5Bs6FkOJEjLgEJ2v
         0fj8UIGFot9LMsnnJs5p89mafyQlf3UH2TouNwWeHTr1xTOll717ZI5ZvdlkTqsC19Fl
         rWX+SYrQLGz+jm/YzFaDjOYVdshoMPQiYjBVw8m2ZagONDemDZNBAQXJ3yfd8np2krtS
         LOjP9qd5VSTos8Wxh/K7dW0gMN6NkB7QHWm0fee4DDtCVzAwRgFoFhNFZPLovX+xiGWY
         fGGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSx7CNH8ciV1G8eF/DuDvWpyCDZyJUn6pkbYYNQ5sMHzOLWOxyse/6fce9MpefzBw0Ww+bd9T9NM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNM7T2F4Dy/hNy+FSOyyfDIrxkt9J0TMT9jwQege/dojSLIWrE
	pMig2hF1b6X3jTivzAYxpz4pU3Z5pUrdEs880mpZu/ivWEf/8jAH3P6I
X-Gm-Gg: AeBDievvlSy3eOGZ3816UjMSqpOYlakh2jjoZlefYsTejq2az/buIguBNTEpA0oA9Wp
	EZUJGFAMR+HNbSfk9nOsYYUXAQlFvr4F0M7IXVNSWXlkPEGqWpvr5c8AKAutTeWAQQC9+QgtFAb
	TsnM+hxOo9kkOibNc17a7aN9HFscNASGUviFBsDQroPEskxSw2cNTj708xjLjtu63xBSDgMCXfc
	6k3fm4B98iShpxL7+z7Ll05VfVX6Wml+0frJjdWel3QT5GoNb6yz7rU+5Nuch1CDCOQdYYhY+Qk
	6niuU9lIoBD2Kjm1YturfgQGHvnQyPwl4Xl6R27X1PInM/jsJjd9H8TJsUfzdJj3S4pH25ksPc/
	o9OBe7n8lNvpuWuvooZHSuVghG1t1cSaWdospD8jEWMquXICLIG6mWG2owPAGx3mHO15Ff3USAZ
	WEnczdlKrnmfztIfLl2b2fzh2f
X-Received: by 2002:a17:90a:ec86:b0:35a:1762:92fc with SMTP id 98e67ed59e1d1-35e428bf537mr6976880a91.26.1775906706579;
        Sat, 11 Apr 2026 04:25:06 -0700 (PDT)
Received: from fedora ([2401:4900:1c6a:cd16:7e87:6c5c:5d2b:6126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e43079069sm1922154a91.12.2026.04.11.04.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:25:05 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: krzk+dt@kernel.org
Cc: robh@kernel.org,
	andi.shyti@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i.shihao.999@gmail.com
Subject: [PATCH v3] dt-bindings: i2c: cnxt,cx92755-i2c: Convert to DT schema
Date: Sat, 11 Apr 2026 16:54:51 +0530
Message-ID: <20260411112451.35095-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Conexant Digicolor I2C bindings to DT schema.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---

v3:
- Added necessary tags in the commit

v2: https://lore.kernel.org/linux-devicetree/20260409-beneficial-macho-shrimp-4b3a8b@quoll/T/#t
- Omitted address-cells and size-cells in required section

Note:
This patch is part of the GSoC2026 application process for device tree
bindings conversions https://github.com/LinuxFoundationGSoC/ProjectIde
as/wiki/GSoC-2026-Device-Tree-Bindings
---
 .../bindings/i2c/cnxt,cx92755-i2c.yaml        | 49 +++++++++++++++++++
 .../devicetree/bindings/i2c/i2c-digicolor.txt | 25 ----------
 2 files changed, 49 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/cnxt,cx92755-i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-digicolor.txt

diff --git a/Documentation/devicetree/bindings/i2c/cnxt,cx92755-i2c.yaml b/Documentation/devicetree/bindings/i2c/cnxt,cx92755-i2c.yaml
new file mode 100644
index 000000000000..c11bbf8aa9c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/cnxt,cx92755-i2c.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/cnxt,cx92755-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Conexant Digicolor I2C controller
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+maintainers:
+  - Baruch Siach <baruch@tkos.co.il>
+
+properties:
+  compatible:
+    const: cnxt,cx92755-i2c
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
+    default: 100000
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
+    i2c@f0000120 {
+      compatible = "cnxt,cx92755-i2c";
+      reg = <0xf0000120 0x10>;
+      interrupts = <28>;
+      clocks = <&main_clk>;
+      clock-frequency = <100000>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/i2c/i2c-digicolor.txt b/Documentation/devicetree/bindings/i2c/i2c-digicolor.txt
deleted file mode 100644
index 457a098d4f7e..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-digicolor.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Conexant Digicolor I2C controller
-
-Required properties:
- - compatible: must be "cnxt,cx92755-i2c"
- - reg: physical address and length of the device registers
- - interrupts: a single interrupt specifier
- - clocks: clock for the device
- - #address-cells: should be <1>
- - #size-cells: should be <0>
-
-Optional properties:
-- clock-frequency: the desired I2C bus clock frequency in Hz; in
-  absence of this property the default value is used (100 kHz).
-
-Example:
-
-	i2c: i2c@f0000120 {
-		compatible = "cnxt,cx92755-i2c";
-		reg = <0xf0000120 0x10>;
-		interrupts = <28>;
-		clocks = <&main_clk>;
-		clock-frequency = <100000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-- 
2.53.0

