Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C4A31F98D
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501563; cv=none; b=LRDLRoCbzqRkHdKFu2lW6e8gHqwTt74vf0QZ+S9Ck9rjtv0+VPogjzwDbgsazxv5wF3T6n3plz3XxeKmub1vKKcNZGXM6TkjIOGhy3iBt3SnoACwVrhbezmRNnxm9b8iKZQ9xjcw+9lYQFs5l/2sipBSqMpvXXTgieYQwGyhY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501563; c=relaxed/simple;
	bh=e2AEx3Zy3Vi9LVwg/sozX1GxUiADsRLGbTvWqih+8tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtxRns6RY2r+cThAzHjxRxhjqpUHwtHL4M/wu2cUFCvsisJrU/iqeGvpMfoUk5oS+1G9sVDAFn0Tt/DSRSEpyGieQxzHD3q141fZ2tBmrlPHxEff34yzZnZPatWzVIqCR+yrKmy2aSiEQ7pkKT6SAXN8tHg+yJXp1zJs/f8qPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cgs2RCDw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cgs2RCDw"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c7c61b5292so8897435ad.0
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 02:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783501562; x=1784106362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ePld7oM6qnWsI6gvufVO8q/95rU2M76WU3t0KmkgKhs=;
        b=Cgs2RCDwUouLJKWAIelbJNTReYknOsPJl4HJvmNms08ZUG120vgA89lHSomssdUnDR
         iMfx5eoYidcY+HCoU8+Wl9Y7UcmmtS46cFpD+JlfUaBebwYUOsuIB/AjBHpcuTZrCKoT
         eecjCBKAT9uBVXqJaJP6bO0P1W/NgOvjEQLPLrxJzjbgSUko6+qKJPBsk4uTt6rSrGAq
         cKPAOxmCHhIsDKOSnRWhfh56DwdfNOYWU85WJM3ozD9CdKh/2v/hwNwhJbF8OrDqEpUh
         z6ZBUuHA4jS4oKqKqM0bEbpqwat/FzSeIho/3N3LbOYHYo8b0jkqN1e7M3sNGDcX4vOi
         GEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783501562; x=1784106362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ePld7oM6qnWsI6gvufVO8q/95rU2M76WU3t0KmkgKhs=;
        b=dEXvXgwH2t096L5cXFKqczwJ8SDTY/fQEIZDMHFxX5yFVDAy3UF9qo1Mr+k9ofIXp/
         EX0Q44mahUSp5+ou+uGHRiiVi74xebu829qmS4Pu3IHRRcYgOLYwuYhA7o8n5BYX9tIA
         VcLUHCVvb8MCx5W3EenVMPN8HxNlfjC08L0ysNwANx/1lD1W6jBeYawjOoVJwvcdyjq/
         Lz1e+4dK9My1t4NYp8mRAHUXkoAvUeB8MSx/HZERVcvv6dUhqoELUD3WgRXOSsooJ2Hy
         Y5A/tKqCiw60smV0Gs0UjTALG7FaaLNRdQ4n5gskP/VexvwGYfxXP1tHDV+47xEWCWU6
         Ch2w==
X-Forwarded-Encrypted: i=1; AHgh+RrlNOOygskmQ68NspsA+54KlT9Of5I6bxsuFQ3SJn6EYWGGQieJB5NTXCZnVfcoJPtzph5hwui2f9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuRAvbyvbmK4sEZYUfvk1YKsiWF5jHARnbfa6tez46ssImFsXg
	K4Y4/nlXlpdfDb+oGnW7thBzFwIWHp2vJFX7fDutMF5+LgehjtWdwFl2
X-Gm-Gg: AfdE7cleaxnBxoTF3psOuGxTaTG5m3LCvT1sq6NMEaQ+dLAcgwc1NBediyArT2N22ym
	FZbFrucS4qsWUBWEA+glxngDoCsjbCr/Qil4uHkTvqq86DzLdLv4tMYJaf1Thbqby0qkJ025pvw
	flkAsVUYun4q8f4NhasMwbhHLetmKNWYOCKew4bdzssZ8OTzej/5MCu9X2uDtyLXlUDG/LJFihW
	EP7eV9HQUmCqfFjvdGd33aZvES3X+fvt7dIR8FOZLmD450k/m879pt2cof+fTSnALkJs0rkkjFk
	MW7hxxMljdfHRrmZbJHt9tMfAJ3j9qS4UF/VAgegBKI70HQG9Aw7Is8+F648k9O5tbW1QdQn76Q
	+XtU8bZ0uvfFiI3d1csq/ZYjxVxHJVFavl76F0OVr7cxRQRhMwsLQbmmuFl1es9Yrgw68+kgMTU
	byB5wqh7zFKA==
X-Received: by 2002:a17:902:fc8e:b0:2c9:97a9:2098 with SMTP id d9443c01a7336-2ccea3a3ddbmr19175285ad.44.1783501561549;
        Wed, 08 Jul 2026 02:06:01 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb9a3sm24834395ad.13.2026.07.08.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 02:06:01 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>,
	Bin Du <bin.du@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] i2c: designware: amdisp: balance genpd on probe failure
Date: Wed,  8 Jul 2026 17:05:52 +0800
Message-ID: <20260708090552.739789-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The change referenced by the Fixes tag avoids a runtime PM resume during
probe by powering the ISP domain directly with dev_pm_genpd_resume()
before calling i2c_dw_probe(). Runtime PM is enabled only after
i2c_dw_probe() has succeeded.

However, the i2c_dw_probe() failure path still uses the old runtime PM
cleanup path. At that point pm_runtime_enable() has not been called yet,
so pm_runtime_disable() is not paired with any enable. The failure path
also skips the dev_pm_genpd_suspend() needed to balance the direct
dev_pm_genpd_resume() call.

Suspend the genpd on the i2c_dw_probe() failure path instead of disabling
runtime PM. This keeps the direct genpd resume/suspend pairing symmetric
on both success and failure paths.

Fixes: e2f1ada8e089 ("i2c: designware: amdisp: Fix resume-probe race condition issue")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-designware-amdisp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/busses/i2c-designware-amdisp.c
index 9f0ec0fae6f2..724cb05e21c8 100644
--- a/drivers/i2c/busses/i2c-designware-amdisp.c
+++ b/drivers/i2c/busses/i2c-designware-amdisp.c
@@ -81,7 +81,7 @@ static int amd_isp_dw_i2c_plat_probe(struct platform_device *pdev)
 	ret = i2c_dw_probe(isp_i2c_dev);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret, "i2c_dw_probe failed\n");
-		goto error_release_rpm;
+		goto error_suspend_genpd;
 	}
 	dev_pm_genpd_suspend(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
@@ -89,8 +89,8 @@ static int amd_isp_dw_i2c_plat_probe(struct platform_device *pdev)
 
 	return 0;
 
-error_release_rpm:
-	amd_isp_dw_i2c_plat_pm_cleanup(isp_i2c_dev);
+error_suspend_genpd:
+	dev_pm_genpd_suspend(&pdev->dev);
 	return ret;
 }
 
-- 
2.43.0

