Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C839367282
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067321; cv=none; b=pDMpk3ou0oJkmwwEZ1xIPrJY+LjDpxVq2A18Y+PVEFVZ0X49PL9xZCuXzvbMkgJUaAJw5O4MI4sHAMB3cQbMjdkd2IMOGqeDMz+Bl+wCRpUt+kWkD3z66a+euSU0Ksy8pbNV4Iipz4rCF2hLGGRTaqtTKF5/q4Vx/kOedQLMwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067321; c=relaxed/simple;
	bh=g80eYQhKz7g1873uZRKJPXvkY5aQW0Hozvxpfa+GqI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VRstey5N/4awdcqgNXyyiDB3gWlC0Zc7vZPIj/h8p0FFPsKsWJvNeTU6dl7Y4B/VO8aSAkrkqmecYB+oIScA3WpDQkSBMdDcyEblm7z3ydriSSXZzElrCvKI3AA/NVeCXBdsMjBSW6a1d1ifxd99tcIwBrioGL0eqHOtitiS29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=OrLRO2jT; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="OrLRO2jT"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso1183400a91.1
        for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 08:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1787067319; x=1787672119; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BJxkO70MopchWEw+ENjoFGNji5+cFc80kc/rYib2sLU=;
        b=OrLRO2jT8U852CVEtjEgo8mUEsDcTIWl5yCLPfQxC5qLldebq4ow+0hrPmt2rY2nem
         kHc1BBmCT3YoHX6v5nqkW14htoHZZhAcPYeaOtaNKsbYv+0zH82aPqX1HJgJ9bzQo/tD
         f7be2d+5+MC6+LtxzEc3mtapPHuwMM1cl/ge+HQpiBQsHaozLdG8ks34ROsl/4Nb3Hc9
         0yKK9D2nDUzkUhUmRqHNeBoRDu9okP+llnZ62gaZ5kCNekIMfXAvlbNaswL0KuMLj6UX
         owghh23MEXDlkyeC86iv7wXAnsYtKyuoyLftpvSRX/9gAFctIL9enPpf0OBYfrntjGu0
         DErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787067319; x=1787672119;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BJxkO70MopchWEw+ENjoFGNji5+cFc80kc/rYib2sLU=;
        b=gSDb1CKYN2yKr/9MZhEH7CXccTjWYQ8d5Xxxeyq+5SBl6n/eFeW/UhGy6JwCCiTNe1
         +cTz3jO4goSUhaN03c14fyGiChzbtxYByo8YJzePXmQ2p7HXm8VOLqP7j8y+YO8C2yLF
         wsj66d5l9nyNIPMTtWk/d0bORgXgfnNn3Nuq3sSE+Gtvnp57gnvDRWABgEtNgl3H3q2n
         8C60dCJMc8uew0WGPHcpB0nirhQo6o5aB+mo0vh8QDZW7nStzxzFe7DqePuY/CPqykh8
         yY9ennDtoPWW5WcI5VlN5A0ffXHmmPABDFJosVRYtijph8BDSqkGwCjT6CqLaffQLNDs
         thNQ==
X-Forwarded-Encrypted: i=1; AHgh+RrUwxJYyi3PW4BLD6sGgHAhlpGPhTWGA0xnU5JOmrQgfAKUpED7ZeJkowDZqfcj8eiYQAOx9cgZLIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3jc1PQXqE9x3A3ULB/AW8HN1N1ehrc3deM4+l9vzMW3wfnfbd
	CUg31vaF+nKvq60khlPDG2vUg3i4D8xJhGicszFaFzLUS7mtULmzkhEdwz0mC3h+eWQ=
X-Gm-Gg: AR+sD10zXdzbckUJwR37EZKQa/XtXlxCpP1Ik2fSwHib4VXwcrJ5l+wfe+q8Gw+lzrm
	9S1xmJCZrSUQFIIPZp1L5336AQKUB6KAMp2pyxdEerXgz8tOG/9PbWs8xcM64j4hlivRIx6uV0w
	rCrPxe4Ifm38+nNYG2O0q6M+XzUf7z2Vas5u6ZK4KQQgLsGab8Ba4ZIhQ86gJFV2Id5wOy4tEHB
	LV8WLRZgvFLla3daph95r3G5OxO9mg4lVVwCjh/shi3TlkKxau8iHr3tF83MIAzdse9PTbS71ac
	Cg3oLfIC67H0YUsjaPhA6aN9J2f04XrBYrnI2JNaIBzSnJtu2AKuDc+mgU7XzjLATXlR4/vGskV
	lhKnhAHPITT7r5/kyEaIoishXpPv82alx/dbgaJXqjkjL7z0FSyUZfD7Tt/bv25is7UXltyzn6Y
	w84ByHnrGf57crPWEkVr7refZU9pnK5M3tJ9priggeCYUJOU2a4xdElCIXzgBuJr4=
X-Received: by 2002:a17:90b:5404:b0:380:8bb9:aba9 with SMTP id 98e67ed59e1d1-3955f0c0364mr8515980a91.3.1787067313991;
        Tue, 18 Aug 2026 08:35:13 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1415315900csm18033268c88.11.2026.08.18.08.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:35:13 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Tue, 18 Aug 2026 08:35:10 -0700
Subject: [PATCH v3] i2c: xiic: restore non-managed runtime PM to fix clk
 WARN flood
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-i2c-xiic-restore-runtime-pm-teardown-v3-1-5fd315b078e1@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XOsQ7CMAwE0F9BmTFyXKDAxH8ghjRxqZFIqySUI
 tR/p4EFNhhPOr27h4ochKPazR4qcC9RWj+FYj5TtjH+xCBuyoqQ1rjRBQhZGEQsBI6pDQzh6pN
 cGLoLJDbBtTcPzqGptKvIIqmJ6gLXMrxmDsd3jtfqzDZlOzcaydr99aPXuffnZK9BA3Lp6opwX
 W5x73lITdstjKi82dOnuvxRpUktDa8c2gLrmr7UcRyfG8Vws0EBAAA=
X-Change-ID: 20260813-i2c-xiic-restore-runtime-pm-teardown-dd0ab1db2c02
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787067313; l=4647;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=g80eYQhKz7g1873uZRKJPXvkY5aQW0Hozvxpfa+GqI0=;
 b=Po0ZSxvDkegPgxo3O3Ziz9EKRCqbDqeHczclmEEE6BlxsYDrLbtWrdfc504VO8Q8rITosSdtl
 ixHRWZAL3/7C7Z2FhAFcUAV8ePng7/wTwvC8EpSzojnY5swq2dPjTtW
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

Fixes: 50c63491ff26 ("i2c: xiic: switch to devres managed APIs")
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
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
 drivers/i2c/busses/i2c-xiic.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 3e7735e1dae0..85f3c322b1a2 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1475,9 +1475,13 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 
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
@@ -1489,7 +1493,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, irq, NULL, xiic_process,
 					IRQF_ONESHOT, pdev->name, i2c);
 	if (ret)
-		return ret;
+		goto err_pm_disable;
 
 	i2c->singlemaster = device_property_read_bool(dev, "single-master");
 
@@ -1506,14 +1510,16 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 		i2c->endianness = BIG;
 
 	ret = xiic_reinit(i2c);
-	if (ret)
-		return dev_err_probe(dev, ret, "Cannot xiic_reinit\n");
+	if (ret) {
+		dev_err_probe(dev, ret, "Cannot xiic_reinit\n");
+		goto err_pm_disable;
+	}
 
 	/* add i2c adapter to i2c tree */
 	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret) {
 		xiic_deinit(i2c);
-		return ret;
+		goto err_pm_disable;
 	}
 
 	if (pdata) {
@@ -1526,6 +1532,12 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 		res, irq, i2c->i2c_clk);
 
 	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+
+	return ret;
 }
 
 static void xiic_i2c_remove(struct platform_device *pdev)
@@ -1545,6 +1557,9 @@ static void xiic_i2c_remove(struct platform_device *pdev)
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

