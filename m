Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DC248B37D
	for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158063; cv=none; b=hLzdEIl5P53URCLCCS2fJCAlPCCFUmYCvwEfoH+QuwetI0KHDtMQTl0P9h9rRU7jP9PodlIz2rHXjUJQNjcWG3iIxuwWB5zLw1qf8lrq7YWt1ys63wBSx/P5vwkG5Tb5yY30zc9rwfUFUVQNS5iuGfaWoBM/i2LZPADGOb9XJ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158063; c=relaxed/simple;
	bh=M8vBSbuA8VI2DOK1kxP8WB42QTX2GzsUgR6WmbobO8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qQllFt/yjKHNQxQkpYuDutF0ueaUZ7jpOKjqlZDZKxDKF8/Wp+0SY7Apb+5ztEod8u6iMl6LfQ4G/IiJY36EoIz1jw4Zr8ElSOsVoUWtgwS4f8MSds+ygqXwawWLvZjIUpUFA0pT5rGlj0N9Ho+xcmoUe6bSUNcdcCV/HSd5UFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=AO+Al2HG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="AO+Al2HG"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d530328efbso11455505ad.0
        for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 09:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1787158061; x=1787762861; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+nlBq5UdgVIUTs785HzCl/oYDRAOZ9I08lv0VtlQk+w=;
        b=AO+Al2HGowZsLbFenCtlWGpGM5JsnopYsb6plk2IVFRAtdYxCfmjg9f/W2V9aKZb/r
         zwSbLybjWXdEOLK87k/dmTg+iOteGRfr2CQ2oXN0qE31/nJwYbzanwoVmDf/LFitL1ib
         VxJZ30b3dRvDcgDX8GhJGYXWB5HDSTO74o79wMT7cQWZXK/tLbQlepLVEDFBaz6o/36s
         6s1YlUkpwApj9LlyfeuhjCtbtBBauoDLXhcT09uZOBigO2FXiyULyL+8mydSh2GK0tzz
         tAhe2cLyD/59sPosBNNO2LBjExNZ2nErOcDao975i4kool9aBCaGCF4OKYA+bLCIYEJF
         81Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787158061; x=1787762861;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+nlBq5UdgVIUTs785HzCl/oYDRAOZ9I08lv0VtlQk+w=;
        b=qRSPUnfPcst1nLdKle1q6jDArdye4fj/6pP9kFyJjtuPztnK4V4miQRHR8H44S139v
         mX9j2pxZh3uGgXMAmEHKGglLn0WtZtTad9U7EEjrMTPdg0XUizNqwW3oNa5hNoARGRAa
         pwRdFRnMxWfbYjmeP97j8JV5FxO8y7x+/diBb9hL1mB+nC/PUvIU4+pKR0V0bGkazmX+
         QqklQ0sJ1SYGfXDmdP/+1zfuXP0/aZMw3nX8z4YHswB41XK8MlpPpJpqEsbHNuGInsTw
         OqOfTIG8zbC5ovgNnUB1i+5QF7IMpFiPmhzQWSgUt6FthnRl+uoX5VPvXPLZqicBligp
         lWEQ==
X-Forwarded-Encrypted: i=1; AHgh+RrkNb/nEglvXOa9fVCX8T7xlTj+5QLnvDes+auTreu6g5f/ErZrxAJJYcB9qNCPF6+awLHSVbfZFiI=@vger.kernel.org
X-Gm-Message-State: AFuF++kawQaU1i91iHB9F5+CIkfEVR03fF056gBesGBmpL2nFFx4b6Ja
	cln0oYb08RfzF8CiCMhYfTk77PFyI1k38AjTJCsK4yBZJPjEtUlGP5ekKIifEl+JOnNGpKXPq1L
	UzCWibcY=
X-Gm-Gg: AR+sD13DRdwSFZn0m0b88av8hYeYgYWvQLylgYOwbGAEOQgb16jLJKfLlZNHG8AzdDf
	4G/ZCEQCrN961Bly5VY7ONy4xBV3DmnDaVpyEJ/86GnIlvy9OSr74ur+1v/oUzkG0TzqwyJKI6s
	sh2HZY9RI4imb0jIy8jmeoAzCvkmTjDR4RN66uol50/h/5hb/VJQ6JK2pLwW18ohs3u8hB/bOQX
	CnYjiZJY0zNal6DxQf5oSnqj3xJ5RVuMW8irs9j3XEVrffM2ZdBYQN4XF4TlFTu/5nCTcQh3FQj
	EklAuicHSAlcW9ddm7u0uV01IPXuBsgkgfiZ0DbCPraCxTSyuDvpf6CUU+bb9nfgmZb81JpI26y
	pnca+dLo3JimuCMBJ3S4auxB24YCYDopUjfTLJiZvplBqlCL+yG/Kjoe6CXevNOWij4wB4X8S5c
	Bp1FRB8H/M4hekS1GgHsruGWprf5PpBUeEwqXG45DvHJwre3thH3gD/3V+oxXj2wI=
X-Received: by 2002:a17:90b:4a46:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-3958083fc60mr10940911a91.4.1787158060779;
        Wed, 19 Aug 2026 09:47:40 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957faf596fsm3184128a91.11.2026.08.19.09.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:47:39 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Wed, 19 Aug 2026 09:47:37 -0700
Subject: [PATCH v4] i2c: xiic: restore non-managed runtime PM to fix clk
 WARN flood
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-i2c-xiic-restore-runtime-pm-teardown-v4-1-6999eb434d1c@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XOzU7DMBAE4FepfGbR2m6awIn3QD34Z00WqU5ku
 yFVlXfHLpciLuU40uibuYpMiSmL191VJFo48xRr2D/thBtN/CBgX7NQqA44SA2sHKzMDhLlMiW
 CdI6FTwTzCQqZ5KevCN6jsdJb5VCJSs2JAq+3mffjT85n+0muNLs1Rm7a5fZjka33z8lFggSk3
 ger8NC/4FuktYzT/GxYtM1F3av7B1VV1d5Q59FpDEH9UfW9Ojyo6qp2wWvZWewHkr/Ubdu+Aec
 pUkOXAQAA
X-Change-ID: 20260813-i2c-xiic-restore-runtime-pm-teardown-dd0ab1db2c02
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787158059; l=6356;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=M8vBSbuA8VI2DOK1kxP8WB42QTX2GzsUgR6WmbobO8c=;
 b=bDi1TK6LLCQWJEOOxLNfPaCR2kU7PLBpyloOuASAxvRp4naHPgNsgBElSDaXl7THv2vDPwmR/
 2U7PjotYbNuBLe7oFVGlgoHgdscLNNzeCALnwdstI8fKYnoVCQRxF3t
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

Restore the non-managed IRQ request as well. The probe error paths now
unwind runtime PM by hand via goto, and a devm-registered handler is only
freed later during devres unwind, so it would stay live across the manual
teardown (and across any future failing step added after it). Request the
IRQ with request_threaded_irq() and free it explicitly in the probe error
path and in remove.

Fixes: 50c63491ff26 ("i2c: xiic: switch to devres managed APIs")
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
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
 drivers/i2c/busses/i2c-xiic.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 3e7735e1dae0..bafae1cc44aa 100644
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
@@ -1526,6 +1538,14 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 		res, irq, i2c->i2c_clk);
 
 	return 0;
+
+err_free_irq:
+	free_irq(irq, i2c);
+err_pm_disable:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+
+	return ret;
 }
 
 static void xiic_i2c_remove(struct platform_device *pdev)
@@ -1537,6 +1557,8 @@ static void xiic_i2c_remove(struct platform_device *pdev)
 	/* remove adapter & data */
 	i2c_del_adapter(&i2c->adap);
 
+	free_irq(i2c->irq, i2c);
+
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0)
 		dev_warn(dev, "Failed to activate device for removal (%pe)\n",
@@ -1545,6 +1567,9 @@ static void xiic_i2c_remove(struct platform_device *pdev)
 		xiic_deinit(i2c);
 
 	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
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

