Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB3F317167;
	Wed,  1 Apr 2026 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775066847; cv=none; b=Mx1q8Y3M0sMRc2PPyp1HeftvRhuH7lEmr9ukqnoD/QXT9ElSjog0aLu23sY5SF3hEGTNCcUn0mFd02p6vaia7Ix7qjkze/qk5Jzy9gRtIOBysc2MKL+v9dZZTbqomvBUGxReEZsESy3sfl/vW3plRHRp3i68ykxdU40k1F43kZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775066847; c=relaxed/simple;
	bh=X+qgtO8/Y8FfhUV+KCWr/dOG6ar4xzqbD/lzeFBfq5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gu3GAWwEFUq1McsRqw/uVbRMDIpdQY1ClXca9qk9mhACFcs+3Qnei5X/Ae+jA+XEtZFTKq5dcfWk1fez0iLgqhiPMPQHlE10bnt/fQGMpXfSEIjQBPHBCaFY7lxrSHWUPflr0SiKADQ3Neg5WKIIHi8aWNRxhyGXEvFBX76fG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JMpaNzhB; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JMpaNzhB"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4D75E2672F;
	Wed,  1 Apr 2026 20:07:25 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fkr8TPSXwzpx; Wed,  1 Apr 2026 20:07:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1775066844; bh=X+qgtO8/Y8FfhUV+KCWr/dOG6ar4xzqbD/lzeFBfq5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JMpaNzhBCV6NfaOMGiQcJGJxh5ymoMo8QHEP6BVxFvoZsUFm5O5+EyM2dwmTr5a61
	 hWz754UUG/ou98tf9QIXSg/uT6IeaZkyicFXBqdyB02CgVSChmogNpLOreLIQYc1uL
	 Gwx99j6h/jgWAoe/DzoO//rUFOQwHrVBuU3CerYhIdYAfQB7JS6v8hGslHdU8DlFC8
	 NkhzznioL7VkyxjcWZFhXH6u2IrMjqrJhmEip+FSp5GDW6b8frb//9yI1fowkj+K2k
	 T3/Xu6OohELBnxwUxZCUlWdaYYNqZatNRgjwjAQafP1lF/YnfAzfkCqFmxTxvxiTij
	 z/U1srSOnFkoA==
From: Rustam Adilov <adilov@disroot.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rustam Adilov <adilov@disroot.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 5/8] dt-bindings: i2c: realtek,rtl9301-i2c: extend for clocks and RTL9607C support
Date: Wed,  1 Apr 2026 23:06:45 +0500
Message-ID: <20260401180648.337834-6-adilov@disroot.org>
In-Reply-To: <20260401180648.337834-1-adilov@disroot.org>
References: <20260401180648.337834-1-adilov@disroot.org>
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

