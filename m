Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF713B2FFC
	for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912615; cv=none; b=uuj9Yn1sxHLW1vZevYVXVuphhL/2GyD76YHmhyNWl68dAqRLFkFUy63u50gnHRQKfrklXyX2XKeoAILP3dUI9wsl/Ro6imPl6Ld4YIMXjyXUKEyhSNFZZf5hv8ACXqwTsTTixKP5ln+/YnKMeo8PlO9SiXqkYy3tk9KcFx8h71E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912615; c=relaxed/simple;
	bh=BR2iveUU1nhkZu5eEnbrvTBIk+kDYBBkoMkU+yko3V8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aAmU2acAwM4xSTf034C6vLv38Dh4EkVLEba1YfJIhZUlLShLb8W7pCUWfB/5dT9zshHSTkQG14OTDKOQuXD+tWGkpbCGCfB8snFT00SP9RqTzRqB37tCKrB5xOzgnUMHtcyHHqh1zZMD8Zd29sUE4zh7Z82F8Z4dMFv5Gth2fSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=gTy3LY9m; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="gTy3LY9m"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36ac67f489aso2823414a91.0
        for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 13:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1779912614; x=1780517414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OikO7LECaMFgoDK/X1/jiTfHTUrsVlBaCWwcQEZ7NcE=;
        b=gTy3LY9mavWfUMpicUKxDyRJfte3wm2AevvpArNVRNeZPn0LIbQnoBLBncu/TmvcZ9
         8pwSCr9A25LVYzAItCIK+1M62L9+Je7uoL8aVTokivVmwwbCtdlh6CCtdnZExx4+O+nE
         4oO3RUXpuQ+FEvq7CaNlVFzHSAU0LIEwUuQkEnHPAWQHnmc8dIieaH4sDPQuua/8mo6P
         /tzR4omWuIsebc1QhOaAcihPWvO6/SHLUjXqsjZTv9gNaULDUYHaVWfKBpzgcyTmhrwc
         9PiK+4QEDmN36mnAUkB9Vmohwmhv9xgjkSAOS8N89FeNnpY8qz+ERZafKSZbkqxK9Y+4
         qpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779912614; x=1780517414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OikO7LECaMFgoDK/X1/jiTfHTUrsVlBaCWwcQEZ7NcE=;
        b=ZWdz4HzBT7dsuXRZC4WAZQ91B5wRjElF0bWLy50pfBAdtctBLJRbG6mpNzYvyC+mN4
         tk3CmVzNQ1AhPn5B1iDc3uIvKtYpY+KphIihK3wjhuRgtvLwXK4UGrkKv8tWLCGxzOS0
         20mA/vkqyzj/1qjZKUMKtPe0T09DP+RO2DCbX2aRQvLxZaXcHFd/amE4JcH/s4uOp0hc
         aKEDTT9cwXaBLPmF8Wa21CvN3gK0Ctzjs8FX5FkOTOepAHsn5d+Z4nhuFeN1aOG468NG
         J+8bSHAd8mku1kIkMFqzw6Yks+z8RGnY5CI55WlQ+0qmAeesSCtSYgKnSA26HXCz/Bo1
         4MrA==
X-Gm-Message-State: AOJu0YyUTlCNw1kwDrwcvaJ5+dzOOoKR8luqi4rRZ4fZD6sDTNuiyIvR
	un3KGbdRCxyWQcjFvQM/r2HX697gtiLHaM8hei32w987cqXjqt35zrsk4Epp1ha3QzI=
X-Gm-Gg: Acq92OFe+GbaQcJnxv9WGTYB+ixQnH1cSXV/E9Z9TRKJxoA/Aw19wB7Q99o8+WHOeeR
	+ZxqV3inpEhSvtBDPEzpFJ1yedYyxHp0b4m7Y5NmeGwkwNkYWZ7fpOC1fnrqMOTI1PWtewaemfI
	YSDVEOBngTbi+nU5BwN5wOWwcQJNoTURIgefC+2+9vJpfEiSPiD4k62WXNwZBCGawLo+pnYwYCG
	d5LKDLd1Zx3jtnOpcbeRnfNE+7rfyMqCqQCj83SiG9Ojou/arQ5Sbm3ezSYmOuV2npwu2LGHHJL
	5qV0ddLGryfKCDCfYUQE/S2T9JOjgUPu54r92HM9JzHZu0AhqvGjc7bOrOgx3ZPSZ/RpyyXv1/M
	C48+UQgCK8GLSuY7EhfVn0zB7gBTLUOAlAJd84jtb94rOMvKkGR4mBP6iXN4MBhR2iA3jgCg2yy
	tmcA1ma8b3oTR5CQ3mhV3xgZ3SIoIydBLWZvjI0qDR1VmgvGP6vcrX9KglXK6U75PxE+zmxMzJf
	Gu5UonwGRBvLPtGxftVnho=
X-Received: by 2002:a17:90b:4a89:b0:36a:8254:8eb1 with SMTP id 98e67ed59e1d1-36a82549048mr15765525a91.6.1779912613626;
        Wed, 27 May 2026 13:10:13 -0700 (PDT)
Received: from wakbuild.c.googlers.com (27.117.125.34.bc.googleusercontent.com. [34.125.117.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a71d9416csm21875253a91.3.2026.05.27.13.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:10:13 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Date: Wed, 27 May 2026 20:09:49 +0000
Subject: [PATCH RESEND v5 1/4] i2c: designware: Introduce shutdown exported
 function
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-dw-i2c-v5-1-3483057f8d67@wkennington.com>
References: <20260527-dw-i2c-v5-0-3483057f8d67@wkennington.com>
In-Reply-To: <20260527-dw-i2c-v5-0-3483057f8d67@wkennington.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 24 ++++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h   |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 4dc57fd56170..ef618d3e1ace 100644
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
+	 * we NACK any incoming controller requests. Controller mode cleanup
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
2.54.0.794.g4f17f83d09-goog

