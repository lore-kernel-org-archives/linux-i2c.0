Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99A93B6BFA
	for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217337; cv=none; b=akDSdDon9J59v1HDrJreNlCq23V3pc8+FPxlDLS/O01s5nrygel+dEM2EK8JNHr1RZTbkBHz61e4TeMrJZMRTGtGC/XRH8jb7ytL1Qx6qx3MBvoTlZfgdfNwwCctd0EVU8L+4kpkCsl96GMqrwe0czyplqqJD7LKqjvBLj/K3m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217337; c=relaxed/simple;
	bh=N5oUkVAnlldkOMa+HOB/L+pX+Q9E6BJX1NqPm9wbE5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4RltkgqH15bpeRarsFss0RsgaMUTtme9gv6dCekUvLnyaxn3BlSejgj3ScLd0XsYcZxVRyXoWmmHWnKCvnIRkRJVW3Vuy2spwDVt+lu4sZKLGtEz7YyB/xB4h8vWG+AZvg0Su2rZK0nFlZk/lmnrp+RcuY5MZ2G7fKn6dUEc0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCIwgciL; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCIwgciL"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-cbb818e57c9so905457a12.0
        for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787217332; x=1787822132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y1kOOBqdadqKd7sMsBzk2riCQDzvapQr8MFQipboziI=;
        b=tCIwgciLz57yp5RUCg36NiLf8Vd9qYdo+xhbfD12wyLrejpOcwdqceXtYlW7NNX3st
         8UthJKoTt3ilhyAug9wWTsQk5EziKsuSEDnCLvUQtlZeAElJ/b6Om3pehFLQvZBa5jMx
         iVNjl/nsAzy6JYawAADKRAZrXj+pGHBZUHgoJXwvDKBI/oOE9yVVTJjw1xF8OnGk1qZK
         QO8mQ13Vw5hCHZ1TFNBVsiswfm7s1PILoOeP2un6uXnMxLjUtDpYu7Lky59pHby1ZgWM
         ibWDUi5C1mc6mTpILKcsmhnv6ZPcN/+EK3vI6mxq5dxPZYGh/9vB6xdx5gATCrIyA6Rl
         v04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217332; x=1787822132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y1kOOBqdadqKd7sMsBzk2riCQDzvapQr8MFQipboziI=;
        b=k1lRj9ot4Xf9yenWb7JSpQwRsWyhksUUSaNbuIYfvEtAVSpCANTzDEN0WRtt5YFRwc
         61q6twhRMhj29WbQxDrXcKgj71AOKC+xpMuedptYBnhTzfwp57uN5Y5YaXlz1s4To/RK
         cjr2A4JUmKnEElfhVzGkSZotSz4v9jZ1IJkEktUbJvflmqauhrxSU8g53dTh/+tRPOJg
         ShWp/Ys73VlkVpetFq5hmL7fVuTwL130OhGrznSo0BpbxFoaYtJUgGYk3+G1tNFXBMb7
         ktHXqN57/1CTaO4cpBs9/VphSOIe+1vrvyqwE0gfiqyCuRfOhYP5lhzv+Mu8MaMiZlHH
         0tSA==
X-Forwarded-Encrypted: i=1; AHgh+RpY84uMHhwYS0lH1pAqbfM8TZF7XRoCxKEZbW0FsZC18IYQztewgctnd/wzs6oLkSUBhAuCC2cUyUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtLvsSY8/nxwRmrBds4E/OzCr4ldjSwu31q9FcuHyQTqRoOypC
	8DSZfwN/sTSKyOl60x9H+CQOEHedSRQd35AZEjyrYeoF1IQgAa7QSFE=
X-Gm-Gg: AR+sD13lOKIZlUhcbRTkCddovGKfCbm9AQD/vuAaRhjlLV1e2eH0ZtSjXqamhvrj2Ux
	Nk4bDEQRaO9F3Nx9kF9s/01y2law+Y0mVbDrpQ5QQ053pu8X20H3cJE7yBwkQzsrl6hWhEKVvAo
	uxiCnLVUO+MUb4tiA5A2+4jInahN7IPuOl/9jsATSWY1D50YKEFqe6OnIz1lwBcySkkkWWITNlj
	nkXzgCdmuuuzRPhvALNx2P2kCxhNaMFtEjLGW96nJmkZZN3KFhJ1Wb/rerSQAFtXMkDYYol8Ukl
	sJs/v8wIohosi/7qYZK9rsXFWPODt3VpBVWetMCp3i8J9NOEojKNnXzOJ4/F5+nJCcahgnTICE3
	WcUefczGSzCfSkweHNKxTZc4x1eL2ktDkzhl0f7shk2BsG6Tyo7tqZGUF3H6MpFkvH76M/zTMai
	oZkEuGUJTpCEsnNJMrNcPHKDuptJEPniMuxwrHrL8XwjYfDZFe6zgkTYHyVCu30pC+PlX0Bg7UM
	w==
X-Received: by 2002:a05:6a00:2305:b0:84f:dc19:b77d with SMTP id d2e1a72fcca58-851d3953250mr18184469b3a.12.1787217332306;
        Thu, 20 Aug 2026 02:15:32 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3617434sm1431016b3a.29.2026.08.20.02.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:15:31 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: andi.shyti@kernel.org
Cc: chris.packham@alliedtelesis.co.nz,
	heiko@sntech.de,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] i2c: busses: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Thu, 20 Aug 2026 16:15:27 +0700
Message-ID: <20260820091527.2118302-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the deprecated SIMPLE_DEV_PM_OPS
to DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from its suspend and
resume callbacks, and reduces kernel size in case CONFIG_PM or
CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/i2c/busses/i2c-eg20t.c | 8 ++++----
 drivers/i2c/busses/i2c-mpc.c   | 8 ++++----
 drivers/i2c/busses/i2c-rk3x.c  | 6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 8c67ab4f2aad..405229cf8f1d 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -829,7 +829,7 @@ static void pch_i2c_remove(struct pci_dev *pdev)
 	kfree(adap_info);
 }
 
-static int __maybe_unused pch_i2c_suspend(struct device *dev)
+static int pch_i2c_suspend(struct device *dev)
 {
 	int i;
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -857,7 +857,7 @@ static int __maybe_unused pch_i2c_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused pch_i2c_resume(struct device *dev)
+static int pch_i2c_resume(struct device *dev)
 {
 	int i;
 	struct adapter_info *adap_info = dev_get_drvdata(dev);
@@ -870,14 +870,14 @@ static int __maybe_unused pch_i2c_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(pch_i2c_pm_ops, pch_i2c_suspend, pch_i2c_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(pch_i2c_pm_ops, pch_i2c_suspend, pch_i2c_resume);
 
 static struct pci_driver pch_pcidriver = {
 	.name = KBUILD_MODNAME,
 	.id_table = pch_pcidev_id,
 	.probe = pch_i2c_probe,
 	.remove = pch_i2c_remove,
-	.driver.pm = &pch_i2c_pm_ops,
+	.driver.pm = pm_sleep_ptr(&pch_i2c_pm_ops),
 };
 
 module_pci_driver(pch_pcidriver);
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index a21fa45bd64c..fc7bc0ddbeee 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -880,7 +880,7 @@ static void fsl_i2c_remove(struct platform_device *op)
 	i2c_del_adapter(&i2c->adap);
 };
 
-static int __maybe_unused mpc_i2c_suspend(struct device *dev)
+static int mpc_i2c_suspend(struct device *dev)
 {
 	struct mpc_i2c *i2c = dev_get_drvdata(dev);
 
@@ -890,7 +890,7 @@ static int __maybe_unused mpc_i2c_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mpc_i2c_resume(struct device *dev)
+static int mpc_i2c_resume(struct device *dev)
 {
 	struct mpc_i2c *i2c = dev_get_drvdata(dev);
 
@@ -899,7 +899,7 @@ static int __maybe_unused mpc_i2c_resume(struct device *dev)
 
 	return 0;
 }
-static SIMPLE_DEV_PM_OPS(mpc_i2c_pm_ops, mpc_i2c_suspend, mpc_i2c_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(mpc_i2c_pm_ops, mpc_i2c_suspend, mpc_i2c_resume);
 
 static const struct mpc_i2c_data mpc_i2c_data_512x = {
 	.setup = mpc_i2c_setup_512x,
@@ -942,7 +942,7 @@ static struct platform_driver mpc_i2c_driver = {
 	.driver = {
 		.name = "mpc-i2c",
 		.of_match_table = mpc_i2c_of_match,
-		.pm = &mpc_i2c_pm_ops,
+		.pm = pm_sleep_ptr(&mpc_i2c_pm_ops),
 	},
 };
 
diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index fcede9f6ed54..878bf42c4d73 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -1145,7 +1145,7 @@ static int rk3x_i2c_xfer_polling(struct i2c_adapter *adap,
 	return rk3x_i2c_xfer_common(adap, msgs, num, true);
 }
 
-static __maybe_unused int rk3x_i2c_resume(struct device *dev)
+static int rk3x_i2c_resume(struct device *dev)
 {
 	struct rk3x_i2c *i2c = dev_get_drvdata(dev);
 
@@ -1394,7 +1394,7 @@ static void rk3x_i2c_remove(struct platform_device *pdev)
 	clk_unprepare(i2c->clk);
 }
 
-static SIMPLE_DEV_PM_OPS(rk3x_i2c_pm_ops, NULL, rk3x_i2c_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(rk3x_i2c_pm_ops, NULL, rk3x_i2c_resume);
 
 static struct platform_driver rk3x_i2c_driver = {
 	.probe   = rk3x_i2c_probe,
@@ -1402,7 +1402,7 @@ static struct platform_driver rk3x_i2c_driver = {
 	.driver  = {
 		.name  = "rk3x-i2c",
 		.of_match_table = rk3x_i2c_match,
-		.pm = &rk3x_i2c_pm_ops,
+		.pm = pm_sleep_ptr(&rk3x_i2c_pm_ops),
 	},
 };
 
-- 
2.53.0

