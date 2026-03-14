Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9864E3164DF
	for <linux-i2c@vger.kernel.org>; Sat, 14 Mar 2026 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480154; cv=none; b=uzzWwaDgjw8gkXsNKig9EDnGSM+GW8+tTpa/q46MDlygxWMPQmJchZ4Deookl7AFJDFi8/Jqv58sjr+BjxxDZo3Eqkl4fcGQ5x9TXLW0VipNq0SbrLA7pomdNTs97zXVrXSsNEbPsej7tSi0Zjok6iRvW15JRQjIvWsCP5zMZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480154; c=relaxed/simple;
	bh=vsSIa0c3XvGrZdSaP0ssvqDlYgrE1wL3DrKCmY5NXO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBiTgwRAyZNsO1mitfYnnrao2qJyBo5Q49uCU2Cq15QT8FAZtK5gDeyErAO6E78dbMQGUpgCAx3Y+JJ048qAEmKneWgNNnHC54SN6NFzAnyyTfxUmLHlWcPaV1XhpY9wC5MXpawP5MhQH7hEcKGA7t/a2O8p4n2R82DnJ8W5BAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGUkq4DU; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGUkq4DU"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38a2a59baa6so24864771fa.2
        for <linux-i2c@vger.kernel.org>; Sat, 14 Mar 2026 02:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773480151; x=1774084951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5AwS+cqy4cAKKPRWlRgkDDFxDwgSl6qxYrDkjeel6k=;
        b=GGUkq4DU0JjPh4Qdmld/cNJCF53DNwOvjTXX2kw2BQ4AJCEqs1yUx+XOIsyf/ZkXuU
         3qmZHO9oov5ya9OYmBf46Rl704e4KAKi+4nITwi6jsceRV9fwaq2rZNyr6Cfx4AMA9Op
         5AvrsXeKvi25b5lX4fawGLwBhxeU3IY0kZibsUsbsGWmyGDLRO0vfcPHUCS0lM/Yh7gO
         Ib79S5AYRTWLo/mcvON8Melpyi4J46teE6r7xdjxgLEJ61B5PwVb0+K02O85bailXqN/
         4/X3rPVEjR6B1bT/TPdxLK6iTulxsh7WEMh+u3sHscHMPm77lej7b5WA2uBfPd+3PtIm
         TSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773480151; x=1774084951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O5AwS+cqy4cAKKPRWlRgkDDFxDwgSl6qxYrDkjeel6k=;
        b=ssuXIAIXAS8Y6aqPjV592u78o1BPZZsvlLyeWb4GMYkCDF6Hnq8sGzaZy4ymiCFnuM
         X1UNWuVXXXTVa449tp+vs4hizgmjiIjb6d5d7NmgZBSEOBhB2JwYumug5ihO1K1uSEru
         4bga7aRhU9fjUA25nt/Gnu1c0cnFtabZOC2yYNbyLjCYZJA5Ur0kYjOjGNTjlB6oeOOm
         XKwxBT4Y9TgWmOzsmWipjeh4rVQrum1Ycwb73o5VCRXOU9xaAEKC1MNf1yIb8lOU+p8N
         XMRCVWvpkBxlX2p60XSDHlv8cIY+Y9XQ5dyJfQ0dTsymADy7ofeQPdkZVQnLEliFRExK
         k0Pw==
X-Gm-Message-State: AOJu0YzV89KMLt4CEIXDk2yqIozymzMwwg1lnt5C1PvsJRiojxvrkxS6
	X7IHTJ01zh6DC3TBygTdrNlQvNFtGhfYQf0dzYEuq55QU1ZdErYzbDOK
X-Gm-Gg: ATEYQzxHo46I8pldyFI+Kl9lNAGpB+sPLD0uYd9t7rqARnwOom8gHnt7GWOCRu8BCUu
	CZRZT59++9FimomX5W/dSGjeG+HPBTJhCdajyJCpMot1EuoHwdNaLDaPAXg0sshEWY4hVugNV5K
	Pqr0Odu8zm5lM6CR4/axHqD1Wkfv1Ca007WTfg9lk2P78odsiQYQaHXVrpMcXM4zCnLd1SFXR1t
	zohgjKbd8KekEWT+R3mz6QhS1ZD+orezTmWQKRxMKADXMfM1jK6xL42rwet+ObuUoHSUjMQ8AS1
	RWfWE7bhX+skHeVhng4jHoK4ugVa4dqwLDtf39aNPoJ5F310HGcdR/KmVmUGKlr1YKDdPfIdk+Q
	zq8qzK0r5K+5DRAiVbY4SyUfwS7gW969ssHrZceDA8hoBE8nHONWRJj5Cz1ZZXkejXqdTSkfOOd
	NFuyKnUAZ02PNeRJcTCunU448iC5oNZuVjrUTRb5YmD2MxTNUTTCqEM4wWVZaGBmxgV6IH
X-Received: by 2002:a05:651c:418a:b0:385:dde5:1bf3 with SMTP id 38308e7fff4ca-38a896663damr17085931fa.6.1773480150436;
        Sat, 14 Mar 2026 02:22:30 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ec94sm18454261fa.22.2026.03.14.02.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 02:22:28 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sat, 14 Mar 2026 10:22:42 +0100
Subject: [PATCH v8 3/5] i2c: davinci: calculate bus freq from Hz instead of
 kHz
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-i2c-mux-v8-3-fb1738a4df0a@gmail.com>
References: <20260314-i2c-mux-v8-0-fb1738a4df0a@gmail.com>
In-Reply-To: <20260314-i2c-mux-v8-0-fb1738a4df0a@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3233;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=vsSIa0c3XvGrZdSaP0ssvqDlYgrE1wL3DrKCmY5NXO8=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBptSj56Xwy+MgHCIG34d4tFjurt5gk+F9pQ2pq5
 kqyoxNp6EyJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCabUo+QAKCRCIgE5vWV1S
 MlIZEACBCgO7bJ+4AS8gst3qBeg8NEVHmuvcetgmLS99GSwqTUu6+IVEU4oACsNsnQ2p0bIIW+A
 iNQ9BinXfoc3df0p3yh50lqq6hJUyLKwQCXxE9HDJ1wQxZtxXGIvKg/YcZ8Fz2B57uY/z4voHoe
 wt1HxuP7qLxrJp2+HaG7nTMJwrLC8nyaTmLYYt+oqykesf33FWZcHY2+tfcvah/L5LctfYoeoeC
 1dOdlRvTyvPHlgWlBvvZt9OAGXfcRUw4vJTnR8Y7jK+2UeUq2Z/BYIm872D223apEPEv2c+Tg6E
 oQJ6srMBoGvGPgq6QKHkFlFP7XLa1cfbFFXI0Rk1GnIJDSYXUfy2dThHQzStZ41eUTXhJJVD3Do
 hPWsraBXohDkNeqeTFRup3Ef32gAuYztho6eUGY4PcgjOpHQd3FbboGbdRQMOlFPqIizCclzhvK
 bMikaZXvlGYxhiKNN5Fh5mQ3DjKXUoqTOJ20X3ijEcLXkGIluBsGY3tpaw6Zz+EZgfJzjj2HitY
 kZ9YbYaCi6Xt9cVQMZYD5lSKq0F0eLcEPEGe6fUohMUUF0m8LW0j4b0OjFUzWTnsX2XS5qPN2fR
 eFc6J+ar9pi3DLOX7IdyQwZwdmocTmdWFLa3AKf5Z18M9lAI4xjqBm6oria/hQWQSvqLEl1xtK1
 ACUE4pJ/Vltr3QQ==
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
index a773ba082321..549fb22cdf4f 100644
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
2.53.0

