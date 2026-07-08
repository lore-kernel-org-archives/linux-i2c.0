Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339CD43E4A1
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513016; cv=none; b=Q5+5ua0z32brWuKTJBDnRID3ceVkWxdpKHM1JfiqnbG4xpcYcv0yiqd1bxvCogHmiqu7L5NjBAgbANzaKCCgpqDIUbZbVqjdmwQ1LkR4Piyl/i/X0Awgs70fxeJVcJEyk6zigy4ABfn+geAWGVCGWnnIwmGkPHaMMmHgkIf/Iws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513016; c=relaxed/simple;
	bh=i0MzyPSyCHemenGFkixpELNTDZX3XPRlllD75eljshA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TI1KQ/C6eS6+i5CtdZO/qFXKgcWTNjvFc5DjRidypTwhxeB/dnkGhmh3kpoekZ7JgYMBLZoQWaLgHlIKxkMseB8voqGvacoyN+eW/a/MwGZfFOpYmoIvGSeiQtrSeWxFA1wL8jQ9A5dQ75pSIWT1+x1kb/5NuqEKIssMVaKsRoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4SjJFbh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4SjJFbh"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeb5e85378so630302e87.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 05:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783513011; x=1784117811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4ngO6LQ445yVIm+0Mq73SpzwdNfhUAJBkx6M7Jo6mI=;
        b=g4SjJFbh1EXQO7wUf6L2lw2mScJEUvR+E21E3mqBPXgMBQZiEhGi40xCtZzNAwZZhu
         RAs9s+hHrUCQ5ij+BdIo3rIwrFiBlidb2Ran3qaA3VV4b0qvdNaMZytUXhYPg3MZ+hEC
         v0lMxuiGF7aMwuYhUsxQz3lXEXKHD9G5MnFp5WcHiljsz7++v1iJuQ21Td+0dGGVONc4
         PvcVEnjt6xn+haxGZYg6PJcDic29ItLK9cKQp2UYg7ArBeKEfFtgzOAsS+BHWCORZJ5O
         5s8W0lRyJ9aHg732a00gid6eGmPKTO7ID8WNWHguhdrGhY4mh3DAk7N/LhmMGwLBW/dp
         dceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783513011; x=1784117811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M4ngO6LQ445yVIm+0Mq73SpzwdNfhUAJBkx6M7Jo6mI=;
        b=heWWTvOOdF8tJKQ8rV/GMEKeXU/4K9rpbnnTHsV55r78gugHf2uW+t18Hqmq3cQyt2
         vI/meM8WMmUmASRjA6fbYantVdtxu5Qh7k+RkHz2eEu8/DQmnebys53SHY5V1Ls2aUJn
         SlyxBaWArIyCI8/WJPAF6bgZzUIukHXINKCGNJvgf0ea5s5Z5E/APa0g8OZgBnoc428d
         VAUadmQGwpapJdghqNHWpHM4h6w61CHRFfBlTUyOI1WdVkUF4UhM78oyY/t7fpvboj+O
         gPywD3dfw5fxGdvPc+2iSxmRFhvGyluXki7d54/ggGX+RKZIFMzMLzFVOmB6aOmcNUEw
         +fXw==
X-Gm-Message-State: AOJu0YzbGEZx2pz9NtMHgiL/f0qyJXf5Pgc/bz7zwRHapOSrwlU6OGQK
	am9MbVfCbYHd0twoBxsf6FZCStBJK5EGEneP6fGDJMO41egjnEmIjZi6
X-Gm-Gg: AfdE7cmidTkhh0UONEbhypDirYCC9uRe1SHVcbWfHG/be7pK1Mv2tEx4JMSwp3Gn6Kq
	wbQz+AlEJQ976EjwBOivBNJnIgprbA4nnSKRl3p5EB9QmIZ8AkXMst/oBk5YVoiYgrEpUpXRAYS
	5MRbfQe2/3OXIEYEAu1g59rOyLlkN1Yt0rgcFmv29HTpwaxOE8CSQL+8i8FhcmluQqLKRfgh+A3
	cDpI00gPke6gZtfdMyOgimU2Y7d0BQPTBLok1ZG/IAEHmVbL0vSvBpgJt3dovW+ikLUk0hkm8Xg
	qeznbH9/U05ViZRIQx5/1W4mC3I5bZc5/wXsfeP1sp9gjNqrt9w1hvJpvNPydPcLQNFGk5GcAwV
	47KTXc8FQDYm1ikUK61oPAr9nwutchCYbTQVhRK2ZDJcfMoCQ1Cq1fIYP/xFPsUQnDlFQSFY2qn
	CXZOz9qTSoknNU3PqT1V9dSLYl0bE4sE7x2eh1IiutGyqdMf/nTcvOIL89JZmWFefZU/Fg
X-Received: by 2002:a05:6512:358d:b0:5ae:b62d:3205 with SMTP id 2adb3069b0e04-5b01147ac43mr433734e87.14.1783513011316;
        Wed, 08 Jul 2026 05:16:51 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bbbc6sm4471459e87.41.2026.07.08.05.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 05:16:50 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 08 Jul 2026 14:16:17 +0200
Subject: [PATCH v10 5/7] i2c: davinci: add support for setting bus
 frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-i2c-mux-v10-5-09dca03c8a15@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3829;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=i0MzyPSyCHemenGFkixpELNTDZX3XPRlllD75eljshA=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqTj+ots8cu+FKDeonoFwNBgioHD05/dGsQ3jPv
 g0dgiOw4veJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCak4/qAAKCRCIgE5vWV1S
 Mhu+EADeGzF68my1I2YE3fmzMrHzVkJDP0KAchf3oIBo2pkG91mfjP7htpTWpt8DvkRkFPSeJfq
 afoVZ9JAKBNRujeVE8YO24LmeW60z67pXHY4TYmpgeTHwaGQCNRsICgsnGpaxrdCxYwi9jpnPwW
 mAd0BGOrwTXiC8tjEATc/oXkv2KC0/F7LuuetYIlsmAtAuD5EHslg3LCm+aqlyP1cmocHn1n5BF
 CUMniC0hguGN75+2cwGgEsMx1gW1Reh26HyLgTnyGV3C6wy6ghRlzvrc/mrITL2eHTvAUgm9YPb
 /3hZtgU1vPVYba3jiA2jDZqwM7y4bQ4rtS0rpFPlZSJrdQ5/IeEFN7ohqriVfS138XyYZuVd3rs
 /OGCky9BuD8tAXFxyoBUasl0x5cma06qWcac3O1fm+vVcNDL+5tV7bIsXPbfp2Fw90VHnj9FldY
 e47Fqnl9cpO6XhB9l0X6Mn9wnct6QXFycg8gf6g4YvN8jGo1PoxyeY92yMv/kEfPliN6775ZL0n
 bjA9/QwkF0A3XSdkpJiokaDUbtnutIHzML+uGutj6TKXOoTV1mDNaujF1BUTtK5mtzTd6C+Ka+E
 WJnSK8PUeQ6XD3oq2kReuaNVXwIpOL+logmHm1FySStrbDm76XhR4ou7cdh5AVAg+MsXA79rqFg
 lj98HqrZ6f2SPIQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Populate adapter with clock_hz and .set_clk_freq() to enable support for
dynamic bus frequency.

Remove bus_freq_hz entirely and only use clock_hz instead.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/busses/i2c-davinci.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 549fb22cdf4f..fd87dc661ecb 100644
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
@@ -171,6 +169,7 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	u32 clkh;
 	u32 clkl;
 	u32 input_clock = clk_get_rate(dev->clk);
+	u32 bus_freq_hz = dev->adapter.clock_hz;
 
 	/* NOTE: I2C Clock divider programming info
 	 * As per I2C specs the following formulas provide prescaler
@@ -207,9 +206,9 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	if (device_is_compatible(dev->dev, "ti,keystone-i2c"))
 		d = 6;
 
-	clk = (input_clock / (psc + 1)) / (dev->bus_freq_hz);
+	clk = (input_clock / (psc + 1)) / (bus_freq_hz);
 	/* Avoid driving the bus too fast because of rounding errors above */
-	if (input_clock / (psc + 1) / clk > dev->bus_freq_hz)
+	if (input_clock / (psc + 1) / clk > bus_freq_hz)
 		clk++;
 	/*
 	 * According to I2C-BUS Spec 2.1, in FAST-MODE LOW period should be at
@@ -267,7 +266,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKL_REG));
 	dev_dbg(dev->dev, "CLKH = %d\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKH_REG));
-	dev_dbg(dev->dev, "bus_freq_hz = %dHz\n", dev->bus_freq_hz);
+	dev_dbg(dev->dev, "bus_freq_hz = %dHz\n", dev->adapter.clock_hz);
 
 
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
 
-	dev->bus_freq_hz = prop;
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

