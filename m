Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681C4DF4C2
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062162; cv=none; b=KzbnmpxFWRKvpJQaTDpTLdIZid/qQq5gDZZ5Sr96IHXHW7ZOIW5Xu2zkGlSdntFlaNBQvm/wr4uNpt7JZNT5x0DEgGeJlxyN8HOMYKDqV/73wXO8APE7ifSoRKHrmj5CNyT2DyvFcZzs3xdcBc0EWmwRzzfP3+u8TV8Tx1jR3JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062162; c=relaxed/simple;
	bh=e22RJbTG82qr6LFGcR9T8dUEuzukljfrT5Pej2KkyeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y8gx+dezEgoUShIwSHggcbd2NmLesWuMFR855VF5bypcJD9/QcjP5wIxx3Eqj7CfkfPZs343H9Q6kIbz3ODr8McPPWfQfbU9LdXC9oe9o0nw0PeM3L4AK+C7UT1QfuG3T6lph1s0B/DVd9FNwXWjPN4Cn/caGxBIuaadnq2WT6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEWLAg1K; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEWLAg1K"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b8b3c8c4bbso2239480e87.0
        for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792062159; x=1792666959; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81xDklTWGU+AmdrjBK/MxEzrPsfFoRwViVGtyxcHsTY=;
        b=GEWLAg1KrPI0ZUue59Z/ec0LNhqihKh+G9hN8X0xskEXWRc16DjoKGnUft+Z2znFFK
         0H17imcip4sfPeOFRKB8PzKpX9iomgsq2Jprk9p4mqiJhFlpHIi9gBpXND1RgZTmuFjx
         2nHlo4SDVr13Trbi424vQgs4xKEbnelKpxcwwQyLQXqyas8FP2MVN5E9N0NqWz0Eys6v
         J4W3Ty4Qg8IKj+/jsanySl4sYDkXpjREavz7nQOAzVfRJq0zMCd3C2kjwmbQE17d9+Yt
         2drVVn4c/9B4+ngsPy5zSqVDPqzT8j9GKgWK0c+HlHrPQPaUbg08cTQ/mhffAbNssb0I
         Bc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792062159; x=1792666959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81xDklTWGU+AmdrjBK/MxEzrPsfFoRwViVGtyxcHsTY=;
        b=tVEvgR4VI3b7o5X/FZq1rqRttXZ+MsqU1BoUbNh85amCJdLYiBPBEWKgQN8cpwfuM6
         wtzKn7MrSIMTO4eXV5yApqt3MboDwLPwJBxsIbBu7SVXXyQKX3yc1ILUrZ0Ji0CA0be6
         QLBoFIgjaYHpr7286DBly3OvQYstjtaUUHw5h6dvOpNRGkir9HSuoG8JQ0v//q1YNUOw
         nnkYz2MWTLqwf4An6UwaLqQC/452pvEtj67V2yKuaIFk2HSlyQGdRUwGo+kCrm/dyfmS
         nG9G5ybVY6SQfU7Wy3KvR6aVCblAgxd8RrQj1YjrLMbZ1yuQ+u8SFeITlLPGXAzErQEq
         6P6Q==
X-Gm-Message-State: AFq9FYJYEJ22uy7BuGnzDmC2cjtVyGjDh3M7Uaz+mBpdLLWev8f3i1Ix
	26IvkTqxiCnnjb2tfzVanhxO63Budpd/nvfNa+kNQE4PiOClZkeFViYa
X-Gm-Gg: AYBFou2REtZQdjqbIlrVzAeai7uoA+CUDHgQ5jKlILarw8iBShlYXtKhorMp/MLxlPI
	nvb/HMqOLz/HXKDn4Uu5x/ihemJZLYhpWw41u0fMwJmlzJN+0d4iHoDIH30T2VkiwhIhMAxeKdD
	RmXEWo4yttFe0lHL7GUY8ir8u+bpzL3p8thbMtXAI3m+pfRgj+dgY/ac/CtEiWaZ0cZQ8PlXD8s
	tuASNEdIEstzHeWpZt2mzdbFHtLMOn7s2trvxhP+6xlZ1OiQCV7w+qtLgrFBCPf9mjsDZ94XExr
	O+6GjuKZ9S+1Sx8U+zLqcjsBbu3jYQqhOUmr/M4mU1GgC6qYYKNDbkTQqz6XpyNf3WX3El8cNqv
	VV//G3YJCaZ0+x4NW++8UYVHI2lM+zNH7d4Kkjxjq5LRftfmdI9M/viYixnyXOU6Ker99vAEYgR
	F/MSnj51Lj5LVGQPozb7KRdTV1WEV+ztb4E0FU17x7KmrGx9X/LcAypQ4vBbPKODretn3OIhANa
	KdMtUwiujZJVTV+vO493/VXmO77pcTBd6HGqWK9/6OGd6pNt1Q=
X-Received: by 2002:a05:6512:6406:b0:5bc:e430:9c8e with SMTP id 2adb3069b0e04-5bce4309e16mr4572278e87.2.1792062158525;
        Thu, 15 Oct 2026 04:02:38 -0700 (PDT)
Received: from [192.168.1.135] (81-229-40-193-no2450.tbcn.telia.com. [81.229.40.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be3739b5d1sm905465e87.22.2026.10.15.04.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:02:37 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Thu, 15 Oct 2026 13:01:52 +0200
Subject: [PATCH v13 5/8] i2c: davinci: add support for setting bus
 frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-i2c-mux-v13-5-778a12cfe93b@gmail.com>
References: <20261015-i2c-mux-v13-0-778a12cfe93b@gmail.com>
In-Reply-To: <20261015-i2c-mux-v13-0-778a12cfe93b@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4390;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=e22RJbTG82qr6LFGcR9T8dUEuzukljfrT5Pej2KkyeY=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBq0LK3mj507AETOdbw46lZppl0qAw95zzMLoF8o
 0d940H2IMaJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCatCytwAKCRCIgE5vWV1S
 MlAyD/0fe/EPWjUKTiqAoGRE2frTsmsr1CF3v0fMY8hyetxKC0DXLxZXMZlYeRn2LtemqfBE6T0
 d04rmEdaXKko3c/xo5ZlddxD42tl7Eu3+SH8NnZxSXb+x+Z62I/0lcPeAPt3b7nJPEczZIMY3io
 0bkUAm7heIPNHiU+pLd5ejzmRX3OhJLzWBGUmaLxwq0zyKXWO7d4w6jSJ9NgqWClIC1fg1m5t4H
 GcPVhWKDPdketPaclvQw6W6mRZlZU5vtfIaVksVaak5zla5aU9vOY4Xsh0tLUVHV5kKQYgYXnaA
 rl7Sdz5PUnOctAdXxK33Ruqo7nkc42QcVdw8sXvJsL2lRnyZcipEvbB/2E2ACrKrO1y/OKandJ/
 4DSTCv7XE6k0gx7qEZJ/TQh+nSggX5+plUESl6P5POa9hjHjHRyljdsXfyAgLZgCI5AHlJ2nmnl
 7UBYOY19xeyLFbMvjjZNkzHf6y3ZqQVI3l2rZQrt+f9RIowDWFhkrleeUs/109d5FuSW/XwUmWW
 3I2qr74vubjU46fH2MK9BeckQKzBJFzd/6d/rGpaAmyuT9AkO7OtL3yLLkgStVHDCbxeKje2g58
 WBFOgeJR10hvHuo2L+kaQdjBenD1ObHIq8aIdlw20G6O2WYdyGJu+QMETKzicRCp7l4CP7O8WFP
 rxzVLVKoPyaj8vA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Populate adapter with clock_Hz and .set_clk_freq() to enable support for
dynamic bus frequency.

Remove bus_freq_Hz entirely and only use clock_Hz instead.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/busses/i2c-davinci.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index f543997c31e9..e27cb3bbf34a 100644
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
+	clk = input_clock / (psc + 1) / bus_freq_Hz;
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
@@ -723,6 +739,10 @@ static inline void i2c_davinci_cpufreq_deregister(struct davinci_i2c_dev *dev)
 }
 #endif
 
+static const struct i2c_bus_ops davinci_bus_ops = {
+	.set_clk_freq = davinci_i2c_set_clk,
+};
+
 static const struct i2c_algorithm i2c_davinci_algo = {
 	.xfer = i2c_davinci_xfer,
 	.functionality = i2c_davinci_func,
@@ -755,12 +775,13 @@ static int davinci_i2c_probe(struct platform_device *pdev)
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
 
@@ -800,12 +821,12 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 		goto err_unuse_clocks;
 	}
 
-	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
 	adap->class = I2C_CLASS_DEPRECATED;
 	strscpy(adap->name, "DaVinci I2C adapter", sizeof(adap->name));
 	adap->algo = &i2c_davinci_algo;
+	adap->bus_ops = &davinci_bus_ops;
 	adap->dev.parent = &pdev->dev;
 	adap->timeout = DAVINCI_I2C_TIMEOUT;
 	adap->dev.of_node = dev_of_node(&pdev->dev);

-- 
2.55.0

