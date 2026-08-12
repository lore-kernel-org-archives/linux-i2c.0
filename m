Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404CE3AAF4E
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524607; cv=none; b=EYy3kIJfu0J1razuWgBzhsnYWMgMHE+uRYwC6io92qe5OpSW8ahCMIKW8RUEAjjvNJtBxJ3XfN032yiIpKB33JGPmSF2N3obTCjMJ6aWLXNVKDSzKMUrwEDkS+I7BrR9rCVt0sOjS2uRZpz3xKvSmMWO2E1ScKrfKkF/RQlDNV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524607; c=relaxed/simple;
	bh=BnlANvI8WbeEf1Ztphy2XQiPW9daGoWnPs+LvO5U9AI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dgdEm5hB6dSalxMT0rGCC80GDUkXOTtxhYAnrbL2z1DTJ9Wuk33HKqHUZtlzPXenqWHgLy33XmShW/lDq+w8/IbOMzCUjuOpbz+X4XKSA/wqnXtqkeJfVPGX3LyBlcKNkPsRPktruNZLVRNd1u065S27NwAenBxJC2vSK2Wkh58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOl4qfCf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOl4qfCf"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cad8076b01so8719425ad.2
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 01:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786524606; x=1787129406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MkRv/h1X+HN1BXMoAhiYtkmVo70dmlygE4GMmGeHZkE=;
        b=gOl4qfCfX+I9LHvp8EpvI9MrJ9ZZkRcuy+vgW9Htg5wY2Qluo4LeYv+yIcHt32fivI
         nb65PWmZjwPNgzzggY3WxIWjZPf6r/QhP0s+wlsMWQDBdezwBGJ5LhoA1kcYzh+d7yvv
         Zt5uqQ3Oq3xs9QtZjGgLUKBXxY8nEy/PJ+pTkzAOo5ZoAftCRRfvkpcM3wAPbu+g6SA2
         rVKRTd5KB4OdE2rCuMWaEBfeZTTTtyhFXmEAjXOf7WM5KpWyqcZLqge+IDPjD2YtjTLn
         klj4UVmhhDP5zaI6vVKnOOKDBdQdNVVcyciLEnsSMgFIjT8wImPVgN7CeC6yoeQEMdov
         nvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786524606; x=1787129406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MkRv/h1X+HN1BXMoAhiYtkmVo70dmlygE4GMmGeHZkE=;
        b=aMD7z7WztJ6kFKs7Givhk2YBr4+UTHGl8J68lX7Dnn6crjpRmL5RmXCz9PJiQfowpQ
         ffooCrMN7wMfLndJ9ixMrDTYGV779deTiwJMIcMNoZCzp1GbVNTTGd4Kmj7R3Tq6r3g2
         /Olro3T4tE10qXyhTGyfsCT9EohsP4QT4QdaZtMB1JVrjzwt0LnScErrcHxpCrC+mw0i
         M4CNQHkD6RXMeyyE+gNajUTCQbkcBWQI+FpaATjR/N868rcQjZtiPXwSAaOVuVuoNpeg
         BH35D8O3vFP2Cz+E5Tkb+/bXgYYlGCrylOa+H85uh+1uzWLPHbSYhYzIlJWurqfb19y2
         bFhw==
X-Forwarded-Encrypted: i=1; AHgh+RqIjIQAi46gyzjixLsPTPRksjPjv9KZzoTNitG0zhLg7N2iK9WG/zVcZ0CxWJQwyKF0oMS0SoIMBbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAg3E+1pmHsp4rJtrEGNDdIDqzTzXLgpr8+RQeEhvY9EU8K0w4
	oi0fJ8GTaMStKjg+hG6u5nr0UDBoE8tzWuhG6795qHvS3sGBjZTT5w8u
X-Gm-Gg: AR+sD12mbbbCQWKZupodHunwRETVDnyfMR6y0kuATUHj/NB5Ed6Oqe4kOuHWu7KcwpU
	IZq1ldEvI9g2CyEsbeOPqv1SxKrI8l14N4MXZ8E3Pw8phGW1VFOeZOs/LMzZzWfXUYIy9Zmx3uE
	d0sRBZILr2AZf+YiAOmHx72hifEFGwvhjQ5M1g4nA8m35HmcYRdGZXYEOyKOenttJfxWuJ+pmg/
	d36Z/5RU7z1IcJcE0D4JR03EL1fHjXtoWfVCA0nRPGAJYaGVixEHy5W0KJaFiNjsiNhehivPuNA
	/k1H1B6Gi2cqZWG7wVi5ckNhmND7rotQlGlZB3hSLnHEVQhtCM2msBMZ8kvSo7GSuOamTjGL8bC
	TolerCPppzwrAdFJhBS/rb94jRs1EIUCES8VTp+03JfXGhJH+/FMTxwha/h7W2rT3XmnVrXeOF1
	+fW282UmAgEDNDiSaiq3+bkuu5d0UD/h1aB9GaQbJvfNZvnY3dE6QozA==
X-Received: by 2002:a05:6a21:6e96:b0:3b1:882a:607b with SMTP id adf61e73a8af0-3cc3f6ea473mr4441127637.22.1786524605619;
        Wed, 12 Aug 2026 01:50:05 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbee7d528absm370351a12.29.2026.08.12.01.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:50:05 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa@kernel.org>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] i2c: i801: fix usage_count leak when autosuspend_delay is negative
Date: Wed, 12 Aug 2026 16:47:49 +0800
Message-ID: <20260812084749.3267780-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i801_probe() calls pm_runtime_use_autosuspend(), but i801_remove()
does not call the matching pm_runtime_dont_use_autosuspend() when
tearing down the device.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during driver teardown, this reference is not dropped and usage_count
remains unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() call in i801_remove()
before restoring the runtime PM usage reference.

This issue was found by manual code inspection.

Fixes: a7401ca5596e ("i2c: i801: Add runtime PM support with autosuspend")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-i801.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index b29c99ed3883..629115b5c76d 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1698,6 +1698,8 @@ static void i801_remove(struct pci_dev *dev)
 
 	platform_device_unregister(priv->tco_pdev);
 
+	pm_runtime_dont_use_autosuspend(&dev->dev);
+
 	/* if acpi_reserved is set then usage_count is incremented already */
 	if (!priv->acpi_reserved)
 		pm_runtime_get_noresume(&dev->dev);
-- 
2.43.0

