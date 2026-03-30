Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7CE1EE7C6
	for <linux-i2c@vger.kernel.org>; Mon, 30 Mar 2026 05:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774849618; cv=none; b=qleD0aVNst9njhJAyGzzIAJEEeQkKJitapK2FAyLiBQQUcic+G9roG/7gH7Y8RoccT+QJjUSpAmUuec69TVbvumunK9viOpAAMEJNO6WGjCHqCJgqnqicl1sWCqysGzse2E6daOdyPx6bn35VXamiDX3z8KEKy3KpS8tvlHgRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774849618; c=relaxed/simple;
	bh=MxSxEdgoZ4PoII85RGQRakg+DmHRK3gpJWFtiILNMV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vdgtm0ZmL2yn+Gwlvk5ASot0IqNwgEt5HFshrQKuRWXvSkSPWHCbHTSTX3Kw3FmXgVUc/kY5dzcFe4f8lf07RrhFwS216XGpPNHW7YeuJM86gGZN05HJ09AdIRAXDjhJetcFe4uSpwD5w76WFnnf8kplDZmVGHBNutR5F8uZ6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AD8STJDb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD8STJDb"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2589c26e3so1235795ad.1
        for <linux-i2c@vger.kernel.org>; Sun, 29 Mar 2026 22:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774849617; x=1775454417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rYN+ax0YYaz7mmeSbPjkbMbninoa6J4+7cNsZfzsvA=;
        b=AD8STJDbX6BtdDDLXIp2HmeSzA/MpnM7ckf4dTOnh/gOJCRbW4WsTvSLCvaI9BbDOS
         6i/5l732EL2SX4i7LFOXBi2GUfdydSj7biiKUmx2Xx1S1N5gpy9crBtnX8re+497De8O
         3F2C+DpB7qqRwddqov7tlohQNVqx7xaFl86LIt+N9uqku8dXGnfj0/pigvKrnbcd8hWg
         CELyKsaf6TJSFmU86ccGCQlX4/Z76sJ7fhwcnph0NCsIk7Qwc1AyhBHib61P1VzeAyxx
         kp8d2GzVaZ/vUBpQF2v1ZuSFgc7XEiia7rnX1EOZnexgdgoeggG4Ak4Dbw6M3/E8R0ap
         HC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774849617; x=1775454417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rYN+ax0YYaz7mmeSbPjkbMbninoa6J4+7cNsZfzsvA=;
        b=O8VRq5a5OGUK1V/+h9nOuPBLYRFnxMMG4wMmVVGNAlpX4cEWFht8DIi06mnCFNXA/F
         TSqReo3eW69FaYJt6o4E6R+Se8c5KLIi6UZ76SsG+JWCbkwEqsWvZayd1xGo2zlWLXxK
         8/d6PANqnlpGiggUniTdvnGlOn1hQT7udj+rFOZihkdmmlLDKdQLVd2FyePOaEXKYyQW
         JfEWYCw8s8HjMEWnoDJSJvAK0/RfnoyZeUD3gobzYnUWMaMDmyZhPf2JEpQFcUGdpr/S
         VsBB2wADcUan4Ol3gLNNUASjZlXxtEWEd5WHMuE6mlk44WZdxhrvBmoeyGeh1vGm+jSX
         4gng==
X-Forwarded-Encrypted: i=1; AJvYcCXymQutBMTz9YIQ1mvzuQIoa+qrvHJ97FhLPb5Veh+XzI9oeub0mGaSr80X4iGO5bsKf2yYZrrVsBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd60gxJSdO/zoMSeOsh8SDf080PBQv02Ayr1e0kUmNGoXbrsWa
	mNOUbMSCXqi8rXkLaTiPZJ2IeX4D/Rf7cUEB1QaXhvEjB9/E/nQRqF8J
X-Gm-Gg: ATEYQzzI4sh3zS5x842pORr9dVzBl7UtcW7NFT2/xaCpKGCB2TVcpqVHERXBGLet0AH
	euVQgmtizoOekCav1T921a3zZcq5VrJRYKKVdZ7l+v5T5AMdV5MZGaPC8ZTX3YRKJomsUYlgBnj
	cZWZTtPBXndP+Sqye2DOguRuP6945DM56deC7mMgIS1xZECRacgipC4RWyzEXpnttMD2gSMBxz4
	nNjdjjl9JZuGaReHOHRnciFUgRv+5av5nPzkl26ZiTQolcxiXsbVoLQ8hjf4juBEBEJdfUvCL3l
	yuTivEKvIN5TxbXFVVv9cg2jfZAhfJbmYpsKDQhT5/Jkdi7+Ex+0KaerAlii9gsblUMLXo3ad36
	OXXrr9A9XkV8kZ1+iNcqhQVeWd71/BvJur9wfyD03UWnM/q4jEY3oGB3DDUfmBLPOiSiku7PEVs
	DrAVMnWI93Vcrlm/hesWx0SwUCJjb++g==
X-Received: by 2002:a17:903:3886:b0:2b2:4c92:c389 with SMTP id d9443c01a7336-2b24c92f846mr46653035ad.34.1774849616597;
        Sun, 29 Mar 2026 22:46:56 -0700 (PDT)
Received: from fedora ([122.173.26.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427ae07fsm67446745ad.69.2026.03.29.22.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 22:46:56 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: krzk@kernel.org
Cc: andi.shyti@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	i.shihao.999@gmail.com,
	krzk+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: [PATCH v3] dt-bindings: i2c: intel,ixp4xx-i2c: Convert to DT schema
Date: Mon, 30 Mar 2026 11:14:39 +0530
Message-ID: <20260330054439.9545-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the IOP3xx and IXP4xx XScale bindings to DT schema. This
conversion also adds the interrupts property, as it is used by the driver
and existing DTS files but was not documented in the original binding.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---

v3:

- Add description for adding interrupts property in commit

v2: https://lore.kernel.org/linux-devicetree/20260328101157.84191-1-i.shihao.999@gmail.com/T/#u

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

