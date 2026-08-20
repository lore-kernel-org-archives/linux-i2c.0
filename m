Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19C03B9942
	for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254802; cv=none; b=AIfKPEhxi3wLxMbEKpuWM78rLAiH08sZMdvVb45zC2eikKZRaTlMGrTZn+IGSge2VPGgoW58YwN0TNKAYqMRbOEBwdOLmAPldIcJI+RYi9WLs7XFK90HfqEd+trT+ottsE2XTLEloeoO+1PRTdklXkim87smNdc3qi0vTmeRbm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254802; c=relaxed/simple;
	bh=2VY9MXDjK9yzik9Rg0IadfnDzQtNAmpccieQpDEqoRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TiLby2DDtjEOzMoDw+Omn8bBDj3qOPxrvfX3bGJgqxjU97qMH+bZFfdSy7gqFDsHkubV+MS/cGEnqKHIYzGD2M+B6c03bIhcG7AR0I6aalnhZtac3JgfcMT9IbGMYqw6xm60SByV4t/QNHg9s3IlHc+5Jd5vnTqT3S7UZslpqck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=JbknkvgK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="JbknkvgK"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ce98cb8165so1431105ad.1
        for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 12:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1787254800; x=1787859600; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZcCE6qlc50qWmg1m/bQqEwbDw08j9kuZZKKtuHo15dA=;
        b=JbknkvgKqA1WDjLF4gDOOZ1BAKjjXtpc2Fa8QP/+u2/kgMidNUSQwtZSXIUgXW484L
         i8tqezLZamzg0xlvCneJ5UnibZJBGV3RLcJxO8V6YYnlvOWEHCbsh7HY8Df651Q6rntj
         YNOjfutnUGEx4BjB+nt6nIsAHfOFqLr5I0fTGyuZF9InZEpp7KM8u8nLh2KGOxhsUZ9M
         l8QUWGzG92iGSBa+MZE8uewdqigYHPY8D5XEdpU5T9kTEiR1DUJBZNthWu0bUu5vZtqS
         X7sKzh3gmIVJLFEZcwI7d0lZpgA4ld9/CAglFjGGO3yRBIEVEXqsog6ZiZ5KhqX1aQxF
         eGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787254800; x=1787859600;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZcCE6qlc50qWmg1m/bQqEwbDw08j9kuZZKKtuHo15dA=;
        b=MqbcQsv5vuhNrRVBbTLsnE9Qb8iDKVtDTsNy2zAgOMjeLP4yRC7+UGLmJNBO4bN0eN
         FAps0W2dUaPgO1LxSP/LHON7N5NO6CDOBQUFwgkSazwaNvPoixPo4+v7QUS3UkF2tQUa
         cnD2r65ldGqC2mKKrn31MPUF+sSr0EElaFM90E/TPKY+RinwgMHvwFri0uOcuHvq4lp1
         lOnI4Rz/oOktSsITxESDdF1wOPEMZmu7UM66Zr6K0j9jVfJkx1N5qqyoN5LR9S+C8HNG
         DCTPCNeHq78BOYJ2dkz1MkkC/NO8z0YxJeHJnZLjNqcln1BURnsRIQFXnlSsalm0CSHG
         MoUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpx8OM7MQZot/Ks2uws0dDIkMBAE1yOJr6q2zRNJmAgXsJ1kqUyzV8DGpXehpFW/DHLLuuhAF56tZY=@vger.kernel.org
X-Gm-Message-State: AFuF++kn10SQofWJ6c4XMqpht/+J2hnUFCXfVBCKSDfQy9T+rnn/Ej54
	i4LolTUPvxQg7bUEVKSZkNzvarM5/Pixwi7XWOskDVULlGJhw2qGXVX9NOjvPyBxL9g=
X-Gm-Gg: AR+sD12VQEUSOxLwBdK0GDK6rGPmKZfIUrfKTuTsnPnNzlNF9RpyQ9rclrE6CXy7hZZ
	/5Qt2Leq8wgLriZN5LNRpZ02LQHKjUgW9BdVJFBSWJeJcC8OYvo1E9uzvsTOnZbU4PsdGjT/0Yi
	cATrF/fUBk01k+Lko5BAtDVPN+w9ab0OAg4x6Nw/sV7Ng9mqFfm0YqWPboc0IjWGZWuW8a5R9qB
	/B6Qk+2KO8xiyiOiK19eMEmvTsAWEm4O1n158qzMGBsoWFTUhu49Gw8uobD3NVzGbKySsiAe8M3
	8dDQoOxeUl7miyF4paL8OhjHsAh+wLmuKEt1ZMRBvTec0KM0yBchmQNxA0BiS2FHLW4LOTRUN25
	iCRx/tr1rhK+A05yVqaJeMmqX9ABNAoUI7pq1e8kHl4O+KZidfGMFwzHnCxlM9jDsgNtDfOvkev
	iMOOZAo4a058XUQlV6zqehwFrCXr5L2llkPn3gxB+cONIQ1RSXdIY4796hjXutaok=
X-Received: by 2002:a17:902:ce0d:b0:2bd:2c3a:2a36 with SMTP id d9443c01a7336-2d619d47dfamr114795725ad.0.1787254800300;
        Thu, 20 Aug 2026 12:40:00 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf14376asm19543822eec.24.2026.08.20.12.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 12:39:59 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Thu, 20 Aug 2026 12:39:56 -0700
Subject: [PATCH v6] i2c: xiic: restore non-managed runtime PM to fix clk
 WARN flood
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-i2c-xiic-restore-runtime-pm-teardown-v6-1-5db5c3703ea0@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XOzU6EMBQF4FeZdG3NbUuBuvI9jIv+3Mo1GSCFQ
 cyEd7cdNxg2uDzJyXfOnU2YCCf2crmzhAtNNPQ51E8X5jvbfyCnkDOTIGtoheIkPV+JPE84zUN
 Cnm79TFfk45XPaFMYvnoeAlgngpMeJMvUmDDS+ph5e//N0819op+LXRodFe378WMRpffPyUVww
 QGbEJ2EujHw2uM6d8P4bImVzUXu1eqkKrPaWNQBvIIY5UFVe7U9qaqs6hiU0A6aFsVBrfaqOal
 WWa2NMegqVQXhD6reqRJOqjqr3urgTA1aQ/tH3bbtB/Nj7ixDAgAA
X-Change-ID: 20260813-i2c-xiic-restore-runtime-pm-teardown-dd0ab1db2c02
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787254799; l=8044;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=2VY9MXDjK9yzik9Rg0IadfnDzQtNAmpccieQpDEqoRA=;
 b=zmlZ/jh+vJ9Ved5kvwlUN1/FjmVcYt5PXN0MSjfimc3sGeYYCRzy8OVImTmtbE+RAKJkVvjwP
 sOGeRxiXjfQANRvxlwD/MRYRuFoqFa31xrsYzgpe6xCydIMita5Dqyz
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
 drivers/i2c/busses/i2c-xiic.c | 48 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 3e7735e1dae0..0f19bca8ea17 100644
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
@@ -1475,9 +1476,17 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 
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
@@ -1486,10 +1495,15 @@ static int xiic_i2c_probe(struct platform_device *pdev)
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
 
@@ -1506,14 +1520,16 @@ static int xiic_i2c_probe(struct platform_device *pdev)
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
@@ -1526,6 +1542,15 @@ static int xiic_i2c_probe(struct platform_device *pdev)
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
@@ -1537,6 +1562,8 @@ static void xiic_i2c_remove(struct platform_device *pdev)
 	/* remove adapter & data */
 	i2c_del_adapter(&i2c->adap);
 
+	free_irq(i2c->irq, i2c);
+
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0)
 		dev_warn(dev, "Failed to activate device for removal (%pe)\n",
@@ -1544,7 +1571,10 @@ static void xiic_i2c_remove(struct platform_device *pdev)
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

