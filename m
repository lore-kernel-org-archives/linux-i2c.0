Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F605419FCC
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528004; cv=none; b=HPbk+dgAKXfFpC9qcTIUhkQ4Fh2Tzp7JQVpmk7nwu9RdVF7EHi2ZaXBPIJfqUh5A5kxxx/7AuV7nl2BtIai1McYh/tdBE8732sj/uiW3uBu54XovEkAsZdsXrMMurGR8WIpD0YA4P9yptA8VaMc+M64q5M89A4Scku9o3WDlTfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528004; c=relaxed/simple;
	bh=fmRq3OUJCI0HOwd9Tp5He8EsVLoZ/GIvCjkdw7TRQcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TT29fVXZ/JgubzbMHiNzCLq5yU36LzrL01PTim+nirKjxpoS9QARuwFLCaRJjxYbXouaZt/LH7tvVMOQ4qwH0SXO9rOMPOMZibssBkzxmhVRWYVf819KtB7JjB71lfbVrMIHhJ/otGEP9amd/3J3tqgIzSkobvql1mepw4oxsFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gE9NLlsI; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE9NLlsI"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso535083a12.2
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786528002; x=1787132802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lzbbraV1K3+6Tojc98ovuLlmriNG0/xql/GJKFiqTC8=;
        b=gE9NLlsITE48tTR1mnGp+xuYiOhAy8Gdl2rRcgKUVPh3CK6ANOpOr4Mc/mM80iSfyo
         FQzK98bZBGKQrn6kaMAao0n9m7LnNJigr+hbuNm/m0oYcvy3GkbBeF4YvBQgSriUpMQM
         OVbVIckkqNeO+K02lqF54AdqC3LHOYtig0r8h7WzyJedpPXbkZP8A/e7ezHEmIwe51qi
         yOSNSMxJ3ILPqYkhsLbNbDIxQ3za9O7WJecoonMzjiByP1QBiJcmRawtk+Fxu+JZ9fGr
         dgOPt+K1aYIKZCDrzB1jFp8aST7lXKT9qYeHHs8UsXKOzB714tvt2f6r9yeA+n2qU6Iu
         Mqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786528002; x=1787132802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lzbbraV1K3+6Tojc98ovuLlmriNG0/xql/GJKFiqTC8=;
        b=n2Fu4kKGBfwYAQ9/cOpQQd31kbUVw3R0W0iQjhdSec1EJJ4A2h+3KL6V/K1qtkTkvv
         IHc4PsuGk4S9kLnwxHXgWXMtg7yJif/d/JMZM0fUpLgKBTzUsEZ6U3NQ5snnCC7G4qFr
         lgpGhtM0j0Ng0YVF1JbYnj3hAaULvi7DjmluK7Vegl9sL9YCCf7hqPUvz7iD2II3qRc9
         jVK4VXext6KySeXa1EUAQ4FzdrpMVUFaLmvatFUxTmNgw+HjK4+5W4ep7XE57QkFw/zD
         3DTB7Yus9RsXRzmuBpyfRM3alZlPMeR8Sk2+4kfqm/nR3EAz78nDS1A+DwGJH6Bvcxd0
         CdVA==
X-Forwarded-Encrypted: i=1; AHgh+RqWHv8aHiu9mEoGrhEgBq5TLaGeSHGhuvWwiZcQ4axa9O/mVXod+/WxgN/ymmKMfvilY0eGKI5xlZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEuqj0nLr6IW2Yy3DNFr84A5LM3vh9kxBcQ8eCoKTF0Q+9bZlo
	5ESrjuUHJ6Ypc2vX8FIEBz97jA5xvXzHoKftBVm+e6pQiYJWcBUsfSBw
X-Gm-Gg: AR+sD11dfZdNJlQCA9Is6moEDSsac0KOHWAUkq7ZxDr/COz1R0QwMrJ+UBV3nNL0w3J
	d1jQSocK3JGsaFM5HjyYyVHjsvZF/1BeP/nEdWAbDecYPqVgbDz1w5dfsaVQceBmgpycfqujfYN
	FoCRkdn57JPyWWFatYPsYG+4lSqRJf2YTlsZww6hoow2T8aYQeBGbPpsi0zW1XK0GFFqT/3G+p1
	wtoM30C/oom3aL4F3hLY0dvJzr+XRW90F091j2ZFKc7G3jqPnNwH21HuePov+adtbKRU/gFoqIL
	yP5ypzOBJd2q2z/WPfLEGr2CHQMLCeNLgIuCR7KQyVuWbqRnEbC4Qseu8naTMk95P69KuM6gVjS
	ksE0mPtFm3QwJxj6Zb8CmE4VqXGM4/eUN02FBcMi15uYGb+/NrdDHtS2ZNnA/P93uQArBQy26ka
	Rg5q8hDMaM7eCUhRewhK7c2tefBeYMRfPvwGpfVSweCGU=
X-Received: by 2002:a05:6a00:4089:b0:848:2ae4:d2ba with SMTP id d2e1a72fcca58-84fb555d354mr4174309b3a.28.1786528002311;
        Wed, 12 Aug 2026 02:46:42 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbee797c4b0sm424557a12.1.2026.08.12.02.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:46:41 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Todor Tomov <todor.too@gmail.com>,
	Wolfram Sang <wsa@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: qcom-cci: fix autosuspend cleanup
Date: Wed, 12 Aug 2026 17:44:25 +0800
Message-ID: <20260812094425.3515179-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cci_probe() calls pm_runtime_use_autosuspend(), but the remove path
does not call the matching pm_runtime_dont_use_autosuspend() before
disabling runtime PM.

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

Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index bdeda3979c48..25b6e4e9e3fa 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -595,9 +595,11 @@ static int cci_probe(struct platform_device *pdev)
 		goto disable_clocks;
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
+		goto disable_clocks;
+
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
 
 	for (i = 0; i < cci->data->num_masters; i++) {
 		if (!cci->master[i].cci)
@@ -613,8 +615,6 @@ static int cci_probe(struct platform_device *pdev)
 	return 0;
 
 error_i2c:
-	pm_runtime_disable(dev);
-	pm_runtime_dont_use_autosuspend(dev);
 
 	for (--i ; i >= 0; i--) {
 		if (cci->master[i].cci) {
@@ -640,9 +640,6 @@ static void cci_remove(struct platform_device *pdev)
 			cci_halt(cci, i);
 		}
 	}
-
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
 }
 
 static const struct cci_data cci_v1_data = {
-- 
2.43.0

