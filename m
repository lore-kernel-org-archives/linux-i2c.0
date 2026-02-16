Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C7254B18
	for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771245520; cv=none; b=fQz9kA914qwL0nU1xQkp0QGt+2SCDGkJYIN7qocUMnuGfQ8NvG5QyjpUWG+9AwhGCznwiyy+Z71PnqoNzIxvfAEUz7LBbm44GPpJyTBrI07NMmr+simi2P3kILV91nUOUkL0lopD2DcnJN9O0KKG3Bf+y9a7ffC+AL9lwK6daDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771245520; c=relaxed/simple;
	bh=FZLb5XRyW3qJmkpIPIeOUrGpSdB/lOwxjtGV8G6aT1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WfGjjSCvcYIbCg5wnY078YOwz/iKTUpHB6idBoy0gZWKwVw4qWMr8HA2arMCt9pE9HSs1JDvr3NrU0mvFG7PHmCi5s2q1WrYP6/8ip3ZVlaDhILdoSK797z3SFswvHYo+MamH35rAvAWTIibYt7ReldLp0UHWc/OpNrT6GAq++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtevYd0C; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtevYd0C"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59de66fda55so3187420e87.3
        for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 04:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771245517; x=1771850317; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGd9MnZZeJn6tPn8V3/jY050merklc3RKXS0iFKCy0A=;
        b=QtevYd0CGwECo2ucYFbvZz2H1HatKDGqQKFnxHhUFh+gveCLeB6sg229E+7mjYnFII
         HofqzFs4ITPtdQkTaieFHuzIe+eVrRv71mBgqvpyq2190Y5q3lzEpWP9i8b13aMpY+jT
         7GDUlX/WHPLmfwHuKtytx2KtHsz0aV9ndq3H7ALt9ANYhMLhQpcrwCJGsYippmbl1w4y
         9OLz78Y6i0bO4P/ke4Fqda38vJXtzqa5X/wWmXM75IgmeoXYvpZSPF3cRsOCVkIQX1Ph
         efiM1Y5nqpoxqXXWl8K188E/CDZKmqzNDMCU3lLty/6MnSLjm9gm5Llg6FbgNOlIS6F9
         uxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771245517; x=1771850317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cGd9MnZZeJn6tPn8V3/jY050merklc3RKXS0iFKCy0A=;
        b=Bs/WsjidBBU5MFFdJz4EMiY4nKhVO4W0Xyfg41UYVTlWsVqHckMbqOAm2NDYCweHx/
         VgDFKN6gVUeYdPeQzufV476puxcl6Dey7Yl2fGzQWbEFnWJ5C17VJ4eYjn+/eIcM/GcB
         8G4+fvmRJie4FhLC+5Am4xIusLo7N8p/Gz7MM/BaZw1HaPxyDbLQtnZmBBIgO4C9CatZ
         PaKLvB+O5hChM3+cl7zxAOKhYQigQmfcKOpd/VuOWi2gbx48Jw3yLwfFTbTf1Z5SO/k9
         Q7uWKCyhr0RuSq3Qz3sOFZtizMJERCqvkNvt0XS1+tA3mkJZJKOXoVueCFUH1hnkD3/i
         jO3g==
X-Gm-Message-State: AOJu0YyO5tiDWVYGOm36FcHVbYls1h4mzr+kWWnr6CM4AdYwpErK6O97
	OCe9XU8KHk3/NIZ3KDvbwkn9OFmx8lMUsHivRVqkqvJ1vOk8tFtGxFJ2
X-Gm-Gg: AZuq6aKt/xlg51Nb9Ft8wRWcRSm75ReFoRf+0sPBgEqd4RT1k8nUCGulpmrOGCIOcd1
	4nA1wUwufqJVuhVDvBPNQuHBJepWE1TAcwHjvicCVMgSoKHOnyrNSFSuuBYOClhLDd4Dq9aysNE
	LU85m9RTGaJe4DRSzYiNsTE2n8X+IisU4ZeutRj4VA/vrGzU1cCXkYE2IB9uAGxY6/Pg+CDXpnY
	A6VO1JQrvl6EIfVKYC/XYBOepsYSuotn74DEIgfY3uRNR5AE62sLIFS7Jswhd6AY7/NQxCNoqi6
	TvKiF4nm296756Yw0Ke/TTmwr7n5VgZx9g1C5uJEYnWDXEgdO66OvVz6EceDIIQ9mQntD0GS4XN
	eX4TSXYQLUNeXn/KZDs3OFz18c9YNHMuVbrL/T7G8UGcVFV8eq/RDxqo1WcqXrEyitNxfHZES7L
	r2Il3AJf6VzWeAaLodNqB9DmxVs7WM9bLw6hfsE7kM/229olvS/DxjANo5gCJELoa5Pctv
X-Received: by 2002:a05:6512:ac9:b0:59e:49f3:657e with SMTP id 2adb3069b0e04-59f6d3590aamr1998626e87.21.1771245517227;
        Mon, 16 Feb 2026 04:38:37 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5b0577sm3175920e87.71.2026.02.16.04.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 04:38:36 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 16 Feb 2026 13:38:16 +0100
Subject: [PATCH v6 4/5] i2c: davinci: add support for setting bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-i2c-mux-v6-4-9be28ecfd7e3@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4136;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=FZLb5XRyW3qJmkpIPIeOUrGpSdB/lOwxjtGV8G6aT1w=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpkw/SjhxPbOdl6PzzFXxkG7V00Yfw6LrO32v8G
 AJ5G3J/oZaJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaZMP0gAKCRCIgE5vWV1S
 MuWAD/sEgcqRDjfv4dBtPGn2rMygDHEQ/WhM8LZZY/ZsUdTu9IEazfaetDhsq19yVFasDasuKDN
 DsYRv1P0iG0tx5+MlZkmLfN/5UETYd/30vekBJhObSat5hw6ipvIhKzQG9pPCIJ+T5K5yhRhITn
 KU1Bt0hFa+0TF4vhsVUfP0pgEEsdTUDu/b7b0LZIv5hCUbk1pv56Y0uM65puMV8FuIh+4MH1Pkl
 8q4lVmWLYnbUEevmJTy3eEHw+BTKzwAf6NnpVAZL8MZd8e8+jdZkZbGMUdTfmIsMKb+GQZ/9Y3h
 rArQXnWUk/5sOPLjlwlMe5hBpv16OmHWtjkJ6e0U3mUBzEHYtlNpZ/T1Mmh8JYVMwIyA4QJAJdM
 dWrqg9RbU8x+499vybmgDvEaDqG/4O916z0m1G4mXHJ3cus79TG2Mt3Px8821pcBdxEoA/5QRPE
 dMmaylJHuhoBgEgAOkufNDCMbbFWI/xF/lXnN5QFUlOKsR5c3BI7OZ8F/q9gF0x4uEGRtEnkYjl
 SmtX+sYiLL/WDiNd+tTD/4Q0W3vbS7c7sGjeAlLk9tv5nR9Cj2kMz8qi3jHLFtQtcy+CRzm3Ij9
 R3K6H+G6lIuuHpi/0pBxr13dJSVrUk8cTbSJWAU00Yi0MNC6zTaBMcg8nmqx9yDLb88ehl1xQAZ
 7m+FV3jxrMt5h7Q==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Populate adapter with clock_hz and set_clk_freq to enable support for
dynamic bus frequency.

Remove bus_freq_hz entirely and only use clock_hz instead.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/busses/i2c-davinci.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 761de5a814df..ca41e6d6b623 100644
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
@@ -207,16 +207,16 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
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
 	 * least 1.3uS, which is not the case with 50% duty cycle. Driving HIGH
 	 * to LOW ratio as 1 to 2 is more safe.
 	 */
-	if (dev->bus_freq_hz > 100000)
+	if (bus_freq_hz > 100000)
 		clkl = (clk << 1) / 3;
 	else
 		clkl = (clk >> 1);
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

