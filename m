Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F630C637
	for <linux-i2c@vger.kernel.org>; Tue,  5 May 2026 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976811; cv=none; b=iSov2q0nXKue0JCUXiTawwSoR6ojuRnAUC2GRCGDilQZim5JDggsRhBHkYBEE3syKw/fU0TP9xUVdhUi75pF4PmtRMpxcZWQ+zbm5vHB+FYPChl3SV6EjTBuJ3yjBvsJTLTsuJus8bhBABrDm93AxdHiRkyGI36tg6RCWEztAGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976811; c=relaxed/simple;
	bh=BNQcmIUcI/sLEEdMaIwi95O/OjrcePYCPJrqUygwTgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AOCcS5LU2PNEW5W8CKrYe8hF+ufTcfB3rLs8Oz/wXIoNzMUin+gj8Te1pIQsszDLfcYNgxQ3iqI3kIIxvlffnCMCzK42IsbN0EEo9XqvuJqii6gkS2+H2iKkQTb1nmoh/UedRBg9zPcBPfnqDFYt1ULXCM87hTEVSHJxD3VczH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoIciCMU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoIciCMU"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-365212191f6so1859095a91.3
        for <linux-i2c@vger.kernel.org>; Tue, 05 May 2026 03:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777976810; x=1778581610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9jtWi+BJEmMiKBLc81hfsFIIWmO6WhR/hALIJ9C45EQ=;
        b=PoIciCMU4+3rlBr1aA3HOCoZw20/6NqJxj0nH2SYo6WYNeuIu0bXFSWkyadVedznbI
         Qk7Iaq2fZkWYsbVigcOwXbMo3e7q0pwGoV42wduyuZvRbe5ixRS/JrpLlb1QoUVgLFIE
         e5mwNhZj9ICaL3GK63wtouS6JgXlseCtuMYr7cC19E/4znTxYf9DFm51FtYR0Q5WPA7N
         NF29Ob8JZyBQQwEumZXEHPUPcaeGdYaFV5Cf4FVJziUlq1tuM9A8C2ZfBLyVfBji3BG+
         bvtytKHFJ6uEiIRpIgXN8zZpxur1KNZm+IvXkeUcFJNga6LF0aEMhGgc0tcYrgokTr30
         JGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777976810; x=1778581610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jtWi+BJEmMiKBLc81hfsFIIWmO6WhR/hALIJ9C45EQ=;
        b=NLW7iDjOOzWCSPn6yA8UgwmzUtVtXWIyjdf4M57JnA7F5+KYpLN5OZqdMCrrHaA5OE
         KMZIoeavQqXfoyNwRFjo3uH94XQqxBe+c5hGbczf7aYYeJ1DFSee3MnTCNcN1qjCdpuo
         uQ+NN6E4HDG9yMaYAJN75oWgJzYjLCFzDKllYUz8q0fu1+wMDQ3seYxnb6TPjLDA0cMe
         BbvgYEMGSkKLFGjB2dabZwIHli/XTcDEf940pi5QUAMZXolTXBvNea257f9TUg6fLzQ7
         j4u5tpMfJEDmO/5jqFp4OJHT3pC4oahvzSAa57LL7PHKu6zgESuaKmYXFUe5BHJjSn0L
         1RoA==
X-Forwarded-Encrypted: i=1; AFNElJ8URrxWyxsl5r4O4IQXYFAaNFWVZ2RBQkDe7rZ2no+tRFNCk4QWPtNL/wzngIVeiSXDzWqKBZ+HlzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybISPZ6VIFQjGhUyHIP2MZJWlV/TutWwKhd6K/TFYcDhZrAsr4
	h33MtgRJ/u4pQ7M6qvv/3+DXXetkfawf5VWGZAtJR3mU291LerAz/K8u
X-Gm-Gg: AeBDietOfEiowVbAHzBXpEJEobbJB1Fott0T9qh6hmcIjHs5VQBcSl+GQI1mfRk6WC3
	jvojzky5fvSHaTPzr6qcJpZ/RG1w7esE+tiuZFxZ1q/j6pm2rDvlKyF2s0c+Ykn4HdSPMUD1X8c
	sNP0xlKaRJCI5iHLsKuB8v9Lkz639dS8TyNmMnFb5TwNXk6r/tqSkL/WdWlUkbXx+SPkbKOlrjI
	ds7iVGY1wAfxMKfEEZIGUOttroY7sJuVeI1BqeV+h3VEJ7K66OjFizOyCFeQW2DAtkHx6JWOafS
	ajEpEzqUgPM1US5mpg3vTZxiqzaJviaCJNyVRYNiFyabGzSPRGT6jzgzZ3Qn34p+SqSTXr/dYKa
	LywhIR7yCfYAc3gz7IO5xmCYk6eh/RWpmB6GknKjWUo+BVmyBpjAyUqVq/JgfJQGtnL8jvpDVkN
	lPDYm6bXB6hrdqD076FMF2ilXVyFzOyAS3Vpk2MevR6NbMxL6n368jOsxQwBGdjHcSUQ8rQhNgD
	iOxjRAezLM=
X-Received: by 2002:a17:90b:53c3:b0:33b:b078:d6d3 with SMTP id 98e67ed59e1d1-365774d3260mr2619605a91.23.1777976808405;
        Tue, 05 May 2026 03:26:48 -0700 (PDT)
Received: from chaitanya-virtualbox.. ([103.249.241.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ec00ad4dsm18983102a91.11.2026.05.05.03.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:26:48 -0700 (PDT)
From: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
To: andi.shyti@kernel.org,
	wsa@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Subject: [PATCH] dt-bindings: i2c: convert davinci i2c to dt-schema
Date: Tue,  5 May 2026 15:56:26 +0530
Message-ID: <20260505102626.5726-1-chaitanya.msabnis@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Texas Instruments DaVinci and Keystone I2C controller
bindings from legacy text format to modern dt-schema (YAML).

During the conversion, the `interrupts` property was made required
to match the strict requirement in the driver probe function. The
custom `ti,has-pfunc` and `power-domains` properties were also
properly defined to match SoC-specific hardware features.

Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
---
 .../devicetree/bindings/i2c/i2c-davinci.txt   | 43 -------------
 .../bindings/i2c/ti,davinci-i2c.yaml          | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-davinci.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/ti,davinci-i2c.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-davinci.txt b/Documentation/devicetree/bindings/i2c/i2c-davinci.txt
deleted file mode 100644
index 6590501c53d4..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-davinci.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-* Texas Instruments Davinci/Keystone I2C
-
-This file provides information, what the device node for the
-davinci/keystone i2c interface contains.
-
-Required properties:
-- compatible: "ti,davinci-i2c" or "ti,keystone-i2c";
-- reg : Offset and length of the register set for the device
-- clocks: I2C functional clock phandle.
-	  For 66AK2G this property should be set per binding,
-	  Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
-
-SoC-specific Required Properties:
-
-The following are mandatory properties for Keystone 2 66AK2G SoCs only:
-
-- power-domains:	Should contain a phandle to a PM domain provider node
-			and an args specifier containing the I2C device id
-			value. This property is as per the binding,
-			Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
-
-Recommended properties :
-- interrupts : standard interrupt property.
-- clock-frequency : desired I2C bus clock frequency in Hz.
-- ti,has-pfunc: boolean; if defined, it indicates that SoC supports PFUNC
-	registers. PFUNC registers allow to switch I2C pins to function as
-	GPIOs, so they can be toggled manually.
-
-Example (enbw_cmc board):
-	i2c@1c22000 {
-		compatible = "ti,davinci-i2c";
-		reg = <0x22000 0x1000>;
-		clock-frequency = <100000>;
-		interrupts = <15>;
-		interrupt-parent = <&intc>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		dtt@48 {
-			compatible = "national,lm75";
-			reg = <0x48>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/i2c/ti,davinci-i2c.yaml b/Documentation/devicetree/bindings/i2c/ti,davinci-i2c.yaml
new file mode 100644
index 000000000000..89c639d023a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/ti,davinci-i2c.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/ti,davinci-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DaVinci/Keystone I2C
+
+maintainers:
+  - Chaitanya Sabnis <chaitanya.msabni@gmail.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,davinci-i2c
+      - ti,keystone-i2c
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
+  power-domains:
+    maxItems: 1
+
+  ti,has-pfunc:
+    description:
+      Indicates that the SoC supports PFUNC registers, allowing I2C pins 
+      to function as GPIOs for manual toggling.
+    type: boolean
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
+    i2c@1c22000 {
+        compatible = "ti,davinci-i2c";
+        reg = <0x01c22000 0x1000>;
+        clocks = <&i2c_clk>;
+        clock-frequency = <100000>;
+        interrupts = <15>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sensor@48 {
+            compatible = "national,lm75";
+            reg = <0x48>;
+        };
+    };
-- 
2.43.0

