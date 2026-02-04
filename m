Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55789261B96;
	Wed,  4 Feb 2026 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770188526; cv=none; b=jh+i5X+033b2KXNDdgTPi6aEFCPrA0HDcqiFT0CY+yoUaUWevvxYfEuqJrssUEy9lqBq7ffILeMU6XWRgrRsJxxSG1y8t4OHxIXN+XMtEeCPmAwg4QHnOUWxxiE/9JCTo8sguUeIh1lZSuJAyTBVQJbOCXp4cwfNQqIrEZ5kIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770188526; c=relaxed/simple;
	bh=DPRlDntlu0iKeJf/CMopdHlJpBQ0BaeVB92s+jp4gPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U7SgXy2Rapiq37qKv261Mt4XUKb9AzEPTe20OskhDk0I7LU1mL6hnLaFE1Fh3PZuIELXXZwjX1H25QDUshmkUxcpRRbKrNBUAjvi8YKHYwA7PEgSwZDZE7fo56ROPP27G3a0XJApx/JNZSJA5hUmWLNymqcvVeDjZp9pdxa9XTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF+ZS9qP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF+ZS9qP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33FD5C2BC87;
	Wed,  4 Feb 2026 07:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770188526;
	bh=DPRlDntlu0iKeJf/CMopdHlJpBQ0BaeVB92s+jp4gPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nF+ZS9qPwTJ5H26J+elkSzW+G0Dba8Hov7dKIVBDV2bm2TZwoHDmHZYkiTb/qPqJp
	 fo/5THFxpDHL0JKnTGwefKbjPZwh1Thp/YvKCoH7Jw1s/Pb9hzUOG85QCJYbfj5Psx
	 kNeWvje5SXoGM1WCFz8WY+laj6anc5jgHahSPDwcmNoHvjkW/nJkJZj0GHrEkjoHRI
	 ZaUpbqx8v/uD32qu290cOYRyiiC9uRU5VppNOr1l2plnMu4TCj4u5swU+BaCYsl4Ok
	 Ihq9upqLcIHKD5AiJgAnL2weoXirAR1LmzeWo2tSod4BrfqeuqEu9Ts608+V4T6apw
	 TjnQrquHkdfyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A2EE83041;
	Wed,  4 Feb 2026 07:02:06 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Wed, 04 Feb 2026 07:02:00 +0000
Subject: [PATCH v10 3/7] i2c: xiic: switch to generic device property
 accessors
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-i2c-xiic-v10-3-c2b996425235@nexthop.ai>
References: <20260204-i2c-xiic-v10-0-c2b996425235@nexthop.ai>
In-Reply-To: <20260204-i2c-xiic-v10-0-c2b996425235@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770188524; l=2990;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=k0KDwbzoPFBnih9Js9Y0osMzTW9DrweWovD0ZQMqow4=;
 b=UGg6s3GVWItBMEb8A2iHPTZbMwa5XEZyXRL5nZYANVQluKIS0FuXYPGC7iW9yUf0FoLAU0WDW
 6A05pVL50L1CFBglSrooA3X6dlmtPo0O334gPrK9272HX8mvFikkV1a
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Use generic device property accessors.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 4cb7c40fb565..60d417a2266e 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -27,7 +27,6 @@
 #include <linux/platform_data/i2c-xiic.h>
 #include <linux/io.h>
 #include <linux/slab.h>
-#include <linux/of.h>
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/iopoll.h>
@@ -1408,7 +1407,6 @@ static const struct i2c_adapter xiic_adapter = {
 	.algo = &xiic_algorithm,
 };
 
-#if defined(CONFIG_OF)
 static const struct xiic_version_data xiic_2_00 = {
 	.quirks = DYNAMIC_MODE_READ_BROKEN_BIT,
 };
@@ -1419,14 +1417,13 @@ static const struct of_device_id xiic_of_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, xiic_of_match);
-#endif
 
 static int xiic_i2c_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct xiic_i2c *i2c;
 	struct xiic_i2c_platform_data *pdata;
-	const struct of_device_id *match;
+	const struct xiic_version_data *data;
 	struct resource *res;
 	int ret, irq;
 	u8 i;
@@ -1436,12 +1433,9 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
-	match = of_match_node(xiic_of_match, pdev->dev.of_node);
-	if (match && match->data) {
-		const struct xiic_version_data *data = match->data;
-
+	data = device_get_match_data(dev);
+	if (data)
 		i2c->quirks = data->quirks;
-	}
 
 	i2c->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(i2c->base))
@@ -1458,7 +1452,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	i2c->adap = xiic_adapter;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &pdev->dev;
-	i2c->adap.dev.of_node = pdev->dev.of_node;
+	device_set_node(&i2c->adap.dev, dev_fwnode(dev));
 	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
 		 DRIVER_NAME " %s", pdev->name);
 
@@ -1482,8 +1476,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 
 	/* SCL frequency configuration */
 	i2c->input_clk = clk_get_rate(i2c->clk);
-	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
-				   &i2c->i2c_clk);
+	ret = device_property_read_u32(dev, "clock-frequency", &i2c->i2c_clk);
 	/* If clock-frequency not specified in DT, do not configure in SW */
 	if (ret || i2c->i2c_clk > I2C_MAX_FAST_MODE_PLUS_FREQ)
 		i2c->i2c_clk = 0;
@@ -1494,8 +1487,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	i2c->singlemaster =
-		of_property_read_bool(pdev->dev.of_node, "single-master");
+	i2c->singlemaster = device_property_read_bool(dev, "single-master");
 
 	/*
 	 * Detect endianness

-- 
2.52.0


