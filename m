Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8462F3630A9;
	Mon,  9 Mar 2026 06:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773039241; cv=none; b=peiAN0aOs49P6V4hS+SGADMSpHezCx6rjKBtbEEewjBd8MMbf/LjKbSIOulUcvB335XbVBgT+4nEarhCSBW8efeJs7J3ryw3ISmBCASgs1o0cRGyRhvqsrx8knt5WPSiqwyNanGMNox5WJJRsmhgcuuDARYpjFdG888UZ6qD7as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773039241; c=relaxed/simple;
	bh=OSCeKlXxfRUVxy4RSS8MIELV7WCLvYWFhFrL+v3vWEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lESHDW+0CbSCt20XFKr8VjdswUlcYZO5SmXBDsH3+PokGWPHzBUdu7ZuxFQSJGF+6Lsp6+N8HnxCZD/WOIwBXP0CE2pV06m05ufwTpU5UN4veEKMUJdFU+d9B/nlpYXXtFLVjDBHHYvhtUw6mmvpJ2uybxtSnDceDKkqCLlLm2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 9 Mar
 2026 14:53:53 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 9 Mar 2026 14:53:53 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 9 Mar 2026 14:53:53 +0800
Subject: [PATCH v26 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260309-upstream_i2c-v26-2-5fedcff8ffe8@aspeedtech.com>
References: <20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com>
In-Reply-To: <20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com>
To: <jk@codeconstruct.com.au>, <andriy.shevchenko@linux.intel.com>, Andi Shyti
	<andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, Rayn Chen
	<rayn_chen@aspeedtech.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773039232; l=2731;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=OSCeKlXxfRUVxy4RSS8MIELV7WCLvYWFhFrL+v3vWEw=;
 b=jo5UpvRiPIQn90hv2zsKOKq9gwa3fBWtvw0tr0gR++FndDuc99ryFOvZxehAnu27OdPsM4bQB
 +Hdu7qKnlPaAlLKK1eAXAZXjPmpVe/+WgFmf/+neS7RMLDiYouW2IND
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The AST2600 I2C controller supports three transfer modes (byte, buffer,
DMA). Add "aspeed,transfer-mode" so DT can select the preferred transfer
method per controller instance. Also add the "aspeed,global-regs"
phandle to reference the AST2600 global registers syscon/regmap used by
the controller.

These properties apply only to the AST2600 binding and are not part of
the legacy binding, which uses a mixed controller/target register layout
and does not have the split register blocks or these new configuration
registers. Legacy DTs remain unchanged.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../bindings/i2c/aspeed,ast2600-i2c.yaml           | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
index de2c359037da..323e4f9b290a 100644
--- a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
@@ -37,6 +37,33 @@ properties:
   resets:
     maxItems: 1
 
+  aspeed,transfer-mode:
+    description: |
+      ASPEED ast2600 platform equipped with 16 I2C controllers each i2c controller
+      have 1 byte transfer buffer(byte mode), 32 bytes buffer(buffer mode), and
+      share a DMA engine.
+      Select I2C transfer mode for this controller. Supported values are:
+        - "byte": Use 1 byte for i2c transmit (1-byte buffer).
+        - "buffer": Use buffer (32-byte buffer) for i2c transmit. (default)
+                    Better performance then byte mode.
+        - "dma": Each controller DMA mode is shared DMA engine. The AST2600 SoC
+                 provides a single DMA engine shared for 16 I2C controllers,
+                 so only a limited number of controllers can use DMA simultaneously.
+                 Therefore, the DTS must explicitly assign which controllers are
+                 configured to use DMA.
+      On AST2600, each controller supports all three modes.
+      If not specified, buffer mode is used by default.
+    enum:
+      - byte
+      - buffer
+      - dma
+
+  aspeed,global-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle reference to the i2c global syscon node, containing the
+      SoC-common i2c register set.
+
 required:
   - reg
   - compatible
@@ -59,4 +86,6 @@ examples:
         resets = <&syscon ASPEED_RESET_I2C>;
         clock-frequency = <100000>;
         interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+        aspeed,global-regs = <&i2c_global>;
+        aspeed,transfer-mode = "buffer";
     };

-- 
2.34.1

