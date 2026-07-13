Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F09F385D94
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927243; cv=none; b=Z50qLLn2ApN7ixGBdk0d0ooOt6enZuwGe7o0aK1IVs1VrnXWEprIdXDYqgxUifp4p2uwuwMggIJIiE/7D4IV0WtH/G8zfsUD7bZguqYCPy2mdsm0LB8cjIxOmdFiT/7l7WE49nsh5hlWCTJkWI39qfPwOn+8Yik90HW46gtbqAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927243; c=relaxed/simple;
	bh=+XcNRIzkmbYbd4RGr5v7OnmsIYyLQ+F0lGI6snUGPQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OQs+fOjfqttRI3pcu2u2q/b+nSqEYDJccsNln+lYQvlMY2PO8ffQtHqtrREBLC2YZqDHfcSd0X806ua6f/vUCNYOitYw8Wf+a0tQasY1cWzU9bHV11v37YRr+qHQ5rR2h3TOReSY1jp+eSQa5WEU+PgwWmsXH5UvRLiudURi7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rvLuvsD/; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvLuvsD/"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aeb91c003eso3025696e87.3
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 00:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783927240; x=1784532040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Qa1P3gWmqXciURmGpT5GI4VZVYIEIGJapqmcZUGuQg=;
        b=rvLuvsD/vA8inACuwqmcNJ0v0QJuhbR09XsNVxTEZ8VSCRF74XGEi03Mmbfl75ebXR
         u9ok508bnahR66qa6A6LR6mWVlObaXR3zh8tYmoVNHHT6RkTe/5l2tT4ewmHoqfWzc8e
         hUdby6dhawuuq+6b8jTW2V+6p3aKzqsaKJ7RdKfe4SSEMXzrooUa2DgHJ4PuyQR4mJp7
         XXBMT6kneFFIRfo9MDqSpeSt3H42GpQ/4oePOgtu89HAEwGmV6mBKa3sSCk31digIbGE
         zlfR8dOzp8uNSRX5Na/lAfk4GsOj7tpA31huqJU+J0+HRCa0xX5xXAiodjuDgtBZkz+K
         4d2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927240; x=1784532040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Qa1P3gWmqXciURmGpT5GI4VZVYIEIGJapqmcZUGuQg=;
        b=FHfLavXbGI3fZkId5rglhZE6XI5wZwEAO5rqv0uaShNqU+fNoVVPfG7pTzov+fXE5a
         wtG47UqSUc6vffUx/tvfBh2x4qkSLsNUf+f9zux3IbyoNowVJgYcATseT6CroMe6tMYX
         bn+HLwkUPEVH9LNwMqUPSp5goMyx4oXx182GIZOxku/19hIAmORnNtDQ4XCnEYMMgjkz
         loKCZU0kF26hCbl0HpiZ0h0UlnzdYqcK5CRM9HC2nt9ffqR0CArbbO69FL0TjIwrJP+Z
         bCC8PYCVQf/DD+2qiGDgkBe8JgrRP9JNQxnTMRb8FDSZNCN3kx5E4xmD0y04cidm0cH2
         9ItA==
X-Gm-Message-State: AOJu0Yxjk1innDfjnWpHLm/I67LFMqunpCNh0stX448Eug+mREjbF+ja
	K9hblhJmlHYVaNSlZPWRQiWolD1K5yevPYZwEE723WlMFh6rVA7GnSfW
X-Gm-Gg: AfdE7cmYm+awK52byM4gM+R3m++jEGP7aWCubdNPKWWjXSzRIqoDYhzCD8CsehsXicj
	Mo8IEW6ZQfzubIgci62u6V0eUAjgawa8j/yoE1lXkp9XYnezNoc8OJLyjEnQe0t8qpU3BMXdKzM
	7j9nOha/OZ4fWgbhNvPO1KPCtTsBDmCGRjCXTx4K2ZI+68ptem2XxOIEBg1VpNyfXKRNtIWMroZ
	FNrIrhBUZE3CGKIPmjj3IPQz3UXLDymdY/VvKedz1KjifcBAsr0D+/1FMIrZYvTF6xR0+F6GH2S
	g7R98E5BBOPw3d7WzptnANXDEljHT6xTVnxgE5g91SeE78Pv8VUQfynJrjYmOv4kiLFotw1joDI
	LFOkM3f0tq+YkIN7wXZren0d6G85MFZT9F8mLQSFI+qV+XIBquNx3tQBLRWZXNheZ0d18HVVcrv
	kjoEFPKungU0ei26YUSi8yzDx5RQcB1ZWtB4TNvJ2YkhvI2URze6I7rqFXJw==
X-Received: by 2002:ac2:5a5d:0:b0:5b0:1433:13b9 with SMTP id 2adb3069b0e04-5b023666f30mr1407505e87.25.1783927239479;
        Mon, 13 Jul 2026 00:20:39 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca55723sm2625636e87.35.2026.07.13.00.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:20:38 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 13 Jul 2026 09:20:00 +0200
Subject: [PATCH v11 4/7] i2c: davinci: calculate bus freq from Hz instead
 of kHz
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-i2c-mux-v11-4-72bb8af8ee8c@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=+XcNRIzkmbYbd4RGr5v7OnmsIYyLQ+F0lGI6snUGPQo=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqVJG/pzVMAqizUHvztweXaWVBDpM4y5gVWk5HZ
 S37HT5pyw2JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCalSRvwAKCRCIgE5vWV1S
 Mn4fD/9BwGcAZa8DhnVd9G0RNPbmv8PAuimgGEwGv2EKo9MNof4aHekeKrMnsUgq69rra+8Eucx
 WuHqRPWqmDTknWnCKO25jj/NcfkkIsxm6dTWT1b24R3HzaJLPoterISEl5008f8BQ6mrG+grIKT
 vbRpaa7mP7WKkXNpwb5PtcmyJgHE0jip1M23M0U0ASsIBWaAEkICKzeIZoUtbYqOPCTdvxCT/Yo
 BM7RT92Q5dnxBk9bCRIj1iGQf9copKWeB+MkaPC9VtET8qzAFa/rlnA9LyzhZEiRjXDJ3rdbECQ
 K4MhqmvQwmf5EUznjNDshyB8/PvnD9N6d8scAXHHR846hEHzWQFf3eaeHEUevr/U0+luSCFsxYd
 TxBg+cq7P8czHpkkrHqfZI0i3tATjtOfa5gbfZ+E3yJhtJUToly/m4YzGpHCpBELz2PYFWkNDfT
 viO/1pJJdI/XXrD6RytzcudRIBWY+nkbCq0i9pjUCJFEViwhIJXkNxhn4DdJA9H7aDMO68YoFKq
 x8sFq/6KbvFj8icXJeRag7LhBQtSFuxtaRTjI0i+kkKi6iQoJHalam3I7fqwL8i+37HvvginMad
 827vJNbs/tGlrUkHFRULmozg/hziNe4h7lGsgkZWyWT5zY715reM4pIpdmIlMfmBmIs0YD4EetQ
 RiLIhr7gyEp2R0A==
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
 drivers/i2c/busses/i2c-davinci.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index e15eef163a8f..f543997c31e9 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -132,8 +132,8 @@ struct davinci_i2c_dev {
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 #endif
-	/* standard bus frequency (kHz) */
-	unsigned int		bus_freq;
+	/* standard bus frequency */
+	unsigned int		bus_freq_Hz;
 	/* Chip has a ICPFUNC register */
 	bool			has_pfunc;
 };
@@ -207,16 +207,16 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	if (device_is_compatible(dev->dev, "ti,keystone-i2c"))
 		d = 6;
 
-	clk = ((input_clock / (psc + 1)) / (dev->bus_freq * 1000));
+	clk = (input_clock / (psc + 1)) / (dev->bus_freq_Hz);
 	/* Avoid driving the bus too fast because of rounding errors above */
-	if (input_clock / (psc + 1) / clk > dev->bus_freq * 1000)
+	if (input_clock / (psc + 1) / clk > dev->bus_freq_Hz)
 		clk++;
 	/*
 	 * According to I2C-BUS Spec 2.1, in FAST-MODE LOW period should be at
 	 * least 1.3uS, which is not the case with 50% duty cycle. Driving HIGH
 	 * to LOW ratio as 1 to 2 is more safe.
 	 */
-	if (dev->bus_freq > 100)
+	if (dev->bus_freq_Hz > I2C_MAX_STANDARD_MODE_FREQ)
 		clkl = (clk << 1) / 3;
 	else
 		clkl = (clk >> 1);
@@ -240,7 +240,7 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKH_REG, clkh);
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKL_REG, clkl);
 
-	dev_dbg(dev->dev, "input_clock = %d, CLK = %d\n", input_clock, clk);
+	dev_dbg(dev->dev, "input_clock = %u, CLK = %u\n", input_clock, clk);
 }
 
 /*
@@ -267,7 +267,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKL_REG));
 	dev_dbg(dev->dev, "CLKH = %d\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKH_REG));
-	dev_dbg(dev->dev, "bus_freq = %dkHz\n", dev->bus_freq);
+	dev_dbg(dev->dev, "bus_freq_Hz = %dHz\n", dev->bus_freq_Hz);
 
 
 	/* Take the I2C module out of reset: */
@@ -760,7 +760,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	if (r)
 		prop = I2C_MAX_STANDARD_MODE_FREQ;
 
-	dev->bus_freq = prop / 1000;
+	dev->bus_freq_Hz = prop;
 
 	dev->has_pfunc = device_property_present(&pdev->dev, "ti,has-pfunc");
 

-- 
2.54.0

