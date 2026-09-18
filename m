Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D551812F
	for <linux-i2c@vger.kernel.org>; Fri, 18 Sep 2026 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789749909; cv=none; b=qtILj6Yxb2S6iw0sb8ViZdcDXCDnlDZZyYX9CSOz79oVcnwRz55+8S8bRFRYtUqVmCcpJAsOHVdfT1aSQSri9SkEyJtElIkeQ0dDwOBe6+qVNPIjfGfyYDHVPxWqpXhCDrW+hfmRYiJJgc150fyccfFAsqpO2eEIhlmSGqwtfSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789749909; c=relaxed/simple;
	bh=F9Ooew1OnhYj+7+lRP3hdU3cYh095LxNYQoUPVEdLv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ddyll/9XUzMeDp5NOSzFuI48wbJ3wkzR9nz9lQNTNzTQKuBxz5RvyPUG+U1vmwqyQE51uAEr/EZx60bc3inoxWeGQ+HXLxivMESj/B528trEfE5A5gFNdvNOLk2MeTBJkrWknt45GabpVUfPItrmO887aAO8VfvY3S0o/3L2tIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2mus+4O; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2mus+4O"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so8804855ad.0
        for <linux-i2c@vger.kernel.org>; Fri, 18 Sep 2026 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789749908; x=1790354708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BgrE+qMf44HKw8ZKydwe+LbuJjw2yiC2KnJN/ZD6phg=;
        b=c2mus+4OzheKe5TzI3x+uV6xvP7X2hy9U49NByBqW5arnwokLrqqwNs4kQ1q0OOnA4
         MFpL49eY/uR/O09NkFAkjiTZ0XuyajLQIAhOcyoqi2JWKLxfzVNBYVHA33H4NsdzpgDX
         +0yB86PkLPD7w1op4iPtCzgktWe0ab8mLoP86Diglv8YrMSfLkBDun4mWnp5ONQ21YWh
         fz0Z7CnMjFJXJ0wkm9lF7g0KOn9RjhufvSJt0VORWgFPgU2xGHTN3+lg9R9nzQzIxJ9G
         nUeA9z4QxZjs92HYSZWVI4kUvQWaa4/MHxbvh/EWgN/E8EAELjqyftYwecnaId7gayb/
         Fxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789749908; x=1790354708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BgrE+qMf44HKw8ZKydwe+LbuJjw2yiC2KnJN/ZD6phg=;
        b=aVrBGcEDP2i/0yQfQrfz1H2lPt5/jQ21vBjGrLyXTiuj2Afd8LSlwtRkuo1Z/+NsWa
         EWAY+0DfCid4+tfUPfuN5JvBNFiqQVgZH5sn9A4loOQ11Pcl9kKx1z6unQKzZ1Wc33Ss
         VVBZ0sfxz7QWYlq96S231pXeRFSYf+u/CQedOi61EMPD/5cClE3BTAAgNxcPIZAWAssc
         VRfFaxb/a7bBYtz3y5rvrMDz6yFBjcps86fOgB/JDT9F5K5E3BHyXZeBvL4Km5JnehjN
         VRjavmHcwvlc6r5ZHl/0iLN/pbYiAzLp655Mvj1j2iISIVoM3vBbGt4ER4g8ZXkt5qGg
         bW8w==
X-Forwarded-Encrypted: i=1; AKwUvBxMrP8M/vil9jOOgglkto4ank/Rq5xrYhOJBTh+d3NBZSyFjKZdeGY7vBZ0Jeji5M30AH3zwISVExY=@vger.kernel.org
X-Gm-Message-State: AFuF++l/Gw08sWgHjqa/bLFGS/osLZLIbi/E6ELVj8BNJxb1mQev1Hvm
	ckLIFVwAgYwr+o+f1JdlauzGcz/urhzIppifbEkb7KSXXSu885jM+6gZ
X-Gm-Gg: AYBFou1GnWtAUz5tZiFGgTMqTkplMC/B0F7d0HVd+DIqw+eSfLCo3IrHLqwvyURQ9uP
	JzRkYAj+E+1iDt4aGc2kIMRNkNjS/1Ptoos0uONxWhK3a9RiHnqEnBdByZCYCL5I4NzL4GOTOB+
	p/VTbZzZ9EvrtZcgjaezQbQ1Pa0tGWUkf3iJU/ULGEvqvtyfO7vexvL7dbX74qpf0hviCSjZE6M
	XQx5SSIP5jneNdQk0ZKZmVEMx7FgfnoMCr0vJb4J5evGxi2i7o6gR4WYqBzupKH8DaG2G2iK6j0
	fVOI9DdwdHBha7/S3xCGClpPiwEPne1TMc1hPkh22sX46+tiWjFIYULi4GQZu6h/abotbJzUVhR
	SH/YN2lC5OqZ9N64LCzSqirD5iD/ZzWzQPXUa9CPi4B1R4Pi1DUMARUj7U4S0Rvp58b2dAqyQa1
	YCT/MSYPdOR6ZD7lTKUkRem5Pln1QlaU9wZqRLZGJCRNcI0KaIZMlzZlEFbfYXfjVwwtm7MkX9r
	G4M3vEb/3Ac3V/j1zTAqwVavKM=
X-Received: by 2002:a17:90b:2f47:b0:39d:eca2:5c81 with SMTP id 98e67ed59e1d1-39e54b19f9fmr7403518a91.8.1789749907789;
        Fri, 18 Sep 2026 09:45:07 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca86d83sm206717a91.6.2026.09.18.09.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:45:07 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: cadence: fix clk disable/unprepare underflow warning on remove
Date: Fri, 18 Sep 2026 23:45:00 +0700
Message-Id: <20260918164500.2726242-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cdns_i2c_probe() enables id->clk via devm_clk_get_enabled(), which
auto-disables/unprepares it on unbind. Runtime PM autosuspend
separately enables/disables the same clock as the device idles and
wakes. remove() never forces the device back active first -- if it's
runtime-suspended at removal (routine after any idle period, not a
rare race), the devm cleanup then disables an already-disabled clock,
hitting the "already disabled"/"already unprepared" WARN().

i2c-imx.c has the identical shape and already gets this right:
pm_runtime_get_sync() first, balanced with pm_runtime_put_noidle()
before the final disable. Apply the same fix here.

Fixes: 3d36dd1161ca ("i2c: cadence: Simplify using devm_clk_get_enabled()")
Assisted-by: LLM
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/i2c/busses/i2c-cadence.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index da8770182a18..d0919593456b 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -1625,14 +1625,21 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 static void cdns_i2c_remove(struct platform_device *pdev)
 {
 	struct cdns_i2c *id = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
+		dev_err(&pdev->dev, "Failed to resume device (%pe)\n", ERR_PTR(ret));
 
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	i2c_del_adapter(&id->adap);
 	clk_notifier_unregister(id->clk, &id->clk_rate_change_nb);
 	reset_control_assert(id->reset);
+
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 }
 
 /**
-- 
2.25.1

