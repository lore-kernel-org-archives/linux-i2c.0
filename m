Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A9334373;
	Fri, 23 Jan 2026 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155385; cv=none; b=nmfIOaULubK1fHNTTgt7bRMaCP3QrT4HTiYXmntjTjNi+omkMS1fvscdX8k68V3TAbuaM1BtRFdtEKcCGJ4Hctek+EgRc7P5V7WZxvsQsNv6NgKGAO0/VlCaSPKZTravsgXM+gbJ9lz9cFOUTUTq3qDLxHFfJPLk/HbR7i0SieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155385; c=relaxed/simple;
	bh=95pm9pT9ahIHrDl5PzXCxnBn8T9VaSAm0YoviS5jmaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gvdOcoZWlqGeM1FcvZKG2MCtJHJbLuhSvYq9z97m9eVzzpyxzKrTxK/C6E7y8gDxOfZ+MQ10LzKAp1t8Lm/nUYkLF6AUYAVRsr+2v079vawdR7T+lys1qFnOUnUgwYvGon8jp+XA/xupIo52GQO9+biaIq2rf0o1lQZeo5XIwRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFDAFhr6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFDAFhr6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F8E5C2BC9E;
	Fri, 23 Jan 2026 08:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769155385;
	bh=95pm9pT9ahIHrDl5PzXCxnBn8T9VaSAm0YoviS5jmaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OFDAFhr67MNlL4E7XR9TEf32UYdsDhZKV7paszUclc/XQzN8ynUFKFU3NofcPupfd
	 T5aPxJ6qOzkoYs9quApPVFGv2UTU0hJ4ZscEC/9JRRnqcOJwxsk3rRCeB4Cy6KYSoj
	 UPwPvgCpxZHX8zfLuJaGUHIkwo5hc4uBmjqOwBbkO7yWoi1kBTVIh2g90eQlegAEUD
	 1AUlYQ7qVgzOUsgYArQqxjnq/HIEOmSud5xe0uxPmMEcpmZXqng/8Euegs8Q/Np/HW
	 QiYGu220V/pFBGm0k9ESF1ih2l8tA0hZPYt0ydNmqTw01UZqnVhSLzWCNhITY5uo3U
	 KBX2ZQWS9ydEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3651BD7234A;
	Fri, 23 Jan 2026 08:03:05 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Fri, 23 Jan 2026 08:02:47 +0000
Subject: [PATCH v3 4/5] i2c: xiic: switch to generic device property
 accessors
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-i2c-xiic-v3-4-eb7cd4254dfb@nexthop.ai>
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
In-Reply-To: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769155384; l=2893;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=pRnnq9ftB1WpZGbAGXJnKnnQsZgU8BUHyOSlFjYZleA=;
 b=LK2aNS+rfamEhfnknpw98lduE2JhQgnSXDaLzB0zQJf10Ywv2FK6XTB7rBGnGEOwWY1CzzSQ0
 H8/KOJs+8LoBbfJREvk48dJiiGuxeDlrROUp3on/Cc1zj+nxUqKuNwF
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Use generic device property accessors.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 52d5c0c5c5c8..3af2d60d3e32 100644
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
@@ -1419,13 +1417,12 @@ static const struct of_device_id xiic_of_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, xiic_of_match);
-#endif
 
 static int xiic_i2c_probe(struct platform_device *pdev)
 {
 	struct xiic_i2c *i2c;
 	struct xiic_i2c_platform_data *pdata;
-	const struct of_device_id *match;
+	const struct xiic_version_data *data;
 	struct resource *res;
 	int ret, irq;
 	u8 i;
@@ -1435,12 +1432,9 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
-	match = of_match_node(xiic_of_match, pdev->dev.of_node);
-	if (match && match->data) {
-		const struct xiic_version_data *data = match->data;
-
+	data = device_get_match_data(&pdev->dev);
+	if (data)
 		i2c->quirks = data->quirks;
-	}
 
 	i2c->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(i2c->base))
@@ -1457,7 +1451,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	i2c->adap = xiic_adapter;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &pdev->dev;
-	i2c->adap.dev.of_node = pdev->dev.of_node;
+	device_set_node(&i2c->adap.dev, dev_fwnode(&pdev->dev));
 	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
 		 DRIVER_NAME " %s", pdev->name);
 
@@ -1480,8 +1474,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 
 	/* SCL frequency configuration */
 	i2c->input_clk = clk_get_rate(i2c->clk);
-	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
-				   &i2c->i2c_clk);
+	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
+				       &i2c->i2c_clk);
 	/* If clock-frequency not specified in DT, do not configure in SW */
 	if (ret || i2c->i2c_clk > I2C_MAX_FAST_MODE_PLUS_FREQ)
 		i2c->i2c_clk = 0;
@@ -1495,7 +1489,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	}
 
 	i2c->singlemaster =
-		of_property_read_bool(pdev->dev.of_node, "single-master");
+		device_property_read_bool(&pdev->dev, "single-master");
 
 	/*
 	 * Detect endianness

-- 
2.52.0


