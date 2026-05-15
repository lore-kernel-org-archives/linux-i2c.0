Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B893F8EC3
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888494; cv=none; b=TT5i+8FHkK2Lur9GOdR1lT3D/j7ipPlDaNKVWT1obSGta24xPBQXjdn1kikCLAg+WbGJrWt7llwrmJcvd6XjITLlehhFhZN4bGGq3xrQulW/WXN+3XbN1BN3FNH5sih21qiW9AioiaswKICQGybaC9aE+wsdtNIEZdg1qX3DHLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888494; c=relaxed/simple;
	bh=C+qF5H05m+lMwqOx/0QVVROjNJSEOi/BBdhavGVTfi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iU+new/JTuiAso4GRAhlVFfONKIUgrglTK64B4aDvXb44+ZRQy1uw5H6TJfHm9OdwdLOSJCBiUDL4t7qcBlciUR8246Iac1Z6Qa9BgwEp1biB1RnSBqhokf15gHkAoTA+CrnevyF5lUMPcipOAnjj7v5w8riDXPzuumo4wxmXqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WoDUEDRt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WoDUEDRt"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a875ca312eso40448e87.3
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 16:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778888492; x=1779493292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dfTgLeE5mGQ13g3PRCIVRX0SnrFeZ5bvGsKRjJIG5Q=;
        b=WoDUEDRtzMtlMHlNR98zjQcyVL/nLji1foFO3kNwl+nwqRsp1wbz2HiafpS16V7C04
         IeBZuadgkyRoz7Zf5QUABAbUJ6hXZc9edCxDfYJyKRel9NCU0HhehBETz20/twfR3LzZ
         FCoqWQxi3mjVLiVZ8eGfMh4zu8I9+cPW2CyocEr6L9FOQOiju4K6k5SqAneVGeFt8zC8
         S3UyrhbFqyCAyw5BOZNl4IihC5d2pD9c8vTudBkNQCwjIVjXlAQQns123/YTi6h2IwuK
         9eZicbSsAaIhWfekP91dKL+iSY/lsdfLgLEOkg783BJaVyyZnLWv/mRyjJblGf7RDCCy
         RaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778888492; x=1779493292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9dfTgLeE5mGQ13g3PRCIVRX0SnrFeZ5bvGsKRjJIG5Q=;
        b=Le1z59QEo2zPhtaA1yuUj0ocefKmAYXqbpgRey8lb3+VO3pU9bQvFDh08NBt9h4dua
         m+HqvNO76fsQqIIzKJofgdd+yVRigKr7g00pcX8X7rLN8Mc+DYxHI/8HCO6EUHOYTs95
         Y7OJt6J1qwW6fnPN5spCGo3csIhntwg9RVV6/y6QHKla2+/X35k3Kr5aKx0/yAJShTs1
         KnaR2WgbQVkokYHq/zqnMeP/zB0zpcBGUmWdD9ZYI11oNR/xBJx7QOjYneo+Pd+DpuNd
         KFYXULJODYUegCHLaFwMz0oBdIVBN3oDZNDiA7GCEFJR9cXQw8e74x7j7RBS3T5X0RQF
         gX2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/qks2h8fKr2F7d6+MS7qKuatrm1eGilqtYfVtnPkiObxSIh32Q9rwpyawhOLFzy1U7IgbFYbx3w3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzKQ++2xWpmk3oQ94NB+SJUeWBqbUDL4X+XQeuoRteU788IBzR
	0uzPPwr0/yKW0aGAOPnl4ByffRxPwWPX863vZW371wFAT5uLz0/7Fb9Lco8tHBaxRiY=
X-Gm-Gg: Acq92OHc275eZCvqNRFnlYzI/S+2SI0ZECUqAjeAWd5cy2gEMab3ZpRvvuQ24QR/srZ
	xu4l3h3FQCxR/oKidUqWvED7xYf9qVnWSboa8a+jW01Ea+ggHdO4xpsxJziBbKHqNA3ZUDP3LJK
	vk1wM6TWps+zG2CT7akB1KOwmFskiGaNgn6zM17bE7UxjkNxAYWJgtbWTv6wnIMzRWki83sDMYc
	q2lgSRjTDLySnZqJAPQYa/n12TmY4ddxhu17/QN6himWXcb2HHeCDpwrXDeVx4NaQ4LKpMK8iRL
	/SC0+WrdOSCVL0XffwitAYQZvCnPAFAdj86xrZaGjLYz83BSMTV6serOUX2l8Cj1BsxOMP/f8jQ
	xRLz4sLbfVDE9n+GGzaG9kYjaMQKGhtkPdxVl+LD7wlxJNA1NEHNaeauG5lICyN4dKHOneoMpaF
	CC51DhdNroaCev/WxrGL245TsHIu50DsUTz1WP65ko/ZFzUm1P6fimrz8k2uzkL6ifWQ==
X-Received: by 2002:a05:6512:31c4:b0:5a8:98b7:b69a with SMTP id 2adb3069b0e04-5aa0e76b273mr967880e87.1.1778888491634;
        Fri, 15 May 2026 16:41:31 -0700 (PDT)
Received: from thyme.. (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c710sm1631384e87.7.2026.05.15.16.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:41:31 -0700 (PDT)
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 4/4] i2c: qcom-cci: Remove overcautious disable_irq() calls
Date: Sat, 16 May 2026 02:41:21 +0300
Message-ID: <20260515234121.1607425-5-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260515234121.1607425-1-vladimir.zapolskiy@linaro.org>
References: <20260515234121.1607425-1-vladimir.zapolskiy@linaro.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cci_probe() the controller's interrupt is requested using a devres
managed API, and in cci_probe() error path and cci_remove() it'd be
safe to rely on devres mechanism to free and shutdown the interrupt,
thus explicit disable_irq() calls can be removed as unnecessary ones.

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 2d73903f14d3..4d64895a9e9e 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -608,7 +608,7 @@ static int cci_probe(struct platform_device *pdev)
 
 	ret = cci_reset(cci);
 	if (ret < 0)
-		goto error;
+		goto disable_clocks;
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
@@ -638,8 +638,6 @@ static int cci_probe(struct platform_device *pdev)
 			of_node_put(cci->master[i].adap.dev.of_node);
 		}
 	}
-error:
-	disable_irq(cci->irq);
 disable_clocks:
 	cci_disable_clocks(cci);
 
@@ -659,7 +657,6 @@ static void cci_remove(struct platform_device *pdev)
 		}
 	}
 
-	disable_irq(cci->irq);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 }
-- 
2.49.0

