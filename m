Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC3E41D121
	for <linux-i2c@vger.kernel.org>; Mon, 14 Sep 2026 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377358; cv=none; b=hfP36w0oUADyV9YC1O/mV7htjUSbebFVawwW0Fd/8QRZuB6QzAJ4SoAGFrkgPzeRekux6jA9zXLHh8eMbnWlC+3kho0eDkImYqci+RPO8u020i1KLi6I4w9q1LC2GFpwnL6gKeSlOG/hVJ1dPK+mx+MUvCCAAx/tURvXvnQ0jYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377358; c=relaxed/simple;
	bh=MEXHfGz4HzaBznx53art+ix5nkCHygSVvo4IcvkNi3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geO4quI+MIE6s/634Uue+6bxYBXKMqYxX+uACdg2Jf3uur3Hm89StUcmEE200F8R/BsZjiIPLnVBugqTlz3grlTMt/feWRgJRTgIsvsoZZ2jR+uDdSnMqADpFQT6tT/RBpIyNQbd0E9ImnIWFSVh3gYXmRZuoh+vFsGdCdhIGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRmHgq2X; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRmHgq2X"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-869d181419bso2797874b3a.2
        for <linux-i2c@vger.kernel.org>; Mon, 14 Sep 2026 02:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789377356; x=1789982156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=phiJHwRkepb3+2i8AgNorxLeG3jmpMTw91eiZ14pBcE=;
        b=HRmHgq2X2Z/EGgksdvngFTFse1pON+2eV9Gc9/q8ewPiQfwvTa7DX2O+/bz7iF2Hd1
         eEjYv++yMszZdUD5cvJqpvSGl3vsrDOSxAC+DJqMNrVi59gMlNKZJCURq4m04zEftfue
         EbjJRxWBM8xZ0khbbm4Uib5IHJifQXeB2GgK/BrBO2jWruzHjM63qBNbOxjUqxScaoR0
         39pLUJQJYdjwinNeRAdG93ITFiUxcsZHuYRzNW/c2oBEB8Fkv2IFRrxXSgNlbf98+DIK
         c69jQzR7Cv4E8AYwA4agMhJpxlrY+KpgUTquhNOAd//f3Sb3WEdnI84lmIocNOtTQbCe
         uhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789377356; x=1789982156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=phiJHwRkepb3+2i8AgNorxLeG3jmpMTw91eiZ14pBcE=;
        b=C7J9YO4y8IEafcnAfLbEovIuh3AZnuYK2wV+FqQ+83nizbR7orFde5cAc2VLipqgOO
         5YL2AVcxH0Lpr1ZFqIFjNri5GNAibB8D40VbQkChQzej6yTMRYKfEiXZzLnCDdFhoKcr
         M9i6zb4V486AmNjkZqVxBn8AfXOMLPz3VS4PQ1YIMOCE+FPS69E5dSqgVAC2xy8xnJz+
         uOk3QqR4VuoUiQlR/QpWMs5gWSzPc5CCHjcVNP4eAvGjRNegac5xPOhlRwReW7cOUjXd
         dwIZ1ISE/aDiEJ4DLHZnUYdi5CpBNNFSaNMV3t1/j2m3Xqqn4LEc4aDe0knZR+1dobrw
         a+SA==
X-Forwarded-Encrypted: i=1; AKwUvBxOijsbZQDfqGQra6i74DeNocuJA1++I0hCEu5jA07yIPP1NCpvBhTUY7G4FbPayunmND6zmoT6V+Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lV1mVrPt+Savo56J+fFkgc+Jadn2Zy5dsCugMU3zBbFdv3+QqB
	SabYWK2C0TZFSVmTc3q5Fjfbq+uLlbbEQYyT8UFegXgdawQQ+f/l8yJw
X-Gm-Gg: AYBFou3G+/HP1SK3aUHLxuU6mja7Dy5VrCBqxuc0c7JpSgj3DbAeHWeMaunqqHUtu2n
	Zph6qn1eoBdBvQuoUGd9doAveGbi1wyHqxV4CQzUA60dAg6dPtnsBmsSvuSnVAgRBTYTiu+a5as
	WSHgMPG4JANIJb6hi6NP7ynZsdxFUm72biAPLG6rEjzy9ryo6lNrppNdd0OII7YBUmusbBDnAuJ
	9RvyuBWLtxHJt35DvUHM18ZL6YLFgHaMM9dEr1et3Bl/Dju96LO9FSfWk8AHl95YgJn0xpWJLLN
	Ve9w85WUrEwbopAsMaLmnj2mwRuUNmATIPCiUVbfPeO9xtggO5zBU5cVT/p7xaAnnOzBt6fNuPB
	0xu4/y0aKUYbNnwHQuj4fFCY5U6EpvSS/pI0OQGJVYKW+gdr+f/22kl3pYsfKEe/RLvgL7NQaFs
	otst8gZAnPZGstmYbHJMBQjqxnQ04i2C+3aWp3Zupb+OoOI67sUcc2hg==
X-Received: by 2002:a05:6a00:4288:b0:845:c694:5c3d with SMTP id d2e1a72fcca58-86f83346552mr3922964b3a.1.1789377355574;
        Mon, 14 Sep 2026 02:15:55 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b287c0762sm4480614b3a.13.2026.09.14.02.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:15:55 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Gao Pan <b54642@freescale.com>,
	Fugang Duan <B38611@freescale.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: imx: disable autosuspend on remove
Date: Mon, 14 Sep 2026 17:15:44 +0800
Message-ID: <20260914091544.1667137-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2c_imx_probe() enables runtime PM autosuspend with
pm_runtime_use_autosuspend(). The probe error path correctly undoes
this setting with pm_runtime_dont_use_autosuspend(), but the normal
remove path only disables runtime PM.

The runtime PM API requires pm_runtime_use_autosuspend() to be undone
with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
was enabled with devm_pm_runtime_enable(). Leaving the autosuspend flag
set therefore leaves the runtime PM state incompletely cleaned up after
the driver is unbound.

Add the missing pm_runtime_dont_use_autosuspend() call to the remove
path.

This issue was found by manual code inspection.

Fixes: 588eb93ea49f ("i2c: imx: add runtime pm support to improve the performance")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 19ec056b00af..4dc3df6a41a4 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1920,6 +1920,7 @@ static void i2c_imx_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
 static int i2c_imx_runtime_suspend(struct device *dev)
-- 
2.43.0

