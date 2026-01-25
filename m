Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8CA2FF154
	for <linux-i2c@vger.kernel.org>; Sun, 25 Jan 2026 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769370703; cv=none; b=avF41Znl2+KK8nUh/YvDEPgkb6gEHqjfy3h4pa0JH7EFbfwYNF/Sh8KbY3xgll5kiTriJ3CcM2pMT62EF4KTDk3HlJo1ZfYXKmC92bTqJGGKwO+8AhevSpdUJrPM5Uhy4YaD8HQIdCkQyDiG9msDIo2n/sGGcV/INLJbk7aoIG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769370703; c=relaxed/simple;
	bh=tQ0GUXHlvLjzR+49qpOK5aB36nhWTrg04e7AKSsJQxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3tcgjaV6XtXziVP3G5m7BpT29hnIBGiRqRXKo5JP6YYl5GTggaf9I88BeqGC30ZhuDFyC2uI85pcMG6MqaVdUz9/tVuR3kXW3UZUlBNFFrGZqw0KYrwh3ocgmfuyDS0rGb9dfvBpLpe1e6AYWTkb8o6E7vf32a7SBP7E4E83eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwGRjLrI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwGRjLrI"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so554704866b.2
        for <linux-i2c@vger.kernel.org>; Sun, 25 Jan 2026 11:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769370700; x=1769975500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+7+mKj8XKCXDrFYnXFD6aPpUYuOrtmLT/xGxemFmLg=;
        b=kwGRjLrIhDKmLCesfcvfyV6Usw5qEMyHLBTuuN/ipdTDJfU3WAUL/hkytQdUS/Rxmq
         mKeyFMYH8javNmGUXkpTUqp+14X0cxKQUat6Tq2OIlCArrDi3nH+8pRUxiTthofc+QeP
         hbJelIfSlV/fWo1qCQKKECGu6eN5jWLDbb6NjzTX4ExfXkBqmeUb1RLG5rQ8KXYu1F5U
         xihPy+ZS3p45ddht7nx6VAt7rpN6pS3QAXCe7Cu6ntrpDVGLTSDA8MSFZXqDnvy5KrDT
         d8IWIac5Y7NuTh5RHdLf3bIVQZKzvb8NlJx2usYqPDVxmp92FxllE2J5KvLBiQoYDsZy
         StSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769370700; x=1769975500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E+7+mKj8XKCXDrFYnXFD6aPpUYuOrtmLT/xGxemFmLg=;
        b=N1URrB4lj2yaeBy0nUNCQ+6xaMwXIMNIkgGx+vwwUe4wKoFZqWDEpG6p7uJEJT2mTL
         Wa2Apl1RBYykrOECCYjl11Wyc7BB+71aIDgIucoCu2nYxYKTcTsq0VSY7MdzDonnyPVB
         MbP0Fi8PT4mnpK/Xfiua7ivzF7ObqTonsBuwBDVQV5J3u0ZqYuUy8XxrCxuBYbapSOJ/
         II/oFC4bUV1eR+B7D1wawpOeaa3vC87NS+cPooRdfbijiHY6pRZOfCjkXU4qBs4W5Eds
         Up1BVwD/TKxHgEq4znvr8/51rrHpu0AUYCcPzRSBnPkhkNXvbojCaPGqqQis72k7HebI
         Oxog==
X-Gm-Message-State: AOJu0Yw07D23Vze+mFUUtYTlOiOeUtuvzWqrO4DTNFKvbTTZmcKvrDXo
	o+MmnG/jKv4S9E6T5PZgwIbZUqzv4Ji9ic5zA8t1/RRPN6n/N5+2SL/C
X-Gm-Gg: AZuq6aLi7UDMVPyKBPastMiaM3/SsCm42aYAde8nDNe10kHQUmMpP0dLAtklPFmAfnm
	h5ozBoOIoINPLbN6Ffjg0+rIUbfUJkVgZoENhU+qGxvZd84uqJObnSA5EvA1/dyP4psN1qcSwv5
	tga5OxF0yrYubb8CBLvVobxi9z6PJGT9JKeDs449yvwW+0cBvicTAIlIar2JsruL41g7cHl570g
	yHh1CgzXLZlaRz/AJR6x8fmylweE9svAU7OiT2E/50qhdoQ+e0PdhOLnLB65ZonACUNwG9xuDGf
	WA21+29prm2ipbRvAxamGYCK7ccmfv74Q6I7yPNKIAXAMK7aZSdCAwP/x/g66+QTS8IZDBe9ysG
	U3aQeReTwMmDpD9knq3YhWqSYGm8DIzvGjMQaDq1w7CAlbbpZZd/iLri1fF7CxshWAskilRsO/J
	KfKunZVwwahSWcIfwecEijvq8TacL06xRnvw==
X-Received: by 2002:a17:907:3f0f:b0:b88:4fc9:a196 with SMTP id a640c23a62f3a-b8d2e85e0ffmr170791566b.34.1769370699647;
        Sun, 25 Jan 2026 11:51:39 -0800 (PST)
Received: from C-PF5D4647.localdomain ([147.161.248.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b965df4sm4010232a12.31.2026.01.25.11.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 11:51:39 -0800 (PST)
From: Jie Li <lj29312931@gmail.com>
X-Google-Original-From: Jie Li <jie.i.li@nokia.com>
To: wsa@kernel.org,
	linus.walleij@linaro.org
Cc: linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jie Li <jie.i.li@nokia.com>
Subject: [PATCH v2 1/2] gpiolib: add gpiod_is_single_ended() helper
Date: Sun, 25 Jan 2026 20:51:22 +0100
Message-ID: <20260125195123.248798-2-jie.i.li@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125195123.248798-1-jie.i.li@nokia.com>
References: <CAD++jLmGMWjCD0gUcaJPuK0UzJa7nX1bdoVu-BA7aHAgcLTSpg@mail.gmail.com>
 <20260125195123.248798-1-jie.i.li@nokia.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The direction of a single-ended (open-drain or open-source) GPIO line
cannot always be reliably determined by reading hardware registers.
In true open-drain implementations, the "high" state is achieved by
entering a high-impedance mode, which many hardware controllers report
as "input" even if the software intends to use it as an output.

This creates issues for consumer drivers (like I2C) that rely on
gpiod_get_direction() to decide if a line can be driven.

Introduce gpiod_is_single_ended() to allow consumers to check the
software configuration (GPIO_FLAG_OPEN_DRAIN/GPIO_FLAG_OPEN_SOURCE) of
a descriptor. This provides a robust way to identify lines that are
capable of being driven, regardless of their instantaneous hardware state.

Signed-off-by: Jie Li <jie.i.li@nokia.com>
---
 drivers/gpio/gpiolib.c        | 22 ++++++++++++++++++++++
 include/linux/gpio/consumer.h |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1578cf3a8c74..96c34bf65c7e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -486,6 +486,28 @@ int gpiod_get_direction(struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(gpiod_get_direction);
 
+/**
+ * gpiod_is_single_ended - check if the GPIO is configured as single-ended
+ * @desc: the GPIO descriptor to check
+ *
+ * Returns true if the GPIO is configured as either Open Drain or Open Source.
+ * In these modes, the direction of the line cannot always be reliably
+ * determined by reading hardware registers, as the "off" state (High-Z)
+ * is physically indistinguishable from an input state.
+ */
+int gpiod_is_single_ended(struct gpio_desc *desc)
+{
+	if (!desc)
+		return 0;
+
+	if (test_bit(GPIOD_FLAG_OPEN_DRAIN, &desc->flags) ||
+		test_bit(GPIOD_FLAG_OPEN_SOURCE, &desc->flags))
+		return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpiod_is_single_ended);
+
 /*
  * Add a new chip to the global chips list, keeping the list of chips sorted
  * by range(means [base, base + ngpio - 1]) order.
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index cafeb7a40ad1..c5847c8f66fe 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -109,6 +109,7 @@ void devm_gpiod_unhinge(struct device *dev, struct gpio_desc *desc);
 void devm_gpiod_put_array(struct device *dev, struct gpio_descs *descs);
 
 int gpiod_get_direction(struct gpio_desc *desc);
+int gpiod_is_single_ended(struct gpio_desc *desc);
 int gpiod_direction_input(struct gpio_desc *desc);
 int gpiod_direction_output(struct gpio_desc *desc, int value);
 int gpiod_direction_output_raw(struct gpio_desc *desc, int value);
@@ -335,6 +336,10 @@ static inline int gpiod_get_direction(const struct gpio_desc *desc)
 	WARN_ON(desc);
 	return -ENOSYS;
 }
+static inline int gpiod_is_single_ended(struct gpio_desc *desc)
+{
+	return 0;
+}
 static inline int gpiod_direction_input(struct gpio_desc *desc)
 {
 	/* GPIO can never have been requested */
-- 
2.43.0

