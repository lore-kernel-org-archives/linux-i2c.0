Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.4.11.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389995;
	b=eBJ/TkLit1E+Sa08Htlh7huamFKw8n2hk841Lzam3D9Ya9BkwsYphYkm+D/PHbY0Ho67
	 rqKNYw633NVNxLIuoI1f+Cc18txP4K5KPLume4n1ZDStnJIx9F8gXVsdUfWUYy7UNkH8J
	 KikDMkMpAel8uNijV70SU3Ioy7zITojNucdwhzCDmndzjpBax1XchZvSakdZXTF6WAQRb
	 2dpXbc6hw0VQueQbaeOhMMw7f79nx7jyxfXqmNbgK1jMqqXwscTYshXYs+ZdWWALB17JZ
	 /xu3xhHR2CarR04snJSThoHEu555pbwJ+DY1iYxDDnh6+aTTPypuuIx4ytk/pOw0Emw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389995;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=l7FQMS58GCdWz2frTF6MPWJY08KR+5o+y8rdnEYzchE=;
	b=1SZg3SpK9RmiLYUieEgcIXViw6P5402IlLISBn1ssEb0jC12adGsSmUe189JiD9Sky+W
	 yrRg4Ttc+5PEEnz7NL9390heK+tZWGrn5/wQ3tyJeXtJWhfktZTff85RTK+f/SMBwe964
	 sAFg7GcwTXYtkihBrcIUdk5wIomHIoFKmCuSwjeCm94pptn8+TlHq5l928jtZs5pDQi4m
	 aCTv2mOwt428caM4gbAWtTcxsLXDG//aQuonskYhGCIqBAlgiwDVko412DiWAHOIdY92N
	 XzEQDQP6c6JNAFOZ0Nk3HkA0IPpSgBj9XtyL/wd3MM0zXcmIEJknjuy5vUTcsWuUNkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phrozen.org;
	spf=pass smtp.mailfrom=phrozen.org;
	arc=none smtp.remote-ip=46.4.11.11
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F73606A337;
	Wed, 11 Nov 2026 09:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2F73606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1401:33fc:b262:f9a8:847e:6650] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xR4nz-001U9u-0y;
	Wed, 11 Nov 2026 10:39:47 +0100
From: John Crispin <john@phrozen.org>
To: Stefan Roese <sr@denx.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org,
	lei.dong@airoha.com,
	Linqi.zhang@airoha.com,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Rajeev.kumar@airoha.com,
	upstream@airoha.com,
	Weifeng.xu@airoha.com,
	zhengping.zhang@airoha.com
Subject: [PATCH 1/2] dt-bindings: i2c: mt7621: add Airoha AN7589
Date: Wed, 11 Nov 2026 10:39:40 +0100
Message-Id: <20261111093941.691801-2-john@phrozen.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111093941.691801-1-john@phrozen.org>
References: <20261111093941.691801-1-john@phrozen.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Airoha AN7589 carries the MT7621 I2C controller with a second
control register holding a wider clock divider. Give it a compatible of
its own so the driver can tell the variants apart.

Signed-off-by: John Crispin <john@phrozen.org>
---
 .../devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml      | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml b/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
index 118ec00fc190..28659bdd72f5 100644
--- a/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
@@ -9,12 +9,18 @@ maintainers:
 
 title: Mediatek MT7621/MT7628 I2C master controller
 
+description:
+  The same controller is used on Airoha SoCs. The AN7589 variant adds a
+  second control register with a wider clock divider.
+
 allOf:
   - $ref: /schemas/i2c/i2c-controller.yaml#
 
 properties:
   compatible:
-    const: mediatek,mt7621-i2c
+    enum:
+      - airoha,an7589-i2c
+      - mediatek,mt7621-i2c
 
   reg:
     maxItems: 1
-- 
2.34.1

