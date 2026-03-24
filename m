Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659E53A2566
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376883; cv=none; b=Om+O1z/jO5sq/wVWTsBf6I15xPSq9U9P3g6YSWeukal9Y0UrEqdUCcoQCT8UWwN2Mleam6es99qR2I4q3k5VEABWrN9Akrbqs0zWBHsc0folUZCt3eDqrqrz/2WTl+JztwyKudq4DlUEl6n/7wnEg2up1hPUT49XLcmEGbnbtCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376883; c=relaxed/simple;
	bh=Og+ag9IkwKlXlRqp73B5hnPk+W9xiNL+UaCwuonyITY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WDE53g994lXc+OCtD8gnpUI79trTKzvByzonLkJdjJiLE4qanrsL/t1hLOfLQ2vQYb4vI122CAZ8IRke0mLEIl+i8SQhtaQRLeEHTavhAmeoj89aAK13yJolxWWEH0SsBkXgxY4p4i2hiKDmxBGXd94tymK7acSusOK3Qbeg/0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHCrnv0V; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHCrnv0V"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-356337f058aso3251986a91.2
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 11:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774376880; x=1774981680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHa+g9Yvknw/nsgWzBDeK9srp0wKwbZMTd0+ms6kC4c=;
        b=WHCrnv0VzU625lqgVnnry/SM1rBVfsO4msu6b3kmrraeCWCplik3gPSvP5kVf9gyQH
         lWLhnl3sCLyGMMC+EDMS17zeQDwZdeb9Kg+CtMe1Q+dk5nsCbKXWgOTsN5jvkIxhlfrM
         infMW4EyhTh0j9T/PqE9Zha8wpxnbuIDp3GFk4CNKzHOCTHINVEOjJBCiuldD9xeeVyX
         hxOhLgnbMbQ7NXvXEbZ6+ZOIiG9wzXSJz7fSTl21ryX2SCFOOCkte57+Y7yxDvY0J6j+
         g+g3v6WjXKm3yvibbDgURFpBYZfhvIKkQ1JRe+vigNgm6BA73Q8YyUpEJ+Hus5YkcquF
         a+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774376880; x=1774981680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HHa+g9Yvknw/nsgWzBDeK9srp0wKwbZMTd0+ms6kC4c=;
        b=A9auBzGyBmAkiycUIc1GlFD1jKODn2wPVnDz5RQs8lniou3JOm8sUWceKYCr4QnND/
         y2Lj4HDXiIvkFFb5TbRrMFPpCUdwa3wi/fgE3ibFoTsGKRv9SPQqaHIjVTLb5dHhzBZQ
         lIhItTWG0OcirXorJ6J7ck9XzCN4l14qZloyMp693Lmlkf13AmwT2L7XKv/Op6a2AZ/R
         mJPhIR6JIYkbyNgEHAZPLRrG+hmTxJPGyiQFrmXaSIAg6vtXybBJgSGAhxoMmM2N+F2O
         IYI1NRKBinDmEmOClv7m+0OfqehIb7WAdzw+bpTr07Qr4yUCemcqN5FzpCdCGpOoUhSd
         PbtA==
X-Gm-Message-State: AOJu0YwSyK1b9Y7+iwAR2kh7BqDvjtQINiaupzUQUG2zfz3wbdd6cqRm
	6ZGlGQ+bs3yIGtbaK5DHCUYkHPRe86fYaquPbjFKbU2v04aSOvTs9ITNV0+LcXOt9vA=
X-Gm-Gg: ATEYQzzkD7MipQzoNfXZ8Y+3XW3H0/lHhjFKpov/wboBw4b7L4bwwAYVToGlfiERHH+
	UhwhBxPT03krC57E7IcTDGvYI1JQoxFRmwVuc4cHdTc7Lz/QXNtgwL3m9AxlQ/3iimZsUflhB9F
	dXTO3/JpwNePi0HswpxkZe8cuIexcZET2saihGQXHDIbPhhf5RkID0WA0KlJ2LqFrNkihSTMqTC
	ZcXBOlrNG8373Xz1aTQ5zHPnCHuRxEjkrxY3CHRBunh2+OkKjY7CJnOUVt+MQ9aoJH+g/MKycpu
	O006o2Dor0I0mGQYvdqGMTLw3A7lCjbTYr7sFo4paEZImdbPmZ4UXDrxRBOVizyovnttDNs38Ew
	HFEC/ocbMmrb7V9/jni18QMKbDAz4tkkk6BkfpqmKJItqREyUz2BzsYUX11FciLZTU5zFU41LWq
	Yj3RuxSj5UaUTW6tXqAm3+7Yv+FA==
X-Received: by 2002:a17:90b:4ec6:b0:35b:e551:90d2 with SMTP id 98e67ed59e1d1-35c0dd95828mr337562a91.28.1774376879990;
        Tue, 24 Mar 2026 11:27:59 -0700 (PDT)
Received: from [127.0.1.1] ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0d6060b5sm350576a91.17.2026.03.24.11.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:27:59 -0700 (PDT)
From: Atharv Dubey <atharvd440@gmail.com>
Date: Tue, 24 Mar 2026 23:56:53 +0530
Subject: [PATCH 05/10] i2c: stm32f4: Replace dev_err() with dev_err_probe()
 in probe function
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-deverr-v1-5-7e591cce33a3@gmail.com>
References: <20260324-deverr-v1-0-7e591cce33a3@gmail.com>
In-Reply-To: <20260324-deverr-v1-0-7e591cce33a3@gmail.com>
To: Till Harbaum <till@harbaum.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
 Enrico Zanda <e.zanda1@gmail.com>, Atharv Dubey <atharvd440@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774376818; l=3441;
 i=atharvd440@gmail.com; s=20260314; h=from:subject:message-id;
 bh=fUyekU3vIj3XVF9IEZZuF8p06qRSr8GpHENT4b6dCL0=;
 b=Lv6diY6U8yOO+wFg03BiFqyP3QS+BUZjUWZZhiQKaL58Ge1g8J4dtHf+S+KQwwxbmw5DUKteO
 KpFdph3BhEcCYkTzwZIrFSEDvv+nlC32lTjIg5IZhXq8rp8u8lOOdaA
X-Developer-Key: i=atharvd440@gmail.com; a=ed25519;
 pk=T6i1xWOKT/RUSDYATSgyVG/4X7ac8jPjRSG1mMAcqVk=

From: Enrico Zanda <e.zanda1@gmail.com>

This simplifies the code while improving log.

Signed-off-by: Enrico Zanda <e.zanda1@gmail.com>
Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
---
 drivers/i2c/busses/i2c-stm32f4.c | 53 ++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
index b3d56d0aa9d0..44e8b04962bb 100644
--- a/drivers/i2c/busses/i2c-stm32f4.c
+++ b/drivers/i2c/busses/i2c-stm32f4.c
@@ -163,11 +163,9 @@ static int stm32f4_i2c_set_periph_clk_freq(struct stm32f4_i2c_dev *i2c_dev)
 		 * to hardware limitation
 		 */
 		if (freq < STM32F4_I2C_MIN_STANDARD_FREQ ||
-		    freq > STM32F4_I2C_MAX_FREQ) {
-			dev_err(i2c_dev->dev,
-				"bad parent clk freq for standard mode\n");
-			return -EINVAL;
-		}
+		    freq > STM32F4_I2C_MAX_FREQ)
+			return dev_err_probe(i2c_dev->dev, -EINVAL,
+					     "bad parent clk freq for standard mode\n");
 	} else {
 		/*
 		 * To be as close as possible to 400 kHz, the parent clk
@@ -175,11 +173,9 @@ static int stm32f4_i2c_set_periph_clk_freq(struct stm32f4_i2c_dev *i2c_dev)
 		 * maximum value of 46 MHz due to hardware limitation
 		 */
 		if (freq < STM32F4_I2C_MIN_FAST_FREQ ||
-		    freq > STM32F4_I2C_MAX_FREQ) {
-			dev_err(i2c_dev->dev,
-				"bad parent clk freq for fast mode\n");
-			return -EINVAL;
-		}
+		    freq > STM32F4_I2C_MAX_FREQ)
+			return dev_err_probe(i2c_dev->dev, -EINVAL,
+					     "bad parent clk freq for fast mode\n");
 	}
 
 	cr2 |= STM32F4_I2C_CR2_FREQ(freq);
@@ -772,22 +768,19 @@ static int stm32f4_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c_dev->base);
 
 	irq_event = irq_of_parse_and_map(np, 0);
-	if (!irq_event) {
-		dev_err(&pdev->dev, "IRQ event missing or invalid\n");
-		return -EINVAL;
-	}
+	if (!irq_event)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "IRQ event missing or invalid\n");
 
 	irq_error = irq_of_parse_and_map(np, 1);
-	if (!irq_error) {
-		dev_err(&pdev->dev, "IRQ error missing or invalid\n");
-		return -EINVAL;
-	}
+	if (!irq_error)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "IRQ error missing or invalid\n");
 
 	i2c_dev->clk = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(i2c_dev->clk)) {
-		dev_err(&pdev->dev, "Failed to enable clock\n");
-		return PTR_ERR(i2c_dev->clk);
-	}
+	if (IS_ERR(i2c_dev->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2c_dev->clk),
+				     "Failed to enable clock\n");
 
 	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rst))
@@ -807,19 +800,15 @@ static int stm32f4_i2c_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, irq_event, stm32f4_i2c_isr_event, 0,
 			       pdev->name, i2c_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request irq event %i\n",
-			irq_event);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to request irq event %i\n", irq_event);
 
 	ret = devm_request_irq(&pdev->dev, irq_error, stm32f4_i2c_isr_error, 0,
 			       pdev->name, i2c_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request irq error %i\n",
-			irq_error);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to request irq error %i\n", irq_error);
 
 	ret = stm32f4_i2c_hw_config(i2c_dev);
 	if (ret)

-- 
2.43.0

