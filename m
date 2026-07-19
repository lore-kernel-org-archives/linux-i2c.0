Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEF839A075
	for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784474250; cv=none; b=Ei+krPzjz5Jq3ulhtyZAxTMggM1+M6JdD5F+QCW44EKSVvxpZKzTlyOB2ak6onR0YWtvQGoIty4v6WTPc15tvhtf3pcZk3ipag2Scs1FIlVR9gNI60YK1mrbsWT9O87XlSdJQf6Vam1R+Vz3ZdNuqHg80O2niHY2aSPaBBu+NKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784474250; c=relaxed/simple;
	bh=+XcNRIzkmbYbd4RGr5v7OnmsIYyLQ+F0lGI6snUGPQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BMvt2MA/CqrnHwGtPuPUz6TY1Z6xMb6WdoRXiMxD16XeEJsGipdzKiIbNrTKWTa7uq95Cuodd6ET0ABpnlo4A4w2XHVvX24GP8Gg+OYTvR0DRHYa8/8GEu6BKwq5SMGdzjGOAdD37QEPV5LOfCNEv0fnf34sNfrs2RZBQ8VrUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8KkSQsE; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8KkSQsE"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeb5e85378so10067983e87.1
        for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 08:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784474246; x=1785079046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Qa1P3gWmqXciURmGpT5GI4VZVYIEIGJapqmcZUGuQg=;
        b=S8KkSQsE6i1mT0xMuvA7h4hN+16TkEAGnS2v4MmecPi/f/RKXLi9JCCU9Ian3uZkaI
         6uH16+2lDNjt3EoEZ0Z9recn5DGrGVtHiPhTBwvEqVLcjRhLPanUIcKFl9YVGFEr79Bz
         DiepJrMHYCnYO8Gt1gc4MNmD24KvZClbAPLhR213XABjs+KSzUqZJpdB6UgQ3A4xvhQh
         anSghTo5dI+6+hFiq7ZMN23tb/YP19oDX2VBMAq0fohlZdTdVk/R8sq/XpT2qX0hATQ2
         erMgvLeXAbBSDRiKYIvyhWrkOfiTC41K84Scr2K35ZGeP/Ojcsu6MFc/fKUGIQe0UePI
         uP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784474246; x=1785079046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Qa1P3gWmqXciURmGpT5GI4VZVYIEIGJapqmcZUGuQg=;
        b=ah7gelCNW+H54lMFTkId8vWIdE75cq7nsGY9zulBD+Kr/b0W0HNm3VppChqCfNbFMQ
         En38g5BODVqy5QOq405k4ojOia+Fpi3jumeIo/ikBwJj9yZ6CmeZCPRxXJLtxg/uMGKG
         EkVX71NmZT7ok8ByLn5vB1+/k/EXtDFMzWifXabIOnE5tphTJxZAYeBEU1yuF+RxX/Tw
         OwpsGtzCVrQeuvyBNRLUA5IiIQOZJkmWoNvGoEegKwydIs8WXMkmviqdToVDMMkmT0+C
         HaApfqt9XYK9tHJUH0SNHUjlDqywUe7GocdfW7ec31OB/7UiEaOc7MQbniIokvjTNFPY
         0yCg==
X-Gm-Message-State: AOJu0YwOLOOYVyRtk/yklTgSYb9Kd3H4m7BJpwe96O5sLYCU4Yv4O0cj
	w8DNKXfMcNnim7VBu0j90cTFVD+L7dxyDGVUyf3r+4cozmmHJkljuQ4o
X-Gm-Gg: AfdE7cmFNV8oadhHYMIY7rszQPcQQnuSf8m5U5Y8XkR2FMGRfcpz8fczpl19a/NZ6zN
	G1BvIe6oF2Zj4qroOSivxit6dOJc+w+CSa+hB37QFjj3JiCYQxxvfoDOjdzvzRl/58jTO49YvHr
	Wf8pVHHXETFioFgyIukmNmEtw10YcruB1M2FHpOeMDJ1e9VPCf2L050YKuykExeTDGN7oVlHBnB
	sJELS0XMhfzZ/iFapqSwbU3vxYmXQQk89NVZob6ESSOEWU5uI2VcX3HeEJgGK0CZD0wEZfrZDEc
	Kqx6M+34PFNdGqiWLIbwwDL5Bf+0yGv+dtgKFQF2jEqXdgw85CPM3rJxnYaWADEGL307jPLc76y
	N7/eqi4h0r1RqJA/K3PVLapsoC8B8WY6qsPNHIM5wq316WiS6AYAhmtCXiPHs2gv9d1Z3iwmYWC
	caV5UsmyvS6Vq7z77L/zbnu1sphr3w0u3MrDrPzySuO+4UY7g=
X-Received: by 2002:a05:6512:1328:b0:5b0:eda:de2a with SMTP id 2adb3069b0e04-5b28f998d04mr2011866e87.35.1784474246449;
        Sun, 19 Jul 2026 08:17:26 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291e26e5fsm1835096e87.80.2026.07.19.08.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:17:25 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sun, 19 Jul 2026 16:59:47 +0200
Subject: [PATCH v12 4/7] i2c: davinci: calculate bus freq from Hz instead
 of kHz
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-i2c-mux-v12-4-a5010d623a57@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=+XcNRIzkmbYbd4RGr5v7OnmsIYyLQ+F0lGI6snUGPQo=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqXOqE/w5Wcpd25qcAvrFAjK3btR4TTYV0g3nYj
 Q+vQkEjIFyJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCalzqhAAKCRCIgE5vWV1S
 MmWREACFw4mZ0lyDuuMASrzJzBxVPUctzhs1qzkgD7P+hxIwUA+pLpprcm+lx9cRyhyK6rFSaEJ
 aZr+3zq1YkjlTBFA/bWRi+Cr3OjkFKQak4R4VIXyFugMisWaoip2bl4RkiX8qJUN+I24+0AJlm/
 3ylO6g6xOkN4xhHceP8UyhBw+XvV/RcyEOU0JYVna8P++m2bZ9yCQJqIIRTAccQCjFlGWwo+AXh
 I8LVC9cDr4B5i9HeznRF106/Xmpc+kt6lO7dxmpgcmBPExT0SoWvDuBMa3Csaif7xrFKqQ9+9n2
 9kW3Hz0WdTSkvWt9r8gh59o1EXQDIeB7S+pLDbqPzsv6MhzRiCZUiWsokGkHleo2CUZZO1ilb6N
 4hZSiqMQqEPpEX2HaFDQxdldaCl/qB9IVOF78d6CgckpQyugrlr7x+M/hKGVOqQM/XDkBFiSbwd
 0PUc86K2mWfmNDmzHVsnfVYpf4r1+uvTJwRyMO5lkXtEoGaeZFhBB7Dj3Fy5rfh7eW9goILdxqQ
 4jKFv4QfxyTUbmSeoapiS+n7G+PLBOwgNS38vKBphONvE3rbLLOH4nOq/RUAXPPr5qu10ODxZIh
 46+AUK9+Zyn7EwZQeHXsAP1ld+2GTWzpdFZEaUqX6fuFZDJTSBFnnU18LfRDs9fAm5KfKo4Hm2O
 7KZB9P0XaDTYlLQ==
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

