Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470D275B18
	for <linux-i2c@vger.kernel.org>; Fri, 20 Feb 2026 02:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771555054; cv=none; b=nM7iab5o4KX0fLy9HPJzxNvjjlR6Ed+uRfwApLP+h9Bs0YAOX2FTBgjKBSpJjDtiJC8AcaUkiAoBh9W/6/HbvNMoeFnkLp31n5gFw47f+Ajce2EZf/e32UOEKxZ/4Ub7MhXyzifbAENpqcLtb+cwFtX666gUlgSzrB+5tpga9Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771555054; c=relaxed/simple;
	bh=Qh1O+/Hy5EqX42apOTM83BI3a3fKx5LSf0oHpUWdZac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7vGToS+H60KNc8zAKdC3Bm/+LDGeNuxNPXPmzQvmOp9qXOJ5iKYb/Vo/VEHHa7oWmVM2BO6IB/n55TJe8jp3Q8xeQlxDV8fyzwucdtHYFnM380xtk9WqT06Plc76eDGPCX0BMZ1Zu78NABB4H7c1IhAuiNHq5iaKtB/5iHECPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvsQaCJD; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvsQaCJD"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7980ca83937so9644037b3.1
        for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 18:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771555052; x=1772159852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sOEP9Zt46z3G9LBLEHfRwIqijv/UlQO8bMoi39rKfJo=;
        b=CvsQaCJDz74kaAPQk0wZji6zzw/yZRTj6+KmGh3ptOmEQhshpD2WoHc46cAo/NuOHL
         rE9QQRgmAsxcwdfilBZdshD6rc8az7f6gJxRf6mNE5cQFLYlLSMjZXuuxzJG9XsPXdVR
         eualt7nfuoBtRIlrncVG7lqxCoiJqq4gzOQJEMD5/Iap3spklyLjN759p1vSmec5ZaEm
         u040rx5HSSeWu+AdIzCmaxTU40GwY9ezp1o7Kin5zjJGBG3dcdhoFc22eEAxsJ2YLPgF
         Ll2pem48zIaLz/nDia7QMUuuJst2NAfIYGGRS6jOGl6noocsP+/EF/L2byliOJQZ8e62
         PajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771555052; x=1772159852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOEP9Zt46z3G9LBLEHfRwIqijv/UlQO8bMoi39rKfJo=;
        b=E+amqfC8QNMUTas0LT2qDvzrig74nRtjembJgHzUXDuv43ROPlJwYels3lyZfSVvEY
         q+zPMTVCt9hK88Lu9pjAS1Cc2sBaAfOQoQS4sL60snTE+cQdpMMJ3BReqg9ekEDc7vrN
         pZ2wpni43ILRonjr/j8lDEK7dm6a8ha58HF2M3j0hezZS+sLpzrlUyslArh5BORX2WFE
         2Es7eDTJngT8k5XFWmsDGnx68RLnDX+FFrsZTeEWToxyACFdCYzGGh78F4kARLykDS9z
         ygozpkMOJkmU/P5OJN5wAJ5tp/SxHRI0tjctjwIy9IDTefROWvasTwV1TWv204vJE7/W
         ttNw==
X-Gm-Message-State: AOJu0YzduQBJ1ikJ4IIHMt1XC+5loTVujk639Vc7oF2Zg2dcpxDkP9+N
	fcrWagXwjRay1Mf0MNE2OBvT5kzY1CL2d4gDJahT6Rp87ZLWCwObxE/am1qqJaNQ4Fs=
X-Gm-Gg: AZuq6aIdbFLKLbeQyGPjjOMn57ZN/UA+73vMf9WhQiIx8zZ4bM7TGCGnsx6utqat3Ik
	t27awEKWXwD8QQ77h5nTB+kNVTfipP1yAc6Wb8w7Wb+hHPob9VQKerv147lvRq909arIjditESk
	7i3KUfUm/LIJfPCfZnUrUNlT774bblChi+5wHpwyjyNes/THqrCA98SvzITe3ZJI7rmluEn8ZOB
	uUXy7y0sgZH4yHxTayZfbgdAQGvae7BoWed4O91Np0zVgYK+CevQ5BVGrg11vY54tpG1Ph4pKZ/
	I4P7dWoZSreS+CM/bW08zdmUsvMmd0ol/awADsPuPB36HeiWOpn6/Zp/tSA9/YTSbRpAAYgjJ+E
	d0adgcglpdW1qthUTYUavyEkIyim9QGFp2E0OWhpidqHnLQPElriv++IhiEhQXM6333WQ
X-Received: by 2002:a05:690c:2607:b0:796:6bd5:db44 with SMTP id 00721157ae682-797f71d91f6mr58564107b3.22.1771555051869;
        Thu, 19 Feb 2026 18:37:31 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c18ffc5sm135336077b3.18.2026.02.19.18.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 18:37:31 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] i2c: ibm: use devm to handle resources
Date: Thu, 19 Feb 2026 18:37:13 -0800
Message-ID: <20260220023713.42966-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies the driver slightly.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 6bf45d752ff9..87967088d59d 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -687,18 +687,15 @@ static int iic_probe(struct platform_device *ofdev)
 	const u32 *freq;
 	int ret;
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	dev = devm_kzalloc(&ofdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
 	platform_set_drvdata(ofdev, dev);
 
-	dev->vaddr = of_iomap(np, 0);
-	if (dev->vaddr == NULL) {
-		dev_err(&ofdev->dev, "failed to iomap device\n");
-		ret = -ENXIO;
-		goto error_cleanup;
-	}
+	dev->vaddr = devm_of_iomap(&ofdev->dev, np, 0, NULL);
+	if (dev->vaddr == NULL)
+		return dev_err_probe(&ofdev->dev, -ENXIO, "failed to iomap device\n");
 
 	init_waitqueue_head(&dev->wq);
 
@@ -736,8 +733,8 @@ static int iic_probe(struct platform_device *ofdev)
 	adap->algo = &iic_algo;
 	adap->timeout = HZ;
 
-	ret = i2c_add_adapter(adap);
-	if (ret  < 0)
+	ret = devm_i2c_add_adapter(&ofdev->dev, adap);
+	if (ret < 0)
 		goto error_cleanup;
 
 	dev_info(&ofdev->dev, "using %s mode\n",
@@ -751,10 +748,6 @@ static int iic_probe(struct platform_device *ofdev)
 		free_irq(dev->irq, dev);
 	}
 
-	if (dev->vaddr)
-		iounmap(dev->vaddr);
-
-	kfree(dev);
 	return ret;
 }
 
@@ -765,15 +758,10 @@ static void iic_remove(struct platform_device *ofdev)
 {
 	struct ibm_iic_private *dev = platform_get_drvdata(ofdev);
 
-	i2c_del_adapter(&dev->adap);
-
 	if (dev->irq) {
 		iic_interrupt_mode(dev, 0);
 		free_irq(dev->irq, dev);
 	}
-
-	iounmap(dev->vaddr);
-	kfree(dev);
 }
 
 static const struct of_device_id ibm_iic_match[] = {
-- 
2.53.0

