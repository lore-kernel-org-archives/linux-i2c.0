Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0C434E47
	for <linux-i2c@vger.kernel.org>; Fri, 21 Aug 2026 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787353343; cv=none; b=sXMy7ubRj1wzjIo7blBbK5iR4bF0kRz+bcTMzf3IzjtRjU9b0HNrcbnt8tbf2YJuIgZbI0zRRO5Pnh030OQDk+53Wc3hwN6sj5g361vR5Jo0uGIVMKAjKdil2fk+l6/2Vl0H/JY/WVNU5e4UVawvlQJMGGEl3WIowRrTMF9IbXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787353343; c=relaxed/simple;
	bh=E6Jk8oHzULm1uWIsli4b59Exx/v+xazMCDRIGTIhm5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4q4Tl8oU08NGH9Uzp/c091b8+5lK+ZlyHA1lMNI29Zo0I6GVx4xqz8PIWYYTN0EolJc2SaJBQwVKyTP0lFV0iHcDruhco5mGJGu3wPIkJp8uJ7XD8HFEE6nVsYHANXZ0KSTW0AoB/HkFAJhFSvH6AVyKyb3hJSBtg3qh5YzMQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QG2payp8; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QG2payp8"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso1246813a12.0
        for <linux-i2c@vger.kernel.org>; Fri, 21 Aug 2026 16:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787353342; x=1787958142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5zm+5vUsDC+fChluwST+ygDIMDVB0hv5CCY814A5+yY=;
        b=QG2payp8c7dPttuUZ8CtpkcZ6xCIgbayA2LnoS7+sp5qgl6hGCaiZGO7UnctRCmNaw
         pYiQl17VZ2nrmzwp/PK4pghemIbSg0Yu4F1SpLBXjryRlcXCHFMBSAWBL4ENGLFQR2xm
         Pz8/PDCNmBcy9XOlAfy1EVWHtaAoR8FcFuKcI5wAi4a2j/4lGAbZj+4sG2G/+gmkjfrH
         8/LE7LTLrKvQv76CzaYWl5i/i72zKWtjZGs5NPBIwG3f/a3HLGMccuGfF9RlDJ93chpA
         voBwv1jKxF8Mf1Rwi2+5BayqkanAueP3r9s9A2yCVgE1n9CXpZIHiJkmX1y6kXYT687u
         atvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787353342; x=1787958142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5zm+5vUsDC+fChluwST+ygDIMDVB0hv5CCY814A5+yY=;
        b=YvV7zV4o7vlmI64Kq1sCWYyePHNt99FyFNXl9qLq8oa7zvXYNVOfI741RgW0u+Lr1h
         irBuubMSYyzZSwVjOhbNA7F9uSSTw0V7oig1iICFC2efUCgUGXUXLzgv7itHamm3HpWU
         pmqMF4orGQVz581eGfxbwCZ92S+q/jyGlYjLpNTcnUSaugnI9ri62owien/rJeJehGkJ
         HYnTDJ0noKSOWIG9Wp5qAzZcUUTajDYblD99CKPjE2GdMRjZtRrceNl2qAk48fazX/j7
         sBAoAE0uUAUXJmqZLezra/iI+UFEsclAPR32HgRz/MKuemXxI19mRLrSAAB4ter4b/1e
         9RSw==
X-Gm-Message-State: AFuF++nc2TlxVqwz5YY9Ioq9MVLj1swIt/LYY3LOmMa9HYPA+mswcKzS
	o/pQH7XUDaZAmED1h7W+80xZyb5b1XeaPUwjjkz9vbz1QHDrOtPWQZQiq77xiQ==
X-Gm-Gg: AR+sD10FCUt046NR4DE4ixuwkB0IpWNksPaMZska0Uz1uNs1834WEaBbxzvdPwE0mQQ
	nInC4m8x0yKzowwsDVzaSB6dfHZh/V6cJs/zLiV/3GgGOTcWVOh+GCpFLKtr6+yyTEpiAWG5NwC
	sEbMfjVr6/fVKzRThrMUq9sFXQN3pmzTL50lldg11BlAx3m2IifNyOyWt/nI2nKySQZzpnaTs9M
	e/0Vv634Ntcb3cWUhBeqoAkwguzM+raWxzv5KXHInP3ZG8xyGw7ddtzwfPv1Ls8uQokukqxHMV+
	AgXE5KiP1WJIN//s8+s6tmyy+/allwWB55t24HKF11ZpyarUr7DlQw/hV/2IoXGxEVrpO4UPk3S
	I99Aycbqmk5nwhQVwrzz4LpHApJVW8HYMkpFhaAaMH7bJn/vqqNyGwkfsRyoUwgMmd88toLWqvK
	osF3MYI54/sUpewyrY3VKHJYyIdrisuhwIey7oVCLNPuwkhWUL8Qo2Ia0HvU2kelwIbKsAMwoWv
	6g+gogP7MGkyUFJKb2WGwkCr7WdhH5ELIMpTQcshwzcuGHANk71i3hbLFqQ+O8m+n9l22sDBObq
	RV/QEyXwqWgIbC08Sj73+gN0g98vnEB+fF1OhMOnQS8Pdbag
X-Received: by 2002:a17:90b:5706:b0:38f:de97:b06 with SMTP id 98e67ed59e1d1-395deea4a72mr3657075a91.5.1787353341721;
        Fri, 21 Aug 2026 16:02:21 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e49d8b1csm552044a91.11.2026.08.21.16.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:02:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] i2c: ibm_iic: get the irq early in probe
Date: Fri, 21 Aug 2026 16:02:15 -0700
Message-ID: <20260821230217.319418-3-rosenp@gmail.com>
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

platform_get_irq() can return -EPROBE_DEFER, unlike
irq_of_map_and_parse(), which helps reduce work done during probe.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 043cb64a2544..2730c8410167 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -649,20 +649,11 @@ static inline u8 iic_clckdiv(unsigned int opb)
 }
 
 static int iic_request_irq(struct platform_device *ofdev,
-				     struct ibm_iic_private *dev)
+			     struct ibm_iic_private *dev, int irq)
 {
-	struct device_node *np = ofdev->dev.of_node;
-	int irq;
-
 	if (iic_force_poll)
 		return 0;
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		dev_err(&ofdev->dev, "irq_of_parse_and_map failed\n");
-		return 0;
-	}
-
 	/* Disable interrupts until we finish initialization, assumes
 	 *  level-sensitive IRQ setup...
 	 */
@@ -686,12 +677,19 @@ static int iic_probe(struct platform_device *ofdev)
 	struct i2c_adapter *adap;
 	void __iomem *vaddr;
 	const u32 *freq;
+	int irq;
 	int ret;
 
 	vaddr = devm_platform_ioremap_resource(ofdev, 0);
 	if (IS_ERR(vaddr))
 		return PTR_ERR(vaddr);
 
+	irq = platform_get_irq(ofdev, 0);
+	if (irq == -EPROBE_DEFER)
+		return irq;
+	if (irq < 0)
+		dev_warn(&ofdev->dev, "using polling mode\n");
+
 	dev = kzalloc_obj(*dev);
 	if (!dev)
 		return -ENOMEM;
@@ -702,9 +700,8 @@ static int iic_probe(struct platform_device *ofdev)
 
 	init_waitqueue_head(&dev->wq);
 
-	dev->irq = iic_request_irq(ofdev, dev);
-	if (!dev->irq)
-		dev_warn(&ofdev->dev, "using polling mode\n");
+	if (irq > 0)
+		dev->irq = iic_request_irq(ofdev, dev, irq);
 
 	/* Board specific settings */
 	if (iic_force_fast || of_get_property(np, "fast-mode", NULL))
-- 
2.55.0

