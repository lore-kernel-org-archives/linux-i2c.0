Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A527A92E;
	Mon,  2 Feb 2026 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064656; cv=none; b=uBj3Gp/Gm6dpm8RfFRYDF8pDr8FpgCblyXUmyqCK3+4bEHc/xlJ/NQSxQi0ZUZMeVZi19Aj0VFvn1wWBzMIq1+GrLzRF2SVOkYS2VFyaeIwM5+YhjodLXM02llgRXjGxT47qOT5DXd+xx+VOgrUiOHqDR+YM7PLG672yAb2mhMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064656; c=relaxed/simple;
	bh=wzyK5C+7gEBOnnJZjSZxVGWBnuD0tO8LwZHYRLn2itQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+OzNdB61109AZ7+9GM3PVp/O6snZNPkJVKEy1p8pULPhPhw+Ln4DZiKVoqrPOTOqQKmgjknXg70ZHOcWDIXWCbhQoNvwFtV573Zteav4c8FYs29sDvO2PJ/wrhyWak8XzkDzTH+k7dl0zc+m0+tPRAZ0JDIyCuwGlRgCtu7m+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9PEh8nf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9PEh8nf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BB0FC19421;
	Mon,  2 Feb 2026 20:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770064655;
	bh=wzyK5C+7gEBOnnJZjSZxVGWBnuD0tO8LwZHYRLn2itQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=c9PEh8nfTUL3RiuDS0YNU7hXUjr+nFNk/3xoRajlJqiyOOz8O1kVgUjnknSUYiO4F
	 ThrN0CWKjjtms1KE9nBCBCSb2cOiiWyEBDqB8vPnNnE0EasUczSPmgQiBz/AD5qbeQ
	 XylOT0PgspmCXrQIRjdZv7bB1K59OZQOV2Grl53Nd1VgVWtvMggDlsVGTLnGwPra9H
	 HOhVrQY83rbCuox+B3G1Z2aCtHxcSO9pwCB6mfSicjOMzDCxK0V/j3pMXzyy9cG5Au
	 d26b/7eTRqTIq0snR0MYGF2KykDedrMpcRHDRYjpVifW5xt8AodUA4MXdeLVbaZuHr
	 SxMEUfvr3NA2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7D5E7FDD1;
	Mon,  2 Feb 2026 20:37:35 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 02 Feb 2026 20:37:18 +0000
Subject: [PATCH v9 1/7] i2c: xiic: switch to devres managed APIs
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-i2c-xiic-v9-1-ce4695f5267d@nexthop.ai>
References: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
In-Reply-To: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770064654; l=2947;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=W8zDDZw4EUzfrNuEoTOo05XNo8J4+DIsLswOSdxs308=;
 b=o4Yvz0UHDtX4jQ/jQr+uic+MZtDr1LnHeePbTXWkcq+5ymZwx71i2Db1yzzemVp67Uy+myQAw
 TRCh5gm7pfiDRnb/nZjXVqNSHi6p3stflXbnTTNseoYdYcq07kHeBmQ
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Simplify the error code paths by switching to devres managed helper
functions.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 28015d77599d..16ff83fe280b 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1423,6 +1423,7 @@ MODULE_DEVICE_TABLE(of, xiic_of_match);
 
 static int xiic_i2c_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct xiic_i2c *i2c;
 	struct xiic_i2c_platform_data *pdata;
 	const struct of_device_id *match;
@@ -1461,7 +1462,10 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
 		 DRIVER_NAME " %s", pdev->name);
 
-	mutex_init(&i2c->lock);
+	ret = devm_mutex_init(dev, &i2c->lock);
+	if (ret)
+		return ret;
+
 	spin_lock_init(&i2c->atomic_lock);
 
 	i2c->clk = devm_clk_get_enabled(&pdev->dev, NULL);
@@ -1472,8 +1476,9 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	i2c->dev = &pdev->dev;
 	pm_runtime_set_autosuspend_delay(i2c->dev, XIIC_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(i2c->dev);
-	pm_runtime_set_active(i2c->dev);
-	pm_runtime_enable(i2c->dev);
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
+		return ret;
 
 	/* SCL frequency configuration */
 	i2c->input_clk = clk_get_rate(i2c->clk);
@@ -1489,7 +1494,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret, "Cannot claim IRQ\n");
-		goto err_pm_disable;
+		return ret;
 	}
 
 	i2c->singlemaster =
@@ -1508,16 +1513,14 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 		i2c->endianness = BIG;
 
 	ret = xiic_reinit(i2c);
-	if (ret < 0) {
-		dev_err_probe(&pdev->dev, ret, "Cannot xiic_reinit\n");
-		goto err_pm_disable;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot xiic_reinit\n");
 
 	/* add i2c adapter to i2c tree */
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret) {
 		xiic_deinit(i2c);
-		goto err_pm_disable;
+		return ret;
 	}
 
 	if (pdata) {
@@ -1529,12 +1532,6 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "mmio %08lx irq %d scl clock frequency %d\n",
 		(unsigned long)res->start, irq, i2c->i2c_clk);
 
-	return 0;
-
-err_pm_disable:
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
-
 	return ret;
 }
 
@@ -1555,8 +1552,6 @@ static void xiic_i2c_remove(struct platform_device *pdev)
 		xiic_deinit(i2c);
 
 	pm_runtime_put_sync(i2c->dev);
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 

-- 
2.52.0


