Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E976F1A5B9D
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787361143; cv=none; b=LMaGvH9UMcGthxjPBbxy6G4pP2wCDiWY47u/JavrXIxe3EeKQDldZMuKber8CVan8DY/CO8jewNovF/ftOTVpluFisqOSt2SKKd+irQrvcXCFGokPtxucQkf4tUcpwu4uf3+I4PAIIiRVKtAIj2EH95wdz2G8+BTUvIxfvoBEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787361143; c=relaxed/simple;
	bh=wN1MwfUvPUgv6Pty4uwJnzpztqBgXcgXAOukobtm6cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MIwViVNVFaoqTViTYnAWDfEH8e6Immxl15IWalw94vrkNwbQgv2loEnVp9k7gg9Eaf4mLNoWvnMbCmDMvkK4cV9Q82u4wss4i33Vf9Oq0BeXcztk1orWK0qHlbHOuzrbhu4t4pwNuipCHYxcu9QHNvJycRgRchBa1UGE5FyE8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=OWZw7xt2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="OWZw7xt2"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce7d2adef4so22915905ad.3
        for <linux-i2c@vger.kernel.org>; Fri, 21 Aug 2026 18:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1787361141; x=1787965941; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wN/b91/dIiXaYiNY6AMuG5UAHrJgyvCbCYyK8iXNFeU=;
        b=OWZw7xt2Qrn80LNf77R/YjVlwjkZWppPmbNhKYNQyG2D0EQiTZCPCQAwKJSh0MlsnO
         U19Dz6+FNF36DNUoZh22eAXMfBWREdTcOOZ7tir2F55LGx9YzzaOoqqtSovGCHoRNgD0
         lTV0ne2xh1TXGlHM2b2qNXj/y+rm0WvNMipQUK+yaWL04UHX4X++vVCVDPFbHaE1pW9W
         PSDp7OKAbmMs5LMhza1KLCzFKdIqTA3WQlde2XOgny3gtVxkmOLuMutykcNcCPEvAUZg
         7bd6QBEHmnxPPlpnbN1zrT3l8+208vRgRwURpiM/0z4h9GK28dPMSPigWN9ehLu/pywQ
         E0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787361141; x=1787965941;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wN/b91/dIiXaYiNY6AMuG5UAHrJgyvCbCYyK8iXNFeU=;
        b=RSHHqIFBlo6JrVE9p7gSOo5rJKsM6FPNVdPLdw8P2RV7Lo0IsZUdeUYPvBzyR5WHA9
         ip+v5nAE6BO3ubJD334ONAxoWUurdw7Qq2pkOOGr1pN4R69/wZpzQ5JtoQn/RDXLwXTm
         EUtktyfv9SAgpQug0/lZjFTbmHuSXCBn7/IYo7vZnm7oJcOfdqAhfBXK/QBLE9qdBrv0
         iB7wFpT6N11NE9LBftloGIdupFtgsb+Oj3/dX5/sb6cimGyQV0QoajtbAkOKMDSZUjlK
         7QlUMEDDCb0pdI3MeYBlD1gvGasGTDT0SKpdNF4VOYgeg7419InXOtcs58qjO5E9NH73
         DwdA==
X-Forwarded-Encrypted: i=1; AHgh+RrksQmpZPFzP/toItKzyWyT8IlsYrhV8geq85ognQcRfeH2NMVTvatFmeRuqzFFyr3bBxiFuaLO+js=@vger.kernel.org
X-Gm-Message-State: AFuF++mwOEJvy6VkFIAhdYGFLD9Gav7xHC9+b+XyX+zZklZPoFSoaSYo
	FVTta/j4EtGTkKMQlpnFSVm9w8X6G/AY4AeMz6vSGG0KDKkeE/5xNY86wms+AqpfvNA=
X-Gm-Gg: AR+sD13dBIc7oMKHE3OUOSiiE4sWavArdYRplWkeGPv9tu+J7SXPrqUHjh1rX9rIzdE
	Qb+EOpsD7qf80c/mY7DjpN+QUz1qjO3QPkGAr0oOLC39vVE026EE29klZcpNOUwJTWkVNxDsOnr
	HpUqHN89n9i5p70CG4/c6gUyVMEFW5oJlr7b53yEdwemQzKp9xzalLR3HKFJCIQ+U0J88sSsR5C
	anYpWDPHEqdVt75C8WeGwAVnEDNWB1ybGavPTvxQHQqCtnNQslE3fehYdOPjDDaPsSgmUMoJLZM
	1JmZmBHpCoBNm8Tf9WELnzXDvgNmmNcC/1hkluAG91lBphiuzaPpTaVYNksuZVnzVeJjvTH89bw
	d/W2sZJtsc6mhOGqIqnzzczQO1dwdQXpaJ5RgtsMm0WbhdcLvd5U+VwCmRXPkU5Lin9QVHgeW9b
	wZ3ofBMymw3hdE2IPDrh+ZPmjwmeQaiQWALVpWWCA1NuEQeyiU33mPBWnEcvGGOYo=
X-Received: by 2002:a17:902:ebcd:b0:2cf:ccc2:6088 with SMTP id d9443c01a7336-2d64af6b6aemr207150365ad.4.1787361141009;
        Fri, 21 Aug 2026 18:12:21 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90cb8e3sm1136529eec.12.2026.08.21.18.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 18:12:20 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Fri, 21 Aug 2026 18:12:17 -0700
Subject: [PATCH v7] i2c: xiic: restore non-managed runtime PM to fix clk
 WARN flood
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-i2c-xiic-restore-runtime-pm-teardown-v7-1-954e06765144@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/53RTW6DMBAF4KtEXtfV2MY2zqr3qLLwz1BcKYAMI
 VQRd6+dbqjY0C6fNPreaOZBRkwRR3I+PUjCOY6x73LQLyfiW9t9II0hZ8KBK6iZoJF7usToacJ
 x6hPSdOumeEU6XOmENoX+3tEQwDoWHPfASaaGhE1cnjXvl5883twn+qnYZaKNRft67jGzMvfHy
 plRRgF1aBwHpQ28dbhMbT+82khK58y3anVQ5VnVFmUAL6Bp+E4VW7U+qIqsyiYIJh3oGtlOrba
 qOahWWVXGGHSVqALzO1VuVA4HVZlVb2VwRoGUUO9U9R9VlQsEJ73QIND+/ta6rt8nUXppmQIAA
 A==
X-Change-ID: 20260813-i2c-xiic-restore-runtime-pm-teardown-dd0ab1db2c02
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787361139; l=8752;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=wN1MwfUvPUgv6Pty4uwJnzpztqBgXcgXAOukobtm6cE=;
 b=2e8rBZs4veqnDNBR4JmfQHiW14cySID95HGyycLLuRfDo7abiViCnXKz2tIOmoMn6nOSDixVF
 H78DYyFgPrtC3tmuSUK9zz6YMB8gzFl9MXbnOVEXXxwXSvirRW93WEI
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
Changes in v7:
- Add the missing kernel-doc entry for the new @irq member of struct
  xiic_i2c (the non-managed IRQ request added in v4 introduced the field
  but not its doc), fixing a "struct member 'irq' not described" W=1
  kernel-doc warning. No functional change.
- Link to v6: https://patch.msgid.link/20260820-i2c-xiic-restore-runtime-pm-teardown-v6-1-5db5c3703ea0@nexthop.ai

Changes in v6:
- probe: check the pm_runtime_set_active() return value and unwind on
  failure (undo pm_runtime_use_autosuspend()) instead of ignoring it.
  On failure runtime PM would stay suspended while the clock is left
  enabled, and remove()'s pm_runtime_get_sync() would then resume, enable
  the clock a second time and leak the enable across the manual teardown
  (Sashiko).
- Link to v5: https://patch.msgid.link/20260820-i2c-xiic-restore-runtime-pm-teardown-v5-1-ca5db9605508@nexthop.ai

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
 drivers/i2c/busses/i2c-xiic.c | 49 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 3e7735e1dae0..92cefc7e221b 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -67,6 +67,7 @@ enum i2c_scl_freq {
  * @rx_pos: Position within current RX message
  * @endianness: big/little-endian byte order
  * @clk: Pointer to AXI4-lite input clock
+ * @irq: Interrupt number
  * @state: See STATE_
  * @singlemaster: Indicates bus is single master
  * @dynamic: Mode of controller
@@ -92,6 +93,7 @@ struct xiic_i2c {
 	int rx_pos;
 	enum xiic_endian endianness;
 	struct clk *clk;
+	int irq;
 	enum xilinx_i2c_state state;
 	bool singlemaster;
 	bool dynamic;
@@ -1475,9 +1477,17 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 
 	pm_runtime_set_autosuspend_delay(dev, XIIC_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(dev);
-	ret = devm_pm_runtime_set_active_enabled(dev);
-	if (ret)
+	/*
+	 * Enable runtime PM by hand: devm_pm_runtime_set_active_enabled()
+	 * tears down in an order that races the devm-enabled clock release and
+	 * makes clk_core_disable() WARN (see xiic_i2c_remove()).
+	 */
+	ret = pm_runtime_set_active(dev);
+	if (ret) {
+		pm_runtime_dont_use_autosuspend(dev);
 		return ret;
+	}
+	pm_runtime_enable(dev);
 
 	/* SCL frequency configuration */
 	i2c->input_clk = clk_get_rate(i2c->clk);
@@ -1486,10 +1496,15 @@ static int xiic_i2c_probe(struct platform_device *pdev)
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
 
@@ -1506,14 +1521,16 @@ static int xiic_i2c_probe(struct platform_device *pdev)
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
@@ -1526,6 +1543,15 @@ static int xiic_i2c_probe(struct platform_device *pdev)
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
@@ -1537,6 +1563,8 @@ static void xiic_i2c_remove(struct platform_device *pdev)
 	/* remove adapter & data */
 	i2c_del_adapter(&i2c->adap);
 
+	free_irq(i2c->irq, i2c);
+
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0)
 		dev_warn(dev, "Failed to activate device for removal (%pe)\n",
@@ -1544,7 +1572,10 @@ static void xiic_i2c_remove(struct platform_device *pdev)
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

