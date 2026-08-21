Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBED435A9E
	for <linux-i2c@vger.kernel.org>; Fri, 21 Aug 2026 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787353345; cv=none; b=WMHRaIt6cV7dGlAyjvVzehx6QwbIztXX1hnpIwspeilZ+CRsiRXKPzoHTO8V92P2R0ioF50k/o1D3+AtNRCT+Gvknqbt58jTLc3v3k1lE6JRCqyFz7wstkb3t5m9H53j1zQjrs2pvnUHrI131vkIPm7Xpi5VbDWL6KPYq3supv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787353345; c=relaxed/simple;
	bh=DRBZKt4gike5Fxg1DYnXLq9JQ8AI6w1fILnNE9R+e9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHeYbCpDTHZ3qq3zR9aV6TL4yHxro24KI298QFTtv0tOMEG2+Yt6Mzuqneu/MRrkn9iLPiqUTeHBWfi/NA4hM2PhhsBubSMWrynLjeZg22xJKTYQZYzJzxLDd62svKxZm58kqjqvvKJXdO2ZoYsmQDakWmgEONsegQ/M7JBnOIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPnWHPXA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPnWHPXA"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1311015a91.2
        for <linux-i2c@vger.kernel.org>; Fri, 21 Aug 2026 16:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787353343; x=1787958143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ui4fOFF8uuBUtlZPXrK5KtNUrjw0FyZqRoZRSQc80oY=;
        b=KPnWHPXAyKVBuLit74B1EFMyje0ExJESGBiUV1zOnDg2BdTr1sYTWQqq+581lGKWEk
         8qr1kt2vN18hj9aH/E6Ku00s9G+a4zSSl/ZhyhJIVMIIIEbMfGS42W3BHXl3rrvwR4Zr
         Ueg4br1z/nS4f27uaNCiipfTX9Ni0Zrmo4tjz4tnC9Lw1O4pd4SrazReiaQypza0S4eH
         j/jkzg+Mx/JoxaNu8t6sGcFbwekghPbElY2pukrLAWDhpAyMG/f2EJZsJ7PNNGzGAQSM
         f0c3mSeBF1lxPzLkjZvcxO+F6rHohki97NGbwUPdszMtkyEuTMP7ZZqAcWzfnEiz7kdJ
         6G5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787353343; x=1787958143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ui4fOFF8uuBUtlZPXrK5KtNUrjw0FyZqRoZRSQc80oY=;
        b=U3ea4R5E1EBltC8g8zpoymN+P8/ocr4ZBZz99gtHfwAhxufxNdXPJRQciwja/TsxeC
         T2tqCrRmItK+N6dLfFbtfEcxIcjnPh5MB4kEA+2R5Hfl5GSwk7py3wLWMKGGIAqB6Mo7
         hYKhiq3AhNUn4sQiGABg2jSok4GTcQP8B+f9x+nXGZAv5zAMr63zRyERd+lvJaZzLid7
         H4RkpIkmkzqp6qUfvMNHxYUSLYVo9gDZgJYQhyF0UtKSgvaf47ZO7K+qhZnAp+6covhr
         yuUoVpu0EloefP4hSZhqV5Il814XKhoX0AIeGbZGH6o1GNJ5cUdQMmQkZIlLMaPWrS0i
         V8dA==
X-Gm-Message-State: AFuF++lGurbd21U+7xNN2aKCmCXpR/XoG3LkLTiE9I00jPE7KTlHNYTO
	EWpqyXNk3YtJJTcswDXM9DqETh0Y0f6EgBlPCp4stp8vZG5vSUXDPpJlFyWVkg==
X-Gm-Gg: AR+sD118gU26ruKvhh9Vn1pdhorM54X8I5IrHnaR9Y08AQMcxQKStJx8PbQ4KT05Vaf
	TBLYFhUGudEqekTqgDJRPRn7l2FVcBflefNrKOPt/Jb6eSmRl/ngwitwiK9FyBTD6y6hWJ+bpfB
	/J93cbD20KgGiY4pskNEjy5j1D4NBneW7jNw3S5IgQdqFHt4ZW1hdC7pQZmfMzHyczl3Vntai3h
	gutp+CUizC9CrI2VIkEpl34heijEMfQ8D9D4B0JLdY1O8vpGBt1C4uZx2mezzjC/4yj7cJR+WCB
	0H7n6LlvNWBseR/30H8eDYYoqLCPKKHMroIHyWcSAjbMCGLF59rEDOV/G940z7PSADqksl2lQsu
	zxU5O7tGX31pN0eUYb55rGlkwgVzqUa9yD+uMrO897C4gZFKsCPqz2yMBhs2pSESmt2Q3rRYTa1
	TouRVeugm3WIO+K7JahljRnveaH3WzZ9LhKUgsYvdWZi/HAjbXLQPv7p9hqN5mr32JdVqHuNwqF
	7IxHXWOPg4nUaHuh8AqLllhBiKHMNqKwYU/3nNYl0vPjCPT07lHEY6RlQHYSh0b2CPk6Xnppc91
	mPBOuGDOdHMkp5UzY47BdPf4lkVRxeUrULD5Mg==
X-Received: by 2002:a17:90b:1e0d:b0:395:4e0d:bc60 with SMTP id 98e67ed59e1d1-395c354d7ebmr14961191a91.9.1787353343320;
        Fri, 21 Aug 2026 16:02:23 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e49d8b1csm552044a91.11.2026.08.21.16.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:02:22 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] i2c: ibm_iic: use devm for main allocation
Date: Fri, 21 Aug 2026 16:02:16 -0700
Message-ID: <20260821230217.319418-4-rosenp@gmail.com>
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

Allows getting rid of kfree in failure and remove paths.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 2730c8410167..8fc5f314742f 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -690,7 +690,7 @@ static int iic_probe(struct platform_device *ofdev)
 	if (irq < 0)
 		dev_warn(&ofdev->dev, "using polling mode\n");
 
-	dev = kzalloc_obj(*dev);
+	dev = devm_kzalloc(&ofdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
@@ -748,7 +748,6 @@ static int iic_probe(struct platform_device *ofdev)
 		free_irq(dev->irq, dev);
 	}
 
-	kfree(dev);
 	return ret;
 }
 
@@ -765,8 +764,6 @@ static void iic_remove(struct platform_device *ofdev)
 		iic_interrupt_mode(dev, 0);
 		free_irq(dev->irq, dev);
 	}
-
-	kfree(dev);
 }
 
 static const struct of_device_id ibm_iic_match[] = {
-- 
2.55.0

