Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.4.11.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509915;
	b=Dp6gUJegBcfcMPZM6mD7gCX4w+bMQggGCVXuS1WT93vg0cJ5Cpxi3ZQbpxrHxea1zIWD
	 teEUopIkSYAqxLJLQiWT6JuJWE9O/17KKFnEbGul+Y2qQlWD1kkeLa4QxiDbiCDubT4+X
	 b9PecIl0yF8g3lg3Xdc8DYHZI45TIq68mud2CggbdWvpOWdc9SEedUWSPcDJIKyQt7KTt
	 CQiUtiSU62h7WQMhiOouShzuxUyVetB2vUBnH2I/3grYwr1hmu3PXlFwwLInfuLBqMZMB
	 SM7VTfaXwadYLSOowI5GPFnAN4ClWai7w/vZb4Ry+NvSdRVe7h9I/ndqhDQG+dQQ56A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509915;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RuOqo+RKreVqcu1zPpVQn0t7Bqx2kGH6ClqRja+E9Hw=;
	b=2Pth9isIjiJdN0hSTgMqcuHICyXj1Wg7ELEWeJ1oXl+Hca2F8QcfU/QwnfcM0exS/TM1
	 DR9OtrSztMqOeTQgVVMlf0jFTZqvQJbGth8mKFk4n4shEY+6XXUhGjo74Ky1ZdY+fGX2R
	 ur7zm7Lkg03IKE4E7otTsKBKFoB7JoG6BhkvZa5SmPAALAT2PC+9/TrfT2/0Vs/zWJEtY
	 hiVoy7Lc/6sYWzoW+F0fEvbcLVL1KSQ2rwPYCLpVIUTrQ2ou/LVSKqHlMnl2m9S1ijMVz
	 jSEv2Z8EqAlviNQ+2azyvWsiVZ7ft/GlOoo9HHMQh96eqvXRJiHmzJmKlvDkghc8oJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phrozen.org;
	spf=pass smtp.mailfrom=phrozen.org;
	arc=none smtp.remote-ip=46.4.11.11
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80392606A8B0;
	Thu, 12 Nov 2026 18:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80392606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1403:f2fc:83ce:6656:246:c906] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xRa0B-002Xe4-1j;
	Thu, 12 Nov 2026 19:58:27 +0100
From: John Crispin <john@phrozen.org>
To: Stefan Roese <sr@denx.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
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
Subject: [PATCH v2 2/3] dt-bindings: i2c: mt7621: add Airoha AN7589
Date: Thu, 12 Nov 2026 19:58:19 +0100
Message-Id: <20261112185820.1315718-3-john@phrozen.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261112185820.1315718-1-john@phrozen.org>
References: <20261112185820.1315718-1-john@phrozen.org>
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
control register holding a wider clock divider. Out of reset the
controller uses the MT7621 divider, so the MT7621 programming works
and mediatek,mt7621-i2c serves as the fallback. Give the AN7589 a
compatible of its own so the driver can use the wider divider.

Signed-off-by: John Crispin <john@phrozen.org>
---
Changes in v2:
- Add mediatek,mt7621-i2c as the fallback compatible (Conor).

 .../devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml   | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml b/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
index 118ec00fc190..ec42e72e267f 100644
--- a/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
@@ -9,12 +9,20 @@ maintainers:
 
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
+    oneOf:
+      - const: mediatek,mt7621-i2c
+      - items:
+          - const: airoha,an7589-i2c
+          - const: mediatek,mt7621-i2c
 
   reg:
     maxItems: 1
-- 
2.34.1

