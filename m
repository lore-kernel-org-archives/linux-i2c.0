Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74378285058
	for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980883; cv=none; b=h3KhQJewLtOg84I/Z/qw5FgcNzFm9W7sgOv/CBUdHxg+lEZocxITE3SMVYJa4AatYQE6ccQ0F/je1Po9eg4xycYB8if0mLuUdXRjydpEmWbIaR9y4DYrnyqyZ04wNQ3Oauo1V/hSH+itRSsiplGL6UlVps7v52DmLekzTPVT9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980883; c=relaxed/simple;
	bh=32tpqgfedy/sxp2AZTtYj6G+OqEGB6zW9YyBBWylfYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIiaX13t0fd6/4jlK4JT5wopJHhWdWDVZNlQPtQ4gpz3uiJHJcr5dO2WhUkw6BbixGaSHFweST1gU8CXY9B5K3g6NXyRZO0ZKIE5dLMJOxAVMn5Y/+JUWuNwDkwHtrfKv9iYRzNjgRsyrkc2j5uUobnjBzin1qhpUn7B+LQvOF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMvY96JU; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMvY96JU"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3870778358aso6510941fa.1
        for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 03:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770980881; x=1771585681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJdrgI0gtiqZZNbRhdCivzcmuLMzMB0vNSWzU58rH+A=;
        b=mMvY96JUzpsMuK2RrkTaJwC3wsT784UE5O4JW+DoZyIy0CIrL08xclDXWTa/VMJ72n
         7+rZlAD+n5cb5rnPnhd4XM4Wri+8oid8ey6WHdaTUu8TaMCmRI/ZfR7GoH5P1ZOSClg0
         C2GNb4Exhwnt6Ht9myzn8vLOEpK+rJPzIGnQe111eZWwd82MCRBmDQfdCrs6NeMy2vjm
         KMuUJxJoJ2ufQ9m+qMfEoxWXy7anaaEQg5XQLMAGif39rFDYkwRli1M6BejH9Un/ecOb
         e59kUNhGUKWEn0Zk6Whr9OPV4ESLCt+0ltkDVZBw8R6lSQXdL51Twd02LLkBFxX1mun2
         H/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770980881; x=1771585681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QJdrgI0gtiqZZNbRhdCivzcmuLMzMB0vNSWzU58rH+A=;
        b=n/fd1/n4/SoHdz5XKN3RfppAJaME9rf8reHRTk4FB2g4vCItuC0FF+pVBvXLdGorEX
         8HMTWh4nN/VgsOgC2ATwfdRcez/0/nu1sLLK94IvcroMwRf8dwYUGwd3P8T37WR+zZoe
         WM8MP2FXKgMoaJTlMWBKw2NkiXdozWO66bET0GPQzgOur2Av07betcockaqAl1Co4KOn
         7xXYgIhEAul3ewKaLQDVTit0aW767CYxfiS0wHgBdDIxH7l3O1kZhFqOUPNocIKGPiCb
         bGKOB48eij6SxIgcuV6PmSWxTojZNdkK3HPf0ot4XgWqadrTDJsaD8IfmgaJqYokvs+0
         I7hA==
X-Gm-Message-State: AOJu0Yws6e3xjcPuXSqEP50KdG2IppD20QvqhqjP2D1ezwR7iSQYBmGS
	LtNZwAmyc15va4Yu/KdUfvp23B3XkxgciQi/YigspYJzlCPZOTRbpTCI
X-Gm-Gg: AZuq6aK8BEikfVh4+/8GU3LWuvCYyaWJy4wPbfjbs2TbodXjuITJysjOjlAEi7o4p4U
	o3shJN37Rq2lEnULgbV9ZoVpd16fBUpnJ09MDtzxt/PbzTY5E0D11vP6HikgJa1jYxKT6d0Rdlj
	gUGtAluSfxBl/L7Ozv+pmJFxsQIpK5GZnUMg/yiHFyihuH5Hco3hJAqMOdngTqUEKFeoeRw/c/2
	5BvF3CjeAhvqB1PaljyeN0lZ912GBuKvEoHwBPgubvKV+pAQwCNoNvF2XXCgsam8Ptl7n4FjDFB
	9eIPed7E/UENU00Wx9tpj8ITOoBFly3j+eiFbakpkk68MBBvMA3o6gO8+Xr/p53peJbt11vNMmM
	7f6xiDu/4Rr6EY1kpX5/nO2lhPUf3mrgzXo5VaKCxKwfkZo4E3/m/ea5xFlN8GYJXl7alnsRZoE
	ZOyDaurP3ooRHptLUND7DAFLSVcO5cGrmuK4lTIVXw6jKm4EFN3hB+gyjkCj/GjjHYl8Pz
X-Received: by 2002:a05:651c:2104:b0:387:6d8:8d61 with SMTP id 38308e7fff4ca-3881050d8f8mr4342821fa.10.1770980880492;
        Fri, 13 Feb 2026 03:08:00 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-387068924c3sm13635831fa.1.2026.02.13.03.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:07:58 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 13 Feb 2026 12:06:53 +0100
Subject: [PATCH v5 4/5] i2c: davinci: add support for setting bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-i2c-mux-v5-4-fb2cbf9979b3@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=32tpqgfedy/sxp2AZTtYj6G+OqEGB6zW9YyBBWylfYU=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpjwYQjYtkmVzixam7zJlmI7LwWiVJSUQa8NVod
 MxK9pUbs/OJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaY8GEAAKCRCIgE5vWV1S
 MjL0EAC9rAgMMCWzcShokvBpBcCZucXuh3KlCmPqH5ZUGe3a8fLC2Y92u5hFvUeaoBpLmTLGP0l
 m93yekpOYZ5TdQSFzfnrikfz5HU3kG7n9J8UROVxIJksRZL5UUU3HgpObeJgxMoDPCvISmpgalJ
 jefFt/X3XOHJ3Axq4xHaH6B7IBvbYYu3KHIF7UWfDRmXeROBw8+oOqVcddBE1SCa/C4NUFTXpuL
 MWs1PUaG6BDi0vdGsBtEVMbsGRVKDYlKWgehq4AxBKzfc75WiI79nvwXOWlna8VnzBG6cQoDtGI
 dSYKb1l35lkZg0obmYBp0SDoiVKm9nT8JjteMoZl3r1q9mBrQB4496aCXtIZ7Dppc7S/d/JFXNh
 HcuYPMXPQ5zgAbsJmrQlm6LQ2U+94wLvMZMtoPWHVznvxvoVgTnX6xqEfTuJ1S6iluX92ACblGN
 560bD4rPEf2D/hRKNmM8JRKNAxGrVcueMfJ27beq/HMwddNkpGd0C2i6iJmv0gp+I1b2tuAEErq
 pccgokdH9wtCL8+lmwUBRGSKy5zOSt8iB/VgcTnQ3SbsYCX8MlhTjwZ+W3wYvC/oNi2oIZFOR5A
 23rYZ14sUuuD4cu5iMX99Wfops3pVytNSxnKQBMdro8CQ+OXAStSax5Gf34RbAcJs7bVVPe1zDP
 7oNl6E/1JN8+nNA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Populate adapter with clock_hz and set_clk_freq to enable support for
dynamic bus frequency.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/busses/i2c-davinci.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 761de5a814df..3daa823dcb9e 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -279,6 +279,27 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 	return 0;
 }
 
+static int davinci_i2c_set_clk(struct i2c_adapter *adap, u32 clock_hz)
+{
+	struct davinci_i2c_dev *dev = i2c_get_adapdata(adap);
+
+	if (dev->bus_freq_hz == clock_hz)
+		return 0;
+
+	dev->bus_freq_hz = clock_hz;
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
@@ -809,6 +830,8 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->dev.parent = &pdev->dev;
 	adap->timeout = DAVINCI_I2C_TIMEOUT;
 	adap->dev.of_node = dev_of_node(&pdev->dev);
+	adap->clock_hz = dev->bus_freq_hz;
+	adap->set_clk_freq = davinci_i2c_set_clk;
 
 	if (dev->has_pfunc)
 		adap->bus_recovery_info = &davinci_i2c_scl_recovery_info;

-- 
2.52.0

