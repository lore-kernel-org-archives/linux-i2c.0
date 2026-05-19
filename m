Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C21D36B07E
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229997; cv=none; b=GjP/LdaQhtpOI3tpXUYfhlWb8ZXPXLRKdhYs0uegn/RkgxB/BcAQkQNn2JupdVIw353CH21jLdss53eTuOSEnPKfx15GU9CI8v/xjd3WY5ypCuNL5zjtW1u7FPEPZpFhZ5Jy9kqkIi1538Z5/Jg8soAw33VDK2hbZwGHLYxtxV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229997; c=relaxed/simple;
	bh=NYh7GkAaQitazkIJS4x9NUz41kWd9WOoj1M6tPz0fa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwWZTkGANVUiBEH3hcPo6EVTsH2I/+CYSdHuWBciRtAlccjHmZhRhILKjEpvuz1byV0OkoxAt0jbyWakoPMcKCr3Nuj6TYDoSDQ3mb9jDTHY93VooaxeHD0m6j9SkrGbjdMZITVfM4+pmIqFCmoK5PJBYpIIN/FxJZ4N6pziqYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caZbYzrQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caZbYzrQ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso55340945e9.1
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779229992; x=1779834792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKUS30hEKkJqsuTkVMrr7mwScb2qlJAj6ESCesmLApg=;
        b=caZbYzrQdRftFV0MaNvnlrUK2RVP53zySKXI177wmGdV8fYV7NHtEll4p4B7kdY0B8
         ISUoK9mNIg3YleZ7jeLvXfF8VH0LVAOvjRq0pJwSlGY9vB3rYa5Osr31VZqwgu8zcBXS
         0a1ikzq59QIAX+dCSF5h+hc58wIdXkyTfKiHmTXQEsNUTdy41U8BS5nZSl8Md+dUF9uD
         CMvWLFw8olNPsxd5p9/n89wBdYmiAfy4/vFyQQmWihko/UHbyWTGekrxFG+Is0ORaV9n
         r1vLVzz8Fy+xYUkxHkAcxMXDGXfkRnOX8hUQMZU4Rx+6ETVIPADaEFYXWPYZWeAVSg7b
         Yklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779229992; x=1779834792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MKUS30hEKkJqsuTkVMrr7mwScb2qlJAj6ESCesmLApg=;
        b=mGmQ6UJ3ycdOadHZJgBwpkuOX7Xdd2rPuEzSTj9fOzeylxxDvoQWbW5U0konUUM33D
         K1T3lnvjDyEECQusIBffKKG2VUzqR0BbUSQp/xyZG0FAfwgCr75p+K0pu8G3VPEgAYqU
         iIwxfI5GfsjWhARcoFRKSa9JEKzBB3iI4J/yN02omI+7cXiqpC9rosOdRMzGeV13JvxI
         xNFOPfUXQcAtXaPIp9Be23+lhQQ4g7eHAHkwxBRwIxdipM/1bcvYB8y33DV5fR5qb0gb
         u6HH74ehSbvr7COPqDL/dT5ASamGRiqeaOZqH4NAa6c0mkTUIBfz9sZKdASImlz7ltSx
         EkbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+k/25KFf1ymU5W+TfLyAwparF//NghvhsqQZqKHhbP4nPfjS/flfjBs+zOrFMF5bWKZmOByjq2gQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlk8VdKFK1e6vt2LajU/Es/x361rdVdR0TUCi1gKCZzV+2fgS7
	lZLY2/obV84vvIPaRNiqwaEhVqjeyHPpsCV60uyLjOL3zQHBYWiUQXPM
X-Gm-Gg: Acq92OH9NI8ZkHrHD2H/gmvhBkJYOXOrQDDywDcTmmsFTgm5v/p3twYIkRmaphg1RW1
	M2pqsrXc/NCRsvmNuMBVMDnJjYBTfZYgVGZj3KzVFk+IMIlgpXGHM6+8yvXZUDnn2lD72/5Jn2q
	KRZiOvhzYOnSL2o5XkedpItF4xaQAaYMeHQ+0lQcNVVau2vWsRiTk28eiZvFXLmvQj+JRi4qK7T
	baxPwyqGNqsqvluIq5k+91RVmTfoIe1kKDc4d3XMskF9PsxihsoG0euOUHVFBoEP+zfz0grV0Mq
	WQ2cI0R0wQkAVjXgJuiRTOWRUSoh+Q4GCX9RtbOZgL2iHRVA3KqNgg5FNucibf+UVcss/siUFan
	vDUljf+5cJ1khpde9r83KeRkytpOr9eSPEmdeJbPg3BXmDBc0cm2hPVNc4VAOEs0oqI96mVVEf4
	WuMBq+sNzNlr1R7EvOju4NCGQXT+0oVgW6L4xJd2aT1BX7udWxjXW5Prz86j06AUvhRzouDYAOI
	Es4s0hRSA==
X-Received: by 2002:a05:600c:2d86:b0:48f:d5b2:7c42 with SMTP id 5b1f17b1804b1-48fe63259camr228600395e9.17.1779229991759;
        Tue, 19 May 2026 15:33:11 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-55-252-101.retail.telecomitalia.it. [82.55.252.101])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88495sm346659955e9.4.2026.05.19.15.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:33:11 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Stefan Roese <sr@denx.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 3/5] dt-bindings: i2c: mt7621: Document an7581 compatible
Date: Wed, 20 May 2026 00:32:45 +0200
Message-ID: <20260519223253.1093-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519223253.1093-1-ansuelsmth@gmail.com>
References: <20260519223253.1093-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Airoha SoC implement the same Mediatek logic for I2C bus with the only
difference of not having a dedicated reset line to reset it.

Add a dedicated compatible for the Airoha AN7581 SoC and reject the
unsupported property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/i2c/mediatek,mt7621-i2c.yaml          | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml b/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
index 118ec00fc190..8223fbc74f14 100644
--- a/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: mediatek,mt7621-i2c
+    enum:
+      - airoha,an7581-i2c
+      - mediatek,mt7621-i2c
 
   reg:
     maxItems: 1
@@ -38,6 +40,16 @@ required:
   - "#address-cells"
   - "#size-cells"
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: airoha,an7581-i2c
+then:
+  properties:
+    resets: false
+    reset-names: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.53.0

