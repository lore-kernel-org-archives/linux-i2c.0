Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348240149D;
	Thu, 26 Mar 2026 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538859; cv=none; b=k9hvxilubIpXfXMYAG8dgU1gWiR+ey5ht4/Ibgc7/ysDZlsGKxi/+gJDh2YR8UXAwdJ4hdLCkEF5AkHMOoSoTk4oWdoDeNcubNZJD++WxiJnqbXFh7oAlJMbbe3xVgBnvmk+H07H/EYcWPBXxqcZ+NqKv2lpr5Yu6VTzlM13wQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538859; c=relaxed/simple;
	bh=H1bfUpMipvMvET5lc+bmoWRphWlHRydo8G36Ny1Aicw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/eaU0aSeJVyFVZNfwctWeAkEd5IcWVTO/Gi8LySI4EXv0lGPoSx7DtsopWtEbpXFAL5OJrZHJMYTSzl+S2gj7kC9zt5geG8KE2gZ9cyQB3ZkfURzMmp35w9gSvVRU483xgwKPlNVyH5G6PUWstH68M6YoToTXUZmzgyZejjxQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hxQQtHUn; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hxQQtHUn"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 20CDA264DD;
	Thu, 26 Mar 2026 16:27:37 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id msY8QdYZc0GL; Thu, 26 Mar 2026 16:27:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1774538856; bh=H1bfUpMipvMvET5lc+bmoWRphWlHRydo8G36Ny1Aicw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hxQQtHUnh7L++RmZsoTl8IwO2gBMCL21J9ISNOwbFcofUyLNO8U9mQ4BtLw/hi4ZD
	 fwnzBnbjoj/VbuCzqWq9hR1zPOVV8H2hbg+FipYWb7Buf5/bGWudElZVQAQsevM1iz
	 Q+houYvjyKVfCA6Q7hFkNVA1H6smjXBqbLP6Kjd+4ktLOhL07wrUF7g5DKczuKOFYB
	 TMTw9JnfjCper2iTJtdYaapCUGEh9a+mA+5WKmsgwdZjzcBtRwuRnWW458pw0IpoWq
	 KLSz8wbA2Z5Vw2JwDJOJhxaesulCdCJIRc/SzhuWEE+2AMZYXImKeAeRf9Wcahe/sp
	 W2TFuxS6L1HFg==
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
Subject: [PATCH v5 5/8] dt-bindings: i2c: realtek,rtl9301-i2c: extend for clocks and RTL9607C support
Date: Thu, 26 Mar 2026 20:26:53 +0500
Message-ID: <20260326152656.14030-6-adilov@disroot.org>
In-Reply-To: <20260326152656.14030-1-adilov@disroot.org>
References: <20260326152656.14030-1-adilov@disroot.org>
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

According to the info available about the existing devices, they also
have the i2c master controller clocks.

RTL9607C requires the "realtek,scl" and "clocks" to be specified
and so handle it under separate if check for "realtek,rtl9607-i2c".

Signed-off-by: Rustam Adilov <adilov@disroot.org>
---
 .../bindings/i2c/realtek,rtl9301-i2c.yaml         | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
index f9a449fee2b0..5873cfdc5b3e 100644
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
@@ -81,6 +87,15 @@ allOf:
     then:
       patternProperties:
         '^i2c@[89ab]$': false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: realtek,rtl9607-i2c
+    then:
+      required:
+        - realtek,scl
+        - clocks
 
 required:
   - compatible
-- 
2.53.0

