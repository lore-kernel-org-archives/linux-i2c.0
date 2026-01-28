Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C47834D93C
	for <linux-i2c@vger.kernel.org>; Wed, 28 Jan 2026 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594112; cv=none; b=RSwCLjTU3UqAEF2ZjiWy9MGv85O27qDbozZ16Gyq9AH2wuSgD8zx0yY+OsBclXmaGstFK8nIYZFW7nfW0O/SE6Qfv+yCGQy8OCYe6bPjYb7uM3cf7XKTGDefIAJdtvLQ8TXFlR/g9V426VnVgAucqDw5QCvpSaCgwFlH8nTo3zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594112; c=relaxed/simple;
	bh=NgWDqx3izSY9aW9W75gFytkLHJndTcTMdemaHAZbfa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HOdV59CNkRcq/I5DQy+jIwSujZHXUdrJ+7TM8GJJOcG3qiAHcSk0yP89QmQqdFd1TQksUGg1ZlTQNkQX0u+jICXsVmEHlVV8G8/lilS7Ao95EMVRppjtoNpi5DWCscChejYKIevFltk6LE2WpI/XXEXyOdeujPQIlnreMBX7fGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJmFpmIg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJmFpmIg"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59b9fee282dso6187044e87.3
        for <linux-i2c@vger.kernel.org>; Wed, 28 Jan 2026 01:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769594109; x=1770198909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgLydv0OAbPSYmy/7mtUdSMM6gy3g70cS63c1sKd/bM=;
        b=DJmFpmIgtYyTUCS0CkFoPb9BVhzBYuPbW+qiq6GdEED0QfSkp2gqib3halH2nhmt0j
         GosmtWI6TEsUS+KKCPn5+WkO1W5+vEn7o/cX0ephjRlPMZQ7lOV9WRlyvJktrSGwjO6x
         mQCg6/ML3MFTxqQXN9ZkGzK2/G2ltkP9jyPH0ZU+qjkhGlaBqKoLc0/VLz9RuKgjp80l
         Cm4vqWS5HrvlwJrQ6t9IuVjJgGEgVoHxs0kKPQxtpwCN/f8VTSok8awKBCttWsecmSFI
         68PDBY28fF3WThr2/AGxBfT6rKTrDLMbyIG262jSwGnOSYrFddwRreuBWqnzrJ1DGEuy
         xcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769594109; x=1770198909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hgLydv0OAbPSYmy/7mtUdSMM6gy3g70cS63c1sKd/bM=;
        b=bk5/EPJXU3etfmCgyxkcwIXnLkJg4XBRitx+V0dyim31N4tiv87/AajEPCmd+QALUp
         7kBlS6eorjOaKHMPQHlW4KkkdfNxHuE0h4AAR49uGCIROONPJsROQY77POZDrwEE2pRk
         OcIspf/mMHD/JpLBoxwUN6QEqutMJ5oftxN1NpCQKnsdQRt3SsDP78NoYp4JT5A6f+l6
         H/Ue7HKf2qcFcBPRV3GFmVvil0zk4uQEtaWhLIVN4//zQkdpHRDmnYZpCR3UKlZDV81B
         tBo/tJcWPIpaNFECTE/i41FQhaLQGy70vifnRscdg78tLFl+/H/wu2cW8vZ4VsDAht5c
         PJ4w==
X-Gm-Message-State: AOJu0YyNNOsZ6BOC75uMEwKlWdhDGCaloofyk8/A6B/re63lmQhFaWrZ
	5U4mjytOKG+SPvNbpywZ2UN3BBeDyzNPn/pSgywZHu4Rl1Az+bDxG+CX
X-Gm-Gg: AZuq6aIZJ6wCooEFoEBc3dVMaGl7hnJd1JbGPqh6J6C7KueGlNp3uxq3WwRmVhjNBwq
	6Af4Rt3GkTXT1fkZIlQt5XybU7XNiGnTJx6tVMpGrGVpxdVaE7Iunf0VIm9JTfkD/DxGf/HlDN8
	NiuBSD4u4Qu+HoDVIsW7LpQ2uJl/+JS8W3PE6emldDnkFPP0SgVNl7tJqinjvvPjVJV5LnxIOqd
	oGtezE4KBVHq0hA73vNuE098g/k67Fijulf4eGVSSPmclGKrQCIeYPl9tROmJoWT7ap1JC28Rf2
	E70QB+24cUUaytqx8Gcn1kBuhpW5vsODsFX5KAXPrU8CYzfyk2u6sLKoiedUemKbv/cDzE1w+kE
	EnQUs8sSDCA9g1ldjFGp3DYphtmlDA2FHzrfMGhGORpmvI2t9Ecd/6M/4GeOd98AhTTuR2I7oVK
	a/UCB4sN2C3mUmS1k654vtK4s3bE/Lfnayhx4pdKUI/0KOGyV+JXxBDYrLlWo3Wu+h0FY=
X-Received: by 2002:a05:6512:b97:b0:59b:9ff8:468e with SMTP id 2adb3069b0e04-59e0412c83amr2449893e87.31.1769594108946;
        Wed, 28 Jan 2026 01:55:08 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074bfe83sm459483e87.97.2026.01.28.01.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:55:07 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 28 Jan 2026 10:54:29 +0100
Subject: [PATCH v4 3/5] i2c: davinci: calculate bus freq from Hz instead of
 kHz
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-i2c-mux-v4-3-dee49ce276c0@gmail.com>
References: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
In-Reply-To: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2849;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=NgWDqx3izSY9aW9W75gFytkLHJndTcTMdemaHAZbfa4=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpedztECNc3VxUquFpfx8TQoFrSB7cIxNlSZrqJ
 OhN7zzlH9eJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaXnc7QAKCRCIgE5vWV1S
 MlXrD/sE0/W8x83hap7Dhta6qJH+6wF6kDCcG1nxuNfBbrETgbLx4/lBqTEH+JGM1kh6cLk+cBC
 OXhIvL0znx8Ye6vGhce2X3A05Vxr81wpEbQbRe9QUN6obI9cvRO9lgAgQbU/G1E3LN0WuPUDpGq
 2keTYvwNLTRFhKa3oNJ0jVezTvxaBjegypn7VqGh/2wsAKFBac0He5JPPm5Y0QHZ0HynM7e6eKR
 vLjy2123DV8Y37F8GNwXvsgh/V8ArPWLz/AFWJgKnP1Jg71uGQkpoE/o+KHJg0VPmGzjdhecORg
 INeawLbjnZElkte5DoMf0b3Cgmef5Ai/CydViiGWFB5LtjrnpIOTC6nPXsekboiTW5n+BS5ce0r
 z8mC53lIH+iNWjMK/EloWDzWZRW9c5r+F5fRIedKlapVON883bMtMNPt6rfwpTjUWxPDfeOzbGr
 WAu806t53dfko2sVuyMr9WpeZcneLS+p0leVem6G+fD7tjUPct3N7Rt/g+0IY1ZFsDPZkMXxBq3
 awFcReXJ0Q0+/CwQCoZrfLAo8FZuVAwXO5fShHCu+8VuzXvmOkM+bsW+bF9VkSmRzrtPGDV3P5J
 LIVRvkRAjDPrO5S+pppy0mF3xvBoxjiUycdjY8TxrWA8CkRLSZqyUEosPD2ifkHPGiGF3stiWZs
 PhoubjCsc3jj1wA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

The bus frequency is unnecessarily converted between Hz and kHz in
several places.
This is probably an old legacy from the old times (pre-devicetrees)
when the davinci_i2c_platform_data took the bus_freq in kHz.

Stick to Hz.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/busses/i2c-davinci.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index a773ba082321..761de5a814df 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -117,8 +117,6 @@
 /* timeout for pm runtime autosuspend */
 #define DAVINCI_I2C_PM_TIMEOUT	1000	/* ms */
 
-#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100
-
 struct davinci_i2c_dev {
 	struct device           *dev;
 	void __iomem		*base;
@@ -134,8 +132,8 @@ struct davinci_i2c_dev {
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 #endif
-	/* standard bus frequency (kHz) */
-	unsigned int		bus_freq;
+	/* standard bus frequency */
+	unsigned int		bus_freq_hz;
 	/* Chip has a ICPFUNC register */
 	bool			has_pfunc;
 };
@@ -209,16 +207,16 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	if (device_is_compatible(dev->dev, "ti,keystone-i2c"))
 		d = 6;
 
-	clk = ((input_clock / (psc + 1)) / (dev->bus_freq * 1000));
+	clk = ((input_clock / (psc + 1)) / (dev->bus_freq_hz));
 	/* Avoid driving the bus too fast because of rounding errors above */
-	if (input_clock / (psc + 1) / clk > dev->bus_freq * 1000)
+	if (input_clock / (psc + 1) / clk > dev->bus_freq_hz)
 		clk++;
 	/*
 	 * According to I2C-BUS Spec 2.1, in FAST-MODE LOW period should be at
 	 * least 1.3uS, which is not the case with 50% duty cycle. Driving HIGH
 	 * to LOW ratio as 1 to 2 is more safe.
 	 */
-	if (dev->bus_freq > 100)
+	if (dev->bus_freq_hz > 100000)
 		clkl = (clk << 1) / 3;
 	else
 		clkl = (clk >> 1);
@@ -269,7 +267,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKL_REG));
 	dev_dbg(dev->dev, "CLKH = %d\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKH_REG));
-	dev_dbg(dev->dev, "bus_freq = %dkHz\n", dev->bus_freq);
+	dev_dbg(dev->dev, "bus_freq_hz = %dHz\n", dev->bus_freq_hz);
 
 
 	/* Take the I2C module out of reset: */
@@ -760,9 +758,9 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 
 	r = device_property_read_u32(&pdev->dev, "clock-frequency", &prop);
 	if (r)
-		prop = DAVINCI_I2C_DEFAULT_BUS_FREQ;
+		prop = I2C_MAX_STANDARD_MODE_FREQ;
 
-	dev->bus_freq = prop / 1000;
+	dev->bus_freq_hz = prop;
 
 	dev->has_pfunc = device_property_present(&pdev->dev, "ti,has-pfunc");
 

-- 
2.52.0

