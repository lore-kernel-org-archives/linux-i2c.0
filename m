Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC35A3FE37D
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774360491; cv=none; b=WyMp0DszwPhS7KVIF1oDgA/TUr3pgrIBnwnmGmNpD/vSWvmaSTcCSxxOteAjUn1xyGAGerQrI+bXVh+F/B6BHMZfuMkeGiSJ1OUzOdFRNqTjSeNMRKqgxmZqc8GaMmW/shHAzZof1ICX0/Klt2c48jxQUDoJdZww25YJzEJn1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774360491; c=relaxed/simple;
	bh=vsSIa0c3XvGrZdSaP0ssvqDlYgrE1wL3DrKCmY5NXO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZDGvOZUiE9lp1Haa6hsE+pKnDZFh08+g6KBzQAvyyMjW1PNkT0DhY1XlLrRoG5fOdZ8D8RgyZAEpHJBc9/YpVpxS5v5Rr1PoO8pwJUXcN/RcwEbJM7Ya84wS6cmnXA3B9n7VphSgIB9BNy82kpPE5Rhjt4mHPIeWRluk1KjjueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qEYr0Kz4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEYr0Kz4"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a299cba953so510585e87.2
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774360487; x=1774965287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5AwS+cqy4cAKKPRWlRgkDDFxDwgSl6qxYrDkjeel6k=;
        b=qEYr0Kz45Jt6+EmVunKic3gvgcM0gnjO0UzeVRDg/IZEYYMoo81TS90uJ/b5UqHCFN
         ZU1+rvvJSQKrcn+R+a0jYkB5NRo/N7ALlb3DPEmYLSxHDyrB6QsBVR34vK9qMufbN/hm
         TtBTWSwrybiBs9MN/aolXjpbj+sfv8loveeMTbL77vtbq3tyf8GRYBb/OoJMSiGYvmHG
         FMfnf/G8pDZinDSqCTxyDHETQ+jX02h/69MWHl+ACSeHr4VRzwL20ovFGajkQvvSmqU2
         mTGlln4Sg0PLMDUHkl3YTNLjZ4eVAsYAcxubCDEARUwSMeXohrWQf7ousuJCrU+E4AlM
         CeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774360487; x=1774965287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O5AwS+cqy4cAKKPRWlRgkDDFxDwgSl6qxYrDkjeel6k=;
        b=JOcCRdyxDJlHN8bPuSeUiMhARWkxSXolzG1dDablhitvcW7SPhDsFcYVp25g1I4ph7
         1vGrR+RDGer04bxR1mSqSkx4lJIyURWQKJl6KCwJYh0W6tcpnQfjfNq98AfOiNXtHJP6
         R3UxvEJ+MHMEnvwBExJRDXd3CrPvHZEEwe7CQCd39xM33JqSbMs/NQ9iZmKk2jNo/aUO
         OmybQ8EnN2qNWYSs3GhKJhD1Ug6a8CRx/R20g/h8VwuTBjkToOjFXSXLRpHNXaHekmRt
         +UeHBr2Tp9zQeijNMgdZcefcELK4JnM7Mr49AG5rydBb21ChfgRtU/dtT0SJsHpqloej
         H4jg==
X-Gm-Message-State: AOJu0YxxNSdwQoG56hL3L5usHw6g1uMrFQvSjtO4BPuAFersUpjTFQls
	NBFow/zCvD5jqSYBtOSh2SK2VjpyKuFZzHwOaWultT4gVe2/n5dfT9cN
X-Gm-Gg: ATEYQzzE2tRQLwPR4A1mA5wcPJumV05GrBzDURnsBAWbd7D/DKxXyFSxuiDl0Fwfb+e
	crUfb48UhjLgYtuzdOFk3mkYI9KZRiKZtI3uh72Z4FZDnIXljHdJ6MkwQAhyL+TD4gLwXG6KaHX
	4rAvPeeGjf2KMP3tXjlA9qiBVff2ehWv3FBsyxJtgqznrJ31A0743A3ARy2XBw5rUNy5OiwXgNV
	c6EZ0Eld9hNQ18SmbktsP2qrjPIOzTlZmzutMmxZbiSwYdwMNrk7xkC09JrUmBrJWGxIXLK5C2v
	k1xoDik6HX/yITw92tFk0OfbAMY840T8lCz/HU+UTDisy8rclYKZuCaSXgsKdH9ULGmPhDHiun0
	NCpt6Bdtk2+WRW0dcTTyB+tXPDWqNlzoJ/0ZS6+3o772luy6lYyrdxCXR+060JaYImnn3c+EqbD
	NOSw9JKhj+/T6ZOIiEgyVVh+5El7ZgapbhhlpK4T2BUSJFTk9DF29WjqrkMmk2TYpkKJKk/WaML
	uXYj54=
X-Received: by 2002:ac2:46e8:0:b0:5a2:86bf:39aa with SMTP id 2adb3069b0e04-5a286bf39admr3361995e87.2.1774360486576;
        Tue, 24 Mar 2026 06:54:46 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285207454sm3162823e87.48.2026.03.24.06.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:54:44 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Tue, 24 Mar 2026 14:54:17 +0100
Subject: [PATCH v9 3/5] i2c: davinci: calculate bus freq from Hz instead of
 kHz
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-i2c-mux-v9-3-5292b0608243@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3233;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=vsSIa0c3XvGrZdSaP0ssvqDlYgrE1wL3DrKCmY5NXO8=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpwpeXnuFJFWzexXqw09JiHF2NlDfub0tdgNkAy
 JmNB8DycneJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCacKXlwAKCRCIgE5vWV1S
 MozOEACOJ2bpbAAilgam5B/hfpEicuTdw7nYs4wdBsggK24iT7bbb1s1mO1+BGuTP51q6MKlptY
 SpQQzE26PEk5T9v/sEa1on45fHW3qPqwi8leQ30vBk4+lJlfWXJCXuZ7lwvx3/5dC1jNXM+psTr
 Ii/NhpwlYN20GV3NWfLDKRi0f7Yn66t1kcPmLiQ/fpVqlN118+xXwBkdVzqYKdPMbkrBuzXqh8V
 MAx5HBdeqGVR9y/gMmWKclBLWBZ0fT4D9mHGI8a2NcMzJDgvBUN9Da100swKoWerXTXC4E1BXwA
 3GbOt3pVW9Gg/JhhF2aSlOz2kW4Oz2T6TQsRk5UfDmAHIrNkeEdwLfv9EHHkCfFXuPbMAsjRgim
 FAn3jDtVCbZHB/n4iiPCChGPo7QkqXdAfk2MlQC6OSKGNtvfLOG3IV5MOKmzevxYcFgqBgpKBiR
 e4S+JVQ9sofJTt4b0jFxpraujpKmAnUoe9JTtqNEo9fMWAxZZywZtp224UzpWWZv0It9rNfsgGv
 MLoafcSTorixc3gva745S5KlCMoWgA7y2kXehEdwBhpNk9x53P9clEVLXBbOy8Vo7aVlPEPDTbY
 zCNMSk7iOwhcmJV1SYdwM84btVVf1bBPdbMENP/+2dUOn69Zt4MjL4Xl7o9pmyrjRWYYlJpilQq
 /Nj5lSnT6J0B6Pg==
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

