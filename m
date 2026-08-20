Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60423CAE93
	for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228717; cv=none; b=CT4C48lp5AxoNt7avWT4FEAZx5vqUSlaGr/LGNx23XfJtGvE9PhhzXDJHZZCyLptn30SXQZY+Fkfs2yrZxDLLhsHoieQpYZ9qBEMuCoHPiCm3XXYIbWEz3Xdu2GLsej73WE2jQWPp7tSManZeH2MaAc7re/mjAjPn/5SnlUhcqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228717; c=relaxed/simple;
	bh=dmkm/yOT+VGwmCEIl36qnFbW0buHfut/9COHetD6ULw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YQDulFyFvFKUNH/RIYBgGCbQYcRWwavxyfKWG4Ztw5BdfMvop8kqmZkRSw08G445LYtE6KHrH8XbMJOrAD0O+Uc09+bJQi+os9OJwdPZn53ri7s6mZ9L55FnhU6maUcB+H1hTRvm3QEvw2BfJmBK/HOvYIq7tt5mUiXs1IWMaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=MLPYLIj6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="MLPYLIj6"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d0407aedd6so19772135ad.0
        for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1787228714; x=1787833514; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OyXdngKokkNNzIHrBbg7P8oeDiJFCinDSiokluhjKGY=;
        b=MLPYLIj6ZpaVZZJ1QuSdxzosg9d45jI1QkfPwsCs+Ec0wXNpBUEm7ULjyPO1gaZrPn
         r1ceLQ0cOqhL7LF2Zo+uj4hg1CWuYzMmMx8yvhyGWM8PJT7bf233BbzQyZ1py8P5IsP/
         lph2mWYX5QRTpolklc4ispMH12Ba0lpGvv9l9lPtT/dHcIcERlDcUKL0izxilwbNMl47
         R1amxStrm3iKJ03JOAgNpM8kB92ejxCJBVR/AFh23AdHwHUV1byWLUfJfiLX2Lkh8PQK
         ogq+zj+GX2iz8rtAIK73AeNjTPpTfIGewRoyDPMmDF95rY36BkJG5PNn34Hjs0Oy+iZe
         X9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787228714; x=1787833514;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OyXdngKokkNNzIHrBbg7P8oeDiJFCinDSiokluhjKGY=;
        b=eU08hZCVc5jwyJlot6Nme7vYWbcSsixhc5Nx2lW8lEa3WmszKyshpiinG0hJwFXwRm
         Irw1A/4kIm5BmfOUBpu/1is++kf/P/2F8BF7eV9cFU38GjPJZ7s5GmYc6CWrkmpXkkQ4
         8ennmnw3VhdmEWIHkCK3t6NWtztUErCfXSS/L7YNIuMSldIxbSVcbi7RnKOlLi4gXkI5
         +t4A2wO5qXZwwDJgfzQuAw7qAzfC89s34mO6nejRg2JMKG2uKOZUKCBdNaeV2aUvhLac
         TQIm9f5QhRMGa3QV/0tcvscu6DOGpK3M4+Pq+TKJ7OGPHTl9qb7UvhAGhLjSfZVYYg7V
         FIwA==
X-Forwarded-Encrypted: i=1; AHgh+RpjIwIBhrAJA3u2yB/JFQZ09VQXgePxjPtaFeXBEND8I8jZkxQtk0itvlzFkcSI9pmBiG7HqwNsxSU=@vger.kernel.org
X-Gm-Message-State: AFuF++lfX8l02WqLBboFKurGvBm1ffo3cRYEZAYDmsnm6TjOYpYi7+K2
	OVxyMczjiLSdP9ggXDtZh35DJq65cI93O9zoViNzjeYCUrH5OqDGwiTeUJrTlSN1fwU=
X-Gm-Gg: AR+sD11BqflZ1IiPGrmeUnEVpvcfCBg1t9f7XH0QnPcBV4ygHmiH7EHaP/q5hac3uq1
	Shk2B8sa78WJE9fap83xlF1L+MbYcIOfyOZrND3C3EZpRQ78kD5eWwZNHaEP9+q9ZkLyFY+cq5w
	2IMXZBpODz45uCzvHsnpVCgqJxGxvKOonWm/Ptk87TNBI6N54ebcqm+4ZHuOpTBbjztFhuOm+zn
	jLkZ4h1lAQ8SbtjwN+3xtPv8wVW+mXXbs9DeOxeHDdzNmpC9XG1Do9HG08tPBkPbViOKWpqkdWk
	08Px5ncdzZGCIWEHZvqzbhSEhOIuS8BCHlTIyLXDBUklT4u7X6lmkYisQMp+gZVF8CwlzF3V+qu
	NH/tlNVmsisXaJ8SE3Bde7Y0dnbD8KcpdaLt58aQ2LId4ijPIsfZHZDZGZGuqt56uGOwA5X9tgf
	tTFxy14GHEOy5Hy1BrrpKM8nB2g8JNZ7UAV/JAotWLxcSIS7HiL2WHaROL7jLV5RE=
X-Received: by 2002:a17:903:120f:b0:2c9:c991:3bf0 with SMTP id d9443c01a7336-2d5fd62101bmr202658635ad.8.1787228714188;
        Thu, 20 Aug 2026 05:25:14 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3a231fsm6182765ad.63.2026.08.20.05.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:25:12 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Thu, 20 Aug 2026 05:25:07 -0700
Subject: [PATCH v5] i2c: xiic: restore non-managed runtime PM to fix clk
 WARN flood
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-i2c-xiic-restore-runtime-pm-teardown-v5-1-ca5db9605508@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XOOW7DMBQE0KsYrMOAmxamyj0CF1w+ox/AkkDSi
 gxDdw/pNArcKOUAgzdzJwkiQiJvpzuJsGDCaSyheTkRN5jxEyj6kolgomU9lxSFoyuioxFSniL
 QeB0zXoDOF5rBRD99j9R7Ziz3VjgmSKHmCAHXx8zH+Tenq/0Cl6tdGwNW7fb4sfDa++fkwimnD
 DofrGBtp9n7CGsepvnVIKmbi9ir6qAqitoZaDxzkoUgnlS5V/uDqixqE7zkjWVdD/xJVXtVH1R
 VUVutNVgllefuj7pt2w81WtEy7QEAAA==
X-Change-ID: 20260813-i2c-xiic-restore-runtime-pm-teardown-dd0ab1db2c02
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787228712; l=7470;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=dmkm/yOT+VGwmCEIl36qnFbW0buHfut/9COHetD6ULw=;
 b=G1VAeO5pYDbOoFCVwcs89ktZblgSs9zHSq32LEA3fD+Y0v0/SJnqwGrQUpHnphgA+Rmc0r3h+
 rruLu4UA3PfDr5FN9GS+e8yb3hbChRa4/GcFu5igLKZ0/WiYpaP306y
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

The devres conversion replaced manual pm_runtime_enable()/disable() with
devm_pm_runtime_set_active_enabled() and dropped the remove-time runtime
PM teardown. The managed release tears runtime PM down in the wrong
order: it calls pm_runtime_dont_use_autosuspend() before
pm_runtime_disable(), i.e. while runtime PM is still enabled, and devres
is LIFO so the devm_clk_get_enabled() release runs afterwards.

At remove(), pm_runtime_put_sync() leaves the device active with the
autosuspend timer armed. Clearing use_autosuspend then makes rpm_idle()
suspend immediately, and xiic_i2c_runtime_suspend() clk_disable()s the
clock. The later devm_clk_get_enabled() release clk_disable_unprepare()s
the already-disabled clock, so clk_core_disable() WARNs ("clkN already
disabled") on every teardown.

Drop the managed helper and restore the non-managed runtime PM setup and
teardown, so runtime PM is enabled once in probe and disabled once in
remove and the clock enable count stays balanced.

Order the remove teardown so runtime PM is disabled before the usage
count is dropped: pm_runtime_disable() followed by pm_runtime_put_noidle()
instead of pm_runtime_put_sync(). Dropping the count first with autosuspend
still enabled arms the autosuspend timer, and a preemption before
pm_runtime_disable() lets it expire, suspend the device and clk_disable()
the clock, which the devm release then disables again - the same WARN.

Restore the non-managed IRQ request as well. The probe error paths now
unwind runtime PM by hand via goto, and a devm-registered handler is only
freed later during devres unwind, so it would stay live across the manual
teardown (and across any future failing step added after it). Request the
IRQ with request_threaded_irq() and free it explicitly in the probe error
path and in remove. The probe error path also clears use_autosuspend, to
match the teardown in remove().

Fixes: 50c63491ff26 ("i2c: xiic: switch to devres managed APIs")
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Changes in v5:
- remove(): disable runtime PM before dropping the usage count
  (pm_runtime_disable() + pm_runtime_put_noidle() instead of
  pm_runtime_put_sync()), so the armed autosuspend timer can no longer
  race pm_runtime_disable() and re-trigger the clk double-disable.
- probe error path: also call pm_runtime_dont_use_autosuspend() so it
  mirrors the teardown in remove().
- Link to v4: https://patch.msgid.link/20260819-i2c-xiic-restore-runtime-pm-teardown-v4-1-6999eb434d1c@nexthop.ai

Changes in v4:
- Request the IRQ non-managed (request_threaded_irq/free_irq) and free it
  in the probe error path and in remove(), instead of a devm handler that
  would only be released during devres unwind and so stay live across the
  manual runtime PM teardown in the goto error paths (Andy).
- Link to v3: https://patch.msgid.link/20260818-i2c-xiic-restore-runtime-pm-teardown-v3-1-5fd315b078e1@nexthop.ai

Changes in v3:
- Drop the managed devm_pm_runtime_set_active_enabled() helper entirely
  and restore the non-managed runtime PM setup (pm_runtime_set_active +
  pm_runtime_enable, with probe error unwinding) and teardown
  (pm_runtime_disable + set_suspended + dont_use_autosuspend), so the
  disable depth stays balanced rather than being disabled twice (Andi).
- Link to v2: https://patch.msgid.link/20260814-i2c-xiic-restore-runtime-pm-teardown-v2-1-7ae5d0c30ff2@nexthop.ai

Changes in v2:
- Move the Signed-off-by into the commit message proper (Andy).
- Link to v1: https://patch.msgid.link/20260813-i2c-xiic-restore-runtime-pm-teardown-v1-1-0e7dfb206790@nexthop.ai

To: Michal Simek <michal.simek@amd.com>
To: Andi Shyti <andi.shyti@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/i2c/busses/i2c-xiic.c | 46 +++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 3e7735e1dae0..ece6d4f2cc6d 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -92,6 +92,7 @@ struct xiic_i2c {
 	int rx_pos;
 	enum xiic_endian endianness;
 	struct clk *clk;
+	int irq;
 	enum xilinx_i2c_state state;
 	bool singlemaster;
 	bool dynamic;
@@ -1475,9 +1476,13 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 
 	pm_runtime_set_autosuspend_delay(dev, XIIC_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(dev);
-	ret = devm_pm_runtime_set_active_enabled(dev);
-	if (ret)
-		return ret;
+	/*
+	 * Enable runtime PM by hand: devm_pm_runtime_set_active_enabled()
+	 * tears down in an order that races the devm-enabled clock release and
+	 * makes clk_core_disable() WARN (see xiic_i2c_remove()).
+	 */
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 
 	/* SCL frequency configuration */
 	i2c->input_clk = clk_get_rate(i2c->clk);
@@ -1486,10 +1491,15 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	if (ret || i2c->i2c_clk > I2C_MAX_FAST_MODE_PLUS_FREQ)
 		i2c->i2c_clk = 0;
 
-	ret = devm_request_threaded_irq(dev, irq, NULL, xiic_process,
-					IRQF_ONESHOT, pdev->name, i2c);
+	/*
+	 * Request the IRQ non-managed: later probe steps unwind manually via
+	 * goto, so a devm handler could still be live after that teardown runs.
+	 */
+	i2c->irq = irq;
+	ret = request_threaded_irq(irq, NULL, xiic_process, IRQF_ONESHOT,
+				   pdev->name, i2c);
 	if (ret)
-		return ret;
+		goto err_pm_disable;
 
 	i2c->singlemaster = device_property_read_bool(dev, "single-master");
 
@@ -1506,14 +1516,16 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 		i2c->endianness = BIG;
 
 	ret = xiic_reinit(i2c);
-	if (ret)
-		return dev_err_probe(dev, ret, "Cannot xiic_reinit\n");
+	if (ret) {
+		dev_err_probe(dev, ret, "Cannot xiic_reinit\n");
+		goto err_free_irq;
+	}
 
 	/* add i2c adapter to i2c tree */
 	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret) {
 		xiic_deinit(i2c);
-		return ret;
+		goto err_free_irq;
 	}
 
 	if (pdata) {
@@ -1526,6 +1538,15 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 		res, irq, i2c->i2c_clk);
 
 	return 0;
+
+err_free_irq:
+	free_irq(irq, i2c);
+err_pm_disable:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+
+	return ret;
 }
 
 static void xiic_i2c_remove(struct platform_device *pdev)
@@ -1537,6 +1558,8 @@ static void xiic_i2c_remove(struct platform_device *pdev)
 	/* remove adapter & data */
 	i2c_del_adapter(&i2c->adap);
 
+	free_irq(i2c->irq, i2c);
+
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0)
 		dev_warn(dev, "Failed to activate device for removal (%pe)\n",
@@ -1544,7 +1567,10 @@ static void xiic_i2c_remove(struct platform_device *pdev)
 	else
 		xiic_deinit(i2c);
 
-	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 }
 
 static const struct dev_pm_ops xiic_dev_pm_ops = {

---
base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
change-id: 20260813-i2c-xiic-restore-runtime-pm-teardown-dd0ab1db2c02

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>

