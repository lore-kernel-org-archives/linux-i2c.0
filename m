Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18113A6B8F
	for <linux-i2c@vger.kernel.org>; Wed,  8 Apr 2026 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637486; cv=none; b=GFs4e4hIRt+jWAyiR4PZK+oDFKad4Sf+K7Z5Lt7Vk6nIn81HKny/9mVluaGYAURQcCKnLWg5TChkc+4Xb11VBU6M82ZS7pi3b8dQ7BGt+Ka3R3bqyH3or/D9rMa+FcpmyvmeZ5AJXVpOFObAMA50cMnWGbnMKbhHRYHfusCh6TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637486; c=relaxed/simple;
	bh=o3i/9A+UR7jHnszAbDMT6wuqZPcZ0j+UzYLKz1f2lwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHG1VE54EO3gbN65frG9hcbcTztYeN7a6KmI1nj8c8vBkd0MJPi9bujHsxlWviDbtxJ8t6IRmMM9mVQ9dPGtF5vcEcvGqfSxrMVfNaUKOmwAcBfEmLINzYmjgEuXdm7qEPaJty3ZPCeOnxCl75nxAr0xtu8gg/gY5ixWs4AESEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxzVhuTH; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxzVhuTH"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c76e702e01aso1318268a12.3
        for <linux-i2c@vger.kernel.org>; Wed, 08 Apr 2026 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775637484; x=1776242284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ytUk8qPLi0qU09r4gER+1HWGgGcT0Zkz53wb+1TtHds=;
        b=cxzVhuTHQAp4gMkJoIYZ5Pi1T7x8s4H0mEeaLKu1fbDcDHi6iXIlXWPMayMPh5tsyZ
         85nVIvVZbvT7YqsfwvLy4uMmKWhUo5xo+4prvQXLmBnS4vuQ8nyKopAKO+ynbrLNsJce
         otiOggd4NmpItuVew+A+Im2Aua11J2BTQcdonU++jCWZGct1OyN/FLb0BeuR++hMnXq1
         Gm6QjKGnGcRHLnxRWDjjMANxNb6GFkpGPqaDrBwaAfpQFwO8bF4K4p2FNJC3RAKA2Y93
         CsSkUhcxvrCSaOlw13PEGs6PSII5rEqQz16lI/qgTrEhygF59hJw3Z4cksPx3EiBL26w
         o5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775637484; x=1776242284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytUk8qPLi0qU09r4gER+1HWGgGcT0Zkz53wb+1TtHds=;
        b=HQCYsE4ew6I7h7SrHt+AagzX3OKYnAZfEQv4fjCZEmEWiSzTZJUwXxKqDriS6pTUss
         VNpFyiLB63S84elWwh0vGRXdT34271DChiSkyV83Nv6/sNFl6nv0dq/jwmJnL6O6sCh9
         U+YYFw24R5YDgmEzYQ5g/EAvxnl++7BbtSC6QQRMTQqDglIBLe6pmvogp1oohF3F4SWM
         Hi2N8uyap2Kqbzihs04Uld6RmatUJ+ibYoXQt92HMfqaGlYr99Gt521zihPp9pU7X+CC
         RM8PGgRexgox4EX48tK4u4UHKvwjDLIWLvt6/D7O0A3hGxZtxGFNg+4SL2sWnDifnWn9
         UspQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9XC5VrymE0icOfrhIofsi/t1WNHadWWCJ5zsU3WdfK8LDb0Ad7yv/FdrA/tjFiA4mzI9vicwH7h8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz21F5JBQU1fV9YFw/zB8LGvKB5I/bfqOlW+lBS1s0rJiqUeKeR
	Yt4iC6k0FIdgzIHgo+y0i7h+RFVV9iouKYIqqecRdk62lbO0fwGdjXEJ
X-Gm-Gg: AeBDieuTg08brUsflj65rPwz3tvjjMzuQAHnpsspQ2PljwvCwwIP2mZK6OtQurtuLuY
	Pml79A/AskEiw+heeE/xUxhtKgJvA0tlJo6oRmn5QSTMjTjplIAe2UZD271uTjQRf/SrN1njqkP
	xR5dL1683nP8E7Ap0DfUkk1ntadpWohvvaMX6PVitrgic1QA9My7u6tBbzWzdHsiqLkk00xMuBq
	Bg6grdu6IkOPCOKy07SjPTieyxyEhkbR6Hi0vQnMYnoTUck441R8hjOvNE78Vv7isDvI60Vhp7u
	dK3Xg/wHFpjt6aerbpK9LagRqf49864osXg8tA5qtzML2qn5B3MKeDsXXsHsOefPRK+funaYQ/9
	w0q3CGTVr7d/heM0VOv8Bew3O7R4UinhxGWbxvHwC4j3SNqJa5mZ2KLq0QgRahRgNmuYRQiFyrp
	fDS6QdBjZISw7L9x9HJzqq
X-Received: by 2002:a05:6a21:8a0e:b0:39f:9eb3:1d09 with SMTP id adf61e73a8af0-39f9eb31d55mr5025574637.37.1775637484198;
        Wed, 08 Apr 2026 01:38:04 -0700 (PDT)
Received: from fedora ([122.173.24.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6562018sm18210763a12.18.2026.04.08.01.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:38:03 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: robh@kernel.org
Cc: krzk+dt@kernel.org,
	andi.shyti@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	i.shihao.999@gmail.com
Subject: [PATCH v2] dt-bindings: i2c: cnxt,cx92755-i2c: Convert to DT schema
Date: Wed,  8 Apr 2026 14:05:49 +0530
Message-ID: <20260408083549.12815-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Conexant Digicolor I2C bindings to DT schema.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---

v2:

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

