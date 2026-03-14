Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757A632D45C
	for <linux-i2c@vger.kernel.org>; Sat, 14 Mar 2026 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480155; cv=none; b=IlkNQbwPi16lqwF1eUkylAj9Q6TYPzxe7hGcATgD8lfm8dATeu9gj1QrmLhYp//CTBypkTtS8Tx5LkTlS605bzweOiTPII2Yzhz8teUTI2JTggxXFRjM7H/owc2dpco19XJX6uz8FZxeFEmnN6UCoXqrv861pvzS4+XJDfA3VF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480155; c=relaxed/simple;
	bh=Lh7Dkm+/uvcdStnc/oNui4Wy85cMEfrtDS4KN8XCm1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GCeD7kZuNNxzrYPoxj9s81c5Y+tDAWopFx7/ecLVrUkGU6ik0XxPHrVJ5fdVv0MgDG80nCffqezIobh5/jh6zYqIpoVIFGwMZ3ro2bzagHGT3xw8lYcQgGCPp7q+hMSEV9Dn8E0NTYa25DUqW5mF6hOUl4gM/Ni1bui35U177X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWEsfy8R; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWEsfy8R"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38a2a59baa6so24864961fa.2
        for <linux-i2c@vger.kernel.org>; Sat, 14 Mar 2026 02:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773480153; x=1774084953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSO1H+xcwrtQSAme0jF26QT4KzRAqEvRrObp3E2vgew=;
        b=NWEsfy8RS4s0LH5p+ddFy0yxBu3c5ph/3bjNXNucNQKTVlTwZPLEL6SKTuHnRnw36n
         en6u2dyyqu9BCxrcDd4t8okcUGTf0aIdAF5YOVmoIw9U76YpJf7I7UZznMKL5k9Axosu
         YXntR5buLGjiJDJSKIjbJu3HvIx+SLE+O+/phv+id94t3N64NLJopo+SnHDnPgehg9Mr
         bG+raRHGl3ajW71V8v0PEOP/5tK/CXcnfWmK6nMoCQxZmLbeFr/gtwZ2OrbRQGhT9V3P
         TfDvS5S3oMfRtsm4FsH2yqaOZ60hY3oP5MFpdf43Mb6uGiShNH/85AdVdXTqSrzzS7xo
         lQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773480153; x=1774084953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eSO1H+xcwrtQSAme0jF26QT4KzRAqEvRrObp3E2vgew=;
        b=Eft8ZZdVTc1IdCm9CibDBQwGHf01QpEbayXiXupJ17fb6LVW9zYMMKjtNkPdnZo3GM
         DKT7tkUCMiXL7LamEs2myHyJAjbl6I+wq2lHgP4YOFxkoC7Lx7ZWZum/DtSCk3jgxbTO
         gyI3bdiVln7pYlje8+vVb/SMCxgOeHA/JyXDFH82VBn/a2EDC0jkAPL7WZrGRioDFSV2
         SSsQCUh2i2f4gMseQV1BYEwkCYq2MuzJqcN3wTzNBPeeEVUvFyGRXSdBICG/ZkfplSpQ
         PgBoa+zN+t1zQbJvaEJ3U1Q5EhbQqQqSWfS6+04pqpiKcTVpP/celACll/YGF+PwNpNT
         RN6w==
X-Gm-Message-State: AOJu0Yz4uMjtPMneYhrk+sAspjxu46sWfAkS7IqbO8YqrZk8FUKbSWlj
	rsucIEZxxbxMkwFw2By82S6BfdmF+TOZV42TnRTDjYgi7A5VYjCkbHq1
X-Gm-Gg: ATEYQzzi2t3siGLJNcXxC6CCT0hT6b7V+3uTb1QUL5/y57tR9Q/UvFQDTGxDd19rYcs
	jRw1MVKOjxGCXY8qxaeWG3xvgp45tbHhc1O8CGTtvpp1JLOegDPDYaXz9NV8r3OUkjTu8QCcIuS
	gqxMGOzZjC86kYGUvriW9FWccvr5UPocbemrNNtH7+SyMk6DkJCepBOJ6HSpKolnWjoC9q8zfhu
	atkhjsMPVhqywL1QvcHg3tFPJuKMXfBEFW5QY4tz9bFpSkkNfMXET/tNgjvFvM5mbIDUur3oEyl
	l4BgEAHJRUDJ9D735u5aoC+uCUwr85IeI+4vJpk5oROlbSx35yfOHKpjIUb7tnsy2tJ5VoiEz8/
	suqMjeyPhjFCsK8tfzLS/gJ4vHpAFAGTkh07ts5cvNbLUZEwZHiowOKYDrmHI3vak0XMBxzGob1
	qVQh+nyeAvKh8xLYl6aYlmUWBzuBNhc6mvROlg/HKjgXyHOqi6jmAQRYxKAZy1H/G7ZLU9EFp1P
	+SUo9U=
X-Received: by 2002:a05:651c:3242:b0:389:ff39:d36f with SMTP id 38308e7fff4ca-38a896663e5mr20481001fa.8.1773480152498;
        Sat, 14 Mar 2026 02:22:32 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ec94sm18454261fa.22.2026.03.14.02.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 02:22:32 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sat, 14 Mar 2026 10:22:43 +0100
Subject: [PATCH v8 4/5] i2c: davinci: add support for setting bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-i2c-mux-v8-4-fb1738a4df0a@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3885;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=Lh7Dkm+/uvcdStnc/oNui4Wy85cMEfrtDS4KN8XCm1g=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBptSj+uCJIvW+lUyvN1DTR+9pw5rD1oPcFBJd9x
 1nuXwaGxiCJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCabUo/gAKCRCIgE5vWV1S
 MhQZD/sHVDGLWGQz/rWMZl6TcG+2SxgXoflaNlMTf+9HfNzomB/WDqheVJpLoxDWh5iEwNXutiZ
 /DgfKzqGuSOn3iEvj7s8BUcZrvBvhpsq/sRDTT0IFZwBa2TmdVpPhYfKEzSyZ/IZGnp/IL5s1Cw
 iEMsMwEAb70BG4Gg1ilq3tht6S94zis2zZvJ05IW8VcKMwYr0hUSnj5DryTk2ezOEIu3VIyQmTU
 GSCoqlhQC2m8dyaPs/LulYuIWXnrW1UAw0hVphSjYnv5lJfQ0UAMkRPF0bRoR7MFK0yWsrF35TC
 bvODG0nal5qsZdVDsWEHl6H6JHvU+bKK8HR3+LCJD42H58CkR24NukoCSU3xFbdPO5N0Wxxx6zv
 PDcP00RPve20HdiXIpprLCkno7w+Hg5plcX6yHOwH0d+9FDCfj/qLGTmf4+Xq/rg33qV2RHX+5i
 E4TAYLNtopB3xGeSZpDF7an18Z2Bm/Whq6Ts2c5/0pIJD6NrnqkrHiz+I6263E3vBlXEGBcn9pg
 Cl7jY/3ErUwyvF9epMwo2rM1kvoi/0yUJRrYanC3tMu4QRVox5nB+VK6MLTN7EMjlJqov7HrRNM
 BpbzImykbv5BLCd8LH2ia6RCf5EwxSDpLxFUxPfpBcnMnMJi+7J8KwACRweT5+GF4fE366haoaV
 kOzKtpnTA+6lUXA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Populate adapter with clock_hz and .set_clk_freq() to enable support for
dynamic bus frequency.

Remove bus_freq_hz entirely and only use clock_hz instead.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/busses/i2c-davinci.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 549fb22cdf4f..72bc3b286d20 100644
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
@@ -207,9 +207,9 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
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
2.53.0

