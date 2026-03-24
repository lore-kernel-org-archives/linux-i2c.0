Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E05B3FE366
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774360227; cv=none; b=tEq9IzJkmSDldV2tr3iqlrlVDpdoDuT+4pQIcpd9aUaAqh2ab7Er2HDT3acQr6jkrjszI3YZ4yV9z993/vWN783vstLO4nodbAermZUhxTrZ1+8H39l6uyNX7V9P/T+GwIYFGAjCpF8Owfy/c5XHCBrBgzO6vDZ/neQJQN9ocMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774360227; c=relaxed/simple;
	bh=ZFB19VUeR99A5y68es2jsd4tSaX8a4ZSbxHmtlwKA54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bb0nIzgTUzpDVcbFPov/p2KvYGGhVRTIwjhVVHapX2dh1ZHU0Nx5bwXZhtctwvVZbnBuVXZJEUFDJQhzU5aKbu8UUcVYNw0GQW5kYpiE5oi+qCZvHM4NfWyJuPwPcAWMbRjOTE9BE8yeOf3EgaMSX1VMEw8UoL3pziWVWz0n7Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENBwxu/2; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENBwxu/2"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so758865a12.3
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774360225; x=1774965025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eG09CQ6i9jLIM83EphpMOCR5GqtN/33XucYU6e5iqHM=;
        b=ENBwxu/2cYviaNH67Gl3pMTMthedNf2x2/n8rThJGB++zrlVdPd9BoXxpqxxT5tphQ
         BQ9x8BMG02dLhttKToD6qMh6O0VJfyPW0fQBAj3D2NHQ+9pqrNu6sRzbohWl21X2qwPX
         GN+w0lqr74C3kGzsO0r4tzTY/S/P0gKK4o9VnAPwSK9A5CpeRutZaUAJZ2s7wPtNM/LB
         NVnDe/WoNNS3vtN1CYYjOVzx0wYxX5+u+fadx8oh+DWEEvsnWZauqoF79TsqemYj0Qd3
         cGT6oc7684agDMImj62yA1RwbAuAb3siS2/0E8ft45VFJ22v3sNaXIxfF83OPbLK5k9c
         028g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774360225; x=1774965025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eG09CQ6i9jLIM83EphpMOCR5GqtN/33XucYU6e5iqHM=;
        b=nThCUmWfJDbP3Slv+2+KFS8rtSkzPZj5QSzKOFbgmII7ivE3jBnkBLa0AmR3rFDVrE
         nvbkVeRbQnEFAHP4up7s+EXkM/BFNkR/y6PUJO8DfJ7pEaX/haiomD/8VH2+TmWq5pmx
         n7hWGZbZh406LlTXXQyBtdbHc8V5DVQT6vPwx0BJmw9qU9aYNuxZJaSw1N8z6rSI7qay
         ejX1aaFvcyQKPdqWAlmr2p4VN9b/060ZdS1lTHe+VWQ1TyylujrAwhvKqnTh10SCY/Oy
         WNciJ9RYsfVwXGrkYsylHDdBuW2n9Uav3ZFVBJD5V2TdTtF1LJo7Z1GSGD/JRZCHp3nP
         1LXw==
X-Forwarded-Encrypted: i=1; AJvYcCXzRTG3mcex5Nm8YQ1w07VDF2iQo/3e4YNoNrdhjbKBLYw/EST4MgVbqVZ9FwT4W8yU871XrtyoTRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvD0nlL2voVCr1Z8PPHzXx4JQ9l7wA53Eeav76Kkv1sCVVmJcj
	+subNT6hkcFNuufuukZhOwahabynJxaoy4UfL7h5ARFIp8JOPLC1pAfW
X-Gm-Gg: ATEYQzzw8Yc8ljvoTZHf0mGukQC5gNw+HKZg5X2BDqqA3cusHHCgEhKwkWdB76Qh3qq
	zcbRK8ot1c2bFbSxqsdZiaYRs8s5LzwDDlt9QyoGBq+AeDoBY2XdjoGVf5yoSGxyiMEIF2jE6ws
	xze+I0gQpKK3dc2nRC79o4a4nf/T6HrE9zIcsG0B6jxidptIr9wZK/RPAAf2Xodw01bG9qALFBB
	J1oSLAqOfB1VI4/Tav8vRzL6W607z4IvPcUdDQ6xCV+K1DMcwpSMC+XHZ+gZJPE8I1A/1E/+XbB
	1PxhqWYMrdPuTnOdo6Et3/eBPiOciazXI4bevbh9olV49RhXcqWdtgx2REZvG8Io++UzoEPmCw8
	FdsAoUpUioR6EWQEBCFNRV+f5epyJznwrZStG6lumlI4urfDYDAxNplSvmBWxUC9ucRl+GoWCsI
	vMNVFYeJ3GGht+cClLALI0RTo=
X-Received: by 2002:a17:90a:d446:b0:35b:982a:28c4 with SMTP id 98e67ed59e1d1-35bd2bd5848mr12549745a91.3.1774360224631;
        Tue, 24 Mar 2026 06:50:24 -0700 (PDT)
Received: from fedora ([2401:4900:1f32:22d3:4161:93a:b87c:36eb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c030577f7sm2900902a91.0.2026.03.24.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:50:24 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: andi.shyti@kernel.org
Cc: krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	i.shihao.999@gmail.com
Subject: [PATCH] dt-bindings: i2c: intel,ixp4xx-i2c: Convert to Dt schema
Date: Tue, 24 Mar 2026 19:20:10 +0530
Message-ID: <20260324135010.17730-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert IOP3xx and IXP4xx XScale bindings to DT schema.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
Note:
* This patch is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings
---
 .../devicetree/bindings/i2c/i2c-iop3xx.txt    | 20 ---------
 .../bindings/i2c/intel,ixp4xx-i2c.yaml        | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-iop3xx.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/intel,ixp4xx-i2c.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-iop3xx.txt b/Documentation/devicetree/bindings/i2c/i2c-iop3xx.txt
deleted file mode 100644
index dcc8390e0d24..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-iop3xx.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-i2c Controller on XScale platforms such as IOP3xx and IXP4xx
-
-Required properties:
-- compatible : Must be one of
-  "intel,iop3xx-i2c"
-  "intel,ixp4xx-i2c";
-- reg
-- #address-cells = <1>;
-- #size-cells = <0>;
-
-Optional properties:
-- Child nodes conforming to i2c bus binding
-
-Example:
-
-i2c@c8011000 {
-	compatible = "intel,ixp4xx-i2c";
-	reg = <0xc8011000 0x18>;
-	interrupts = <33 IRQ_TYPE_LEVEL_LOW>;
-};
diff --git a/Documentation/devicetree/bindings/i2c/intel,ixp4xx-i2c.yaml b/Documentation/devicetree/bindings/i2c/intel,ixp4xx-i2c.yaml
new file mode 100644
index 000000000000..13ba2a0e336e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/intel,ixp4xx-i2c.yaml
@@ -0,0 +1,41 @@
+# SPDX License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/intel,ixp4xx-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: I2c Controller on XScale platforms such as IOP3xx and IXP4xx
+
+maintainers:
+  - Andi Shyti <andi.shyti@kernel.org>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - intel,ixp4xx-i2c
+      - intel,iop3xx-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c@c8011000 {
+        compatible = "intel,ixp4xx-i2c";
+        reg = <0xc8011000 0x18>;
+        interrupts = <33 IRQ_TYPE_LEVEL_LOW>;
+    };
--
2.53.0
