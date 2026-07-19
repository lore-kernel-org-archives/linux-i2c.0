Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C9339DBE5
	for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784474253; cv=none; b=Ais+vPojglZes/LD9prLcOwGLjhLvDXDRrRVLgsUmz/s7LFXQx7KZGvOVVL4IwDZ34syqbMX4LeSq6/wP8zyjqfnhmprXcHFeeqLw5mt679lWg3KSI6T+l64ubTo9rh6qTzDI5oMNSX2tDBl1bfGphk0d6d14ebV83t+8YPZFi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784474253; c=relaxed/simple;
	bh=0IooApVNJrr/TWFtnF3D0qsEG9K3kvelVRC/Qgvjyuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qA04319oeWoscYcZxk7s2FCmZUzCWj7wT/CQW7Pw8Om7T316If0ebVzmdVSG808JEpfLwBbD8o3x8fZyGobAUTfl9bJlp4xrfcwMQ+4LMyT0OiK0+iK7gvib2XvDL6NnZhIwtEooW4rFxA2jt4f12FR6glYTbOxRzSiizW37sa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXgu56mu; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXgu56mu"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39669bcaadfso71058391fa.0
        for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 08:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784474250; x=1785079050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0P1wZkKY3oPnYRFvFJO5fhl20ZxgiT2muLo4/CwDf7A=;
        b=UXgu56muFaSEcVV+j5JMXBB6fT9yyoNkiPIhJqqwgEcPD8u5X4eV0eV8EDKomfwymR
         a2j9KRJVOzwH0mkCu7IHOGA9p4nJ4YVZkRAERgrVxgaPppFE84AYzMaBVKdGJrg5BwVj
         QreE6MYY0sEr0Ju9GYz/CeGD6BIlwJOnxX1IvLVvDWlIu1MY/V89VFGwtgpD/S0bOVUL
         9GdMc9jcjEr7LpJrB0tgfVRoll2uULWgH97Gcf4F7EiL304/lTR5rNVIQDNJIWDI9zep
         l7/PE9UIAdPfTqIX3T1CfL9aOQdg8MJw0m1YHwV12icsJu0Sfh6FYi/k4X0diw0AIX0S
         da7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784474250; x=1785079050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0P1wZkKY3oPnYRFvFJO5fhl20ZxgiT2muLo4/CwDf7A=;
        b=UZdLO8Rd9Sbmk7vYFyWmcU8OdFuzto1uKMpHpxERDlsYVEm7thqb/ifftRrJY0FAAp
         0rE4/aBoKUDoyONoJLgBOA6h1B5qgKQQE6bzQMW3cqy0Jy59xwwsAGlnlJ4f7OWx4ZFv
         DfSD5GgZWvasGUK5qfb2/+eDQSMNOqdldVHd9HuMJCIvyKrwlo6RDwA+/sTXP9qfWMrh
         AzZ9eeRRkaTqYs+4sjaPQBcNY+OUPvl40Xtqrn53fpn1a9VlXi2jdsHEEgL0sgx2UUUA
         Se7/z6MKT+OM9TA2wjgPQeC+B1OnQZ9+hyE+rm+XINgFdUUL0O0li43Eqkw/c4cUTHGp
         amvQ==
X-Gm-Message-State: AOJu0YzOGvBGBgT+TVh4Do3VJ5Hp0sIPrWmRhVjm1VgD+BTr1v3ZCHnD
	w7kAt6euJIdQKUDDkoVpGYhCxsojhbfcz/vZZ9j7PQUKiA3BEfsAeeReTMKjma1Wg7k=
X-Gm-Gg: AfdE7ckRVnX0KC/fVU4Pd/e/pSil1NsXt3RYp4fAJS9iyZdfZ3JWrkPiTuFHbxPpB6p
	/P8VcBOfjXYxkksfvIfIiOKUxeXNs/fRlqsumKnz3U9pYPUQb2ZOcq7u9pjqRoD9DDVmykKLk/v
	LrNypdS0alZm+BgCCG1SIu3whGYJox/9pidF88BRz/4uy9g4kKVEDNSv6qocpJcWzaUC81tu6wo
	RiutgXmbWkaOl0fY4z5sLWqxrE5Lz5+NMHnrS3BeW5Ony7ujwnf6fvwvKfKzSofG+5TrQcjh5Vj
	qcx/VSTleYJhVvovjd3vjcYgTddN3RDVFyw0nT6gqH+Bg2iaJJpVTYjtkRnK4QyaYDJAEiXjcEj
	PNrULIZn6m0ZJewIOcdam1w3owHk36v0QywmEByoZYYCo58tTg14dAerIlAxRrTu5SoFcTA50O/
	nSYKug+ch4kvZV3LJ5G6nl99G4M1U5H1OZWsZYFyXeuc5e2Wc=
X-Received: by 2002:a05:6512:124f:b0:5b0:21e3:6716 with SMTP id 2adb3069b0e04-5b28fac5c62mr2539868e87.58.1784474249617;
        Sun, 19 Jul 2026 08:17:29 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291e26e5fsm1835096e87.80.2026.07.19.08.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:17:26 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sun, 19 Jul 2026 16:59:48 +0200
Subject: [PATCH v12 5/7] i2c: davinci: add support for setting bus
 frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-i2c-mux-v12-5-a5010d623a57@gmail.com>
References: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
In-Reply-To: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
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
 bh=0IooApVNJrr/TWFtnF3D0qsEG9K3kvelVRC/Qgvjyuk=;
 b=owEBbAKT/ZANAwAKAYiATm9ZXVIyAcsmYgBqXOqIy07xsgS56s5AGnVfEIWyzaYloyGKeNoyc
 U7m1aeCzuWJAjIEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCalzqiAAKCRCIgE5vWV1S
 MmJbD/daqz3ho1lBvy0xeHIGX1v57Lk/kAo72SLucpqluzWuCi1bBXX0mpaFqtO2f835GkyrVPC
 CH2/Nxtkp82UcdYdO3ss+JncrpWdcFFbz7gWMMkhw/NEuHU25mSkAsuXzzle3RU0BxpJpH9jLjv
 FbCbRp3f8Yn58WIBaNq/7ii43QFAdL2tAxBfm5klQSbFRIFFiIqXvWKJxlwEpCvB0fAaJHoEWbw
 bvrewVsQwcDrzWakzh1wJ+xeXaJGaGD5cMlLXf5nsZHUGiyVruxzUh4U/kG6rFd2hJKx7D5jWy5
 z7vh2JMQ82NSKxeLCZS5ZDj15jMdXUtmZf5PoOt7kp/CQXBcMBtQJEIWj/Q//1cGmuEsF+07gTd
 EevJD/AIIiTOwTh9DN82llPVJwMWsM/pnbOmRgDfMayaVPVBKLVVLsXiwjbJ53aAHUMEZEqI4y2
 nGXvlmAl8YkE3LRTnCj/48DjZes9tahbt4hoVNd7xCTjHkJzxzaG4ZphMW7gG31oA/l8TJhFnDu
 93In1lrjS1JUz6P7JIhOzlmaz2BU/78XzpOf9IsItrEJ6LVGWeMo5ZVbS9Z1vqLBvNXlC8VnIDT
 E593gorOQhn95pSjfdilpVBY3pwmbTujLAPzr8afOcUpxVvXynVIBGO3Cu9zPpupYKSkNwQeotc
 he3tYFNLYAYmY
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Populate adapter with clock_Hz and .set_clk_freq() to enable support for
dynamic bus frequency.

Remove bus_freq_Hz entirely and only use clock_Hz instead.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/busses/i2c-davinci.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index f543997c31e9..87fef17bca55 100644
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
+	u32 bus_freq_Hz = dev->adapter.clock_Hz;
 
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
+	dev_dbg(dev->dev, "bus_freq_Hz = %dHz\n", dev->adapter.clock_Hz);
 
 
 	/* Take the I2C module out of reset: */
@@ -279,6 +278,23 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 	return 0;
 }
 
+static int davinci_i2c_set_clk(struct i2c_adapter *adap, u32 clock_Hz)
+{
+	struct davinci_i2c_dev *dev = i2c_get_adapdata(adap);
+
+	/* put I2C into reset */
+	davinci_i2c_reset_ctrl(dev, 0);
+
+	/* compute clock dividers */
+	adap->clock_Hz = clock_Hz;
+	i2c_davinci_calc_clk_dividers(dev);
+
+	/* Take the I2C module out of reset: */
+	davinci_i2c_reset_ctrl(dev, 1);
+
+	return clock_Hz;
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
+	adap->clock_Hz = prop;
 
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

