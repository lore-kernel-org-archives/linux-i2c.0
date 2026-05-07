Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DD036C9D5
	for <linux-i2c@vger.kernel.org>; Thu,  7 May 2026 20:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184328; cv=none; b=GtnG6wsryRsgvGV5cZtZQWgfQwJ+ndSF3AMhRRAbYNBOqbmToqjbpjVUH9UfkV8KJQyV+krtK88+xlrT5FSCr3Iy31SKLB1o3Ye5/66wzXbmQFiBxFVbg9ODxCeN/qTGZQWWufkGme8mniFHpRQQbhm1VZlpyfHE209p6FlfJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184328; c=relaxed/simple;
	bh=4evtoOZVO2A/G6eOp1vXsIAEnmO/V0PzVvlW6tZ8LWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ubc4HkfpPpnqa3giYHmLyI9kGDAnsaBOSBaMzvCTuu3nHmzTN/mBwX9Qx5jCTgakqHkLnvOKygRJytUl4eGucmzmSs5Jxl9eKL9MU1k7fKfZj40AhzqDX/l9YkmdZm537NXpHyUbbZaDgs44cAEeucBnRtNyLa+ZJKKwSZNR8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=FY4ix1LB; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="FY4ix1LB"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so780541a91.0
        for <linux-i2c@vger.kernel.org>; Thu, 07 May 2026 13:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1778184326; x=1778789126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ucibh90VG32FPtRrP0vVUl7eKuOrNfTmwf7a/Zp51ZY=;
        b=FY4ix1LBMXST2GsTbN836rD1Sayb6w+swbGtbHn17BlbZax2Xyra46CSCkhXtMkzMb
         32CihZJxSBTB3FhHVleyHOJtsM49s8jNRkZpYGCKiLR9VZHl1GptyDtxTIAarmqVKWs8
         DSyiXjeNK9HL9/X7x53e93125vupxJPh6P9GI9KKwcMkq8PZxkkUd5wXiH6oxqOXg/W0
         9GmJD/24YYVAiXDqFhmp7zV0ZNN7IouKMrY+KrsKx34mB/q/ISs3+bP3xoQAAXM8nk/A
         GfH1Q8LzjpSAVO0NjciX4HNuG0jkMJQENPkG89g/nZhIJlcdiuY25agMYPdJNszLckkT
         3+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778184326; x=1778789126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ucibh90VG32FPtRrP0vVUl7eKuOrNfTmwf7a/Zp51ZY=;
        b=UIBx0ad505X6GbVQbHguBBtrmvzAEjqcM/MQqbnttial9I8dVtKLli73f7jHCdMdjc
         D2J3RW2AfDzwF1SBm5eDA+39rpBicWA3Sa4Q9Lh3L8DKJDIXOXaxR44ocxMlTmi66ou5
         KZFYEB66z93+nZe1QaAJV3G2W9M77x6eRkJPPdKjMO1cEGilf1VwIs1T5TV8lfI0qgss
         IFxzVcr1Q1beMGQFm6alBJIazFQ2tf+i4ckMadpMekPN+yLVAL4F0s132kzz+10BZnYd
         p1QB8fc63hfWTkC4rSFvHkiDz+bUDOrJDkKPjiiubCDQZdCsV1+xeD4DPClXZpjlqjmL
         Hr6w==
X-Gm-Message-State: AOJu0YxKyF2hrp/6tRn9fG2Lb9v7aFcM/7DazoCruUJNZXZClQlIS/tA
	NypNK0/KMU9MtLuLI2js56WMyMu8PwnXOolHJeJo+e6Va+FaHFVV0vT7+DoFgoqIZJc=
X-Gm-Gg: Acq92OElkwoFlV6I1pxy4MPYlatSP+lVxV9u2G8nWRW40qPo+WuhDUXJ+a116SKU2gY
	Q5U/9BHFs6o41laxb26XEa0f94yXPuxieek5A/1vouNmY/1fQaJ4+3pAyOTNbGsCKfdq4WDGuZc
	ZoamH01QFRQokfd98fqm4Dwc6vyAZ3QbrL2D++OxmKJiDiRgLmn2iNVI/EbcLKgFa4WHCUXfr+t
	8mqFUzhjqBnKYGjHOctFUL/sYBkMT9uXuhkWAiS19NHjHyEyCbHq3GJmeW4B4bGJ6M0/yvx5XMa
	HwcCwPUSiWqqU58P4x12IwpGhaq6FoxL+uILfKWA6GrlF7tX74IHxrbSgjc/qzf1N6bGZKXioPs
	XxZR0mgwncHK0IVGbQg/yELJ0hKp98D/A0WCzCuh4+oTKhbkXnir/DWiEvpqaQaaX+tkrjI+u2R
	hhtYmD5PrU/QqH/ax4AwH3/5SHNqlM/nIKnIRxZ+7JRuHQFG1drDtLpifTSOgVROYaqb9qE2Ilz
	MQbbiO5jL3x2uY=
X-Received: by 2002:a17:90b:38c3:b0:364:a6a4:596e with SMTP id 98e67ed59e1d1-365ac775a97mr9947878a91.24.1778184325521;
        Thu, 07 May 2026 13:05:25 -0700 (PDT)
Received: from wakbuild.c.googlers.com (123.143.125.34.bc.googleusercontent.com. [34.125.143.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8263ff29c2sm443200a12.12.2026.05.07.13.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:05:25 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Date: Thu, 07 May 2026 20:05:17 +0000
Subject: [PATCH v4 3/4] i2c: designware: Convert platform driver to use
 shutdown hook
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-dw-i2c-v4-3-9a447b23bfdf@wkennington.com>
References: <20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com>
In-Reply-To: <20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "William A. Kennington III" <william@wkennington.com>
X-Mailer: b4 0.14.3

Convert the platform driver to use the new i2c_dw_shutdown() hook,
allowing the controller to gracefully NACK master requests during
system shutdown.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3351c4a9ef11..da2babd6188b 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -289,9 +289,23 @@ static const struct platform_device_id dw_i2c_platform_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, dw_i2c_platform_ids);
 
+static void dw_i2c_plat_shutdown(struct platform_device *pdev)
+{
+	struct dw_i2c_dev *i_dev;
+
+	i_dev = platform_get_drvdata(pdev);
+	if (!i_dev)
+		return;
+
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		i2c_dw_shutdown(i_dev);
+}
+
 static struct platform_driver dw_i2c_driver = {
 	.probe = dw_i2c_plat_probe,
 	.remove = dw_i2c_plat_remove,
+	.shutdown = dw_i2c_plat_shutdown,
 	.driver		= {
 		.name	= "i2c_designware",
 		.of_match_table = dw_i2c_of_match,

-- 
2.54.0.563.g4f69b47b94-goog

