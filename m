Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5E13FE37A
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774360493; cv=none; b=anEXE5EeqB6lHthesjHyYByGydqt6zQCcnqFuN7NNH94sEX4NbC7IolcK9gQtwTkSMu+1+sJOvcUTtQi3AkfRZvM/1MjGGy8HPbhb5Hzpe0iOiIVxu6qKGcTMlqWO/9PE3kIQWJLf9/GVvv8+mDfYUgzQhRrKxhSkxh4kmFHJfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774360493; c=relaxed/simple;
	bh=ryrI9MAQVwCIRRCngn0KDdHz7g1aMSsslONZvQCRx8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MjXIASaOtR3N2+cSntN2R5gcp84WZLh4GpRxi5M9r1Xn+pZro/83hKA8Z+Oysb3Nbvd/ksoCAaRGifwH99sq1HVTr+mca57295CGZ+d32o99ytPqbDtl+15yCCpY23rZdD7/KKYfW549pybIn9SRG/oGZX6CVO1GNUIMuGj5IQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHmvppdX; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHmvppdX"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38bcdda57b0so40507261fa.3
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774360489; x=1774965289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oz1kP6mGnYmsV3pNCXtV9G7tgVBh7BnFUeruC1cPFLw=;
        b=ZHmvppdXhURiLELwFxX594JA+pei3PUXrlRBMh9PvnLy7Dc5iOVMY7qf+hMpV0RR/k
         aHaIDC/CQsi/rPTgj+s6Lq8Oa+qVwDCwbBydWJTote+frMgCr0VZkRjK5/h6lcLE7ZfI
         fJhiJIkoEDRrFp31e2gOpbLVQgZlLPlcPtzgTZfXf9WD1lKJxi1jn3rOV+NH9XSKeDLN
         XMvPTJelfdQuTM/xma7enmOxG+y/Fxf7Nm2jw3Uk7T9i0coHONuXYJEdCMxH5Ef4vtVU
         q4RddaidRJaYjmCqbpJhwTEwbxV+EANRyEhbwcyK4dujmf+VFu4uvdQEoWChQ3YTPAxy
         Nbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774360489; x=1774965289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oz1kP6mGnYmsV3pNCXtV9G7tgVBh7BnFUeruC1cPFLw=;
        b=otwtQ6hqFG7GYpvpX8yt7EF26SkmwVKXeBddYX5YkVsKXT57AqCz8YFL5jTRf5i6Kt
         QSaVqKhGr1kIRltS+PbgjYhVrYnOyXRb9LhK1O3KhPzjUOkhpv4dxS21mS5+sZwv+u7y
         OyR3FTDYPZRfl47/83y2AAnNRdg095ZLimhkE31lbcE2GVKbaL3QasqUDWs2Id1J2zAh
         tuWrbf6xENuBDO76Sv2RvKM5IntV1WRVxhqMxXbo5OqhrPXu11jtbOJw+tlygimRTpDk
         LPBSyehxedfR33kbvK9h3Dpi9p5/56TOIiVwXUdB46ZxnLhzVr7N/Wi7g3qDOmW4slv+
         ueAg==
X-Gm-Message-State: AOJu0YzVAT2A/Sys7pjOspGjLXxlmKxIajYO1gloSfT6R9XpXKDbLeZL
	aTStn5guajCojF7txmEQETqn5mTicLut78p+Hac8XgXJEJvOb2xBtnOV
X-Gm-Gg: ATEYQzwoo9Ft2lajMqU/h6ZmFiEC6/dIda2Zad9kRUFpdLVGImIKjfGcu07+CmeNJwL
	TA6FotnWoMYrk2HNHH4oACzgH5bhyKBmtEfTCPT27N/gZ5qYYENDe1y8j32GHRq1w0IN3y5Wbwb
	45TPalokW/XZ5aAD3n1xJSddFkWB+XmsAhhf77YZqP932BBr2ydC4E8g6KYzN5z3g32NHkDZQd6
	UWHCsqrl203NxPgerQVNer0mBTr7XM9yzkTT0Luk6eLqM4BnsXcG36smZAwrb+xX/FExAnvAaHU
	pfnsT9V4eu6Yc5d6Nm15f+OnQGcEVg9hJg2C2P6JD0Vw71zLxOvrasvuyfQ57dWQ4mTrSId2e8K
	i5HCL1tGhNALJmvbmpKjt0heN3OuSl7gi2KLFg3DgFtDQt8IABg28Sra/cGwqD0IOMfp8+exQBc
	qibGd6/6HkMsfSNgJ7EQPqbVJONDwxTPImn9WieVfvvul4iGmToapAie+mvpJ/AhP2+YYb
X-Received: by 2002:a05:6512:124c:b0:5a1:6c86:b945 with SMTP id 2adb3069b0e04-5a285afdc41mr5770590e87.12.1774360488477;
        Tue, 24 Mar 2026 06:54:48 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285207454sm3162823e87.48.2026.03.24.06.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:54:47 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Tue, 24 Mar 2026 14:54:18 +0100
Subject: [PATCH v9 4/5] i2c: davinci: add support for setting bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-i2c-mux-v9-4-5292b0608243@gmail.com>
References: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
In-Reply-To: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3881;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=ryrI9MAQVwCIRRCngn0KDdHz7g1aMSsslONZvQCRx8g=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpwpecpKtb2LQM74bmvDz0req+77DcvmlflCxyE
 W4Thx+y7rWJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCacKXnAAKCRCIgE5vWV1S
 MlCUD/wPBVoCUV1xDm82HsdePvpFTI2QRLF6oP9tMPcFfNn5gKnix7i6IZSK70o5JGbRZP2Oqt0
 krIWM96uzXsZY1ahQOTrC//PEKTVZLYgv8Lek7pJ8fNJV70Nd2DzkaovUlBXeGWQUeHcSX0rrc2
 jw8muH/LXYI4RgA3nxwZlX3lLNEb0nNbxv/rDf0jYPs+j9mcGXH0WnRwsoVv1JO/UovW6am8AkH
 tvgbfHNliDmVpPJPeE6U4SxgwY8Otxk3b7cw7L1y2bcqxDZFIzflpxzuNNkQj5DnW+llnIAzgP0
 sjO8H0ms1lOrTt5+f4i3I9gWz5CAdvaAmZwbG0n5JEwpG1CI5BnJVlFMwld+yEJBaU4HyAexUOY
 SnRNTR5ot1h1CREUoKB90y7hEflr+pzSwtaqZNYhU2WtZAYyqB7HRwV0TpoCOUGhndf0HXHMqyJ
 iljSssZsBtgHzvWyxdh885YIt54nIFeggj3YJs8prKmAiM305wftGDGIK2xLfY+IMdwQq/cJAPq
 +/5/7exap9aoXdqA8WVdd/gAnHS4L0bLoN7UzcALDmF4Am49BXowNySUrTaEqHHiQfTMe5uDwlE
 L7+KTQ7rWJCda0niD3xovRf+f7DUKsLQsSep5U2cweJQW4WJ0R5W443R0ez0yJwVRLlnoxAR3m7
 UorDwjz3rJvMstw==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Populate adapter with clock_hz and .set_clk_freq() to enable support for
dynamic bus frequency.

Remove bus_freq_hz entirely and only use clock_hz instead.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/busses/i2c-davinci.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 549fb22cdf4f..d87172408445 100644
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
@@ -279,6 +278,27 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
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
@@ -755,12 +775,13 @@ static int davinci_i2c_probe(struct platform_device *pdev)
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
 
@@ -800,7 +821,6 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 		goto err_unuse_clocks;
 	}
 
-	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
 	adap->class = I2C_CLASS_DEPRECATED;
@@ -809,6 +829,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->dev.parent = &pdev->dev;
 	adap->timeout = DAVINCI_I2C_TIMEOUT;
 	adap->dev.of_node = dev_of_node(&pdev->dev);
+	adap->set_clk_freq = davinci_i2c_set_clk;
 
 	if (dev->has_pfunc)
 		adap->bus_recovery_info = &davinci_i2c_scl_recovery_info;

-- 
2.53.0

