Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E38389DF0
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927246; cv=none; b=tpkPiDcA5C9nNOQuE1sHZLPRP0jBFopA4ylgjsgQ9zqD0r4fOX4/Miqx3lpBm46oUdHR2qp8/pD/O8lyNewDg9X//A1jZ3t1ZfjgvblTfDhs4jPuPbynGzrD2GzZJsmz67FZgwGbbf2N+U63fPn0XNJLgM3CDbFuP2sUMREpbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927246; c=relaxed/simple;
	bh=KipNKAzTJU8VgRjKDoGKNRn5s5XpRFE3NoXWRS5HQQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X07j1JoJLbjDOg//VGDodpl7RgfswiUlOpRylhD5AfElcEkgIg738DQdGqj25J8or1V3IE76+82/UgjkBY1NMIGf7v3KOijUoNNjRtYLC3s14tkBvbww/kcWWFQGxIrR95E4xVDty6tcf77Lim8qMC/0JoKEZ8AwTSL0Xxc1IfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/LSsW0B; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/LSsW0B"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so4132187e87.0
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 00:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783927242; x=1784532042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LK67j8GtIdgh2zXDGYw/AI9RtdfrjczxIkn8lzlmvug=;
        b=Q/LSsW0BNYiT4P+ATz/Oo9wHjhzXk81LDGj/aoL/fJ5HuVJMhKVwpfeJDdXGJF5U/u
         eMfXFM6HNOqpUW85aHDXYUczc59PhOKtLsHDQ4qJfefD4gLVW1JVZT6IJDo5o8CeZOD5
         HTckWSr58yypFA3d0nQ3K7W9yyCLq2HUEz+d4ews17wGi45YYDY9BqrYYDnk0jWg3ySM
         F1TWZOF2TjnltU3R38ftN2bg78ITbfpHaMTxTos+ARdC1x4gvz56yhS3wUT6hfUQ09sg
         BIqcH4VLCHSotDlC2mlxZZls5EWAInE2G9xzUZs+cPn4OTek5yUROk/kS7XZ+iQ2SQUs
         Si1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927242; x=1784532042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LK67j8GtIdgh2zXDGYw/AI9RtdfrjczxIkn8lzlmvug=;
        b=gCzcHXfDeFNAEeWTDBuTCuebBIuJnPq4tbzI/+/mKOUXqroDjSh4KHTsnsnJNLppKG
         x6dzwwcN41WUtCKosn56BtztZQ6eahJFirlG/7RG6DaCStfr4mh/sQTeK8qNxjWOMJoS
         zIoX6PC7TiagXq/VGsd24PmHgEo32Y+o94hbeWRMp2CyocETugNlzJ2E61hvIV6Wf0KX
         UYd2OUvf9sXZT18thKW49Gku8Rh+1gioPCIKYDan5WQhfb9M4dOBT+/dzOL7ZtGOVspA
         qqeWoHflFFF2hLKx5/Fq1KmSr1gw5Xgs8Odvp1bNz/PQdkWWrN3qJckkkY27LXL+K/HQ
         7CUQ==
X-Gm-Message-State: AOJu0Yycr8NwUK7YpXLZCn1DgWk7Q41LukJYjIU77G3s32mQxBEr8gRn
	UqZ6MRdbt77ZV6ieNRHYmufctF5qwDcyRuNLeNFdzXUxGOvvvT7WCqzr
X-Gm-Gg: AfdE7ckr1/P0rAW7p7c2bX2U920BYvgrx0IKjTRwV005tV9ru4SBwMdwkfcJrXR7IO2
	mRlHyJCkaHVmz1o7JasUc6WBoToEGG7VR4opuaZxOK9g16X4xS1iHEVCkYdFNDr2oWyFzM6vuHq
	VeV4rR2b3fYLVCrESaaUZYqVyTsQoWjUDx41Uhhe36n/C9m64sJojRIc1/FvydMiWPmC5WTY2GO
	dfFkvhdhSiTIn383J5zjSy4Yz9OW9x/pvuljpGcR3aGFOIcgfcKD5yDVAXOe3QxN/AvpXgSIZfJ
	x286INTZ7YVKwf/lZwLOt7wa3xSW+Af55cmhmHRl9aIQtkaDWtCBWBznjgTsYOLLuXCGJxuDQD8
	UYUf1HD2+t05oCCYoQ/72j8dgq1uSOCwicxMiLu4fJ/OQWJaluAbAHdMzkL4jHgwNdJqULFAQL9
	w0nY2ihiGL/eZEJ8NJZ2q2hkuN3zN8/Jmg7qP2VkMpzaF/kBK4Uxezvt32EQ==
X-Received: by 2002:a05:6512:3509:b0:5ae:a9eb:eff0 with SMTP id 2adb3069b0e04-5b0236b3f00mr1956757e87.57.1783927242235;
        Mon, 13 Jul 2026 00:20:42 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca55723sm2625636e87.35.2026.07.13.00.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:20:40 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 13 Jul 2026 09:20:01 +0200
Subject: [PATCH v11 5/7] i2c: davinci: add support for setting bus
 frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-i2c-mux-v11-5-72bb8af8ee8c@gmail.com>
References: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
In-Reply-To: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4119;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=KipNKAzTJU8VgRjKDoGKNRn5s5XpRFE3NoXWRS5HQQc=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqVJHEIYnKNxtWilpVrad41XofG86sGu06CkLzf
 K82KPt+QaWJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCalSRxAAKCRCIgE5vWV1S
 MvUCD/9LWlczj0L1fn2joODNFGQb5woOPuSNDMMw85B4V5Wrc2ForgHkbHfPvwBjF/xVQ6f6JS8
 SuDQDnzIqvsuMFzw8R5LfUmm5ueZIDPhQmZbVGXJgzyCl8xO0tq0uOHYOHbaICriYM0XlkKBWBw
 e1uQ92LgMebc+FmEQJFjjbWHMKWJ14QHVADKqiVF7t6rl6xYixN10JDxEQDJMpXlz2W5OOu220h
 +A+ExVcp3Y770NBaHD57rNHcbddOxCdB6UelwsqFE0sYf33EYrLzV9IK3VnuCbunKM6LIbFPJ+Y
 M5top4ePflHSPJ4VN3z3kH20ou2P6uq+lyEv1/rWbpUhChUyapBwkpLLBY4AB+bxyMA9hq9lLzU
 5C38tYq3hsYE9j/3yG8QwYstzhpDUR40OnPz+IWxZv5iXNf6FMbOxgBePiFGBUKgvHsIhYNK0JU
 gW6wbOettVXjgAWzW1B41Mylp/Duo4a5YVKFFb1luIoAsexGN2xyJLjkBBeB/6AqsX6sD8KlMck
 NgSDCk+V42y/Hd2cJ3a/VCKTjG7qwcvFN8B4SYk0iWMj46H14iBwhsabi4KDbA3Y0dR+8pNu/HP
 zG5OdeqB1JzXFJWR4thJBzZfhQ+SbXhzY2gYYt+pPQ6SAul2lHuvEu1fjEPaCCgsBbb6pyvmNK0
 D2kerlOLYIt/03Q==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Populate adapter with clock_hz and .set_clk_freq() to enable support for
dynamic bus frequency.

Remove bus_freq_hz entirely and only use clock_hz instead.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/busses/i2c-davinci.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index f543997c31e9..06e8af83df0e 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -132,8 +132,6 @@ struct davinci_i2c_dev {
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 #endif
-	/* standard bus frequency */
-	unsigned int		bus_freq_Hz;
 	/* Chip has a ICPFUNC register */
 	bool			has_pfunc;
 };
@@ -171,6 +169,7 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	u32 clkh;
 	u32 clkl;
 	u32 input_clock = clk_get_rate(dev->clk);
+	u32 bus_freq_Hz = dev->adapter.clock_hz;
 
 	/* NOTE: I2C Clock divider programming info
 	 * As per I2C specs the following formulas provide prescaler
@@ -207,16 +206,16 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	if (device_is_compatible(dev->dev, "ti,keystone-i2c"))
 		d = 6;
 
-	clk = (input_clock / (psc + 1)) / (dev->bus_freq_Hz);
+	clk = (input_clock / (psc + 1)) / (bus_freq_Hz);
 	/* Avoid driving the bus too fast because of rounding errors above */
-	if (input_clock / (psc + 1) / clk > dev->bus_freq_Hz)
+	if (input_clock / (psc + 1) / clk > bus_freq_Hz)
 		clk++;
 	/*
 	 * According to I2C-BUS Spec 2.1, in FAST-MODE LOW period should be at
 	 * least 1.3uS, which is not the case with 50% duty cycle. Driving HIGH
 	 * to LOW ratio as 1 to 2 is more safe.
 	 */
-	if (dev->bus_freq_Hz > I2C_MAX_STANDARD_MODE_FREQ)
+	if (bus_freq_Hz > I2C_MAX_STANDARD_MODE_FREQ)
 		clkl = (clk << 1) / 3;
 	else
 		clkl = (clk >> 1);
@@ -267,7 +266,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKL_REG));
 	dev_dbg(dev->dev, "CLKH = %d\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKH_REG));
-	dev_dbg(dev->dev, "bus_freq_Hz = %dHz\n", dev->bus_freq_Hz);
+	dev_dbg(dev->dev, "bus_freq_Hz = %dHz\n", dev->adapter.clock_hz);
 
 
 	/* Take the I2C module out of reset: */
@@ -279,6 +278,23 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 	return 0;
 }
 
+static int davinci_i2c_set_clk(struct i2c_adapter *adap, u32 clock_hz)
+{
+	struct davinci_i2c_dev *dev = i2c_get_adapdata(adap);
+
+	/* put I2C into reset */
+	davinci_i2c_reset_ctrl(dev, 0);
+
+	/* compute clock dividers */
+	adap->clock_hz = clock_hz;
+	i2c_davinci_calc_clk_dividers(dev);
+
+	/* Take the I2C module out of reset: */
+	davinci_i2c_reset_ctrl(dev, 1);
+
+	return clock_hz;
+}
+
 /*
  * This routine does i2c bus recovery by using i2c_generic_scl_recovery
  * which is provided by I2C Bus recovery infrastructure.
@@ -755,12 +771,13 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	dev->dev = &pdev->dev;
 	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
+	adap = &dev->adapter;
 
 	r = device_property_read_u32(&pdev->dev, "clock-frequency", &prop);
 	if (r)
 		prop = I2C_MAX_STANDARD_MODE_FREQ;
 
-	dev->bus_freq_Hz = prop;
+	adap->clock_hz = prop;
 
 	dev->has_pfunc = device_property_present(&pdev->dev, "ti,has-pfunc");
 
@@ -800,7 +817,6 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 		goto err_unuse_clocks;
 	}
 
-	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
 	adap->class = I2C_CLASS_DEPRECATED;
@@ -809,6 +825,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->dev.parent = &pdev->dev;
 	adap->timeout = DAVINCI_I2C_TIMEOUT;
 	adap->dev.of_node = dev_of_node(&pdev->dev);
+	adap->set_clk_freq = davinci_i2c_set_clk;
 
 	if (dev->has_pfunc)
 		adap->bus_recovery_info = &davinci_i2c_scl_recovery_info;

-- 
2.54.0

