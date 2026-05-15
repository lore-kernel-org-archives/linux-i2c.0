Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3130F492190
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858411; cv=none; b=S1sdTp4M0zQPpBdXVddE30e/o++GzewNTegvtJzVeKJKpMaIoDDxMJ3ADmSFqoxHpij28LsK15m2bW9M5z7FpgfO6v5j0Jg2d3wI7ZWJcKL+5eBnnQTWVC0+tpqVtlwcHNRSt/lI3yc12MXSq1AKnqJ41KnzHbLT1VxH23kucfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858411; c=relaxed/simple;
	bh=cg1EGpE+tZLsxSw7/5908IsKJBY1Wp5HHzb3pF7yEJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2hYFk2fq9alghEq4hFgxR+9TZ74wo4EFL+677ZiIyCfL0U7lAWoM4UXjOeURNVymbPbQD5TN+2SP/xedfoalQReDm9uh2gdoNfX5/V5nRo9uE1a4AtN7JLYnCp2bsd3vi9lEdhSu3XjSpXwxiARi2Q8QpthNr0FQamiCAX5jzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R/x3oGK8; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/x3oGK8"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a8e3849de7so546077e87.1
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778858406; x=1779463206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gO8zlppoftXaEUDbpITntu0HDlDbn0tIr9/mYNTg0Z0=;
        b=R/x3oGK8p3Dkez9P0VvQG7OChZU69k9Imb4RpnbE/PAQ3t3OQ0GCqnqnUgP1kcKuAG
         FdlTMX3PFehCiM9W3+cS7nw5S/NGM37GkItDyLMrs/Xee0RU8bAM3XLrzkKaWwXYlV9K
         EnmI68pT5a3nkOACXs1LWPaBYIei4w4Bmq3AgFh62Fl8Lr3s0WUxsaw4JpeAvcdQXUB9
         o/gJhZ/JOwarZxCDuYwG99/c0CIT805JhM11YU8HqB1JHejSrH/U3sxkLs57MQU0mq5i
         PwgWSI6ODS5FKSipwDz3nF7U0PoN3xWfJV/95Hl6NYAoTPUi8qKOdUMSk9ceRnbMeUDz
         RfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858406; x=1779463206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gO8zlppoftXaEUDbpITntu0HDlDbn0tIr9/mYNTg0Z0=;
        b=Bwz3wLkcJIJKh3TZRPOhUniCIYWEQ1Gh5Z2AmS9fEW6Owxz6IxEqQ8OzIe1+QLHQyA
         1P8DxS3XT+I3n4DxQICxXADiKXiBDXPaSrhZGVUMzpiyz7mCfJYz5ansdhuWKPSNyhnA
         OvlchPOHFrGclTVINU+GuhQCQYx9dJZAoqKmjTP0cwNU0sup8YKeliW7VzImuhg1Zidt
         MWAEC6zkoJfpCEiKaAEzBoSmg5XoREIujWlTcqj+KybI4EzGJex2+NPjYtfxOs+attKy
         VxfuwYkibmh7dPdz85Ckw6tNS9FSkOXTbT5dIbUA4+tgfZowio8XE3Mh704mxt1D8oOC
         Tsag==
X-Forwarded-Encrypted: i=1; AFNElJ80TBBoZTFlTMPr/uoeWYnOcdAXyjIIAPyzB31NznyhewLdueMsnRTjyExrN2kTrQvk8KgQ8bc4d/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSXVvd4SYZ51zkozA7wbnPq+O9koalgB6+vAl2SOKi7RQ2U29u
	WXa25ckwwvme2j7qbc+nXEiugeX6/HRn2XR082KzS7YScLnfFdcCv3oeqEr0HqAmCVA=
X-Gm-Gg: Acq92OFGat+0O4sPbGvjTwVVrNxRadRyxP/X4vq3Yg7b76M58euGNKzOoQUVhPrOkND
	MpkG+Psn9GAJtA/rMXbMQYrm50GDht3OlF+juexTfejxZoUp7Hxj7BtgwxWOVQRS1KnL/eVCADI
	EUrQJEGZtacfY6FBeJJzea/gWBCubmMDxyaAou6N/o7NciBqJ8RxY3W5kVvhSXSYbGzVlhkNiLd
	JBxA/BHvNpEt7AVK5y6u2PQV4qfwMFhl1MpFQkIO/3npJvCtphSvX7oXOVwVZQuMm1wRlm3KfOq
	DDAk0QSBB7G8bOur8cuo373JP5Ibd5f+3u1cb2yrxLP0+x2s87V4ipPNIj3kz5dSFUcDPtg1Arh
	ahHAvLDqDO7N6a4PWH4ZYplKla43aCPxCCkCFPatIrOMoNU7OQs8PpLVR9PBxOrkw+iqoA/ZTjR
	1iCenHZtmAbD65uUoePxtpe6skpE/y250dCS7CeCPWAbuMf+H1qT7rdjDAd9Ongt2bjA==
X-Received: by 2002:a05:6512:693:b0:5a1:30ec:427c with SMTP id 2adb3069b0e04-5aa0e74299cmr608491e87.6.1778858406006;
        Fri, 15 May 2026 08:20:06 -0700 (PDT)
Received: from thyme.. (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc20fsm1392418e87.43.2026.05.15.08.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:20:05 -0700 (PDT)
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/4] i2c: qcom-cci: Fix NULL pointer dereference in cci_remove()
Date: Fri, 15 May 2026 18:20:00 +0300
Message-ID: <20260515152003.1604187-2-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260515152003.1604187-1-vladimir.zapolskiy@linaro.org>
References: <20260515152003.1604187-1-vladimir.zapolskiy@linaro.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On all modern platforms Qualcomm CCI controller provides two I2C masters,
and on particular boards only one I2C master may be initialized, and in
such cases the device unbinding or driver removal causes a NULL pointer
dereference, because cci_halt() is called for all I2C masters regardless
of its enabled and initialized state:

    % rmmod i2c-qcom-cci
    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
    <snip>
    Call trace:
    __wait_for_common+0x194/0x1a8 (P)
    wait_for_completion_timeout+0x20/0x2c
    cci_remove+0xc4/0x138 [i2c_qcom_cci]
    platform_remove+0x20/0x30
    device_remove+0x4c/0x80
    device_release_driver_internal+0x1c8/0x224
    driver_detach+0x50/0x98
    bus_remove_driver+0x6c/0xbc
    driver_unregister+0x30/0x60
    platform_driver_unregister+0x14/0x20
    qcom_cci_driver_exit+0x18/0x1008 [i2c_qcom_cci]
    ....

Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index f3ccfbbc4bea..01e440b6585d 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -660,8 +660,8 @@ static void cci_remove(struct platform_device *pdev)
 		if (cci->master[i].cci) {
 			i2c_del_adapter(&cci->master[i].adap);
 			of_node_put(cci->master[i].adap.dev.of_node);
+			cci_halt(cci, i);
 		}
-		cci_halt(cci, i);
 	}
 
 	disable_irq(cci->irq);
-- 
2.49.0

