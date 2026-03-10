Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206C638F92B
	for <linux-i2c@vger.kernel.org>; Tue, 10 Mar 2026 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168058; cv=none; b=flH8E7vwRkQBDo6HQJLhJpgor1/Zh4XNl7rOcKMKergi4fP94gkUImZVnF0n3GN1T1Y9O+Y3FrrwnIdaJbdMilQfPDVFdZ/TlVZqJFFTC7YNTjuNk29gv2mDalmonw9/YqAlB91g38JLI+i8AcJoAvY/WQnqDCkFeO0cPnLLfZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168058; c=relaxed/simple;
	bh=IgqVFkgFxEBHiKye28u1/DIuj0AxkVj1Nm37g8a7WPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BxIK4jZZaBXvydotxtz4jubrt0iKmQPK+incO7f9gVXQMLwytLYUCb5PsWSGUjmJ15PfcpHHoS3qJf5MwxMlz4OFpTvX6RTMmY/lKkejUrIpT8IY2hNsSlH/x3ECYST79SFAnlXPsayMLOo7nSvkBldy3JG7GB6QFX89bqGBHRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRzE6c/g; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRzE6c/g"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38a3f6da741so36027171fa.1
        for <linux-i2c@vger.kernel.org>; Tue, 10 Mar 2026 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773168054; x=1773772854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8H73v1k4yDBPkQaRIJyPVtsS2/rCIW0PUibXBmUlqIY=;
        b=eRzE6c/g3XkhlEK52OzCw1CPNVphepbP2i1knsBjbY4yqttcetdiSN3D3bvsacRMaY
         GYZI0w7AAwvQ4ZzylgW49y2oprOfjB618bc2SBG5T5d86VwLIf1awY2oBXCAP+fLADg3
         KLo0fAWr/C42P3lIVGQaPDtzH6tE5vEgi6OBii1yLP/tbfKO1OBIw2iW9yjpPdvaauIo
         NOkfEkl2IMaTq+aBZCRWLB2OIdux13HB5Xs7ekYU0cX6qguldemvWrSqaiSUb94jn34x
         jj3GvQoFp85I3DFwo2zyLm5zbigy5Q6WuQHOT6znjKvQcPmgBLjtHFg4IjxR/6Rj0Smd
         LvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773168054; x=1773772854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8H73v1k4yDBPkQaRIJyPVtsS2/rCIW0PUibXBmUlqIY=;
        b=Z6YA9nR8x7DfY0FlAemVY+SqHQGzseiE34Ig36KDdNrZWBMvLJkTSW20tSpVBl/wxq
         TEDpEFzM+wP77+8QpHnFRAkhbvj2kSDAgFGJ1VBgdD1pqt51npFOjwo9rC5CDWHWmAmg
         4OjeYOfY3pIxLIgW4WFNOwcPosx1+9h+pzmCKg/XyDFqLszvdcIPYH3uGd4TVHt+ZLfP
         4IJNKJEUN/151QbC1TPFMJqLRDjPMuIqv3LHTDGkZyWjmQ1d/e/I4AGokPPithK+kqGM
         zJV9HyQZX2VpAEzShCfaGujpg0sEG5LTz9neWW1llG1csbUOW2FVg05oL+42so8NXxLd
         ZE5w==
X-Forwarded-Encrypted: i=1; AJvYcCVq3joq/oJ7eSVAGARsHg9CV+VZcIgYStYR4FtOCN/zEi+HM7epQO9Zcv5jLBJGo/qX7I2eYnXwAX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKYVUDjdfuZeFW5P0jv6JmbD4LNh+hZcXnMttR81JF6L7654fv
	o8HfXOqkjmkWXGlLEs08b1BZFzmMTlopPSW/6upH2uMLNBPQEMVezbtV
X-Gm-Gg: ATEYQzxsWxByYGykjah6a/njbRHMWWdlY4ayrRqXmaaYiuZATpstq/pbP2nMHAEcVQI
	2Yn5HW8AlaFo/TrAhQ094DddCcXD1dHhxnovVJKMDonxpkRQBeSGnGSi2vuMRrkSpMKtICn6nWi
	Vtz/40Jd+Ww6LWiTe7XpyQ2CcizPkn4Gr4gSUI29EPiGNuO1PXCeAIwGqJUDHKqHn0JoImn1Dd2
	rRSVg3677ZXWm1h/mSAeTO0t6j6yZi5FbBrNFjcNuutv+esdgqgm6VA4SJtkbqYB2CdMDGVSSpJ
	B5Yn/fGn9uF+yMlhc0Fzl1dG4XumywtBth7f6jarqP9fFh739WrqAS/dLwcycH96NNl6HBSrMrt
	0uZ6U3iVnyGXk/U22Cs3Ri5lH4I+jdR+mh+Qit7/7L2uHpOFz44CtTvXc1BeAhPvMnxQjSaB4ja
	JMLJ2A0j6qCE8+qkJ8uHSQDJudVOtQDla6XXbNiYKXVwY=
X-Received: by 2002:a2e:a985:0:b0:38a:5e09:21ba with SMTP id 38308e7fff4ca-38a5e0923d8mr12345161fa.25.1773168053984;
        Tue, 10 Mar 2026 11:40:53 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.148])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a5cfa060asm5905891fa.3.2026.03.10.11.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:40:53 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: designware: add reset control support in suspend/resume
Date: Tue, 10 Mar 2026 21:40:45 +0300
Message-ID: <20260310184046.2010403-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently acquires reset control during probe but does not
manage it during system suspend/resume. This can leave the I2C controller
in an undefined state after resume.

Add reset control assertion during system suspend and deassertion during
resume to ensure proper hardware initialization across power management
transitions. Skip runtime suspend if the device is already suspended to
avoid redundant operations.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
Hello maintainers and reviewers,

This patch adds proper reset control handling to the suspend/resume
callbacks. The reset line is asserted during system suspend to ensure
the controller is properly quiesced, and deasserted during resume to
reinitialize the hardware. Additionally, the suspend path now checks
the runtime PM status to avoid redundant operations when the device is
already suspended.

Thank you!
--
Regards,
Artem

 drivers/i2c/busses/i2c-designware-common.c | 40 ++++++++++++++++++----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 4dc57fd56170..fbe817df9b2e 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -29,6 +29,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/swab.h>
 #include <linux/types.h>
 #include <linux/units.h>
@@ -967,6 +968,7 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 }
 EXPORT_SYMBOL_GPL(i2c_dw_probe);
 
+#ifdef CONFIG_ACPI
 static int i2c_dw_prepare(struct device *device)
 {
 	/*
@@ -977,18 +979,23 @@ static int i2c_dw_prepare(struct device *device)
 	 */
 	return !has_acpi_companion(device);
 }
+#endif
 
 static int i2c_dw_runtime_suspend(struct device *device)
 {
 	struct dw_i2c_dev *dev = dev_get_drvdata(device);
+	int ret;
 
 	if (dev->shared_with_punit)
 		return 0;
 
 	i2c_dw_disable(dev);
-	i2c_dw_prepare_clk(dev, false);
 
-	return 0;
+	ret = reset_control_assert(dev->rst);
+	if (ret)
+		return ret;
+
+	return i2c_dw_prepare_clk(dev, false);
 }
 
 static int i2c_dw_suspend(struct device *device)
@@ -997,15 +1004,28 @@ static int i2c_dw_suspend(struct device *device)
 
 	i2c_mark_adapter_suspended(&dev->adapter);
 
-	return i2c_dw_runtime_suspend(device);
+	if (!pm_runtime_status_suspended(device))
+		return i2c_dw_runtime_suspend(device);
+
+	return 0;
 }
 
 static int i2c_dw_runtime_resume(struct device *device)
 {
 	struct dw_i2c_dev *dev = dev_get_drvdata(device);
+	int ret;
+
+	if (!dev->shared_with_punit) {
+		ret = i2c_dw_prepare_clk(dev, true);
+		if (ret)
+			return ret;
 
-	if (!dev->shared_with_punit)
-		i2c_dw_prepare_clk(dev, true);
+		ret = reset_control_deassert(dev->rst);
+		if (ret) {
+			i2c_dw_prepare_clk(dev, false);
+			return ret;
+		}
+	}
 
 	i2c_dw_init(dev);
 
@@ -1015,16 +1035,24 @@ static int i2c_dw_runtime_resume(struct device *device)
 static int i2c_dw_resume(struct device *device)
 {
 	struct dw_i2c_dev *dev = dev_get_drvdata(device);
+	int ret;
+
+	ret = i2c_dw_runtime_resume(device);
+	if (ret)
+		return ret;
 
-	i2c_dw_runtime_resume(device);
 	i2c_mark_adapter_resumed(&dev->adapter);
 
 	return 0;
 }
 
 EXPORT_GPL_DEV_PM_OPS(i2c_dw_dev_pm_ops) = {
+#ifdef CONFIG_ACPI
 	.prepare = pm_sleep_ptr(i2c_dw_prepare),
 	LATE_SYSTEM_SLEEP_PM_OPS(i2c_dw_suspend, i2c_dw_resume)
+#else
+	SYSTEM_SLEEP_PM_OPS(i2c_dw_suspend, i2c_dw_resume)
+#endif
 	RUNTIME_PM_OPS(i2c_dw_runtime_suspend, i2c_dw_runtime_resume, NULL)
 };
 
-- 
2.43.0

