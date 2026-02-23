Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783135CB8F
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857236; cv=none; b=JuS5ouH7xOWhUfNLEDPqJVaBMvYIXiWRItfTuMZubt6ZDwno+CEmrqQR4/ce9GsuxyCKd/Ef4vb1hPN6L0YQjSaxOvyc9+HdTRXM0wsctrmHvFJ4WEE6k3mtq50p13fSTaREBxRgaQ/Kd55B0WrecgrWRHlqnaK5kdiv9x/hs5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857236; c=relaxed/simple;
	bh=Rjlezx60T8d1CxFV2XLRaRAysWKBz62yOQI2I7gCYFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LgUzo6HZo20ZCmqM5uJthJy7t6T2pBOiTs3vwgDKKanCOFWmMSkfea7uW6HbnafEN3DwcrC+y+dcB5wdL7Q1ndxuY8quiaoUQYanxNCLLrpKpmzV8ZzoAUIoD+TnW4vw5yPSfKcf/aJoJ7knHkmKT6EPDc9vzSZGn0oBx7ZxUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMPJz1D3; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMPJz1D3"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38709888abbso34166391fa.1
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 06:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771857234; x=1772462034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ML132/96OtzaPEHr0g2FW3hc1YN90nAUiFVEwcI9LI0=;
        b=dMPJz1D3s4ZqU7KKoHIykVVAJ+lpsFKjoXSUfLnxh6vDhqqWKFYc08Gp4q7pM/MKBw
         UNtbF4bJIXt21+68sPmtbnua3z2wdfxiepTfUxxSu/YI/Icg0Qu2byqvTbHdSAypf4CT
         oRKF9LVwiNRtrYdRsQmZml8nvc12bVzo/SSmOsDecYZCxVF1dXxh1a8kQJr8+MmCTZEP
         ZVCyeVOm81II6L1vnHjaOK+/gDr4XQf9a1KNGNRcrVo57276t3q//DJ+hRlbKygo3Ecz
         wQUObKZVehiCu/tGeBZOJAbpsVf33CRpl9RFRo8TQLRBZybR3H/+ZVQOyTLayACqMJ9F
         vIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771857234; x=1772462034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ML132/96OtzaPEHr0g2FW3hc1YN90nAUiFVEwcI9LI0=;
        b=C9UI780OsQSkeM1ak3Drd6bDcZ7AQhBnGvcDNbMsSoXTe4PXFMTJWZxla0w0Mmiw1/
         eMpT+nnRSAAgCnSkms0W9HX44UFAVaBzofxIphbLwi/yO0vfriaCCq/DJN4PfvtpisJr
         EVJLo8txeOGZD8zcs6QrG1sPLQK54aiVz7mHFCl7sJ5oZeoEzTPKnxQTJ7seVvRyvyOr
         jVl1agbUVuP0rz5Xx9/A9kdThmtphqbqTz7ZemnTjiq9buPthepst6Bh4z7pH2m6CNPC
         ebMJYBmTqitHql3PZfLwT0gwhioMnD5cFYM2dCl8cim/9MhBJCIhdvuLlAgWrI3SsZ6h
         Ou9A==
X-Gm-Message-State: AOJu0Yz8oXURJtrmxBqKa/6c3QprtADS2d3MZIjr8iVKo80+H0MCi/GK
	fsVOyZs5jrmuXClfYMW+jwRzmn5Q5JaooyWuvXh2oZpNVBXXzewiGPdB
X-Gm-Gg: AZuq6aLtOqby+FVdXZjEwP11VhwngETFNPxwdnW/grF375RkmkeDjQK1Dq1sobh2Dgs
	xyvegqcOu+uSEG9XjEUovZCVdL8znesTHJm86dEzmShVg3Nd8kfhGBNuvqxAgscxuksOcVFR2hN
	XZzoXfD2uKDAz8EOQIBLUpw6hfjr3MMfPU7CH0u6Fhk3cLMBrPhJ+VozuMSxcaWGPRmP1EQv5eS
	sZBicnTmEIvHWTcAHtObN+SI/CopMSmAaY3pua1OPEpvElQ25AE6BtXQ5Ntig3uhadDq8F6Uwn1
	S5OptRxy1qQBrFHNLp90fiSKunOaa01qxttQaYRxlmr+nMmE6t3Es5R2wNOjuUy6jLrgTRASPeM
	QxqltDbyEUFXQw2ffcZbxN6VS+Ya3LdD8jPiPT9DzPES3oqNlN1SWZ6Vvn4dthN18tggeSIP8su
	2DL5HfC/bYfORVkXzqB+N6yjI7xGo7hV5xDzfJTgGXESqrBsIXtPvdtKdgcGDcUK6XG8fuKkDFL
	WSWd44=
X-Received: by 2002:a05:6512:68e:b0:59f:6b45:84cd with SMTP id 2adb3069b0e04-5a0ed89c965mr2597861e87.22.1771857233501;
        Mon, 23 Feb 2026 06:33:53 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb16344sm1631709e87.37.2026.02.23.06.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:33:52 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 23 Feb 2026 15:33:53 +0100
Subject: [PATCH v7 4/5] i2c: davinci: add support for setting bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-mux-v7-4-ec75b214718a@gmail.com>
References: <20260223-i2c-mux-v7-0-ec75b214718a@gmail.com>
In-Reply-To: <20260223-i2c-mux-v7-0-ec75b214718a@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3886;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=Rjlezx60T8d1CxFV2XLRaRAysWKBz62yOQI2I7gCYFM=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpnGVhzIZ66cT2UEVAdWdoZR6qcWocMoWj6ZvKn
 hmeycXUtVKJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaZxlYQAKCRCIgE5vWV1S
 MivUEACBk2EPV07U5h65ZnqBjP+Cy+p4X5YZKG6D4zgckGExFXmlEdcRGt7E62qoatNghWgmKzR
 lggqGF7c+SWIuyG5yZ+EkmViPiiumjqxdVjoP5vAd9X/ntfLcZkeC7+foO8svMqfwa9h9tylvsq
 he/CgCc+SUT6ou9I2FiwTCiRIPVnGzE0scsXQFbv90PZ4HfIGwRITiVXpaA3Fax2JEM4ha4lt1F
 Wwa3sqycWdmKpNqnhrIn9cJYN1Edht2beIk26F058Tyni7LrdOchQAlDZMS3f83erTCecv5ycIT
 BMJnBvxXQuqYN77I7Yl4kcJ3V0eZNQN0RrWrAjH2lNiDhD1O6/gItq9XkTzTDPNDM12qMZ/8ri0
 fy/38HH6WhovvX1ddnvk75EGwk9iSaF4aET3+VSe1fxNi1PGm95uySm3ZoAlyjmZC1hzLZwWOv3
 awfbuw9yYTbwTD0QsHvbxMztkYYG+f/bwOJI5lRzN4QOp5A50NO91eDPx/uvcYjGRmPcXHWkLQg
 QRbeoEbSC+bv+3QebrLbUwIbBIQe9Yd8unvHDCrP2SgDLamMfi9RzmdNI5FQY8UCs4gaA1+MV0a
 1db9GZAsypspQweAv+J5BWwoLZpuSSCugLu8I98gvX4QZrCr8jlCErAKq1gWwkZfKqlWWbPBs4l
 74DcwBD1h5jtkzg==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Populate adapter with clock_hz and set_clk_freq to enable support for
dynamic bus frequency.

Remove bus_freq_hz entirely and only use clock_hz instead.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/busses/i2c-davinci.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index a2b578e0a534..96b78014aa51 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -132,8 +132,6 @@ struct davinci_i2c_dev {
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 #endif
-	/* standard bus frequency */
-	unsigned int		bus_freq_hz;
 	/* Chip has a ICPFUNC register */
 	bool			has_pfunc;
 };
@@ -171,6 +169,8 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	u32 clkh;
 	u32 clkl;
 	u32 input_clock = clk_get_rate(dev->clk);
+	u32 bus_freq_hz = dev->adapter.clock_hz;
+
 
 	/* NOTE: I2C Clock divider programming info
 	 * As per I2C specs the following formulas provide prescaler
@@ -207,9 +207,9 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	if (device_is_compatible(dev->dev, "ti,keystone-i2c"))
 		d = 6;
 
-	clk = ((input_clock / (psc + 1)) / (dev->bus_freq_hz));
+	clk = ((input_clock / (psc + 1)) / (bus_freq_hz));
 	/* Avoid driving the bus too fast because of rounding errors above */
-	if (input_clock / (psc + 1) / clk > dev->bus_freq_hz)
+	if (input_clock / (psc + 1) / clk > bus_freq_hz)
 		clk++;
 	/*
 	 * According to I2C-BUS Spec 2.1, in FAST-MODE LOW period should be at
@@ -267,7 +267,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKL_REG));
 	dev_dbg(dev->dev, "CLKH = %d\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKH_REG));
-	dev_dbg(dev->dev, "bus_freq_hz = %dHz\n", dev->bus_freq_hz);
+	dev_dbg(dev->dev, "bus_freq_hz = %dHz\n", dev->adapter.clock_hz);
 
 
 	/* Take the I2C module out of reset: */
@@ -279,6 +279,27 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 	return 0;
 }
 
+static int davinci_i2c_set_clk(struct i2c_adapter *adap, u32 clock_hz)
+{
+	struct davinci_i2c_dev *dev = i2c_get_adapdata(adap);
+
+	if (adap->clock_hz == clock_hz)
+		return 0;
+
+	adap->clock_hz = clock_hz;
+
+	/* put I2C into reset */
+	davinci_i2c_reset_ctrl(dev, 0);
+
+	/* compute clock dividers */
+	i2c_davinci_calc_clk_dividers(dev);
+
+	/* Take the I2C module out of reset: */
+	davinci_i2c_reset_ctrl(dev, 1);
+
+	return 0;
+}
+
 /*
  * This routine does i2c bus recovery by using i2c_generic_scl_recovery
  * which is provided by I2C Bus recovery infrastructure.
@@ -755,12 +776,13 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	dev->dev = &pdev->dev;
 	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
+	adap = &dev->adapter;
 
 	r = device_property_read_u32(&pdev->dev, "clock-frequency", &prop);
 	if (r)
 		prop = I2C_MAX_STANDARD_MODE_FREQ;
 
-	dev->bus_freq_hz = prop;
+	adap->clock_hz = prop;
 
 	dev->has_pfunc = device_property_present(&pdev->dev, "ti,has-pfunc");
 
@@ -800,7 +822,6 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 		goto err_unuse_clocks;
 	}
 
-	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
 	adap->class = I2C_CLASS_DEPRECATED;
@@ -809,6 +830,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->dev.parent = &pdev->dev;
 	adap->timeout = DAVINCI_I2C_TIMEOUT;
 	adap->dev.of_node = dev_of_node(&pdev->dev);
+	adap->set_clk_freq = davinci_i2c_set_clk;
 
 	if (dev->has_pfunc)
 		adap->bus_recovery_info = &davinci_i2c_scl_recovery_info;

-- 
2.52.0

