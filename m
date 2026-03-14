Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05635282F1C
	for <linux-i2c@vger.kernel.org>; Sat, 14 Mar 2026 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480149; cv=none; b=kerTb5NZ1CGdHfpiivGY0j8+gSR0wRjS5Qf4EZsxTFLqlSqq7NnuX3ELRL0nvb/vsUs0Vo1RvYaDAuJxzd1w9q3lKae5yUDUxJyv4Otq6mC7jid2mGxUi0hvhNWJOzLxC1oHxyKGPkkelmtjjxxtef/RnDvSlIV5DkkZ4b6IGJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480149; c=relaxed/simple;
	bh=XZVd7p9mIBaNy+NIKUZiBgjkJyYONlNCoWZWgB7A9Zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJOEk5t+FR4c7bJVzBqdpNYDblJdIAVGpwNiuiv5uEAPf/hxRqnxon4r3kdK3gQ5lIGfEqdXJkG5piyuDMpRZbeoWipxRR4Dr4tYVFD2x2aHhJ1Ml/ohlXbL3loTsm6G8/H2CgzOnuBZupSF8UoamrBSUUv1a6wDcAJNbQFdA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFAG91jz; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFAG91jz"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38a3225d59fso22237761fa.0
        for <linux-i2c@vger.kernel.org>; Sat, 14 Mar 2026 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773480146; x=1774084946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdAp6xh8xeBfkhw2oXmLZzz+7TGqiyYSvmIRi8yYlCE=;
        b=nFAG91jzs7w4OKR6o62ITquUcCtkoxxEr8I2j4u4gyEhD5kzi/OYDlXRTQfEE/ed4w
         zeNm7itqz4/KEp/JwIS1O/+KtE2xmuljYfzjOQ7VKyB4TrXKXQGPlXbxcBmQBcM3OWTL
         PGN6Gl3qPRDmqCzh6K3XPBaAhPVLHvIkkj0Rqh76uy7zMLURmO4ErSx2Hloa933ZNuWo
         uqtgY+8wyhLpWRPq8f3pCDhQUahNoje36yFNDRGlrjQA7fFRfEGc/SqSWWLH6eRRRtbB
         wkjtMih7ERxk6tifJWzFJunwrhaEUvehSJoUMujovjN52MyHwuV19zuxb08jRpGN/wz4
         pekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773480146; x=1774084946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JdAp6xh8xeBfkhw2oXmLZzz+7TGqiyYSvmIRi8yYlCE=;
        b=DUtobN+A+xHyRn7ZKQLr/uVoakg1eGKVY9Eeu1jkWwmTKdS9HvPwT98ojVx2TGsb+M
         oyBQE0joroTpl8w8mtJ0p+VnzYKk/d1wtipF4UuEkC2djXNspNO6ipNADc21yyNBpBuG
         LBUWeNmSG+R/4sKXqHrNnvLT9fpWerAbkunR/yU0ubilik5MBEys1F2FNAcyWOocgzeM
         F92Y+f4SCmwETdZeO+KRaKZXaEmrAYQEz94Yhm9UMjocxNJQ5ok+lUMCTAIrW2Yajl9w
         auEtZkcIZiG8mQPhNWCXxZQVm+yqKgPXv/UnAPug2j4+eg0OgWIDKcv31DgHKIOm/ot0
         8n7w==
X-Gm-Message-State: AOJu0YxkK3avVTb5YvwThPFrPOSUOFAy9uHaAUJM5gMirSOo72ke0UY+
	Wk3yAHN3QpaXBE3P+F9dSQ3snDwOS9V3V75gt6uWEZyDaJ8bDtHSCCTK
X-Gm-Gg: ATEYQzz5B3fuSmCgjBtNyVlJ5U/j8ONNAKenq9KYjv26Hy/KKXOOZhCVGgZHlJL6v7n
	22LEocTTmw3hdTsA5FUxS+hVPg2t2xoGKWDUNHllA3jheEmN2765qQ5/g/8QlqNNlVdb0UZD5RE
	SflXOU5pYsmvtgVcymSaHD2+MzYSiFabzb8M0i3EcZiHSvG1yMd86qncYFj8imudD1HxIdszyLJ
	bkvKe5ixqNp0dc0aimPfRYcbnpcWY1oNe5oxxSsoxfqmsfZdt+S31HVyZgp1QhbP9geb5UpovBJ
	XVHSj+uAltD6dlT4VxhcAlLgzUDketbPEYDYH9RXHF6TJE6f+VM1J016CWDAe7zeLi3G5UrU1kq
	yHetIpNtmfNCSnpml2k6jspO93QOivhyrmGMmQTTnaHuTNXNwRV+E4hApBgdv2Q1HYppVuyk0Vn
	MTEeZy4iSXB+sWYm6V1aVFfiISbWCT4V+7KSli6t2JT91BxFprQRMAMDHar84J3/wpdtxQ
X-Received: by 2002:a05:651c:198d:b0:386:fe97:a554 with SMTP id 38308e7fff4ca-38a896174d6mr19418301fa.6.1773480146068;
        Sat, 14 Mar 2026 02:22:26 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ec94sm18454261fa.22.2026.03.14.02.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 02:22:25 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sat, 14 Mar 2026 10:22:40 +0100
Subject: [PATCH v8 1/5] i2c: core: add callback to change bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-i2c-mux-v8-1-fb1738a4df0a@gmail.com>
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
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2485;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=XZVd7p9mIBaNy+NIKUZiBgjkJyYONlNCoWZWgB7A9Zk=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBptSjwLT4MaR0DO6Twk7A21vxdQcVbeFomx/EA1
 +jDGStKmI6JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCabUo8AAKCRCIgE5vWV1S
 MkcaD/9VLkaaITlVtQkALLgR9imaLtoSahhvcBaS5hnerW0ZoM415E+OF0n7qMHWx2vJ+6DwVJE
 cYh4zw/V8t/Vq2WtJgxNNKVobFBmGkI8yN8e10b7v01X/yo8P9aBwkeN2JzllVPjp9z1ottTC71
 efLQxd/zVbzEUfscVZBiIDU5jBqnpOx7oIruF5rprombL0+AJky7HBfEBnfltDW24XM3kVRoil/
 SUGQ6ab1qFYGEF4sBorFH2CjwqqoIns9L8u3a9MygbkRCuF01C+cTZxBy3MsVHj6E0vBpJlyDOr
 w7y65qTCcrHUsdNBsAYB0b+KiGgVM74VdisH/ustdjbQVtYhOFulGjyqCkkh0TptdUY4coavYG5
 HGprEjwXC47VGsMN/8r8g2cxUWHOC8i9+fz5cToP2jXuQ+gZisDmiXYopoIUVATbAZ3pCB5u8dK
 kdFEm9aFQmfW4ny1uMHlGQRwtJwChfxSaxInWpH8WuALjtqL/3ZW0NrOAXKln2Mp+GP1SY7nS2V
 RecUtlCpvSUhntRYBf7E5qfb4ROvicm8zY2bnflp6vyfvH3gr73kAVM8LNskzxfWx9JuhliWEKY
 klQjmeO3XUz5A2XhPOGyrSlhbNRIqYKoSq06af6RQzq1e1XaZv6lmk6JxufSjHbAyEWxOC22GoD
 X4PymDvN649/AiQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

All devices on the same I2C bus share the same clock line and the bus
frequency has therefor be chosen so that all attached devices are able
to tolarate that clock rate. IOW, the bus speed must be set for the
slowest attached device.

With I2C multiplexers/switches on the other hand, it would be possible
to have different "domains" that runs with different speeds.

Prepare for such a feature by provide an optional callback function to
change bus frequency.

As a side effect, several bus drivers keep the bus speed in a
private structure and can now have this value stored in a uniform way
instead.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 include/linux/i2c.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c..712f9608108e 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -742,6 +742,8 @@ struct i2c_adapter {
 	struct rt_mutex mux_lock;
 
 	int timeout;			/* in jiffies */
+	u32 clock_hz;			/* bus clock speed */
+	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_hz); /* Optional */
 	int retries;
 	struct device dev;		/* the adapter device */
 	unsigned long locked_flags;	/* owned by the I2C core */
@@ -835,6 +837,39 @@ i2c_unlock_bus(struct i2c_adapter *adapter, unsigned int flags)
 	adapter->lock_ops->unlock_bus(adapter, flags);
 }
 
+static inline int
+__i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_hz)
+{
+	if (adapter->set_clk_freq)
+		return adapter->set_clk_freq(adapter, clock_hz);
+
+	/*
+	 * If the adapter is a root adapter without .set_clk_freq() implemented, this feature is not
+	 * supported.
+	 */
+	if (!i2c_parent_is_i2c_adapter(adapter))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Update the clock_hz for non-root adapters, even if .set_clk_freq() is not implemented,
+	 * to allow the clock frequency to be propagated to root adapters that do support it.
+	 */
+	adapter->clock_hz = clock_hz;
+	return 0;
+}
+
+static inline int
+i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_hz)
+{
+	int ret;
+
+	i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
+	ret = __i2c_adapter_set_clk_freq(adapter, clock_hz);
+	i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
+
+	return ret;
+}
+
 /**
  * i2c_mark_adapter_suspended - Report suspended state of the adapter to the core
  * @adap: Adapter to mark as suspended

-- 
2.53.0

