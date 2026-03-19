Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA93F7876;
	Thu, 19 Mar 2026 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943184; cv=none; b=arPD5gk6/TB75b2zYWKGreRFn/OYe4R8yNzq7JyHbdMasCv7fXlVqELnVN9lc71Gri1Pwks2+R61y/qFW82IPu2qvZagSR3fAKBZYjVAkHvDbNkOTPts5L12/aw5ks2uLMV9V7Q3QFrYp0QziPPMo9vXRoUEft6fFLER5gjXBJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943184; c=relaxed/simple;
	bh=k/JDqmiRXOfPksRprwnqB2dydKEJ8xm1rTB1qgs+v7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCnWdaCOeNw2Y8zPgA+aKQIY1TUJMdJQ7zyKx+WMP7kAUQ0AuSBl/e0U4WMtdnwCkNw02p1+ItbkdjuDDGqKOz5kPSDcWYvn6Tivz7gEy/ZK8BqbpKMDSA5Zk8lhieHzDMPIhjFZOCyaKwZIcuGLdXZkJ2+spmnkXMLgzse7qEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=R/uqfEzB; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="R/uqfEzB"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7AED82759D;
	Thu, 19 Mar 2026 18:59:41 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ThLIzO5U0U7C; Thu, 19 Mar 2026 18:59:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1773943180; bh=k/JDqmiRXOfPksRprwnqB2dydKEJ8xm1rTB1qgs+v7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R/uqfEzBVcer9LrrwLeS38ygbGxTFfjfT5BIufuk5eZe3geIVDPy7B2WVw37oM8Ke
	 lRW0Wa0Xmedo0BLz3D98axNbphyLSfAlPfdYDO+EPEqTSSON57BHdzbWMD5/K0WkZF
	 Xk2DVFN1KYg5a/JbrUqO4Dq3Uyo4edWQpIFkThmegoXjn6sYflTxreTXMDVnF1dfkP
	 VpgfsybKSPNHfcPvUfePvrq19l7dovrDpM5rN+fdkIJItn+MmLfY8fU35rF1KL06xj
	 mXRg6mpSxsiSKPPD25NfJ1uFqS6c4Pn2H6kkQvVjZOzUE1kILDohc/5T197uBdIkE2
	 nYPdFOboMMLow==
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
Subject: [PATCH v2 7/8] dt-bindings: i2c: realtek,rtl9301-i2c: extend for RTL9607C support
Date: Thu, 19 Mar 2026 22:57:52 +0500
Message-ID: <20260319175753.32338-8-adilov@disroot.org>
In-Reply-To: <20260319175753.32338-1-adilov@disroot.org>
References: <20260319175753.32338-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the "realtek,rtl9607-i2c" compatible for i2c controller on the
RTL9607C SoC series.

Add a clocks property to the properties since RTL9607C requires it
along with the realtek,scl. And because RTL9607C is the only one that
requires the new clocks property, add "clocks: false" to everything
else.

Signed-off-by: Rustam Adilov <adilov@disroot.org>
---
 .../bindings/i2c/realtek,rtl9301-i2c.yaml      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
index f9a449fee2b0..35ced0dcf410 100644
--- a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
@@ -15,6 +15,8 @@ description:
   assigned to either I2C controller.
   RTL9310 SoCs have equal capabilities but support 12 common SDA lines which
   can be assigned to either I2C controller.
+  RTL9607C SoCs have equal capabilities but each controller only supports 1
+  SCL/SDA line and require clocks.
 
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
@@ -81,6 +87,18 @@ allOf:
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
+    else:
+      properties:
+        clocks: false
 
 required:
   - compatible
-- 
2.53.0

