Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0F63CCFB2
	for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287775; cv=none; b=GoAbsByGbt0vYmilJHnC96tEEMiLXvEvk8/rcuRtyl9z4RXAq5AM4DMJ+tHqhOTwiXwSy/cpti/I2gMQ+O3uGNhGxqtAfno5uLgt4ElG6gZfNOBq4MEtf/iZJZATRvoTTWQvpEay9Jhz6pJug+qlaE2VfzKmEF6yvHKkZBgnmbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287775; c=relaxed/simple;
	bh=Zia7/De1q5TthWSYEWLCdCXljCxkVAiumOWzbpU94iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mK5nlz8AjHvrZL3mO8plk8oAfwb5pyk5VsUAnSM7moidIuXKh6kMWVPas4xNKl6gXSXI9xTZBtePEno+ldt9M0LRkbUjBSHZScLu8BE0Hj924p26etxL8gP0nd3IhEif7gHQcQ85UigJVX7x1uToWzuYlhhRNZFQslMFZlWDdaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR+UAaw9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR+UAaw9"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82c4b5dfe6cso564375b3a.2
        for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 10:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774287772; x=1774892572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F9rgDJBvOjQHeJIHea/WkUik8ezrEjHRne7jLDTut+8=;
        b=bR+UAaw9REN0zR8aBZkLuWfFnqxvlW/mi3su9CB0Icbog0ZE3y0kJFmuLct2VUF72f
         BhKbefa1PkLOzbujhHVokeSeT7ZddWen4D57ml7zgKNLJ5/PNizKIxBe3WP/RwMeyn4w
         cWGecSEh0Ygx+msHst+pofificU5vtfa2a9weiB71yaoziZ8hd48KgGZhXAuSFMT9aDV
         aYhN9T20GC7IsyLjYJNNBq7KCxvzSRfBKcNShCExdX/JVBSgYM1es9GkiZ9OtN7m/hhE
         3QI202z/Rh/xnCBWGBF5LbKqNb/byXJcRdMaoGp6H++bLZNEUljeasl8C0c6cw5vC43q
         0WJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774287772; x=1774892572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9rgDJBvOjQHeJIHea/WkUik8ezrEjHRne7jLDTut+8=;
        b=CZkcHP/1QUR7K98URhBAzMGaVBXFsH7ULm/RtdtezMtz34bNskmJRh0oV5ejB9mPiG
         sWl44o2afTZWmyxCmroU5U4S0SjufdMZKiOqWCKbcswDGdjVLqQLDZl6FhoTOdkQTg6p
         q2o+ZEbX5AAVGY0TYRcSHA8di0V6Vvbt3tfkvvFh8eOBgClBnJrzPQqkkf0K0SnuUdlr
         Jez1o6ssfoV0pv+MIXujSi67+iF11x2FbmWKIEcVoC1r4ej9D5gld5x1baGTA574jhLr
         t3pTpoYucUz3tgdvKm3JiSsfSywjJYgb4xalsKuKiAlUGBaHxIjZENO1FQSDSwfkpRZ/
         4Xsw==
X-Forwarded-Encrypted: i=1; AJvYcCX4Ht7g4aKyop0hFnPgZh80U6Cx2c/0sTwOeBq8NnYLKB6+i8S8ip7hCCBBUTLfX+0admwsdYfpzkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrlTyAwGomVrS7fATTm1uVzslbTuxwMwoyFkokCTEJJ+nBPien
	HfWWpfAK77UO9aBFS9YUTssqguZ9UcM2KCWSKBVDsF4q7M8PPyTTDyAc
X-Gm-Gg: ATEYQzyJhMol0gXbBMdW8TVEUTtYNDUUO/psVKGj+6vZgnhL686wrKIgJO4kZRwjvmd
	NBUAQdl303jdR8TYatKegp3iksB1PqbQSbMGLifL6lPOCfyElQppRxi/HfSyjx1p+NWJ+Fy1QO8
	38hRT4/2mS/s66w3kRaqCdpX9kCWhr6NfELszmOYWdRp16rk5nzkNMfj3B3FxKQLoadQHRr3Zbb
	hzcTid3ZAwLHzQ+ioOZsR6a6F22AWbYGBrcnA8wUnp3KLC2Zzr/zhwhdoOH/I/DM3Qcb+MSGk8q
	kGaSa8Z6nrPPDL39KeJlfWquGdSCnxXtmnD9VxLLssP2RGaddvapp0OJsGT7TyfJgU65CdJkM91
	UXINrfdXFkHfNo4THKKXWOVZjdM1ibx2wrA5/2ADz+Dulx9ZMvMUyh0NCic5YosF/W4CxVMKrtM
	PHIpX5vTVv+U06zh/E8eHHzrMJAN60mSikjw==
X-Received: by 2002:a05:6a00:b4e:b0:829:8942:2ca4 with SMTP id d2e1a72fcca58-82a8c241249mr11327052b3a.19.1774287772189;
        Mon, 23 Mar 2026 10:42:52 -0700 (PDT)
Received: from fedora ([2401:4900:1f32:22d3:4161:93a:b87c:36eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da3dfsm9847123b3a.45.2026.03.23.10.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 10:42:51 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: krzk+dt@kernel.org
Cc: robh@kernel.org,
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
Subject: [PATCH] dt-bindings: i2c: cnxt,cx92755-i2c: Convert to DT schema
Date: Mon, 23 Mar 2026 23:12:36 +0530
Message-ID: <20260323174236.147507-1-i.shihao.999@gmail.com>
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

Note:
This patch is part of the GSoC2026 application process for device tree
bindings conversions https://github.com/LinuxFoundationGSoC/ProjectIde
as/wiki/GSoC-2026-Device-Tree-Bindings
---
 .../bindings/i2c/cnxt,cx92755-i2c.yaml        | 51 +++++++++++++++++++
 .../devicetree/bindings/i2c/i2c-digicolor.txt | 25 ---------
 2 files changed, 51 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/cnxt,cx92755-i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-digicolor.txt

diff --git a/Documentation/devicetree/bindings/i2c/cnxt,cx92755-i2c.yaml b/Documentation/devicetree/bindings/i2c/cnxt,cx92755-i2c.yaml
new file mode 100644
index 000000000000..669397bbc571
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/cnxt,cx92755-i2c.yaml
@@ -0,0 +1,51 @@
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
+  - '#address-cells'
+  - '#size-cells'
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
