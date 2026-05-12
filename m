Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72615367F4A
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778554852; cv=none; b=o3F++rY7SuWI4bxj8ffxEveRqxEnCcz6aKvbiXJhW2i19CONG0jaxJvnod3L3krJ9eBSFjq+GM8mkwl0+TryZHpq2zP4Ifz30USS8kPt6CkzOwNCsil48WlL0aIpXLo8lwnNkAYZLV3N+hBn0qg688emoQbKDIGithrB+ltstkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778554852; c=relaxed/simple;
	bh=qPqo0/5DPCayBXh3zokgKkLJCpGWJDttXd9AsNB9jx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kl9YqAL2fel0kr3DJ2Ir6Dbm3k79CBVoO7a4g8ltbYlT/pZdK4b2NCWGRKkdEI/0KZALn+LbuxjtivUx/dzCRGqTCfRajzcQ+o3T+28ebTJUg9/L9Zad3f0wh78h3rjcuhGPhy3CSGDFsoF5ZL2qH7EUNfRvyRguYvx9JY1Dt7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp94ZPTb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp94ZPTb"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2adff872068so26697265ad.1
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 20:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778554851; x=1779159651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uLRtpcQHtK0F1OIYFcfZ8eOOu6S/PxCXSiUviagPQbc=;
        b=Bp94ZPTbCn42VtJVAh4poKnv4StO7UeYQMVWftNRgYHvEkd0otBYjr3eWySz0rpPNN
         HKMWGm+Lk4/DJeeBGurgma5Kb0DCu+X4/YNKiGxjashy3CeljWvsICWaykbR1Jis+3IA
         6UexhJuOC8f7id1ZOosDLBYeKiUO35l9tV5mB/G4UzaA/4910o8rm+UZuyhZZ2Spru2W
         a6aOrjLy3C619Vt77ijwBP8i3WHr6D4nUUzGMMvjPR/S4zI+UdUwYn9w4k6Na6/vwqNB
         JaGjpZaGs+cMF+ZBMf9LMk3D7J5aphQ6Uxc4W/cB5Q6SJw1zFDASDBNctj+snUfac7ws
         YhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778554851; x=1779159651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLRtpcQHtK0F1OIYFcfZ8eOOu6S/PxCXSiUviagPQbc=;
        b=rj/LI+Zd/I/XApiVQBy5aQYWoQqnWa8yBe27ERN2UIOOaH3rBWoq+OVzbPpvqhGx3z
         mUHXSzN/rZuvuhc5p7xTC5DtDd+pnKodnAu94Oaem8pu7DMoffTGTxQEkzG7vDN868q1
         efVAQaHdjZc1JisOVAjviBvPYfdc8nQt2okfIr2FEUtTL2bNVTKAKCnBG4gWT7pl2zBF
         enpi+FZKzapkO0q+wwVaV2JGSSMJB1WoN6pZ1nXXNrliDYxT8OXhWtfpncgSpE6OEzDj
         5bgJbk5LLHDE3pRfo0AwfsBbD/TNbeiaY5i2mVHvVZPfwGhh8QeTMrbJueHS9HlgFptb
         cUHg==
X-Gm-Message-State: AOJu0Yx9k7m51UGgMA15bApv+MwurVdFPTm9rZpioA0uKZsVFzaReE9t
	06cZWCw62Eq1iEmW6g+nB7teEyZ7zAiPLHP9Mht2ndEbeOnP2qS9iiqn
X-Gm-Gg: Acq92OFDwpE9SKxV0C3uKVlm7WzqmBaYS0HIwz4E99afXGMTTpZhBe/U/563+FiVG4a
	0uzvPSwUHuO/4xn3Qz5/vuJ+xBsCy8GtiH/UMFLarUHeTzhqZl0rqZlqY6MyhL/e1g58mWx5p2r
	8Z3dbQK68H6M/r9HdQTHzr6Cy6cHslVU2Mt3QAYDSnAD6FbP7yXuNTpCBJ+9j+2Klh/BNQC9zEm
	AKZwvxLrBP4YMW9TGQ2OaaVsUdQHWp322Dn75UemICBZ5sMJE+R1J6Gn70LQXvSEXnyzNCTxwBI
	CRQjPG4Y9RSDDbDZVfRCciTOebMzQGzLMaKSAO23BNUiEuLA7HuHMU3ycN2y62GN8HlXjsYXQth
	uftrEEXRHwB6EA0NlTC/F6bVLMBSg7SD1bnJ19mKW1yCfvxzK9VJLl6EZjp3fs7CvXceLDCgMaR
	Y5SSwvkDmGlLqOMhrX1E2v57D1vSyT69s6lf8Jj5h1Cht0P5KKUB8RkotsRY4BBI0z3jtE1xXF
X-Received: by 2002:a17:903:2ac5:b0:2b2:5597:bad4 with SMTP id d9443c01a7336-2bd012ad28dmr13565195ad.30.1778554850610;
        Mon, 11 May 2026 20:00:50 -0700 (PDT)
Received: from chaitanya-virtualbox.. ([103.249.241.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35eb3sm119851355ad.41.2026.05.11.20.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 20:00:50 -0700 (PDT)
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
Subject: [PATCH v3] dt-bindings: i2c: convert davinci i2c to dt-schema
Date: Tue, 12 May 2026 08:30:32 +0530
Message-ID: <20260512030032.5006-1-chaitanya.msabnis@gmail.com>
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
Changes in v3:
- Fixed a typo in the author's email address within the YAML maintainers block.

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
index 000000000000..e8064bd1fcf7
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
+  - Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
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

