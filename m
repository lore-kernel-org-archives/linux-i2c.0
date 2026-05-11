Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0D13612FE
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499456; cv=none; b=aL4rn3kf3y5WAuwzYh4iBjdhV1JPuzVxJjLlJPoQZcVDHczN3Dtf8CPz/uNenWVVm3+F6NEqBG6S56RLvfVUR3KFca3i2/w4GIGgxEHRI9lf4u5Mn6nJri8atAb7FWbb+aZ4LrTCA56CqwaKULqJBRilHOm9XSrgXSCTnFY4Ijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499456; c=relaxed/simple;
	bh=kT9wOZIR2Wfh0ZigYUA9rtm7wCF4sP8fJbMh8roHmiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpUZRgIExEEqLcx7z+FzM+qSuqYvYOxd9Kk+y/ZAUor6RkqT1eZvGuTcTTyY9IyyQkmrBeQ+T0GseqBVXvt7/ZDH76ZnnuEnyMU31iw45SiK2z6efpbnzkb+JdT7w5eauHfNOIHAuc8hKEBZ6ZmU7bY++gYWWRNofjMW0SSUTOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWk8x7KV; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWk8x7KV"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a88db610ccso4835891e87.2
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 04:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778499453; x=1779104253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4imfVsi2VomO9FzKGpPU5riMSUcvWN6BNCMHeP3TKZM=;
        b=XWk8x7KVwgyTZH4FvnHCRysoOgZQKhh3WuGRBclKTwHdSrTqnjT0Tx/GuZ8RvclYqz
         oAaxNDqiUdSumB+CFa3fTf6DGeV79uF78Vvs+wTaCs3XAhS6GeUIHTuUcgoYtGzxCe0A
         fxsHXOm5zkRoShoCCb5S+tdawfnKUKsIiS65QHi/gojrx687bQtsNsapvp3E3++94ELo
         7i3RiGYAJVzvCVOjXrORsgf/mP9qQ6lZWtwq2O5iF8mAagi8dad8xyD9BT9zJvia1t/7
         VlVFtdsFlP3poHCVES7rW0Fy+CRAJsHWvQThlY8BYFE8PdS99URQvbRf8biklbTaL3vT
         asNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778499453; x=1779104253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4imfVsi2VomO9FzKGpPU5riMSUcvWN6BNCMHeP3TKZM=;
        b=OpHbeI9XNY0IMWsI0hnMKWI2AkQZJGuWKvhx5pUrGCaafAhb+8IKjPYsVNviS5X0P+
         AaLBzEL3A9c8rJvqy8CBOipkaa9TfkjCIjmYqlhqXSxwNfkY2vgUWD0M/Yo8x3wp658s
         luaFiO5XtyAltxNNdImnwLQGn3mnGKCGEQ+U7h3Fn+xWpyXIq1+5mTQFOXS0+45K/5Ud
         jw4ScmwyMV9WQYwpGPYmH/14CCGyHfrvupFG/9rVEj3+9EBGTq2HXcTGIQkx88TxvbDW
         AbhlOP/1xmVgOVhq0HX3hXdAZB13d2au6p8k0t77LCFD4XDnVB7fcUEtSfRbU0BHprHV
         96/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/ATro8Hhb5oscgiIjtLEIrZrTFImmrdpnpEv6MVhEd/SmL86Iv0BDnUyvF/fI0tZ5W1Z2nN8V6jQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBkC3EhWoxEqiDXTLP9/5DJW1Wz/eQHzidCBwydzrQMtuxNymW
	TVJQ84PCgddAjXdNRTm5cxiRcOR1n4o1B0I9Iw2qGR+UXc0JtU67BfJQ
X-Gm-Gg: Acq92OGyR6a3wnvMoCGmqcjIjtLpoUerCEIVJusSKmrZptnpFRcUYwD3ty3A+PQgh8p
	npomAlGHd1k7clXeRj7d2pthgnsEmEx7ApnvGcSqfY4neCcmk7ycGAHXajqRSOB8t+0wef5WH3X
	5AbllO+Fm3FtzJkaJrvwrqHF1M5wBoLvqoc2UAbqraZvITckrf5/aMwCQi9rSyzvrOtWIyujx3A
	DBGGtlxLIemHj1ZHNfl/cKrsI43f9WtlmsvpZ3bkslZoo4G8OxDh2k1f5pBee8Lo0akK0bFWwnd
	wdX4DK2llwtgr4L559TflMYgQFSw5JI3B3LiGNipvfX0xPfO3qh61oafy3d3XtIZibyFwIIz3N8
	Z+WdsyRHUQN4mKGjjnamFlTctxjyv2gA9jjBMC0P8paP0hZXthmOi3X+Z6qEF5/2z5EHajxwEm3
	Uzs2Q07Mlzz0KHV7sH710DMsm107EFfNHEnZYU7l1SE2BPFg==
X-Received: by 2002:a05:6512:15a7:b0:5a8:8b42:4ea0 with SMTP id 2adb3069b0e04-5a8b6e8f5b6mr2253554e87.18.1778499452463;
        Mon, 11 May 2026 04:37:32 -0700 (PDT)
Received: from C-PF5D4647.localdomain ([147.161.186.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a956b1cfsm2593967e87.73.2026.05.11.04.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 04:37:31 -0700 (PDT)
From: Jie Li <lj29312931@gmail.com>
X-Google-Original-From: Jie Li <jie.i.li@nokia.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jie Li <jie.i.li@nokia.com>
Subject: [PATCH v5 1/2] gpiolib: add gpiod_is_single_ended() helper
Date: Mon, 11 May 2026 13:37:25 +0200
Message-ID: <20260511113726.49041-2-jie.i.li@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511113726.49041-1-jie.i.li@nokia.com>
References: <CAMRc=MfMcEbQ3kkW3fMn-jzDoT2xdJWjp2xVBVsu7n683_5g9A@mail.gmail.com>
 <20260511113726.49041-1-jie.i.li@nokia.com>
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
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/gpio/gpiolib.c        | 22 ++++++++++++++++++++++
 include/linux/gpio/consumer.h |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1e6dce430dca..69743d6deeaf 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -491,6 +491,28 @@ int gpiod_get_direction(struct gpio_desc *desc)
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
+bool gpiod_is_single_ended(struct gpio_desc *desc)
+{
+	if (!desc)
+		return false;
+
+	if (test_bit(GPIOD_FLAG_OPEN_DRAIN, &desc->flags) ||
+		test_bit(GPIOD_FLAG_OPEN_SOURCE, &desc->flags))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(gpiod_is_single_ended);
+
 /*
  * Add a new chip to the global chips list, keeping the list of chips sorted
  * by range(means [base, base + ngpio - 1]) order.
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 3efb5cb1e1d1..8fb27f9aa67f 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -111,6 +111,7 @@ void devm_gpiod_unhinge(struct device *dev, struct gpio_desc *desc);
 void devm_gpiod_put_array(struct device *dev, struct gpio_descs *descs);
 
 int gpiod_get_direction(struct gpio_desc *desc);
+bool gpiod_is_single_ended(struct gpio_desc *desc);
 int gpiod_direction_input(struct gpio_desc *desc);
 int gpiod_direction_output(struct gpio_desc *desc, int value);
 int gpiod_direction_output_raw(struct gpio_desc *desc, int value);
@@ -337,6 +338,10 @@ static inline int gpiod_get_direction(const struct gpio_desc *desc)
 	WARN_ON(desc);
 	return -ENOSYS;
 }
+static inline bool gpiod_is_single_ended(struct gpio_desc *desc)
+{
+	return false;
+}
 static inline int gpiod_direction_input(struct gpio_desc *desc)
 {
 	/* GPIO can never have been requested */
-- 
2.43.0

