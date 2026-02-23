Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78BD350A3A
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857236; cv=none; b=Tdni4kRwB9B4mjh7MD0q6Yitop31/zh0MmlZkgwzMXHVW8eCb2srq+fXNp8EMC02LhMFW4ZbYn71GC9nzp5mYFgA4+TNAzsP6Ynr2wDWcfewUAAGvQ6in0o0p8ZGNAqf0g2eLlLlEcXGf+ewwcyAJRRm5KUN+p1hD0twShIfcdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857236; c=relaxed/simple;
	bh=ZEEqeaCS8i/fQh/ydJoSPQSgfBIk2Lb7weS4NuofoIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WaEpI0nZtFyk8WBkoltcDkDy08ividAlEfEutacQ5t9TTiQNti/eOOz28ST1KVneWeE4hzRoGHyAKZvLXeXw8AV9dubzf67yPnER3W3aChuPAwbwRYgco7ZfWwZyuSe8VB7jUiKsD2edqWoM/tPX0iXwL7BFTcG0JskJy72xLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yz6CTIor; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yz6CTIor"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59e5bfa4f33so4169702e87.1
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 06:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771857232; x=1772462032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlHpayBYcqc/iH584SrkLhfCupAvJIo+BPnQtA6Sgno=;
        b=Yz6CTIorcgR/lnCcZ8EEnN5cEh9gOtAUQvzhgnrWQw2IcjNe9qFupSvhQXoDSE9Tv5
         WMxGAHUTjSsFc+Cu1s27JhKqvmYouKNxDShCOCtzNvL0fxrkoYRPvYu8OFTK12ut1aeF
         MOojGsQbtjk8sXebZt87BYKm7q4uZiEnVz0KDivQIHZ8jKPT9e53xoBDpxP/fmYnwiWT
         9KZE88MnIthRZRthbxiKCyAHGtJudduol5zUzgcoqvKygKzp6PrJ+BkgmxSHQvyRSYOQ
         u4LI7CQoEeoQtghys8szUZZp4/Pc+vAq7iFYDG991UrSYBpuXqffYpgh8FiJU/kCoPJC
         NOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771857232; x=1772462032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NlHpayBYcqc/iH584SrkLhfCupAvJIo+BPnQtA6Sgno=;
        b=bFGdc5zJ+sBI5KiCpZyCpzzYEqdfjxzqsyEYgLOeXQdxHuTfXGA1hIbTglZqNa47Td
         zOSRKE2zIO37OhkeBLdq0GJxyX0hOha1M3BqvAYGyssoPhwmMYHfqqiujN3YhSyCCFsw
         7bI4d7iAiJ7tT8uVqQowouoHWQIHSn5KkVZkWZQ6xOuUytOnP/QIdABJeIQXsjqbCEPT
         4SHLYsixm3dRqCAT9bSAoJeinloFvGfBi1xZtZqTX23LoPnFhCRCtms4wxDJo+lY+HSb
         oWsLvLpTjncvRbi4eNmi2vjzdc+VYqLh9EiXpEy3dj322wvSyThrLd9uWMwQmuMkbM0w
         Xnfw==
X-Gm-Message-State: AOJu0Yx6i5b/r7VPAlVs0I9hMU9UXZDkukzz5cA2Kr9yEorWmOEflob2
	aPabqptHljL7aXRC+FqNEjwtQwrb9c6nTEj8EXXfTt9HDgR6oy05a/oz
X-Gm-Gg: AZuq6aJPlDbizmjORUzT7ZAK5pqiDx7T1jWNt5e4GYy9PtEWjsdhNo89st4Z6iJ+/l+
	duqEi4gECzm+FqBA8EHGPcvNqHcnxLJW3EzrP+YXgZPU7QW3K0tIZg11rtzkM4sKihQFLMXPeGV
	EqKhRwkryVEfnr9aTBJ6buvX/tutpIYOuSQsnqZ1pcvWkl2fEqdVl2qTdfTBxUV/egA9P7jy4kA
	s2dx4fXPvGpweK7FcnvWmzzYVZmtwQ5th8U0XG9/chhHseVzRKpsE0s/JP606xJ4WlwNH00xy36
	+LE1JM8wrADJvbMS/KGYAHYFWHRU9+8AgboXId4yZoPCP8WLBgZbEJALBSjW126B2l93hAABBQ4
	FkAi1aZqFlfwCMXB4hJMUcrJYHe496GA2IiGOsyvzDpsu8LX2Ll/6K9R3Hjx+VXh6GeiYUeLjsh
	UmXkCHbq+o+KWqsPgNa9GFgOyCt8BUflIriMCCRd57xb2wTaImGj/VKQRIYt68TxQbYgqV/rN57
	GMees4=
X-Received: by 2002:a05:6512:b05:b0:59f:71b7:4850 with SMTP id 2adb3069b0e04-5a0ed9b12a2mr2729556e87.49.1771857232010;
        Mon, 23 Feb 2026 06:33:52 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb16344sm1631709e87.37.2026.02.23.06.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:33:50 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 23 Feb 2026 15:33:52 +0100
Subject: [PATCH v7 3/5] i2c: davinci: calculate bus freq from Hz instead of
 kHz
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-mux-v7-3-ec75b214718a@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2864;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=ZEEqeaCS8i/fQh/ydJoSPQSgfBIk2Lb7weS4NuofoIc=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpnGVdlhV+iSt5NluQ7dVjtjXvoIJaeUg0f+eo0
 AqUwP+2YXiJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaZxlXQAKCRCIgE5vWV1S
 MmINEAC5kZvmViAk8BONTPcbB5SK2etSLrO/aaqbtq9S801JoBGC+bUGSqLUbTRFbjMEbU7lXDs
 e9lj5kcKnupgjtUm2s33OJv0jnNeoAM/A7nk4485z35RDLF3DKJ1Ys2Fuk5jZnf5mHnFEjR0Rx3
 d2CakuaiCutPI8iEbaeKnivoiXYEZi45aCE1CIKoCN3OnWZa9KEPGOoxORg8x1/ZXNgDpF3FvNi
 4Tkm+CYfcA/jCfxe0FUv8me8RuZkqCi5mTr9pAk8NUMTelNOhdQQst6u3pCc/w6xYkxzCVrDcMo
 5lJFYyRpbbB4Uz+THhyTK4S6mRG7s+uku57/IzsfZDuuIcs/D0TpOu9OSfXO7OKyR2+c8u6PwoW
 wm5D9MpHBXpsHpSOU/EIvStAyo6jUWG0tovc+BORJwrc7fraWfj9AQENmNv/Nr0HofHVoap7TwO
 VoxOcShSKptyQjOburpGIFXjTXtKXThbTiMkRIsodWdV2vOslifczyEYbpFraopHfgaydkIUTlA
 rPqy6ndq0hAExeJDrhl9V4vCEUrZRWWxBO95IxhDhT04bPqPGH2yNE31w5Fr6/i/Pa04FtoKNg+
 OfWAWsV7DcHhaDYRPh4xnCG/OnGZd5PfsPEpikLYVS9DXiDeP68fcD39sZ0K1d2zdSwJ7nU8qt5
 yWtGr1duEV6RazA==
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
index a773ba082321..a2b578e0a534 100644
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
+	if (bus_freq_hz > I2C_MAX_STANDARD_MODE_FREQ)
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

