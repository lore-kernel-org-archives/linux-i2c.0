Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069A12F745C;
	Tue, 23 Jun 2026 01:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177370; cv=none; b=h7p2Ene+2LdLswe7oJnvxiyfo7filqcNqgUNm4y0etS9FkyyftU5SmQ8ZOJZuKra+5PDUHuMkCYc4MLefGoehX7swkqAnAQhh142LAb/y8r0jpsg5OuE2T/rWlGhAFcCom2RJ+Xfs7qqlVO+XIadaect/QSwxqiCTPUX7UbirWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177370; c=relaxed/simple;
	bh=bu5HMc2Z/yj0Ft5OgeLngLhHplEIK0fnHLwW0MpLC2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=P512nM54RFXjJQrPyTKDaEXpumhcqNQKHeNxDBGQj/uzXoXC8y+yWKyXB/rFOtWVtQ/aNb/RSWzIqQsQo6/0VB5DRQ0Jmv0BGlrwfcqV/tyfFwVjeantyAwMEmJhwaQvFMepbPHefHQC1KgP4kv4j9GASVcUlSae+DeMohmE+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 23 Jun
 2026 09:15:54 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Jun 2026 09:15:54 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 23 Jun 2026 09:15:51 +0800
Subject: [PATCH v33 2/5] i2c: aspeed: Read clock-frequency via
 i2c_parse_fw_timings()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260623-upstream_i2c-v33-2-6d5338fc56ed@aspeedtech.com>
References: <20260623-upstream_i2c-v33-0-6d5338fc56ed@aspeedtech.com>
In-Reply-To: <20260623-upstream_i2c-v33-0-6d5338fc56ed@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782177354; l=2076;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=bu5HMc2Z/yj0Ft5OgeLngLhHplEIK0fnHLwW0MpLC2E=;
 b=7Gjcgu/z4EoX5r6IRk4JiFyFKMKRIkQV1XlQedPVLkwOLEl8DnUMD3A24Ik98kXwHzO+sLH/M
 de9T3LkcOsvA5hldIAPqlP+GJ2qw207ipswOWmM3VUyplHErJ25y7kN
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Use i2c_parse_fw_timings() to read the standard "clock-frequency"
property, and fall back to "bus-frequency" only when the standard
property is absent.

This honors device trees written against the updated
aspeed,ast2600-i2c binding without silently falling back to 100 kHz,
while keeping existing in-tree device trees using "bus-frequency"
working.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v31:
- Zero-initialise `struct i2c_timings timings` so the bus-frequency
  fallback runs when clock-frequency is absent (Sashiko AI review).
---
 drivers/i2c/busses/i2c-aspeed.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index a26b74c71206..f00bd779146e 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -1000,6 +1000,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct aspeed_i2c_bus *bus;
 	struct clk *parent_clk;
+	struct i2c_timings timings = {};
 	int irq, ret;
 
 	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
@@ -1025,12 +1026,18 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	}
 	reset_control_deassert(bus->rst);
 
-	ret = of_property_read_u32(pdev->dev.of_node,
-				   "bus-frequency", &bus->bus_frequency);
-	if (ret < 0) {
-		dev_err(&pdev->dev,
-			"Could not read bus-frequency property\n");
-		bus->bus_frequency = I2C_MAX_STANDARD_MODE_FREQ;
+	i2c_parse_fw_timings(&pdev->dev, &timings, false);
+	if (timings.bus_freq_hz) {
+		bus->bus_frequency = timings.bus_freq_hz;
+	} else {
+		ret = of_property_read_u32(pdev->dev.of_node,
+					   "bus-frequency",
+					   &bus->bus_frequency);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"Could not read clock-frequency or bus-frequency property\n");
+			bus->bus_frequency = I2C_MAX_STANDARD_MODE_FREQ;
+		}
 	}
 
 	match = of_match_node(aspeed_i2c_bus_of_table, pdev->dev.of_node);

-- 
2.34.1

