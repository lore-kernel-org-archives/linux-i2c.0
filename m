Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E10D25B0BF
	for <linux-i2c@vger.kernel.org>; Wed,  3 Jun 2026 00:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448117; cv=none; b=rmyHdGr0zpLyPtINJ/ikkk7hfcwbGylnyiboWaEKHW5e70UntwBaWyE8tk5SA5u35dNzSm3JNEWtYIBDtqCXFzWfdb0k6UbirmGIv9UQrYBCHe9w0BNs8XwKMJhF+LcfFOHCNb/GvO5Lxnc8y7llZODfAImIA2Y+pdUXiQu2GKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448117; c=relaxed/simple;
	bh=mpNonfKMwFfyr1RgIesPBlS8Cy4DhqWulnzPIgpeqrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ffl4Z4kQjBrGSpiGZIc6rzWXwdevfPSHX1mS+Lz0N98ajyfC/OVCnbb5H0Wd27s8mDOHa+Mx5eNH6I61wAeOrno6/P/Gp5fO3IH3gMoLMyCPkJohYbVga7ohwkSBzF1IQdiGLbejVms/42dDpcRmawZK5Vp3B/gGQ0LPvNBsIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4LVT0tD; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4LVT0tD"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9158629a220so92620085a.1
        for <linux-i2c@vger.kernel.org>; Tue, 02 Jun 2026 17:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780448115; x=1781052915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0FmNiszl6LG7p+K/D+44UYsDnEcYJOWSFq2DyYSycM=;
        b=X4LVT0tDjEklRLOB4B01UF8dloexE2tg1E2tV3B+sondSx0LLf1lHEtePRMgaNMLas
         4jY4yqko8Yv15Ke8khIlBKacrYRQ0NMmwju5eMcCv4rH8jZ5JBvB3VKJ/ZV4To/c/Uzf
         qxSYf+Y6TgA5O2F11gbdHDuaFR+1cBzka8MK9sJkkB4oXeAHql+nQzJfbJ3OG7UVLJD/
         0PwdPwswkaf49hvQl8fmD3fLfpb9hJ/yIJLs7ecQrp5KqOEK+Vy/+IyZqDHIdfPIeO8c
         neHuIdz6WUNWFcNLJ36DP9B8KzAKsMpbtZQ1SXefa12evKdCljfmkGfkIB5KdLDpKCjB
         8MYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448115; x=1781052915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0FmNiszl6LG7p+K/D+44UYsDnEcYJOWSFq2DyYSycM=;
        b=K7+Mz5RmJFSLbrpUirCHHd9t9zxGAyzap6pzt8vaL2deocuplFctSLEEuZdJaO1GFA
         JlcvNufhUu3sqYhsFS/03oajT2SM0h73pq/96mDMc5cupfk/YuP1KxiSl3VPIawlKcc7
         6jsmB5j6IdWBOavCegRmBk7aqrDlhnRN56eF2yPVDT6ys6L4e23SMqUQasqN3JxWTagL
         n3ww0Ww4rTobS88BgJm8VzjgGo7X606Z0V41p30rCgDKwMx3kRQmMHDy6RKG6JNLgz1t
         TFSuUSGvsFn11B2ZkykYdlK9ddUeDvAm7G2KM8yudQZ5Lvvmq5spFP+t8qvSgJnJOmGK
         LU6g==
X-Gm-Message-State: AOJu0YyokIOICiES1DHYk1DbLtaoLrz6WjNTXNLnb5LBX9zSddxUEEof
	sbRb+A4omOi/KVYJuHEBjkvtKJIgur3oiO8nWVZeIShKwZBvoyWU2z13SyxL0Lm4
X-Gm-Gg: Acq92OHPvN0fYUZuzjVwTgKIV+PsAFAJarYegCM1yNSgiM0vupD5w2PK+Z2tp+dFFvG
	0yWFiVHkhs5i2JJ0i+xFQbpOSfL0pyff0JkoN6hCbmU0LpNEZOY4uVX31we4fWkyyVthkOT+yYR
	TlHJ3hSu389P/EgVCIJmOwLzYZFEvncDEk0c8lGua8F7zC0z9P85xl72e7IQaGOWTzrS9YwHvEH
	2mBuyhFa/XTwtEmnePM6J3NoyHQ6YACe6kDMBxbIZWiVns09XOBF+NVyfUPUffFupqiyRPcKnAP
	e1pK/tyqAS+RWJ7nvunfxt1lD8lTkqlAm9Sq3+pyhV2kFg766YPgadM/YdmUlv3VBt7wju/C455
	Zka4gZCkzRHtPpiu5O4q3b+uHn71yyd7XemaCclUnDUS5rvZ5hYEJFewa/MTskeTBQzW9axx7YQ
	mff5moLyIrMX+PCHBv/TV8sHVLgJOBCxk7w20WciOcsFGkfrH+ZGJ/8D+as+0YL3Ny9Mzn+Uj51
	xYwpAL163N4uFJsE0nsnTVH3zdfAQ6vK9iYnEgyQT36ZYk2ofelcywP
X-Received: by 2002:a05:620a:1a08:b0:915:7732:ea6c with SMTP id af79cd13be357-9158a7dbaedmr249288285a.41.1780448115207;
        Tue, 02 Jun 2026 17:55:15 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a381abfsm95701985a.27.2026.06.02.17.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:55:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Jochen Friedrich <jochen@scram.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE I2C CPM DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] i2c: cpm: Use platform_get_irq() to retrieve interrupt
Date: Tue,  2 Jun 2026 17:54:55 -0700
Message-ID: <20260603005455.226882-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace irq_of_parse_and_map() with platform_get_irq() as recommended
for device-managed IRQ lookup. Properly propagate any errors returned
from platform_get_irq(). irq_of_parse_and_map() requires
ire_dispose_mapping(), which is missing.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/i2c-cpm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 2cb6a233d313..23679c192edc 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -434,9 +434,9 @@ static int cpm_i2c_setup(struct cpm_i2c *cpm)
 
 	init_waitqueue_head(&cpm->i2c_wait);
 
-	cpm->irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
-	if (!cpm->irq)
-		return -EINVAL;
+	cpm->irq = platform_get_irq(ofdev, 0);
+	if (cpm->irq < 0)
+		return cpm->irq;
 
 	/* Install interrupt handler. */
 	ret = request_irq(cpm->irq, cpm_i2c_interrupt, 0, "cpm_i2c",
-- 
2.54.0

