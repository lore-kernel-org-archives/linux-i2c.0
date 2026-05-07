Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A364E35E950
	for <linux-i2c@vger.kernel.org>; Thu,  7 May 2026 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184325; cv=none; b=c+i+s8+kOW9q6i70soeEZB99HdSvf1wpD2TaR6UfHBJlcwky74D5DShk9R5RndMlzvYDENwtUXPvHrFRQ2M76khf5CWrURbmnIC8qcLBaTkHjOvhue7TsAZGP7mis+XbvxC0J4kEAv+c6FR0aiT7Y3u6wFLlDtJ/sibSQmRbtEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184325; c=relaxed/simple;
	bh=xdMaato8TzQhG7sEcha36250OMNuC2a38m+gB16kRFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F3KqDnbRlisQRy+POOV5indS7jGPxM+PFbpSsgpt92T8B6dW/ParonAkZ4uo0DlbhfrzpghPbzLxjm/OVMaJyx9k03fkwGb/at8akp8ctALIXV7iPzp9egfPYTBp+YSj5yCBWAIYh+l3tDnCZD1V5r5R/MtaiAktFvvQLlQKlig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=S2f3MXYk; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="S2f3MXYk"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c80291e6237so925148a12.0
        for <linux-i2c@vger.kernel.org>; Thu, 07 May 2026 13:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1778184324; x=1778789124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dbh8YwmHjgZJuVNCq9Cmjprrm6eEx/Q8kVEN8sLgRu4=;
        b=S2f3MXYkmsULTzHHrDWjRXAQe57gPyh+CxofFXbwX5F3xigvl8lacDyDy/HaAolYu8
         yYb93yqwLL2CV6OUgBUqX4Vx/nIaNVQH0jI+csXVBdK0JaPKhtebirOhwAfV03x+o9OS
         Cf6Fvpf/qaftpAFfsvsdcyH9C0XLaiV/9n/CsH9EhhCkp1c1dz3HVK2FKTcMDGZM0gMg
         d0fI+B4Zl20sWzVJj+vXeaCgVyc/5DpRWd8z8XbjJHk6mysh2wNhvqWN0/xvpP/BZ8oi
         bmjdC+Wyjpwt7l5EsEDlZunK1S9Sj5K9bs9cjoDHzFXG2RW+0zdEfLMgvhI2230o5bH0
         wQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778184324; x=1778789124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dbh8YwmHjgZJuVNCq9Cmjprrm6eEx/Q8kVEN8sLgRu4=;
        b=ZXnfVrJmrpyg/5FM4SzPvQBD7n1gYpCfJ3j5H6nakY6FpRuMREyuHR85/b4+p90DpX
         Sg99PfD8ocU+4RngKQGMAtzs9I/BuCN65d2A8Hm4bcLyLIdx2NMxZUV3k7lHx/x+4Tfk
         2stgtt/hfqb4Tl+0/+jpT1wvpex167sKrT0zsre5C3Y7xpkD1WpSLMSZWYDup/T8u9H6
         ZSpofZnDGFLpMCetsTd4fr8nXDwPcaV9iDa+/htphiU64SnWjANTaTXtKxKL+65Sk+LD
         f9flyO3Bjz3HRY0uzcDTUJkQXNsi127sudSWp/WWJh/UnDMrgxz4yu9QhqykXEQsNb9t
         llkA==
X-Gm-Message-State: AOJu0YzIY5u8ETGKHSgdCmUaz7lm45IYpKnx+YOVRom/KUIeZQ6dH6n4
	niINWHapaHk6uGfS2W9rpT3VrBAMUF+CXWQUk9koiE+yqW3iIL/Q8i52WDk28ivEkyE=
X-Gm-Gg: AeBDiesmoIMz/2SQVb0M2JJZQAmhBgCIE5hae6uesfuCwN5XcjX8m4FXmCxO7UAc/Iw
	0EiR4QHQLyNtui9OiyXrQ14HtCoAEtIvCdnOWo5dI4NeJKSZkBuNgCRXFxjjtvmETt4gtfyeI3X
	uje4hrGy4OF1qd+/X5xHIlk3SbYYvmq33FeRT+Haj8fEswIb62Fw4WeyzbNjBZUGf7ZPXQzmmps
	OBVtfpvI2OPDaWzTvmQvriuEZbhi1gpljhyqQcy3EJ+qcuUrGmL9QNHv9+mEFMbYxlAg541lyl9
	7eCo534nodOICluG4k0Vfcp5RqFo/C0xil54JjkjztLQWZB9KaINj/vf1VxpMq7VcRSKq6V2nPg
	nfBX4H/S2amDkRdspwux5qib5pZTdyatTsgxgW6yb3RCQpSguN4n6czPRYiWQGy3rc2MBlfODRu
	FB/Uhk7MGPrj5IbnzGzOchRn/FxOCsdbcK2hrZZNZTkZl0XJ8ScpehGCYePfIpPDneTgx9SaHRR
	UF2T5hEUfZNiao=
X-Received: by 2002:a05:6a21:6d88:b0:39f:3efb:e888 with SMTP id adf61e73a8af0-3aa5a983571mr10254508637.25.1778184323838;
        Thu, 07 May 2026 13:05:23 -0700 (PDT)
Received: from wakbuild.c.googlers.com (123.143.125.34.bc.googleusercontent.com. [34.125.143.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8263ff29c2sm443200a12.12.2026.05.07.13.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:05:23 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Date: Thu, 07 May 2026 20:05:15 +0000
Subject: [PATCH v4 1/4] i2c: designware: Introduce shutdown exported
 function
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-dw-i2c-v4-1-9a447b23bfdf@wkennington.com>
References: <20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com>
In-Reply-To: <20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "William A. Kennington III" <william@wkennington.com>
X-Mailer: b4 0.14.3

Introduce an exported shutdown function to safely shutdown the
DesignWare I2C controller.

This shutdown hook gracefully sets the target disable bit before disabling
the controller. This guarantees that any incoming requests from the
controller are immediately NACKed during shutdown, preventing the bus from
hanging.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 24 ++++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h   |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 4dc57fd56170..886f4dad166a 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -1028,5 +1028,29 @@ EXPORT_GPL_DEV_PM_OPS(i2c_dw_dev_pm_ops) = {
 	RUNTIME_PM_OPS(i2c_dw_runtime_suspend, i2c_dw_runtime_resume, NULL)
 };
 
+void i2c_dw_shutdown(struct dw_i2c_dev *dev)
+{
+	unsigned int con;
+
+	/*
+	 * We only need to handle shutdown for target mode to ensure
+	 * we NACK any incoming controller requests. Master mode cleanup
+	 * is handled after each transfer in i2c_dw_xfer().
+	 */
+	if (dev->mode != DW_IC_SLAVE)
+		return;
+
+	/*
+	 * To quickly NACK the controller during shutdown, we set the target
+	 * disable bit while the controller is still enabled.
+	 */
+	regmap_read(dev->map, DW_IC_CON, &con);
+	con |= DW_IC_CON_SLAVE_DISABLE;
+	regmap_write(dev->map, DW_IC_CON, con);
+
+	i2c_dw_disable(dev);
+}
+EXPORT_SYMBOL_GPL(i2c_dw_shutdown);
+
 MODULE_DESCRIPTION("Synopsys DesignWare I2C bus adapter core");
 MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 9d8d104cc391..c71aa2dd368d 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -417,6 +417,7 @@ static inline void i2c_dw_configure(struct dw_i2c_dev *dev)
 
 int i2c_dw_probe(struct dw_i2c_dev *dev);
 int i2c_dw_init(struct dw_i2c_dev *dev);
+void i2c_dw_shutdown(struct dw_i2c_dev *dev);
 void i2c_dw_set_mode(struct dw_i2c_dev *dev, int mode);
 
 #if IS_ENABLED(CONFIG_I2C_DESIGNWARE_BAYTRAIL)

-- 
2.54.0.563.g4f69b47b94-goog

