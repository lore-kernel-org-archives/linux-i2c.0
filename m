Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653280;
	b=vI5ZeQkJ2vixyvx79xnZih3Qcf+2pW/FlTSIuPEzW9VENpWhfMIM4bmC6KaB1z7tsioy
	 Dywpt0wiBEVz80LA0YClyw3zXcbeccOhCOto0vcb2y5X5o1gVKV6KV3+fcYsBgpNhjUYa
	 g24nDzUprW8aqsPhCTgMj1NgzUOZ34KFx/zY1RrcuPJjfqMTom5DPgNb9HYccDM5fwPCH
	 Dvgvh6ZIpgV5Ie8Y7nj24AQuDZa0GjTZvhCrM1Wo9/zzL2jAEVliMaBxEjbRYfd+ZpWdo
	 OiMmmh1nYvWa9W88qEgQubWD1gT/vESXncwTurwiI4UJp44nviQZ3ADaKtSVJpREdoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=t8ltOwjxA6KeKnGObAuyhyG+hzNLbLDdGdsDrm0q03I=;
	b=Fd5FLpl/KVTv/YV44w3pjN6UUd7290fK8Fpit766noR4ov5zbfuS01KF6aUOOh5DomkZ
	 KH+Y9/a76bNcaNilHu8h0Ma81L2ewEnmL4ZlH5b492pSLVD9ctKFZ/sLZGkRdsX7bxs5X
	 GOSzZ+yJG6poLp7juDMx0wJq5HO0VGjZXGw8dfqgmeS5wGlpUySJgzOiGZ5RQ7yDZqCME
	 sTYLA2d444bWN0ISLQHqans4iTk4R9R4poNanfl3r0QDWPNcLBZZ2f9ofQirA1mbjdKtZ
	 73zYqyNIEEht1w8gPoUHLwl0gLWde7DoHopkZ9cfuoW7nTusY15ikm1CUs3sLlUAViA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CfGCSdab;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEA2606A320
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 07:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BEA2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CfGCSdab
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1438d9363fbso506247c88.0
        for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 00:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792653279; x=1793258079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t8ltOwjxA6KeKnGObAuyhyG+hzNLbLDdGdsDrm0q03I=;
        b=CfGCSdab2SO2BZvAkr8SlDMq+axi7u/ywHZv15FNsOpdUqbJSQQFIzb6Tn6UrvewUd
         rz4MziqbMsrTh1X6wZx8j/7+//73PcjF/+gMRaGxDo7V8pwDJ9+qUGvtlZQ6Py7wOrp2
         Mh7GYYO7o8wk7HWI38hcCKn5vAY4Miu7HhBzf1/d3XwVdYxaDe9O0pIWE738ZabjktQF
         yTmAINEJeOO/1H+LvfTVsUNkBOu9MltCB7XTTSvzZimNurGpwYl5m4MSDCtexlJtMBcY
         5Cip6/qeuAiuvTgK97HF6bjIsBfhoafSw5RAOeKIg4KCSnaTjQL0OPQNKHr5NE1TxKO5
         Rifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792653279; x=1793258079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t8ltOwjxA6KeKnGObAuyhyG+hzNLbLDdGdsDrm0q03I=;
        b=w11+XmhB2C79YBoBIq7ku/1hloubhM1Tn/k/9ldGHVZuLjIAlwh3N5b/o8NyY8aqUF
         cn77xymSRL8jGPVKJvNJvjcU9BlI8IiagkjrjfcsNDNIsKsj4N3voOKj/xVIyX2ceUQ9
         KHX13yElcPv2HnH9S9ckPvw6lblQu+fkMePD+pUSh2lkco2y9U+onelaeKVo0VZzCFfJ
         v5ZF31VKo+EsR4QoXCfc/VdYih2yFHq7wJyC9sJLJQVzF4EcV1RHCcUYqT+W1EGMIqU8
         HI3oqRzKn+cKSjn93r/4LCti02nxIy6S5PaNhErS/i6uGbkL/+deWEaNUdIJwGCE3k9O
         6TsA==
X-Forwarded-Encrypted: i=1; AKwUvBxbVORBheI0eRshqtH3K/MZH5GBVXrfhH25vpILKREbtVzV/UTDnNbsskffgqKc8LJHnLdNKXh2Hsk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKubFjQnXdvxXeUj0sDaYDorbChYkelDJlZbdkf7HBWFZYg/FTO
	3fLW1uifi01Vy3Ppud6OMyV6C3sNPmJsL2JkprkBRBjya3gTGa26DdkN
X-Gm-Gg: AYBFou1XtNE5VH191Kg8BYb0AOhQYriowDNGnQAm/fUCEZGMWis508J4BHWLig9wng3
	5pICuUg0ewqtGoldAJQdjzp4DSHWnykxp4Liam4pmuSKkVN7oyMPoaYGzNI46n2+g+Qew8Q/DGK
	BUnkcyicnJ7VFwPjsCOgM0wZGlThqxbsghz5M8QPdV47nhmP9jtJbA1NGacrceqhR6UZCfTqEPe
	jvqftKdoazbVOuXgM2unH++j3QXQnclapfSXUG9/qN1feH7a2W2MrjI6LweIYwQwKJLzv+jOMKN
	VK8+0zYzNWEqMbELxYpPFPT/yYfebYuWoetC55QSu9VAewbNijVoqGS+xAWvOMo6B3Z9/j7BM7k
	ayyFO04xhuBQvhk/zXXRcUMbpJqnxsK5SIYLETEqBo88UFgVDqYM0faqyiZPtxeZeEZZLZkbBxQ
	R4AwPLR/fVYoI8OIiSGiyJC4+JrklnKjISI6sjZw7ylrkpq74OlJkSBT1f/KU7b55zbxIu/2Omk
	24XyVD1SC0ecILHmfJxQ3ZUMZGRUA+POSCUqa9zmnIONLRMIxF+DQ==
X-Received: by 2002:a05:701b:42d3:10b0:15b:1959:15e0 with SMTP id a92af1059eb24-192f2d2203dmr2161433c88.4.1792653279017;
        Thu, 22 Oct 2026 00:14:39 -0700 (PDT)
Received: from fedora-x1e ([210.89.35.119])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bd6b7ccsm11112321c88.13.2026.10.22.00.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:14:38 -0700 (PDT)
From: Saikiran <bjsaikiran@gmail.com>
To: loic.poulain@oss.qualcomm.com
Cc: rfoss@kernel.org,
	andi.shyti@kernel.org,
	sakari.ailus@linux.intel.com,
	hansg@kernel.org,
	bod@kernel.org,
	mchehab@kernel.org,
	vladimir.zapolskiy@linaro.org,
	jishnu.prakash@oss.qualcomm.com,
	birk.skyum@pm.me,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH v1 1/2] i2c: qcom-cci: Select pinctrl states during runtime PM
Date: Thu, 22 Oct 2026 12:44:17 +0530
Message-ID: <20261022071418.26895-2-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022071418.26895-1-bjsaikiran@gmail.com>
References: <20261022071418.26895-1-bjsaikiran@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CCI runtime PM callbacks only gate the controller clocks, leaving the
bus pins in their default state while the controller is suspended. On the
Lenovo Yoga Slim 7x, this can back-power the camera sensor through SDA and
SCL after its supplies have been disabled, contributing to brownouts on
subsequent power cycles.

Select the sleep pinctrl state before disabling the clocks so that the
configured pull-downs can take effect. Restore the default state before
enabling the clocks on resume, and return to the sleep state if enabling
the clocks fails.

Tested-on: Lenovo Yoga Slim 7x (Snapdragon X Elite)
Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 873e901a23d7..fba5f664eeaa 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 
 #define CCI_HW_VERSION				0x0
@@ -474,6 +475,11 @@ static void cci_disable_clocks(struct cci *cci)
 static int __maybe_unused cci_suspend_runtime(struct device *dev)
 {
 	struct cci *cci = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_sleep_state(dev);
+	if (ret)
+		return ret;
 
 	cci_disable_clocks(cci);
 	return 0;
@@ -484,10 +490,16 @@ static int __maybe_unused cci_resume_runtime(struct device *dev)
 	struct cci *cci = dev_get_drvdata(dev);
 	int ret;
 
-	ret = cci_enable_clocks(cci);
+	ret = pinctrl_pm_select_default_state(dev);
 	if (ret)
 		return ret;
 
+	ret = cci_enable_clocks(cci);
+	if (ret) {
+		pinctrl_pm_select_sleep_state(dev);
+		return ret;
+	}
+
 	cci_init(cci);
 	return 0;
 }
-- 
2.56.0

