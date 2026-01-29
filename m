Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE59364E9A;
	Thu, 29 Jan 2026 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723006; cv=none; b=UKMB52hNQfBhdlcPLJs+U4Bm9M/sUGxpIinWlgHDlhzfgww7bChQdPiGR3quHXKvStW7MIwXxwtQo95gG9pq/u7ihQ9IfMYRJHd4rawkisJZHiqcFnL4fJB8nV7PRKDidJQ6XGs2W0EZv0HOqxqp80W85wp+MGzTqrOiznYzkZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723006; c=relaxed/simple;
	bh=aK3PD+1V9CbJdF7r5/K5yWNnPE96LBlgQvwpAazD83g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nsmUrYULR4dmScYCHt0PyWZbLp2p3dMEe48izVf3+yh3sVEr1ydda09jU/9Q6Zvs0pPcA5HkkAva9ynPXo3DtGSMCvmrPjhXNNJdx3hmpWrl9RQzBL2FgyNFr92TZxKS+6Egn/xfLidhau8iEJJVtXB7OsOzlWsxViLf4h+Nr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgWO2Nb/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgWO2Nb/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F11E0C2BC9E;
	Thu, 29 Jan 2026 21:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769723006;
	bh=aK3PD+1V9CbJdF7r5/K5yWNnPE96LBlgQvwpAazD83g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FgWO2Nb/7yL+sNMUC/+zaK555uGGDiIXiXXyLwFDlTgYah6ArbhC2btUxhx2Mw9zo
	 TFy06UyFRe1TFL5mlTbdfMvrxRvqYOONZ1AU+JMpKRerhpslrfn5qDqfCkXSOfDPyw
	 RCSj37EYGDFTZyY9Z9pjyi0uJgYtuxF2VnOB9lFWAROsVrW9TNmLuzs0AJyq+5J4iI
	 65uijRwh+1sD3kEUZWuxhiwnlTEqMvCBSBBLtz8DVt5FSt5kEtnruAnCgWFzDMtQI0
	 uwHhdA4U3v3kVRqE4/w/Ls8+DERExDRkWQByDDGja7J7AL6IwMUY7FmZhsP+j6P3SU
	 qMSPIJdWMEiMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8171D73E9C;
	Thu, 29 Jan 2026 21:43:25 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Thu, 29 Jan 2026 21:43:17 +0000
Subject: [PATCH v7 5/6] i2c: xiic: cosmetic cleanup
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-i2c-xiic-v7-5-727e434897ef@nexthop.ai>
References: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
In-Reply-To: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769723005; l=3586;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=Iwa891qmu5bsxzfQcaF7qqAdE4otD0QTMnDYJyhw7aQ=;
 b=3Vlmq/TnuvEJ0CllMYPLJX/3z5XypTON5mdYlh3tHWNKv5KI8g1BICU40VYBJGy3jCNbNIOzW
 Zcy6RKpUi7FBjU8BzX7Bsee/2XeGA9E9uFXzlp4P8Ux0lmXiDyx/BVp
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Re-use dev pointer instead of referencing &pdev->dev everywhere.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 3578c00d6404..37a15065db60 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1429,7 +1429,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	u8 i;
 	u32 sr;
 
-	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
+	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
@@ -1445,13 +1445,13 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	pdata = dev_get_platdata(&pdev->dev);
+	pdata = dev_get_platdata(dev);
 
 	/* hook up driver to tree */
 	platform_set_drvdata(pdev, i2c);
 	i2c->adap = xiic_adapter;
 	i2c_set_adapdata(&i2c->adap, i2c);
-	i2c->adap.dev.parent = &pdev->dev;
+	i2c->adap.dev.parent = dev;
 	device_set_node(&i2c->adap.dev, dev_fwnode(dev));
 	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
 		 DRIVER_NAME " %s", pdev->name);
@@ -1465,13 +1465,14 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	if (is_of_node(dev->fwnode)) {
 		i2c->clk = devm_clk_get_enabled(dev, NULL);
 		if (IS_ERR(i2c->clk))
-			return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
+			return dev_err_probe(dev, PTR_ERR(i2c->clk),
 					"failed to enable input clock.\n");
 	}
 
-	i2c->dev = &pdev->dev;
-	pm_runtime_set_autosuspend_delay(i2c->dev, XIIC_PM_TIMEOUT);
-	pm_runtime_use_autosuspend(i2c->dev);
+	i2c->dev = dev;
+
+	pm_runtime_set_autosuspend_delay(dev, XIIC_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
 	ret = devm_pm_runtime_set_active_enabled(dev);
 	if (ret)
 		return ret;
@@ -1483,9 +1484,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	if (ret || i2c->i2c_clk > I2C_MAX_FAST_MODE_PLUS_FREQ)
 		i2c->i2c_clk = 0;
 
-	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-					xiic_process, IRQF_ONESHOT,
-					pdev->name, i2c);
+	ret = devm_request_threaded_irq(dev, irq, NULL, xiic_process,
+					IRQF_ONESHOT, pdev->name, i2c);
 	if (ret)
 		return ret;
 
@@ -1520,7 +1520,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 			i2c_new_client_device(&i2c->adap, pdata->devices + i);
 	}
 
-	dev_dbg(&pdev->dev, "mmio %08lx irq %d scl clock frequency %d\n",
+	dev_dbg(dev, "mmio %08lx irq %d scl clock frequency %d\n",
 		(unsigned long)res->start, irq, i2c->i2c_clk);
 
 	return ret;
@@ -1528,22 +1528,22 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 
 static void xiic_i2c_remove(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct xiic_i2c *i2c = platform_get_drvdata(pdev);
 	int ret;
 
 	/* remove adapter & data */
 	i2c_del_adapter(&i2c->adap);
 
-	ret = pm_runtime_get_sync(i2c->dev);
-
-	if (ret < 0)
-		dev_warn(&pdev->dev, "Failed to activate device for removal (%pe)\n",
+	ret = pm_runtime_get_sync(dev);
+	if (ret)
+		dev_warn(dev, "Failed to activate device for removal (%pe)\n",
 			 ERR_PTR(ret));
 	else
 		xiic_deinit(i2c);
 
-	pm_runtime_put_sync(i2c->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_sync(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 }
 
 static const struct dev_pm_ops xiic_dev_pm_ops = {

-- 
2.52.0


