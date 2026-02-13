Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D693563C5
	for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 11:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980881; cv=none; b=PURWEZIt37sUKuwmcRVkM8ERuSLBDxsvfrLkawYC/w+5tuh88TrvH46/ZMdmqP9VqgrEBbRRSTQ46nfh8EjRQBRj7UdMK9KKaJxQapJCpkwHNzpY/KT4EzZyqH/2RYDpZDVvrfB1wxDjmIdr6rlAtYPH9hlH2I7IvgZXTw4voM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980881; c=relaxed/simple;
	bh=NgWDqx3izSY9aW9W75gFytkLHJndTcTMdemaHAZbfa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FMnTXjzrzcXk+tsMIrcTaHNkRaimv9YWmY+BNSmGHCWTQt6/8/HrS0wVHxqSF0aiY5UlSxiPh1XdV6DMzthRtWXlywNfK+uTegN3I5IG07Ot0SZkcyXzq+x02QFEN8QCIyowdU7UEl7l9h5d5jAWsrq8+5OaryLwKJWdVJJ967k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5HCWn4c; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5HCWn4c"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3878de20527so4661431fa.3
        for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 03:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770980878; x=1771585678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgLydv0OAbPSYmy/7mtUdSMM6gy3g70cS63c1sKd/bM=;
        b=d5HCWn4cZQHaFNlDeclJ0EMes9WQwVdUPBNitMM8i6QuQ0b2nDwmw1MWzjZ3KcSsm/
         e3KUaFqeL3Q7pMaBzLf8tr2lJ5msXDsdNSGzRiGsYvzwBx7tw82VpIDE4Tj9r4EQf4bi
         sOtrJjUSwkThvammcaxemg5rOHvc8lzH2TJbvCGI40SQ/HpyZfi11n+F9SAmYMePpvJ/
         5OVvMj7Yqa3Rc6b/oopDVn9AQCJwd9+i459ECZDU9TA69uQauBgw0ST6iDa0CkeElulM
         OJPaOCUQMpM4EGFWk4iNftB9KXxc5t/hKyAtxm2EPeJXTu2liFv2ROmAGvw1bSH/DUok
         yfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770980878; x=1771585678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hgLydv0OAbPSYmy/7mtUdSMM6gy3g70cS63c1sKd/bM=;
        b=eW4SZnKhu1Zy4SaeuliZ+AoLYTZ5AnyAD8+Bo8VoZvMbEPM/mW19gSnD9ECBbF0qvf
         UnsgaagX7cp4ruSN+cXMMtrGCU7howZ8qzFhXg5pREA3wn3DofIaYPdT/qEXxWaXdhK5
         5fxuw4sRkVJn4ql1dTRyaQsQ1SNLm2MjqI9jmWFT31yNWIQYyBINb3k66jTzvNVYlL2R
         cVcNFqDcKhPHLVn3MM/CK6+8KdjwmGA3S7AoDaCpr3SU5qlPoEacQvi/5QzUgGn8PB70
         9UUnJQmVElyCZC7ZY2uSOplch44fqUjRH+WQIoS4K89P2pbvPkh+5ITe6910HnXyhGZM
         d/4Q==
X-Gm-Message-State: AOJu0YxcMpQn7l+MEw/DtTp38AASPJkGHo0jpQycZXlsUKPum1bi0sbF
	tKIA6LPmBnIAUFeO+QACuegAgyEglPGCciQJrL8aqOCS/d7dw6qyh/me
X-Gm-Gg: AZuq6aIx3DfjHbWu5taqv7Iuk6Cwcv3F1J3KC8fihWe4iFx8zYIMedmRbaUBH70S6bZ
	/4DZ5lwQNhxMHDdRxgjNeoVg8Qf06VPoayKHog6v/oSc0ZTypeiQTDr0nL6wkuGavU/s8+d2iUY
	spVFt1xUVi0vHQ/XVjZRsNr+ayJ2e5uK217mkeHXudLujVXLrEem3bavEDUr1WO+ArdyKRXjh0Q
	NARXvQcFRyZ3eHnIHPvWuOeHqnpPsejos75ylcoco8MPMm2FWrKkoNwEmIdkWauqoZSIMtg9aHs
	VzwCi0FHnWvGY6YD3/RvTRlR7Kgiqsgsqm38EXPIPdrbyKrVCCz1V9LEz7g52MJWpiPFa1IbIlx
	r+iE9nzq+Mkvjz9pJ0TqDpmsxt7OrMTwpEpeRp/nYk5TgjG36G83w3BxnFTi5iC6owQ5BYlgZ80
	otGn/J+y+pLeTrTMTpf6MGdD1SABRaaBjcJURlwOes9xMR0mYV8m1L2Yk2HV0gqOKnEK2f
X-Received: by 2002:a2e:b8c8:0:b0:385:da34:5182 with SMTP id 38308e7fff4ca-388104d9e2amr4905271fa.13.1770980877740;
        Fri, 13 Feb 2026 03:07:57 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-387068924c3sm13635831fa.1.2026.02.13.03.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:07:57 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 13 Feb 2026 12:06:52 +0100
Subject: [PATCH v5 3/5] i2c: davinci: calculate bus freq from Hz instead of
 kHz
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-i2c-mux-v5-3-fb2cbf9979b3@gmail.com>
References: <20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com>
In-Reply-To: <20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2849;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=NgWDqx3izSY9aW9W75gFytkLHJndTcTMdemaHAZbfa4=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpjwYL/mBgptLRECM6Xhb4gqTFs3FQSjGviRzOv
 JLmo5EhXpSJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaY8GCwAKCRCIgE5vWV1S
 MvCZD/9WMtRGpgF1nsGmzHotYBXEo3UiFoeK7+Nu+zc50fy5TcIUV8PLiDl9zLOnr/WKONF/c72
 FYdeNB+ufxhjtKxNGOIoqlw+xkIR5HtF1iehNbmPanpjW69FJ45g9dWU8iq491iNx6zyDvINhN3
 AuuhvYJmDzuLsnwgAPMALlDA7WskPKu3uigAhraJNLUb8zbtrZBHzWgY8QVF+70RWB7JjWvrvNX
 zB9eFtd6uA5iowL74VBvk4cJgknFWoo76C2jgFKNawr1E+mOQjHxp5KKcoM+2JtNINsk3R4wjoq
 xPN3TwGPNJO9bA6tS19h9fnEFLJLO+xyXB6GTnEBWo36z7mG5pssbevtsI+kN+na8+H+9+RY0cd
 PxOFsJyIBrcb0XHZ9EV68dZC0LQl7DulfGCLh6hiTn+DwiFn0KH9bNoTk3qbsTQWP/i2hihMyxD
 YV2SbP8oC56SwxAb7hQzx4vpit/Cs7aKxdbGU47uYS9wSkt/DgRpFQld5yhMqbsth2fDte6fRFL
 Y1uo4i70kLXeyP6aUK8w8SH30CO3kmPh3bMdVF6TzMO9MUnYKnmTV9r6W2p1EBW07uB9mLWRf8V
 AzfMPFwJ7l3r5OSOe2FoSOOCe//DzfmZmeMgf90tDRh9jynzenWcEv2iVArE2khhRIvdwa9kLDc
 OF7wPgFWNaWbBzg==
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

