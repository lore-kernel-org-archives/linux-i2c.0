Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE4243D50C
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513016; cv=none; b=AdcZFpHXRr0zfuVXUYRoRCFOFkUFerpoCW40rrMRPbZBXhlKbQ6NpwvAj8eIQ27Perex48DFFMzVxJjnTZSdIOrQQAjTqQw7sUjltlO4l+x84mQUrYfoRHj5NGjdHRjp6GBQaPfnHqKfFSc7cpZA2/+Fl/HN4kgbDYyXxV+O+a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513016; c=relaxed/simple;
	bh=rB67qOCn48aLRV8HAmCeHp1RUlscq2JCZSkPmgPhVzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hrjln3utyvB+kEocNQubPzRBm4Fe81vLheiF+WeNqp7nxZThu6fl+limb+u3alBBwSrlYu4uE12eWvgk45C+k3OvcgHNKD70yycp85cDMdkyZIjqpso6OGpeMetsUeSYvpw2/sVuNUDOtEuyK67eR0lnRD4Ye+jLHKStsTDgxpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pN01CBv5; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pN01CBv5"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aebd52488cso647732e87.2
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 05:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783513010; x=1784117810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9uIFX9gmwYckmh1V7qFtkicRfJ2rKc/mhUOwAgiSoc=;
        b=pN01CBv5qpH9QIeiJ+mlZYFXTTPPrsxCaMLQrlERW5ui3225yUIn2hKSEhRxAFxtY2
         IVSrSY1XKmVPntxJMo0kie5hS2vj2JuYN6HPXFes7XrxrVYGS4HVIZFPRo0b00ryGx7m
         9fqt9mHSGDuktL2obzdEAR6BJcI8joGpI2QhlJ021vZfe9Za27of4/5hp+hDI0vGGriU
         4SuzwAlKC4hBnCnybGKwda/6fhwWohnHIfKztolErLCvS6A92yzlraQVIXF54q0tipO/
         1fznzTEmQV1BIrBwxnz8dvz4gMBHZ/8qVcdpU5VYIED1/f1DoKkIcFrzmB4WObBVZJ8I
         5UNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783513010; x=1784117810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o9uIFX9gmwYckmh1V7qFtkicRfJ2rKc/mhUOwAgiSoc=;
        b=Hu0+508vSBSgrkot7vQQSh/sJcarV5/t8WCiaZkb8GGI/4XV2/Bausrkq+Jd7QqILd
         M4g3409Nb2nPIMpO+EFe6OXxaTC/9hT4retiQ3YHXFHUwdM2+WNN0syNRwb8zksngYJe
         vBAWoALEeyWjr/BJZUWEJu4VZQYmTu5e0Qqg5WiGBnxPjPMBNly6/O1u6oL9zgdoCxmg
         vkyohAFcOe/iuFvy9s2GSZ7QLAkbz8EVgZMO1MXlx264+qw52tSPWXYvlghxRc33Wgqy
         6Tc7Oc+Hfu4m13wuoNiHTNprq+6H/gRMPgL1k1oB5X7aaMQZIJiAQXumiJRrVLhyNtTU
         vkiw==
X-Gm-Message-State: AOJu0YziNa/mTOjMJXMJH7AJFHsIRVdvR17xfPDuqrzfNh1VTgnIqthl
	D6YOWUO4CE1pAjoLFFX5/iRlhQ0FnwF4Z0SCel/oW9JK+FzTULw7UJWa
X-Gm-Gg: AfdE7cmNgqIKABJwMclKcOmQo+BDDdASapB1aDxuqPFhNct34tLupQqlpfP4rNC8nB3
	XgRbldR6D5zZLcw+3BXas7aUMtPiNUAk0VPiTwGBFiFNhFmKNSP95zj8z2HkVFClMunVpYfEYW3
	yJW5GMwTy+bghwYzOu9Dpv68pupGEE0dAl25qlQg1q+HNYTKbuDq9ArS1hbGGfBxvJ5KXNdkY0H
	p6M1PvaFScGOszU2IimKmK2hbsY+mBBMzwSFMNcWd3i9v4daBh1huU2Ee+tSWP/3174SOR7IIrv
	m3WAqlhgS8c6Wceg/MgoPPiCU2Ek8U9QvsXOdQfNxIr0bBxhJAJKsz4YLSHcdvb9KFX76KtoQV1
	COMXJHWU/R9WGJAkc/SzYN4t2/WEtUoJ105vjL9oT7zMbaZlDXVJEKKUCRIshgOgdKBL5TPr5Cb
	Olz/EMNV0x2yDD6dKWWdHt+hjBSTmwNUYxGHPSsPUGyRliaHikqULRbghqqw==
X-Received: by 2002:a05:6512:4604:b0:5ae:bf31:54ed with SMTP id 2adb3069b0e04-5b01141b97emr562782e87.7.1783513010229;
        Wed, 08 Jul 2026 05:16:50 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bbbc6sm4471459e87.41.2026.07.08.05.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 05:16:49 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 08 Jul 2026 14:16:16 +0200
Subject: [PATCH v10 4/7] i2c: davinci: calculate bus freq from Hz instead
 of kHz
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-i2c-mux-v10-4-09dca03c8a15@gmail.com>
References: <20260708-i2c-mux-v10-0-09dca03c8a15@gmail.com>
In-Reply-To: <20260708-i2c-mux-v10-0-09dca03c8a15@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Peter Rosin <peda@lysator.liu.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3236;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=rB67qOCn48aLRV8HAmCeHp1RUlscq2JCZSkPmgPhVzA=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqTj+jLNWA8FIa1T/o8BCVuE3HLi/7ll+OQIOga
 YdoyWScpUiJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCak4/owAKCRCIgE5vWV1S
 Mk4zD/9d8cJ3ypeLwdc6f9ef8oHp6LU3OlAg2V13Gw/gtp40jcVdUdH9TdBF2SmY8pwBhmOgCvm
 cV0TWsiy/EaAjFbqPf8pzhFN8hsB00kdoRl16tuumSAscuYt34olo8iLYoVj2RvZQEzaCQ89HKY
 5MHuhI8iMKEcaT1L4+0Q/lZOv4pOAU7FMm9OqDSxcuGb9fbw780FyhPG954UzkVUFle3XTl5CoY
 Ty26dlqlgEp3uPB6ZI48kI0mHGMbKUWYbe9U1DOjBVUMhojRUmjL0MoWMYd1xEa3CB3kTuJfHRa
 woxNHopGmelRRWAoUnToOS1+QN5JRUtvfivOuuwtcgp7fb6lgRaZ0U1m4hbBscItnpDTcvOyxnS
 pAh+diBahUlkoSE/JT2TpOVw3e6EgRySw5ldWxh1uj0Lg46vbKrFVFIbdZaYM5y3CnE2St21upv
 i2aKPB/8xrsvTaxloVh2jy17qKEjL6pKE92jKF9wwYeMVTuU9EsfbC/sDUFhanB5W+I/W/iNEPE
 k+X4RAwcMJe98J0hisTnE2whxsMK5kATxSzcxh428Dzn5FFtikr49aniKsELpHwFOx6y2UvC1qD
 d9sSBZfM4lNdG/tAXlsYtYFVfLU5tYcDOngle7Xoa/rK+ArGmtRC4HU4dNiwoBJSQyw4pLdvokG
 Gy1xiRPAn7JqyPA==
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
 drivers/i2c/busses/i2c-davinci.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 66c23535656b..549fb22cdf4f 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -117,8 +117,6 @@
 /* timeout for pm runtime autosuspend */
 #define DAVINCI_I2C_PM_TIMEOUT	1000	/* ms */
 
-#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100000
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
+	clk = (input_clock / (psc + 1)) / (dev->bus_freq_hz);
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
+	if (bus_freq_hz > I2C_MAX_STANDARD_MODE_FREQ)
 		clkl = (clk << 1) / 3;
 	else
 		clkl = (clk >> 1);
@@ -242,7 +240,7 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKH_REG, clkh);
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKL_REG, clkl);
 
-	dev_dbg(dev->dev, "input_clock = %d, CLK = %d\n", input_clock, clk);
+	dev_dbg(dev->dev, "input_clock = %u, CLK = %u\n", input_clock, clk);
 }
 
 /*
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
2.54.0

