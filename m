Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B48378D7F
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 02:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778554155; cv=none; b=cDge49R3j5za4thCQBFFXBHuMHxlYhO+urRn332k+oeuC94FtJGsOvezAOc8h+8eCsmh9tMfsZr/QhERCC54+7HwSSlHXEYqzsE0o/lgobWvFbJ7YLIau5KJOmkkh3rprbUV6x3WtXWVKc/RRSbIwvbOdF6YcOwzrNk2v5GnYh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778554155; c=relaxed/simple;
	bh=3beTMaNbdoR+54hqmfREYHI0p3HG8qixhJD98uWeMDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8RtAALgsHu48I84MvyLEmjZ+PZQN/Eoc7eH7lT8unZEujjjTkj2DtquF+kAFlUCY45ew+P6huhzdRqq3zZj/q9dIVSYihpR37Qzj/j63ZvpzEUTPTu2GiWfAIB5TVFGItHCVywPV3wf7Q/6fzdMJz26RuOB0exc4UhOPlc1Auk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9J7f9fJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9J7f9fJ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-368763a1bdfso1091972a91.2
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 19:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778554153; x=1779158953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPHa6Agzy1CClNZP307eBIa+jAOQbdPXd+dwL+YOTPg=;
        b=d9J7f9fJf1CZ0yaPYVRAicmXTYfCDnI/xX0PH4l3SMF3LYaygqKIRZvMWJgEfcYhoo
         1rebz736r4Yz+1GQ6mfygDONfrDWOjNt4Xx+reaF8A3cUkpQwr6n5mBh8X20dSsJB9/G
         gz2i9+ckqt0L1NrI7zzl+/543XQY1OEkpqPst5F4fUiiQ39888SthNyAxOOGI2zsai2S
         p+ntBk6E84nAQMx42HbBRSgzYJCJXUfod3/xHUuFy2Mq7cT8KRE9aT7DhVntMuzaoIaE
         0PcGBlPGe/sIqUNGCH3Z9kzyNYomXeiZ0sdrOraafrZarxydrCaifw67XZT22b3P/CPF
         oEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778554153; x=1779158953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPHa6Agzy1CClNZP307eBIa+jAOQbdPXd+dwL+YOTPg=;
        b=nAgED+mHD/CbSRDAd2X8GiU9PeYv4GSt5hL6/BPqmodJQ5EySSWJtlVWLq4jSOt/Tq
         5bYyBIYMuUMjeMUdAlR8e20WHUjOaWBmaQBIidmHaRBWxyl2MQIyPej5rBRbB1Jk507r
         QJClYlQoqh/Qrin47BNz2U/J+L2Vm7ILlng5oFSXG1MnS8ewnHY2hMMcTpJpBli45PtU
         TwWTLJBvIG3eCiTF31Lj08x1nQuwxe1jRr7hkSJ/Y7ZEaFnCPK6lnkbQZLsZA98Nm+5p
         Jcw6IgaJDv3a7dziqxoW8ja9//AEU99x8KsmAbSS+yaIQkvDGRwXZDDuW2q1VqTd5J5+
         NkPg==
X-Gm-Message-State: AOJu0YxtA8QWRMx4Aax+6f5X83WZ1c1NusCs7w0MV8nCAtGxgRTBYFor
	+hjuVPU7ISgpFUngP8AiBc/CSeX1SGd3i+SLFGvgssK2lJb6Qj1IYbgr
X-Gm-Gg: Acq92OFOVa8bN0OnImrFUXYuhY/KtwkzfWX/TI2t/93ynKN2D0g4dMBG98971ZfcqiW
	YLsVeSr8WLfXwh3912kB64HiHNlkmYKlg/Fmx7rRBfGPc6vPEOWLitTyYMgk0+smu2ZYbG10QUU
	7nMTpD0CwI7YIc5+1birWKOGi8cF3D42WjN3ADmRekxOczUJfRJ9y1GgtHDyXQ5X2bE4TdAL7Ky
	g66I5zaqUVtu0HaHHJmVu/atcyUS5Q0GdOFGRuYhUArIfQL0bPziD5m60ImZKwgiRoiyrbVfNgo
	Ol4m+hCrpi5Vk6UBUj72jiw9W3kvf8NDEdK5tB8uVKuU+ptF82UwQnPkYqduUm2HV4m16oPIxyz
	1fRhKIdLhxBXcHzyG6JFO0LeIP0b+pxTe1FSrF7gGhejkvHr5cXttrY0oJTWrd08fly9RoNGPCe
	/yMoTu6EIu7pd0nZr92pSoFnVI07lncC3zyEunptrnnH5cVBBXT3cpqLhtv51TWKdTIJ10kw1K
X-Received: by 2002:a17:90a:1001:b0:368:78da:803 with SMTP id 98e67ed59e1d1-36878da159fmr3395240a91.12.1778554153407;
        Mon, 11 May 2026 19:49:13 -0700 (PDT)
Received: from chaitanya-virtualbox.. ([103.249.241.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e690c4sm118619185ad.57.2026.05.11.19.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 19:49:12 -0700 (PDT)
From: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	brgl@kernel.org
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chaitanya Sabnis <chaitanya.msabnis@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] dt-bindings: i2c: convert davinci i2c to dt-schema
Date: Tue, 12 May 2026 08:18:51 +0530
Message-ID: <20260512024851.4792-1-chaitanya.msabnis@gmail.com>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605120133.lQ1F3qlY-lkp@intel.com/
---
Changes in v2:
- Updated MAINTAINERS file to point to the new ti,davinci-i2c.yaml file instead of the deleted .txt file.
 .../devicetree/bindings/i2c/i2c-davinci.txt   | 43 -------------
 .../bindings/i2c/ti,davinci-i2c.yaml          | 62 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 63 insertions(+), 44 deletions(-)
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
diff --git a/MAINTAINERS b/MAINTAINERS
index bc3bcc641663..50a11a8d71a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26396,7 +26396,7 @@ M:	Bartosz Golaszewski <brgl@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
-F:	Documentation/devicetree/bindings/i2c/i2c-davinci.txt
+F:	Documentation/devicetree/bindings/i2c/ti,davinci-i2c.yaml
 F:	arch/arm/boot/dts/ti/davinci/
 F:	arch/arm/mach-davinci/
 F:	drivers/i2c/busses/i2c-davinci.c
-- 
2.43.0

