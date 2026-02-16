Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0323C4F3
	for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771245519; cv=none; b=er8hkdEZH37hjlV7+CfS47DSji4IGF/ndTxBC+t4g3PrnhDq46mbb4mDgPc5ZnisMn0JcCOo5CVauGJctBT9rR26dkNHOh70DW/hK6UCb4CvhMxgpFBv39835d/VYT7dH8zekOLnRLrRzuhzVQKbBUEpy4scFET+Gq4zItDDeQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771245519; c=relaxed/simple;
	bh=NgWDqx3izSY9aW9W75gFytkLHJndTcTMdemaHAZbfa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cODAKaOpOkR2KGWywyjVxQNsti6PoujuGDw9TIrxTIlhIcUSIR35WfhUY2YL/R++Ne7+gtv2wTWMhvCWMmTlGczbSnJE9Ur9SJ95ZGnnvR3MdHi/5BX7RlD+l0XR3/ya/oXmpRiN3hsQm8eqd3FgwZUkbJXv9ctaGkQSmfE+uTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ng3KgqJK; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng3KgqJK"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59e614b3dbcso3436413e87.2
        for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 04:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771245516; x=1771850316; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgLydv0OAbPSYmy/7mtUdSMM6gy3g70cS63c1sKd/bM=;
        b=Ng3KgqJKFzpVn3u+jDb5S+tMn1MCQHaR/PfN1mkCKfY9yGLTkiJmDHYjTjmCVfLkPU
         bL++ja3rXSAKpvRwdhvwAfe1CZBkVURJP6lg5AUAGFlPffKnhHG9vFzYDoDquETgRWsh
         CYgBB5z2NJJ5rNbMXzzsAMpRE2esVosAxgy08+/gmvufIGgcxUl4JYbq8AsLqXMyfZ2U
         9gMu0iUCYNd9JF2MS09Le/UTXrmmj6Q40sX9y+sjHbFqoaggpBS9PoW01KEfOHhZ0Wwb
         es1bJuKx0xFPrxJGqhZLFFwOPaddZgWEM+Jn2fQ7hdDqH1QQWfGNuzGwCAOa+EKJiJ7J
         +T8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771245516; x=1771850316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hgLydv0OAbPSYmy/7mtUdSMM6gy3g70cS63c1sKd/bM=;
        b=nxmjbtSIEqR5CS2WJxTlvW4g0g6ISxJ4pThag7A74x7EckRXjE/g4DFFzh9H8zKspk
         wfUaqxWQaA/zcU0+zDWhqvXmalp/teBhNhzApRQVg1cg9fw+fzeFScXC2iEsgcWYZv+c
         VZtTZ60aPQ4TtUV7/w9tFEarky3WFWJtbW6Ndr07BjvtOnKgOCIKvlxRaC1dVQA7E/85
         1LqLOjDKqadMacvOsQnZYJtwG4yb7jTl4E3kgSdIDEWm2OXli6zmWA/803arue/hKeHN
         MSFJBTlnVUb6srQ+v8omW2w9cAEcvYeplrDd+V2x2X4OMgp6nzqdgG3jqbmox2zyyOz1
         1zmQ==
X-Gm-Message-State: AOJu0Yx3v1fDZdOT/9+R+ON37FEdrb5n5g+LNmmCWvLfj+4QFWXWRn46
	4lwGzOdmwRArcIkRc3+eMFNOsWq+e3xVIsgRBjFjIQNNOyUApl7gyWcE
X-Gm-Gg: AZuq6aKtqqW4R4VpicsBtnZDR8gsu/WL/HtKaMil56sg899JCvlXFjVgLmjbVC2/86F
	YcpbQ41Hx5rlIsXTUhsQoyR4S25nTzck0I9FrlCkTsPSgVulDrKYEHIWqx0hiVpeSXD5eQJJLnP
	WZvLdbjnJkaIdDBBaZZQv+Xr5Zdl++WyLgfXFGi1hu8C0Nn65bxxgDaWpNv9zmhvVFMpj5ejYkK
	9S62EfTFegGUPGHhIDIq2TYy63+PYdGMZWKoiAyorjoCsWbotJ4xVT83VxJF74EDNQv8BqTOYtg
	QMipxmJ4S7UBhSF4RBP50/hTmvh9XFtK10DQP6ixCrlNRrpjUWWteMHW4AyBnHrIQoafZRDjulT
	0FNnkFZ837ghad0fXDJlp8MCaCrVlLJDVH0suFjHB+TuW82lGBGQfkSv7HiKRkIg/xjTpIhl3kY
	KmlCTiU+m/jDMYbYEnx8P5ecPBgHgmKyPIbGXY6c9SgBDYqM75gbsJO+CyNQ1fbBNUGoG8
X-Received: by 2002:ac2:5687:0:b0:59f:7ccd:fe96 with SMTP id 2adb3069b0e04-59f7cce0005mr50852e87.28.1771245516024;
        Mon, 16 Feb 2026 04:38:36 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5b0577sm3175920e87.71.2026.02.16.04.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 04:38:35 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 16 Feb 2026 13:38:15 +0100
Subject: [PATCH v6 3/5] i2c: davinci: calculate bus freq from Hz instead of
 kHz
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-i2c-mux-v6-3-9be28ecfd7e3@gmail.com>
References: <20260216-i2c-mux-v6-0-9be28ecfd7e3@gmail.com>
In-Reply-To: <20260216-i2c-mux-v6-0-9be28ecfd7e3@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2849;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=NgWDqx3izSY9aW9W75gFytkLHJndTcTMdemaHAZbfa4=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpkw/NXf7RWEjJ/IHuBDaOR5YxveNI6Lowg3H3U
 elFFoc1vxCJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaZMPzQAKCRCIgE5vWV1S
 MrLgEACZHJ0+g5pduSJlFU/RbYUHW2lmuku+IK338ZI1j2QH7T1l+cotOX7Ww5+L/OeSUDrwUy6
 CE8TXG9ijuh9gBJ8N3b7PYGVFEe2PwqQQsgW1RJpLPxwYm6MseTIm2fIRwPUan44PWCwUVV+AyL
 VGnahHqu3Qn8mSTbYdD114xuMzR6XWsZ5hThlJyDijmMCj4aSxtBDWVJgxKHFwl8E0rnfa07wCT
 gYKd/2/18wr61E3xHJXFrhTnSuzIPu8uKRcDVi5hiBfI2LOKnpzluSWqLc8s5nCbPrYyhYne1yO
 Vpv02/spQssfx9PV9Jm7EiFTFg7AxaBHnVoGrGQrLyMkKUUsFNRVd3YqOLSPwKRQ576hGEs6HrN
 n9nQpZUt0SFzlLXEdijzT86rjkKt+tytvnQDRtTiqJ/i1t9YY18jJ7TohSAyAw36vbkat46P9f1
 DEmknjjVwcp/4dbnEtsflYF/SH63toL6P6ZI4ys4FwS57a8ei40VtZFStSko5K2j3K9TuV/z5ZX
 ljs2xYiu5/lz1UosoxgYj+xvbWkdULcj7DOqZKcOSMjPfhKbA3af9Hz3NHBnGiWZ/2zi8DCX/n1
 uP7xRprEudez2VV4YK+S+1BOwPFpzcCFlQpU/9YK++8/JXDX2QoEq8DVS3oWSTGHlR1Bco0RX/C
 kgnMaMsoNUiJ67Q==
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
index a773ba082321..761de5a814df 100644
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
+	if (dev->bus_freq_hz > 100000)
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

