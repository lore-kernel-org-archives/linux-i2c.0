Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C737FF69;
	Sun, 22 Mar 2026 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774182951; cv=none; b=Be4eGbcX6ShLBH2nrSAc6eS5SkM2xHAPemZ25S7pzufQQb+mZZ0fh4sbGpcpj+v3sussEo4QZ0wk8YJQVSR5p54EQeg3H9OUuCGIFsag70ZQ0e0ND/rQRUihGme4YNylgMcCEBNyxI9phrAur7y70hH/uDvfFO90ONG+rIJEV6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774182951; c=relaxed/simple;
	bh=7Qfqoz4eUJMk7KDaZAytgdSjnbxt3CsOY/DCcUzAwrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXHgW065wM0UkWsb5DAmEkR1eYMoEy3eex9p9iQkqFMjACXW1yq6KnZifkoHaYNsfF3elPCWzY4pm2TStvoVuW8SYAiwIGMkMjOQBZ4P5FEzyuYmhshC9eYJpt5Jgf+gR2t3VUrzLw01lm1bzjTXPUShTbCO02Z5AhWQj+wg+IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=T/38u2QM; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="T/38u2QM"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A1F4F26849;
	Sun, 22 Mar 2026 13:35:48 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 30zEIg-cd5x5; Sun, 22 Mar 2026 13:35:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1774182948; bh=7Qfqoz4eUJMk7KDaZAytgdSjnbxt3CsOY/DCcUzAwrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T/38u2QMidzVz55YxCwhPOe0m2Oht3JJYSNICsayvyRrDt83tR/AYtTbl1nDrGpyc
	 DGNkqOOw0OysdzCBCRQagEoxYZWkrl5etn28E9PgvCxT3NpSz8KstysHV6PMPx6Y/u
	 CI9rg/O6T2WryQSfYmIS7Ds0xkED1lfl//51YZXew3heaJgTke1/5DMt9jMe7Vt/yV
	 r1mA/cCWsaBt1cJk9+cczc7BG6WfaAwCGhcqWOnm3sOxBupclpvb65bPcBo+UXXcwn
	 j+UKg1gStamkY7yAzqNwCz1gB8vqNBgFbWg/XE7PNkqhmGc3nefqB6zroxook85S0H
	 OBPrCmiD49y0A==
From: Rustam Adilov <adilov@disroot.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rustam Adilov <adilov@disroot.org>
Subject: [PATCH v3 7/8] dt-bindings: i2c: realtek,rtl9301-i2c: extend for RTL9607C support
Date: Sun, 22 Mar 2026 17:34:10 +0500
Message-ID: <20260322123411.32102-8-adilov@disroot.org>
In-Reply-To: <20260322123411.32102-1-adilov@disroot.org>
References: <20260322123411.32102-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the "realtek,rtl9607-i2c" compatible for i2c controller on the
RTL9607C SoC series.

Add a clocks property to the properties to describe the i2c reference
clock and make it available for all the compatibles. This i2c reference
clock is assumed to be coming from switchcore region via Lexra bus as
the other SoC peripherals.

RTL9607C requires the "realtek,scl" to be specified the same way as
RTL9310 so add it to the same if check.

Signed-off-by: Rustam Adilov <adilov@disroot.org>
---
 .../devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml   | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
index f9a449fee2b0..4a83923fee15 100644
--- a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
@@ -15,6 +15,8 @@ description:
   assigned to either I2C controller.
   RTL9310 SoCs have equal capabilities but support 12 common SDA lines which
   can be assigned to either I2C controller.
+  RTL9607C SoCs have equal capabilities but each controller only supports 1
+  SCL/SDA line.
 
 properties:
   compatible:
@@ -34,6 +36,7 @@ properties:
       - enum:
           - realtek,rtl9301-i2c
           - realtek,rtl9310-i2c
+          - realtek,rtl9607-i2c
 
   reg:
     items:
@@ -51,6 +54,9 @@ properties:
       The SCL line number of this I2C controller.
     enum: [ 0, 1 ]
 
+  clocks:
+    maxItems: 1
+
 patternProperties:
   '^i2c@[0-9ab]$':
     $ref: /schemas/i2c/i2c-controller.yaml
@@ -69,7 +75,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: realtek,rtl9310-i2c
+            enum:
+              - realtek,rtl9310-i2c
+              - realtek,rtl9607-i2c
     then:
       required:
         - realtek,scl
-- 
2.53.0

