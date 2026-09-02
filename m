Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34A4AD7DC
	for <linux-i2c@vger.kernel.org>; Wed,  2 Sep 2026 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384312; cv=none; b=cgW+6l6PG35R0of/f5E2WYErF3TbQf7+VSicUpAVYsYfU3Vb2evErqVMBPEpRqXTMnFWq47tUbl7JcQBorQ1GOGqZPig/QAdjcomywJiaUvNadgoqi5AJTlDE+VpWz3zSg0583QTeENEPsXgIXZfV3ASqAr4O1/3LhcfVt1EBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384312; c=relaxed/simple;
	bh=q9SAIJUr87M37a1nD9qzZab/gM5Ib5Ik8xsr+y/h9ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edHOpSCf9BaAKXscU7kj11IPnKjmi87jF6q/atWsoNB3sj9fbnAdNUKe6uNP/PunyR8SO2CPORm/KKGpenvpDnXQy1mnnk3HRMPio01oFfpRWp+bLkZhVUmYFsq0UTSlTIcE5e3kPwWLksMBqGhLQGu0p8o4pERNYGc86ugt/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBcjtfLp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBcjtfLp"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso1298636b3a.0
        for <linux-i2c@vger.kernel.org>; Wed, 02 Sep 2026 14:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788384301; x=1788989101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rGaS9rMCdfAhEqnXYmIjGA+bHQqtxuQ5ZcfYKFa0ZgI=;
        b=XBcjtfLpZxcpsZfEo/CtsE4o7q0y5V/edJMkwkaCEJdUvkEOQmOmObGeK2HEP0HMEH
         VTmfYr4frVZJZSjAuNBjPDT0aVSiFGaz5awYvLiEb4YPssgRddg1CasQlbodwF1cSYOS
         gBPAcjlHHPqNUqEZpeZL4ScV71LCYFrEVtRxWHiti6ooLeCozAMsX/mG1+/cWea9pfqx
         3AwMG3AQ8HznZVOGR0fgDU6KqP7u4KTDlmGvEA5I8KWK8eezGcxbmffBoDvCHHBA7uEl
         Ywu6ZcVCHOyLaJSqKV8eUv95gUNzC5JI4cxA7SnD5SMLuj2XNRC3FZxoRdabo7W3VOfp
         U+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788384301; x=1788989101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rGaS9rMCdfAhEqnXYmIjGA+bHQqtxuQ5ZcfYKFa0ZgI=;
        b=rm1lffm3ekuurieD9DS58HAXc4ED5+p7a7eQkZRD0rWY7kourQjRoCWjVh0n/rhgo+
         rj7jXwjmh8vTxOf6as6purKh3h59kp9wu1mRcXeZK9owdoM8TmYUrDX3jUnf1ZAsvntA
         Rok4UqtUZMuSi+saXtulZmrcBxJcEmkzLGy3wqIg+r1S3lrDrmRvR0WKsKLRuC+Gb8G9
         zDXG4Wg/Urksf3Dm6IWuAY+CcosDZZGNyfwBC98wrf/7uWmnLRfGOX6vVUfKpdmWa0lp
         MjzacUY9VQbueJUOmo5wNrqJD2yreB8mOp920VVKNpmxZuh84khw/FkyudXLP7i+M59E
         ikfA==
X-Gm-Message-State: AFuF++lDyuFKG03ZTqrgV9Ysgcz0kDWe/oCybdpqqneN25q8nG7C6Cns
	DdVPTzAWYxpcFct53wx5Fx8d7Uuzc1aGFTUev5oyMP5Zfw1suzUzEBD+N0zTdw==
X-Gm-Gg: AYBFou1+4ZnkjhauLzHebeBXxsa+xr3kIekymipvv0umxLGlBdUKNBqUjM0i3xv7bqD
	vIlosrsNhQ2T0O4kD8b+TQhUymLBJPC2XploCpuXI3ULxfILf3T54exJE9e2svsIC2k+DRpOmd0
	LdKBqFV+RYiBTsbav8uyP2P0QYzrgYA1CPUFbmO/X1BOdfq+or+qDnfwpXc7Hv7H7/DrC9jPqN0
	pvDxAEJYP3Iba41fzN/ePrr3VWaQ7lfs7pirQtiYJpST3H1/sEY1at5ZhNTs1mQ+ffgeEG16dga
	6NCmqRoPaUvJTtsDvAxvblRWevN2sW3/b4unBHau13uoDfLFLy6MuzYFCaYmPzFUEfUUuvd29a6
	61DFyukn+swGzaYfDbppT/3ujWIMBoUnrzTXwmmKlAYClaM0sXTfEzzEwLptXpAJRElY/WIJHRT
	k6qWB4I3aad6BDXV4/LrgjuEBLtaJOJQVBJF39UMgzmdXxDwwu0xL43vz80QQnJqytwUGEHc+Wq
	7XxEJzviOz+pdvfUY8mGRzGjxYG/SLG4oKlds2nONXleDwFOVEz9ibKPy2vSZ2e55/cul1+Vc/B
	0ZIdhysMMEgQeIpuTzudNpxXxsGURvFkvQffzw==
X-Received: by 2002:a05:6a00:1784:b0:857:7384:b5f7 with SMTP id d2e1a72fcca58-85ed4640c6dmr10398979b3a.19.1788384301297;
        Wed, 02 Sep 2026 14:25:01 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc43d40c55fsm90890a12.19.2026.09.02.14.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:25:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 1/3] i2c: ibm_iic: ioremap with platform pointer
Date: Wed,  2 Sep 2026 14:24:54 -0700
Message-ID: <20260902212456.289608-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902212456.289608-1-rosenp@gmail.com>
References: <20260902212456.289608-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_platform_ioremap_resource() as it only needs a
platform_device pointer. Call it early to avoid allocation of the main
struct and to avoid having to use goto.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 7c70e8bda24e..20421ebe73ab 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -38,7 +38,6 @@
 #include <linux/io.h>
 #include <linux/i2c.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 
@@ -684,21 +683,21 @@ static int iic_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct ibm_iic_private *dev;
 	struct i2c_adapter *adap;
+	void __iomem *vaddr;
 	const u32 *freq;
 	int ret;
 
+	vaddr = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(vaddr))
+		return PTR_ERR(vaddr);
+
 	dev = kzalloc_obj(*dev);
 	if (!dev)
 		return -ENOMEM;
 
 	platform_set_drvdata(ofdev, dev);
 
-	dev->vaddr = of_iomap(np, 0);
-	if (dev->vaddr == NULL) {
-		dev_err(&ofdev->dev, "failed to iomap device\n");
-		ret = -ENXIO;
-		goto error_cleanup;
-	}
+	dev->vaddr = vaddr;
 
 	init_waitqueue_head(&dev->wq);
 
@@ -751,9 +750,6 @@ static int iic_probe(struct platform_device *ofdev)
 		free_irq(dev->irq, dev);
 	}
 
-	if (dev->vaddr)
-		iounmap(dev->vaddr);
-
 	kfree(dev);
 	return ret;
 }
@@ -772,7 +768,6 @@ static void iic_remove(struct platform_device *ofdev)
 		free_irq(dev->irq, dev);
 	}
 
-	iounmap(dev->vaddr);
 	kfree(dev);
 }
 
-- 
2.55.0

