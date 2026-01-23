Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393182F99B8;
	Fri, 23 Jan 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186057; cv=none; b=monRHlAMG1beYwAWlEVN9B05G+uZmcCqDNxrTuJK3HJpx58J1BCB6T3u9D2hnwGz+dSb4Ivcp7UD1xtY4qMy7G/VraHqVOSHYIvrMR4RJbhrAAtLcHilQY0aVE1awFHWJQdDsMmLeYQAiAdbXSuSLCKAOvBn1JD1fA9AHGCKQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186057; c=relaxed/simple;
	bh=/kZ+kma1og4vRIL1r88KYLIWI/ylSgoxJtILoW3MkpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mq+bIhk8aKVSTpwOMaWPpH0tBr+5Ll8XypCD/8a3I2jRwcNl7lDBdIdkSexTHQ1o8F3X18yHQqFC1okrMzAWKb3la/Rjq8MAWcaw7yT9OpwWHzIhX+/wAayEEprndfdi4bkH5pq5cYHOOVBKHvVNArGKoBd0WgyW8GSS/7SiQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVi/QwtI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVi/QwtI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA5DAC19424;
	Fri, 23 Jan 2026 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769186057;
	bh=/kZ+kma1og4vRIL1r88KYLIWI/ylSgoxJtILoW3MkpQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bVi/QwtIw8uqTnKTsXNGme0jiBrWH4bvY4Sx7oJFH+8f1yWf5sM1sPScZgOCyMs4P
	 LNY1u0cP4zLS9u86fuaKM3kYVfJMxsqgiEL/OJqPmo4IvpN0WNoPXlvMDwEAiA+A2h
	 REcR9DOVBiV6nVVevUJ+m05MVhQE3wsKxlvzg4DI29DlbBtrjHdVV8VFY8R2V7LkY2
	 PkMow6Y1MU4m9dBkzjdW4GeDlzu2bBANtTOc8Rtp7wY1OZ5BN76Uzt7DEyt8p2jGr2
	 FKIWh9/KtC97qgHZI+bwXtk0heCR5RtgRUz/t3yg5mLAcYYx+lQxEuRzczBLLrh653
	 EjLKM7Ffmi13g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BA7D72371;
	Fri, 23 Jan 2026 16:34:16 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Fri, 23 Jan 2026 16:34:16 +0000
Subject: [PATCH v4 3/5] i2c: xiic: switch to devm_ managed apis to simplify
 the error code paths
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-i2c-xiic-v4-3-4a3eba3510ce@nexthop.ai>
References: <20260123-i2c-xiic-v4-0-4a3eba3510ce@nexthop.ai>
In-Reply-To: <20260123-i2c-xiic-v4-0-4a3eba3510ce@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769186056; l=2482;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=XbK+CsMc3APHOOXbUz+q5n+IsW+oIYdY5pzCy9rqMqo=;
 b=k35E0GXsoob5esmQwD9M0HPEhmsWR+DRjgaOdoF/JhihDiy794tnusnmsq940m+6M9wGWHHay
 2cN6x42rEPtBYXqH/cx6X7+8g/k4VecVLBqBzOnFeps5v/ri4qOyyur
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Simplify the error code paths by switching devm_mutex_init() and
devm_pm_runtime_set_active_enabled().

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 2da7e9d1d5ca..6d47c9972719 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1462,7 +1462,10 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
 		 DRIVER_NAME " %s", pdev->name);
 
-	mutex_init(&i2c->lock);
+	ret = devm_mutex_init(&pdev->dev, &i2c->lock);
+	if (ret < 0)
+		return ret;
+
 	spin_lock_init(&i2c->atomic_lock);
 
 	i2c->clk = devm_clk_get_optional_enabled(dev, NULL);
@@ -1473,8 +1476,9 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	i2c->dev = dev;
 	pm_runtime_set_autosuspend_delay(dev, XIIC_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret < 0)
+		return ret;
 
 	/* SCL frequency configuration */
 	i2c->input_clk = clk_get_rate(i2c->clk);
@@ -1489,7 +1493,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "Cannot claim IRQ\n");
-		goto err_pm_disable;
+		return ret;
 	}
 
 	i2c->singlemaster =
@@ -1510,14 +1514,14 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	ret = xiic_reinit(i2c);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "Cannot xiic_reinit\n");
-		goto err_pm_disable;
+		return ret;
 	}
 
 	/* add i2c adapter to i2c tree */
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret) {
 		xiic_deinit(i2c);
-		goto err_pm_disable;
+		return ret;
 	}
 
 	if (pdata) {
@@ -1529,12 +1533,6 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	dev_dbg(dev, "mmio %08lx irq %d scl clock frequency %d\n",
 		(unsigned long)res->start, irq, i2c->i2c_clk);
 
-	return 0;
-
-err_pm_disable:
-	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
-
 	return ret;
 }
 
@@ -1556,8 +1554,6 @@ static void xiic_i2c_remove(struct platform_device *pdev)
 		xiic_deinit(i2c);
 
 	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
 	pm_runtime_dont_use_autosuspend(dev);
 }
 

-- 
2.52.0


