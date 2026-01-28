Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AED221DB5
	for <linux-i2c@vger.kernel.org>; Wed, 28 Jan 2026 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594116; cv=none; b=VA9eow5fNSmI4rUHRRzAhm0pxwpiJ6O7ELf1maVL9JtCizEj7WI+zO7zTuTRu9djQZFeHqztFNCT7O+aHpVSeRSB3T7Ewe7YsseTkCOUtGZlGyi19IEUMt1FcWsNoz7IQhTl23hOTNsDQNM4AvI/hdKpIwkkhUKjEtVvIpMWWkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594116; c=relaxed/simple;
	bh=32tpqgfedy/sxp2AZTtYj6G+OqEGB6zW9YyBBWylfYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJ+p9Wmq3UWvzPPa/R8kRvL+8y+eLi1W4uFU7vdnD0mxjSEywKHMM3IeVGl32hJKArtHBi1wxdR7SUkRSGf5QEuMF2zlzs+oNAtj6B2uTBupV1PH2T0uwPo6c8d8R3lQ7pK6vgVnowlQYLhUyDK5IQO9YoL6tjHg87J2zSQFTAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGv6jPOG; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGv6jPOG"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59de6abf324so4689528e87.3
        for <linux-i2c@vger.kernel.org>; Wed, 28 Jan 2026 01:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769594111; x=1770198911; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJdrgI0gtiqZZNbRhdCivzcmuLMzMB0vNSWzU58rH+A=;
        b=HGv6jPOGa+tQ42+MOjgcQHjyB2vNlNy+TBkyjn+Z+zPLd46Qb6rQC9+yWBt7fpNKWn
         X8j8eBGy2Qx06cUtmqJUMdoHRl0RbpE8JjQXz9/u2ixFsQcsWFHVwZwCcBWE5mzA8M76
         QvIrUKaPjHHF04pzI8gFcqXyd4VVAO/kN8827dJQmsV41Xi5JN8yXvBFmu9E5+amIFie
         vhWua8FOyW1sJL/OsCmaOdZiznDX5XtO6E7PdO+daOIhKKCIBnRvhYM50hrePzvfKQbM
         f5bqIgBzysufOTIdDQGEv9F/UxmefNXMb3EStONFAYuVGZ6UQ+Cb4gywibr1jKK/Fg58
         vcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769594111; x=1770198911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QJdrgI0gtiqZZNbRhdCivzcmuLMzMB0vNSWzU58rH+A=;
        b=R/ioohrp96NwhUH79HxxuUBkWuJgC3nWNsckE7GEMYhEj0/4oG8nE560/gokOx/xvj
         EkNq+YoFvBf87YfXKzvYoj2op9gL+E+FwSHnl/iXLpKx8vtQjANeJHWi76EeNE4fLmja
         zvE09K5FnrDAvbt/GxpMsgabmUZ3ntZ7uWJC7sBbqgQ2ndISNBCN5dShSKMX79o5detU
         QlKYnJTLw/oqdrQ8KhgCoiDkvyAf5H66p5dF2c4haI3I9PnIq2jLwS7qWGEq85/2X3/h
         83RhPEzqnhHqewR0W6k0OAUIP1ZXRgwkJW2x3OEHlgCZdRK3egfs9snig11ZSr7486os
         M0WA==
X-Gm-Message-State: AOJu0YwTxDfXjonMisa5b5PMn8G+bPE7DXgIErvGZdYxFs3NZ6JTVjyP
	R7NjOoQVpnvllv5NzOsm1ygV+TOwaFuum0x7FDnkarXCzVwjRFqbE3CO
X-Gm-Gg: AZuq6aJ5aDph8ywoTFocP+N2DILEMav1yVQ/VMZgCEJO45f6NyYLSSrRAt9WLVFZepO
	JlUvaj0JRJSFjr1RnIOCxFLPfL2IlTGjYf5jOfnd+ye8AyuCHyqW9d4plF+i+76oZNIiFl/m1/T
	/xTOSZg4Rk/qcjOPBeBUyK+cHY8Casl7Vsm0yiFy1vPHkYRSs76SldS0bgkvEVg4WRj13KDt5GN
	nEJlfV1Mycz2WP54chhYSaeIzcWKjMsaw4stZ1aPBVQuzcxTAIkzhS7zYH41smbh3r9emV+YLGo
	r6B7PtFCo09KAASr4gDQtylQnMxs4KpquiZuKNiOBMbU++hy2/WKaTn3y3yxOA7fZ8QEJR5c9yo
	/Z/YznAONz7GPrLyHe+wQP4Wk3UwM85J/7yR8/tdLl0VW1zjK5dDX05YWC5LvI4IEvazIvSkv1H
	UTWzRbouHz0njpzNPKZHtZ3iZjc7K1697muHDp0Cy3+yYdv1Prjy8jsqF/
X-Received: by 2002:a05:6512:3e27:b0:59d:e954:1908 with SMTP id 2adb3069b0e04-59e0412db34mr2132085e87.51.1769594110691;
        Wed, 28 Jan 2026 01:55:10 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074bfe83sm459483e87.97.2026.01.28.01.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:55:09 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 28 Jan 2026 10:54:30 +0100
Subject: [PATCH v4 4/5] i2c: davinci: add support for setting bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-i2c-mux-v4-4-dee49ce276c0@gmail.com>
References: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
In-Reply-To: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
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
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpedzyZidWVC8WFnAehdPL8hDSbJvc6l5n5RsrY
 Rwu5wFkpYKJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaXnc8gAKCRCIgE5vWV1S
 MsF2D/4ycjuzoTTAKCcdpurYUQEmolVE3xElDDxTgrp+COyg6IN/nX3Q8eUfdj5RwRTURcRiq86
 wamt1pt2hRiUr8Z4vNSS6zdl3jom1GKW+TPuCfhftdjgi/ykEBMhk+Ajm3pL1H3LzRyIm0Hihqr
 CddCtl4w0H06j8pcgYUgwylUoLqoCrLor9TEbCj2JNgDFpKxqSStyCmGZfpRF4dTPItUqh9oVzA
 2/K2F9FU4C3ncSfX10f/mYBbow0rsgwlh6G/OIagu94uA06BokctdIO++00nF8AWJZE11FJf30c
 spDPhucw+AMRfwR1QOoVUbdIIbrNdIXkftfdkOo/tnh7vEkxEMO3OuzHdzNFp0K+krA/gL39RaO
 DbJ8mQ/mjEdDOSg2anqVJTZhMKTA4kYU22SjDSRTTgFu+2+lz1DWKOfKtoDlnPt+ruyC9WALG2Y
 iRhWZ/yyhYhWnVEjuNBV6MGc8KP3ILYBF8/qMI9oyJCHSSeFzs97iHJFlLd60hnWgSMfus6joGU
 ZLDSRDEjW0iY1BxJmEZBolSMLSjOSR7WqCKFUqwRbzbMCw3oNeo1Dtn77W2MdjxDh6Mg4LTYCJ1
 oC4PuIK6y5NE+CJnHMkmbMSYLavl7MhBTr4NePIgB4Qy5ZgIG58yYm1EgIH/DjxxPEA9UwjzqIY
 nCYCJi9nUXPteXA==
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

