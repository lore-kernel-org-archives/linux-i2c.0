Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.4.11.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851640;
	b=40Qq2oBua78BMHrzNrenc/cz5bVgm+1aOXpEHRIJ+8M8k1AgEML4PFRPt33t6UEHjzAm
	 X2zUnk3nQbgfXotu8aW5i8HJytzQ0DDa55uRPaTfnYC0iLeeJjMubBvtDtbDJRvOHuVDm
	 1eGH35Od6H9jOZdBiWK9NzL/VOQKA45sxS3TQMzRe1wq18xtlWa+Qu4lw/UjrVVK7J2YS
	 sbZf9VJllqlduHS2XPrmOY/moyoe3JGpJW3B5xcA/E1my/+JrsWB+7MX05TsAgLyLmsr9
	 vfe5iEK/Ay2wy7lCxqUq/z0uB0yLqgtUZBi8nimCJGq6vX1vRwNFQTeO8soYj284GDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851640;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=52QgrSKsfSH7NwDCbCOwCK+9x4DB/HxzeFNx2X6f/cc=;
	b=Sg+c+6oQhI26N4cvPqIlw41V28cow6HPdEd1G7+1jFbaumnxb5lBuxRfNgs2UsHjAQUN
	 4hqiakBeg9n/SHlaUqs9csUPm/KPOoWOsazJ3EkMfk34tftwfjL9yI5YFjnjSLUdgtnYD
	 1j5+KcYHo2SzQnj42W+LkqaLX4SKHfSsLF2S7UUiIqTLRVBZV48/EtOCx7/FpgAyEE1mp
	 EeFuTZZ2zNAAm+0e0rvZrj/gZLYC8E35HeeVLBAdZMgOFTttrCMPY+JvcbLiACghECzfh
	 3Yy0VE28Omo4xWvR8jEa+4N2MbI9OwJSWoW0wDbZEMvhZTMiM27AMqgBPpylMpUVccQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phrozen.org;
	spf=pass smtp.mailfrom=phrozen.org;
	arc=none smtp.remote-ip=46.4.11.11
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB72606A884;
	Mon, 16 Nov 2026 17:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DB72606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1403:e6fc:5f71:2c1e:7d62:945f] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xT0tq-004GoI-1I;
	Mon, 16 Nov 2026 18:53:50 +0100
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
	zhengping.zhang@airoha.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/3] dt-bindings: i2c: mt7621: add Airoha AN7589
Date: Mon, 16 Nov 2026 18:53:42 +0100
Message-Id: <20261116175343.344425-3-john@phrozen.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116175343.344425-1-john@phrozen.org>
References: <20261116175343.344425-1-john@phrozen.org>
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
Changes in v3:
- Add the Acked-by of Conor.

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

