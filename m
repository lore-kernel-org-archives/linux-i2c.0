Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F413433054
	for <linux-i2c@vger.kernel.org>; Fri, 21 Aug 2026 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787353342; cv=none; b=mmJd3RKUA4RfXMZkfl4Zp88WFHN30e1r5kDFDOsCb61pB0LAcIuJiyoV8PwTPbtxH5CFH2KctACmo2Hsg7CyW7K/SqOORckIZnywoHgrbTO99dGjDCwGWQn5Fb9wEw8dYZlsO7pnSpOHWocSJHmgMKrqOTYG9b8YWCaggpq/5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787353342; c=relaxed/simple;
	bh=zEuLCi59FgV6WCQuPZcABSe4ao+KrlKHHo3HZvY3YY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DF/Q5tkTAKAnGni4rGVVQidsEWfcjDsk83Zd9ZIDl7nWJ7yO31mba4jhLRPY4WTnmUq+110srBtG4/8+ZhaGfxPEA8+qjoGavaqhMV63NBSo4XJHtTtoRnCCKj5IBwGNKEAv6XbpyRW7c1wkrgxNDa8jdFmHbVV83PI+W97ukSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbVLIclG; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbVLIclG"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-395bbae578fso1296514a91.1
        for <linux-i2c@vger.kernel.org>; Fri, 21 Aug 2026 16:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787353340; x=1787958140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L4K6nlhSQEP7UWfmOQMCFoOr9zDgXdEDG0G8EbGfjZc=;
        b=EbVLIclGRwex0wSmZ2Kc/ApnQNeJrQlRsfkfJecq23U07vkP1xh8q6AbVM2uX2dMyv
         WsCLYGVLVuB7n4Bg6qgZ0xNMxwv/LTErqk98fAVFDLyYcQ5KBgdj7EqE267F1v0RMVh4
         QGkYS33CKE2K3hxY2kNRVlb6maRWGgo7D8txa5tvtLEK9sKPHOyt/IcXlNSiJi0qqoyA
         YI6RW0k3bCVZ6Fo3z0IkVBfS3BuxW+ms4oMQN1Zx7/UTlKLZmY35tV6d98b42JFS7Dji
         +ouWp6k1hH0sFnhR+QtgGs+Ah/6fT0a2BOkedYP8jqGMWpANARyB9xf5O6BwHSN2uqov
         gMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787353340; x=1787958140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L4K6nlhSQEP7UWfmOQMCFoOr9zDgXdEDG0G8EbGfjZc=;
        b=gsjMITXRIMlyx2n5hskNfOykP+5+bd6zIi9mMTAdg38O8P4WAZnbBuDvIl2ZhHLKKM
         hON4Z1igUH+UBu5PNsJYv0qyf6gJYcYD8lTqG5HmKQE/YI30Bkfr8C1O5HwhS9xMqfuw
         JQF6CulAukssFBdRCoAj8SSrVLBSSiDWLZI9+M/+zboe2ZyuHDzvjkgH0XIQGqE9IdfT
         kzkA6B8BZZd6amkke/zH3/eAM9Ch5NEGEbzJjM3qHhORKRdbcPVNdXWAnwU3DnojSxJX
         p0GtQXmvDeGJr3+X1ynBFZ2DsT4Dx9/UCMlpvtrxb0/o+axDnFHU01ZNVrFLtm0aiwwx
         Xusg==
X-Gm-Message-State: AFuF++m+1gbkCmL4Vj5IfLn9zodU9ngNB0NchjCahppTPw2NLHC6BNQS
	f/ZFu7y96iQcCiX2X7EzrpOjFOPH+dp65hfsNWeuK98I1k4YXEKMiP4Lg0wnUg==
X-Gm-Gg: AR+sD13Oxkhye2ixqJWPzxl+6fCr/HIDuAKUBQX+V9M5plnYUDZZlzGXycv45xn6FTr
	YrsrZnVkCLg10yU01s0LOAY2jpOJUKvT13F2kX6SP4+Gr5oJv0hbuTDX8mG59g/uP7h4dXIQfpS
	z/SOWvUkFvY9DxCTWpWUk7Cdd5rUHq88/EPdvdEVbBg1pTBo/gXmmBC2fd0r4/Xw+Eb/dG7MTbV
	7ya0Vb03sfZ848ZAgnbXkTZXhiLUCw1g4sSgNtXUSW86o9UREdkePG7lh4mWxve3vQqqN18fxYw
	9mmCHAe+DqpGHTlcGuH8pnjKTrCPu8d0VxeR8UcWmJBV1b1EE9JMbElTSKfhhsZGloFoI6Sx4Ie
	oCLnSNic7aVy5hO53PZv5o9IH5ZEucJfSUAkGkaPDQnY6JpFsKo6yGYJlmJGKja0Si27lygS+Vj
	tSzSgN9M5+3uughqy0G64e9gZEiJd0gOIjtr2I8/NkisF5kgZV/r7iFtZhOovV+JEoD0bTghpG3
	nOx/PlA5aFmg5HoWL35/2HGEeAIycZ+gnWFgvRZH9y7t/ZuVPsyeTKOV4xDDNqixB6GG64XLN9f
	zKbZcooCHdsilr0kg6UH5UaN6sh9XiXU4Uxcwg==
X-Received: by 2002:a17:90a:f945:b0:38f:aab1:5148 with SMTP id 98e67ed59e1d1-395c35b75efmr17088863a91.13.1787353340351;
        Fri, 21 Aug 2026 16:02:20 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e49d8b1csm552044a91.11.2026.08.21.16.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:02:19 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] i2c: ibm_iic: ioremap with platform pointer
Date: Fri, 21 Aug 2026 16:02:14 -0700
Message-ID: <20260821230217.319418-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821230217.319418-1-rosenp@gmail.com>
References: <20260821230217.319418-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_platform_ioremap_resource only needs a platform_device pointer and
calling it early allows handling potential -EPROBE_DEFER.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 7c70e8bda24e..043cb64a2544 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -684,21 +684,21 @@ static int iic_probe(struct platform_device *ofdev)
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
 
@@ -751,9 +751,6 @@ static int iic_probe(struct platform_device *ofdev)
 		free_irq(dev->irq, dev);
 	}
 
-	if (dev->vaddr)
-		iounmap(dev->vaddr);
-
 	kfree(dev);
 	return ret;
 }
@@ -772,7 +769,6 @@ static void iic_remove(struct platform_device *ofdev)
 		free_irq(dev->irq, dev);
 	}
 
-	iounmap(dev->vaddr);
 	kfree(dev);
 }
 
-- 
2.55.0

