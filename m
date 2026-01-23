Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABCA33B97D;
	Fri, 23 Jan 2026 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155385; cv=none; b=T34+RmYYReNAKagwU9kFPljeEAPg8IhB0EYtJFoIfL14k1sRvZIW1SffEUKqbG6oub3zPWq/ylb0pF3LktKOPpL2RQ1j5zXU8ecfkL9n6IMA7V4gW4NEHOnVhLMvX3bgPgmEDdoZkCvoHsVUnxAqrFb5taAFLNgKTo7TSIem8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155385; c=relaxed/simple;
	bh=g1/bpjPALCXzFTU1aCqorrXRSWoTWnnLLxTvD1XePRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5q73EuC56KGu9QYHSrTgKn4DVTSBDkv7GWjdIueDDFSW8yFhpQOPpKAVBckw67mqM3IoRBhbeQSwNtG9ECJpm7PUEjrXW+TfDc1RK46AhdDX7BEGN+AxTkw/B2Idqqbcgs6Vl538byz/YLgVNSU0uR6eUozwflLeJOGePLBeAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQcDd3QU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQcDd3QU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D969C2BCAF;
	Fri, 23 Jan 2026 08:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769155385;
	bh=g1/bpjPALCXzFTU1aCqorrXRSWoTWnnLLxTvD1XePRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jQcDd3QUMiq5RhjifeRiKMJlCG5K2ins0Zlz+MaV/v5Do3u1d3q52FBgw17RIUaau
	 Zzh9hjIaWd66O1Ir/6qmYFs8NUcwLCbNAJ+qibI3E1Hr9vzRQSHFufBSS84w5cvlQJ
	 dqu/tsRXcao+JDNdzrmgfvurBfF/wVlwczpiGO3xjf2HFTgTpUyAkytNtwo+hXJZGo
	 wlatOIbNJCU9Qty3zTouOk97RVliY50Vp7MI9DFesGrxMBkHID6DR4cIAOGO994cSP
	 P5wXZLUFkRhFw/ecej3/cCcWfKTP116rF2YEojykvw1H7E29RDo/SxrrpgDgvLVGfu
	 yUZIizWOZdGSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D92D7234B;
	Fri, 23 Jan 2026 08:03:05 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Fri, 23 Jan 2026 08:02:48 +0000
Subject: [PATCH v3 5/5] i2c: xiic: minor cosmetic cleanup
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-i2c-xiic-v3-5-eb7cd4254dfb@nexthop.ai>
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
In-Reply-To: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769155384; l=5149;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=dTX1v7vOgEB5f4WNaQT/jsmJZcS4w/ksW0v2dImQznM=;
 b=YkuZyZUnFWIQcqKGtIzEEqTu0nG2pvhfKHVLBIwNPqZO8JRdoP+A6eOQbjPfDocoF8qn/1Ze8
 26xjEhNk3jbDoYp/BLH1klsKrt0PBzwDV52/hdf6qW753oo2jvdLHmM
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Add a temporary dev variable and reuse it instead of referencing pdev->dev
everywhere.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 60 +++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 3af2d60d3e32..3c0ec33aefd4 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1420,6 +1420,7 @@ MODULE_DEVICE_TABLE(of, xiic_of_match);
 
 static int xiic_i2c_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct xiic_i2c *i2c;
 	struct xiic_i2c_platform_data *pdata;
 	const struct xiic_version_data *data;
@@ -1428,11 +1429,11 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	u8 i;
 	u32 sr;
 
-	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
+	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
-	data = device_get_match_data(&pdev->dev);
+	data = device_get_match_data(dev);
 	if (data)
 		i2c->quirks = data->quirks;
 
@@ -1444,52 +1445,50 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	pdata = dev_get_platdata(&pdev->dev);
+	pdata = dev_get_platdata(dev);
 
 	/* hook up driver to tree */
 	platform_set_drvdata(pdev, i2c);
 	i2c->adap = xiic_adapter;
 	i2c_set_adapdata(&i2c->adap, i2c);
-	i2c->adap.dev.parent = &pdev->dev;
-	device_set_node(&i2c->adap.dev, dev_fwnode(&pdev->dev));
+	i2c->adap.dev.parent = dev;
+	device_set_node(&i2c->adap.dev, dev_fwnode(dev));
 	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
 		 DRIVER_NAME " %s", pdev->name);
 
-	ret = devm_mutex_init(&pdev->dev, &i2c->lock);
+	ret = devm_mutex_init(dev, &i2c->lock);
 	if (ret < 0)
 		return ret;
 
 	spin_lock_init(&i2c->atomic_lock);
 
-	i2c->clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
+	i2c->clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(i2c->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
+		return dev_err_probe(dev, PTR_ERR(i2c->clk),
 				     "failed to enable input clock.\n");
 
-	i2c->dev = &pdev->dev;
-	pm_runtime_set_autosuspend_delay(i2c->dev, XIIC_PM_TIMEOUT);
-	pm_runtime_use_autosuspend(i2c->dev);
-	pm_runtime_set_active(i2c->dev);
-	pm_runtime_enable(i2c->dev);
+	i2c->dev = dev;
+	pm_runtime_set_autosuspend_delay(dev, XIIC_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 
 	/* SCL frequency configuration */
 	i2c->input_clk = clk_get_rate(i2c->clk);
-	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
-				       &i2c->i2c_clk);
+	ret = device_property_read_u32(dev, "clock-frequency", &i2c->i2c_clk);
+
 	/* If clock-frequency not specified in DT, do not configure in SW */
 	if (ret || i2c->i2c_clk > I2C_MAX_FAST_MODE_PLUS_FREQ)
 		i2c->i2c_clk = 0;
 
-	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-					xiic_process, IRQF_ONESHOT,
-					pdev->name, i2c);
+	ret = devm_request_threaded_irq(dev, irq, NULL, xiic_process,
+					IRQF_ONESHOT, pdev->name, i2c);
 
 	if (ret < 0) {
 		goto err_pm_disable;
 	}
 
-	i2c->singlemaster =
-		device_property_read_bool(&pdev->dev, "single-master");
+	i2c->singlemaster = device_property_read_bool(dev, "single-master");
 
 	/*
 	 * Detect endianness
@@ -1505,7 +1504,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 
 	ret = xiic_reinit(i2c);
 	if (ret < 0) {
-		dev_err_probe(&pdev->dev, ret, "Cannot xiic_reinit\n");
+		dev_err_probe(dev, ret, "Cannot xiic_reinit\n");
 		goto err_pm_disable;
 	}
 
@@ -1522,38 +1521,39 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 			i2c_new_client_device(&i2c->adap, pdata->devices + i);
 	}
 
-	dev_dbg(&pdev->dev, "mmio %08lx irq %d scl clock frequency %d\n",
+	dev_dbg(dev, "mmio %08lx irq %d scl clock frequency %d\n",
 		(unsigned long)res->start, irq, i2c->i2c_clk);
 
 	return 0;
 
 err_pm_disable:
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 
 	return ret;
 }
 
 static void xiic_i2c_remove(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct xiic_i2c *i2c = platform_get_drvdata(pdev);
 	int ret;
 
 	/* remove adapter & data */
 	i2c_del_adapter(&i2c->adap);
 
-	ret = pm_runtime_get_sync(i2c->dev);
+	ret = pm_runtime_get_sync(dev);
 
 	if (ret < 0)
-		dev_warn(&pdev->dev, "Failed to activate device for removal (%pe)\n",
+		dev_warn(dev, "Failed to activate device for removal (%pe)\n",
 			 ERR_PTR(ret));
 	else
 		xiic_deinit(i2c);
 
-	pm_runtime_put_sync(i2c->dev);
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 }
 
 static const struct dev_pm_ops xiic_dev_pm_ops = {

-- 
2.52.0


