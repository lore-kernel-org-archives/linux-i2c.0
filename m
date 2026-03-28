Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF56283C9D
	for <linux-i2c@vger.kernel.org>; Sat, 28 Mar 2026 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774692857; cv=none; b=HSRC/J1qmUO7g/FZFjMxNVqa4Nozgd/3VvP7NR0DZNda+1AxER0rHA7pv7xS/5nHqXcC5HocWcwXnvcuoCdTbeskU7Ssb6NHqn9D3EBX+VkBAlcNC97kokpyFKXUMGVFIhw4l270/7PHlc3pYnAqt1EfKQWbMdhEC+3rPZJ4WDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774692857; c=relaxed/simple;
	bh=BvfaRigzA0qTER69cauSqCVbwJJGnty09feTYvHRdgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bXaH63qfrRYITwWobF0VMb82xG/nY1ka+NklKB9D3pCIZV7bZSklW5HwKNKNk7OdNZY2ex5JtiFzx7rLod8PyIuoTLU31lxdXeOLJfs5W8semZrgGBr9JSPujpUXHP0qtHNbyyIluDC7pLoBJqS6eEotGZY/QnCgW+MwftWRyAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4FQuUQx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4FQuUQx"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso2043544a91.1
        for <linux-i2c@vger.kernel.org>; Sat, 28 Mar 2026 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774692854; x=1775297654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3TNxfZYvEXs0lEvJbRfOjzznTi6ItDZ6rSbX7ZykPXo=;
        b=r4FQuUQxzU75f6ro8SYw4BCRIHF34SRnMDcVaaiv48wNjNj8qzor86WGXOGwJu2HDS
         Tw8dglIvx1f/uAnnU/wfGJ1ISSN+S8wj1ZDFHs7FYOc180iUD6uDKUia95avLkXRYOmt
         cl7PjtbFp9rBBIo+ZzHe/Myrtb1wWyA/ppxvzEVl/wjtps3Du3MexhIWht/gHp4YMYGF
         5XuR1ZmTT1NP4ERO9dN4MQYL1pqzOTvqCtzqb6Ut+Uc31sIIIjg6Rn6B/wOA+FrVEGwv
         hj9A4eU6LxCBAREHe6+S0NXURdq8Jo7Nik/o3/y3fR3rKIeb073KoWw6uxw6u69KThCS
         ZpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774692854; x=1775297654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TNxfZYvEXs0lEvJbRfOjzznTi6ItDZ6rSbX7ZykPXo=;
        b=l6FXeoswYNpa3wvyCOvv3XAtGNJtHK3df6bORXqz2/96ETEHL5PYLfH7H5JQ6RPLav
         HmCZjB0kaf0Fzp4K8OKd2088bX0tz+cW4ds5V5Ov69ZRej9f+p69bVVc1YQCrl12cvhR
         xlI2gE+T41YIGJZRe3d5ku+u7PABrWABdN2ciHEQBsglljblwQ8LJRkKQeeHZUcY6HKy
         SMjz5DC6NDXa4WUpvTtkZ9tF43M8QML6Fn6s0tVZTL824gAkaIGd8LRoZIs04s4crzE+
         VcFjeEOGVaoN2aOfBNaGkFEM1iSBUomzWNYY2iGHZs9j64Eo+Y7iamXUnBZNFiGLGFbN
         NkVw==
X-Forwarded-Encrypted: i=1; AJvYcCVojgRUa1c3JeXq4psV8GsZMX65NbjRCG9nYMlZTVrZNfXsfkKoLexufD7d3JcKPPyssQbBy9dN0Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxerwXEvPj73Enq9IVK7tjtbSOwbrvUJYu8MMQWlKT1r1LuiAXJ
	4ja76tQvj960pqu4ZsA64w+9kdGWYEk3e9RvGNgfxpyezqBkM3GMNjWW2a5E1oFX
X-Gm-Gg: ATEYQzxGB0gwf4QjgjGSdQOA7s+WhSWsid7IdXOdUskMvMomX0qRy5VY6vNBg/dOOMW
	jA2d4jCp/Iv9EAS1VxPGMZdp/SLBJDP6o/Gga+7xzFUt3mFYq+Q5y+cNRSDzYaaabT+44XP6ov8
	OSbxpabPfrQaLN1KRv8iy3g+1F903B0LrFksTMJG+MlQ6tbuPVkiP3cSKS/FsAPKSnx2VpGmUcy
	RPddyWjBThtSIn7FZlBFyOo2LAg7M/A/4k+SAkk5OqIh3tDIf/QsCUz9JPRyZU3JoCiLIZwPyMF
	IGOnFOFyndXsjtEivgJMjGbxiGnw2rzL3GSIdKt13RqvFtxwGkKmhbej+CvrhgJ2o2Qzzr4pYLy
	hNSJKXc+fZPitEgND0ymHTsIWn7d+zNCZNyNKDmAN4XuasRp88dai8ThC0eIbjjVb9JmQ6CYXqt
	PxzMxT56AJqrapkGJVSi4=
X-Received: by 2002:a17:90b:35cc:b0:35c:29ba:bf92 with SMTP id 98e67ed59e1d1-35c2ffa8af9mr5711735a91.5.1774692854323;
        Sat, 28 Mar 2026 03:14:14 -0700 (PDT)
Received: from fedora ([122.173.26.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950b7ebesm1594714a91.15.2026.03.28.03.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 03:14:14 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: krzk+dt@kernel.org
Cc: robh@kernel.org,
	andi.shyti@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i.shihao.999@gmail.com
Subject: [PATCH v2] dt-bindings: i2c: intel,ixp4xx-i2c: Convert to DT schema
Date: Sat, 28 Mar 2026 15:41:57 +0530
Message-ID: <20260328101157.84191-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the IOP3xx and IXP4xx XScale bindings to DT schema. This
conversion also adds the <irq.h> header file to the example section, since
IRQ_TYPE_LEVEL_LOW macro is used. This ensures the examples validate
correctly.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---

v2:

- Fix checkpatch.pl warnings
- Reorder compatibles in alphabetical order

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
index 000000000000..15ef510f6fd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/intel,ixp4xx-i2c.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+      - intel,iop3xx-i2c
+      - intel,ixp4xx-i2c
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

