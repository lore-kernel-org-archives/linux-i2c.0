Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B7735F172
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522984; cv=none; b=N102R9Fx90gB+HeRZ1RI9z8Rfx1I74hulwWRxLsLfGeiQqPLoTweHPNJLOf73CFR1+yVz+sXkss+FLrC8vzIKsuiPIZq0mKL3mySYYvEkULsEUTUycnIKsEskJdLTdFFCLEMdIpKj90Vzz5CpxqzxFIW2dAYoq+xULM/jnHrhjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522984; c=relaxed/simple;
	bh=2H8v1oyrle2HKsNAP/KxLy914h/4c7nGoy2o7SVu/VI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VoPY44Q8F14sJkku3bFKODfX6FWwOCKHjzmNoqA3OyxGIdC0TTI1JlqbLcMe7b3UFC5KDRIzw2zUaOqxyLvx6vrNUopFwUqtaJDuGzoviSEpcwEO3Be1Ap6TJRbh/3wiOwlxaCB9B67edsTXIXpfjVDT9z30OMc9fXk/wSx2s7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibFYu8B2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibFYu8B2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cad8076b01so8538805ad.2
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 01:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786522983; x=1787127783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9czSt6q7vylVa/nHulnD/ffQGxol7Pay/M7CQhmuBNg=;
        b=ibFYu8B2udqSkwZNJSDjY5m7r7VPuALu50jA88TMtMoFkELprG1mDESg80u7FiLwIe
         JW/g3WE1BjgX4Zla3+SFlsfCJmSTe2k6/DZOr0z/1IWGPb10CwRk89ENt0LdV7qI+bQE
         6NisE0SWSat3NA9N8vQfu2ugasyyoKNLeG45VTlpN/mJ9lPQircHeeoQqVMIncFWRXLj
         XbrvrwpkhvfwzLPfM/Ui7e8c+fymuRI0KvSzJdtozXfnzvQBMCbaUAj5x9r++UYK4KNk
         mieXivVUD6OSauD/wl2wONyiMqyr01DX4aYSf5ysZCxVMeQsXU0pDWjEF/cburhlIXs0
         LwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786522983; x=1787127783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9czSt6q7vylVa/nHulnD/ffQGxol7Pay/M7CQhmuBNg=;
        b=XaLgJqT6J8yd97jn0NbtK9cx2X0Zbp/tJTryt4g+cqMJuFiqJ80k1fHmMHBj7R7ZGz
         TBCdlqL2plPijycOjKdu8EYd6/eQSQjQljNmNdnWx3S9LGZ+tgwZzdxmipPEHQqS+u9d
         Kjmdh7OT6Y/u0Fep/+e+4PYat2MJxlWN1k18bURxCMKJ7otSopof8xVCMAN8tQXn6InE
         /yq7EBCPpU6zWx7NdJQoZgLJaUtafANhQGHnIqmJZDOjOFf+TCxvqxRUo+soagX3xw8b
         /WzqFd4MA1wecQ6nvNi0884+W8LDRMzpmd8mUiM5yD7MzzTfEURb3Yj9bHczcNR8NGWQ
         jVBw==
X-Forwarded-Encrypted: i=1; AHgh+RpfNvTSmW2sUtkdkLOLdquWIHR1DccA5s00B8sOT4j9iaRioVGin0mO/ux/mCQifMztAEtL81KNxss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8pkNNyz9FozWkkGbVIuckPX290Aya3BmzYrKqHJBZufXsKc9v
	+k/nF4DswqlaqrhD6+3t0Cgbbj4NbFXHwpFtjUeE+aTsK0PI6SFRuN32
X-Gm-Gg: AR+sD11KiF64KiV1XDuFASYCD+f/1DT7Fw9/Bx4IofVRXiO4cYPgpIS0f+xdY2Avny2
	HEEEINEs/vmZZM+gs9dsdio6iebYjDhWkob0tB3kE69OY+jWcOFw/Gg2si99L7g9b/pUf1yACqr
	2DFQIUMIE0CWnS9KA9iFItUR1q9GRi8EFlWQfi+2EK6GE3wPop5TE0w78CEpHnMW3gq3KUjPUUg
	Mbzz8VjxK7zDTTNdd75v5SKC4UWkmbQhnpW7qw7wuIMbbeBU3kot3jtfWt8YFFO2ykBLLRTpFmp
	kGxSsif4LM28iKDicL+AMt2K/V9xU2wKVg2HUFlq6kWID8c+tnKpsV+eUfoel8k1bmt217TBh+z
	ss1kFdoqO1YxmqPHktHSxNC7ak1DPPlyguM19YvNYF3Q+8YybMz4WbgdZcw+L6O8gGbw9V/5RRI
	wmUs6NveInp6padb9qfmLPPa4aYHn1RTI8dVvlvg2zzYI=
X-Received: by 2002:a17:902:cecd:b0:2c6:a772:7e43 with SMTP id d9443c01a7336-2d34560d1e8mr36701705ad.18.1786522982570;
        Wed, 12 Aug 2026 01:23:02 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d35219f21bsm3015345ad.54.2026.08.12.01.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:23:01 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Wei Yan <sledge.yanwei@huawei.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: hix5hd2: fix autosuspend cleanup
Date: Wed, 12 Aug 2026 16:20:47 +0800
Message-ID: <20260812082047.3148742-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hix5hd2_i2c_probe() calls pm_runtime_use_autosuspend(), but the probe
failure and remove paths do not call the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without undoing the autosuspend setting during
teardown, this reference is not dropped and usage_count remains
unbalanced.

Use devm_pm_runtime_set_active_enabled() to manage the runtime PM
state. Its managed cleanup disables autosuspend and runtime PM and
restores the suspended state on probe failure and driver removal.
Remove the now redundant manual runtime PM cleanup.

This issue was found by manual code inspection.

Fixes: 15ef27756b23 ("i2c: hix5hd2: add i2c controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-hix5hd2.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index 95ab910b80c0..f3b967316a2d 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -449,18 +449,13 @@ static int hix5hd2_i2c_probe(struct platform_device *pdev)
 
 	pm_runtime_set_autosuspend_delay(priv->dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(priv->dev);
-	pm_runtime_set_active(priv->dev);
-	pm_runtime_enable(priv->dev);
+	ret = devm_pm_runtime_set_active_enabled(priv->dev);
+	if (ret)
+		return ret;
 
 	ret = i2c_add_adapter(&priv->adap);
 	if (ret < 0)
-		goto err_runtime;
-
-	return ret;
-
-err_runtime:
-	pm_runtime_disable(priv->dev);
-	pm_runtime_set_suspended(priv->dev);
+		return ret;
 
 	return ret;
 }
@@ -470,8 +465,6 @@ static void hix5hd2_i2c_remove(struct platform_device *pdev)
 	struct hix5hd2_i2c_priv *priv = platform_get_drvdata(pdev);
 
 	i2c_del_adapter(&priv->adap);
-	pm_runtime_disable(priv->dev);
-	pm_runtime_set_suspended(priv->dev);
 }
 
 static int hix5hd2_i2c_runtime_suspend(struct device *dev)
-- 
2.43.0

