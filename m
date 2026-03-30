Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563653B4EA4;
	Mon, 30 Mar 2026 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858918; cv=none; b=dwlmhYnebFydIxXDSVb9L0kqP8U1Ll/vckQd+RWG09ju6lNeHcphQYgDyweILLKrMZ02xBRoYuhx7f2OzgH2pc64C/qcApMNVAAFPqHBR5UijTjtYztiHhTWs+yCfDd5UPakNQY7OohztCenkgrxmbR439JTrXyhHPYio3Sbik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858918; c=relaxed/simple;
	bh=Z2AXlRcw8rroVI4rnpHgF+99FZI/yNPMg8RNUT8tbwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Eekuhq4QZUjbvW/yainC4hbQLPzXUu9gTT0OWDIItYupr2IFw6zB3T7rrj1/+VYDnzlFAILr66uqpESS1dprhRaJwyB0BlQlpwciQPUtUu9ENjC6FERRGsM59h8fYP/4IFg/GrtfbtXs8Cd/6A2fAT0gJFBNu2A6zZKU1DROSEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 30 Mar
 2026 16:21:47 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 16:21:47 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 30 Mar 2026 16:21:47 +0800
Subject: [PATCH v28 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and enable-dma properties
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260330-upstream_i2c-v28-2-17bdae39c5cb@aspeedtech.com>
References: <20260330-upstream_i2c-v28-0-17bdae39c5cb@aspeedtech.com>
In-Reply-To: <20260330-upstream_i2c-v28-0-17bdae39c5cb@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774858906; l=1878;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=Z2AXlRcw8rroVI4rnpHgF+99FZI/yNPMg8RNUT8tbwc=;
 b=mRu3dj7XE8wlOn99k+9o1IjAAtiPtC4krH7vcIPJvKLUcC8Mo/TQob7qLzxbb10+44H3WcEbG
 O1gXVUoJBpIAqYXpj+1/h707e1Uzv7zRg1QBWHqw1f7Awi/EM2OCbhU
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add aspeed,enable-dma boolean property to indicate that DMA is
available for transfers on this I2C bus.

Also add the aspeed,global-regs phandle to reference the AST2600
global registers syscon node, containing the SoC-common I2C register
set.

These properties apply only to the AST2600 binding. Legacy DTs remain
unchanged.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v28:
- update commit message correspond with aspeed,enable-dma.
- remove aspeed,transfer-mode and add aspeed,enable-dma property and
  description.
- Fix aspeed,enable-dma description to reflect hardware capability rather
  than software behavior
Changes in v27:
- change aspeed,transfer-mode to aspeed,enable-dma.
---
 .../devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml          | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
index de2c359037da..67b23d1a4cec 100644
--- a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
@@ -37,6 +37,16 @@ properties:
   resets:
     maxItems: 1
 
+  aspeed,enable-dma:
+    type: boolean
+    description: Indicates this I2C controller instance has DMA capability.
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
@@ -59,4 +69,6 @@ examples:
         resets = <&syscon ASPEED_RESET_I2C>;
         clock-frequency = <100000>;
         interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+        aspeed,global-regs = <&i2c_global>;
+        aspeed,enable-dma;
     };

-- 
2.34.1

