Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1233D6ED
	for <linux-i2c@vger.kernel.org>; Sat,  9 May 2026 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317941; cv=none; b=AUqJS80G+a5PRNgAELbHUL7Iy4md0MIHCRFru6sKI50eQXd9/d+KXHosBNKSYeOLwjuTSNNDcjzVOmR8GYsfsMvt5RRZCQ1k6Ue2a0qZWFHiKW8vpW65YS8yzYzVVfMEJI+VVZ0WG5uWimGbQLbtvdRLZ4idZKBKcFaoPgD3RYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317941; c=relaxed/simple;
	bh=kT9wOZIR2Wfh0ZigYUA9rtm7wCF4sP8fJbMh8roHmiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8bMuJgjYfULrrdBxZhl+gPO5qTcB8iazZoGHPMb/roXZTjg5VGd+MXXtJBUB9aLBIRwLlESSQuxWBoqaWBzH1ehG4CjxWvDoACBt9Yudepeky1P9/RukGFNePWUmLS1JVExaBg7GvUM9DnvVrJbx+ILpx9UtjIGJsjaTSuxgXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOFZrX51; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOFZrX51"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bc66ad3742fso472363666b.1
        for <linux-i2c@vger.kernel.org>; Sat, 09 May 2026 02:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778317938; x=1778922738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4imfVsi2VomO9FzKGpPU5riMSUcvWN6BNCMHeP3TKZM=;
        b=XOFZrX51tARqx+WMuQE+aP+J9SRmLZoSnkM+ra9RUPA8JJBDhw9zHobJBaGSPaXbdU
         0zb4UMYDmxdsvV06uFigXEuYTG/uJClDhtWIQeHQUo25z/2HCb3kW2eGdOVOP9WsRilE
         kIuuz+bxHOii6/H02br6k3MERjB72jP8xbQ3d8VlFLBdA8LTs2tgDheekEU/r4KJPAOf
         S8t82uTq0/KC2JCPOZWFaIs/JRPq4lYNU7+q/QLYA0Iau7Ah7jGwIIk3EH1cNumTLUlK
         wpZiAMocKgMOXyHZcfbYFRmDGVtcylEQ/K7Id9GmeO3Dmc0Q6pjmswQmROw2l+rsNJ5F
         Gx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778317938; x=1778922738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4imfVsi2VomO9FzKGpPU5riMSUcvWN6BNCMHeP3TKZM=;
        b=Exg+7FmoQom/oYwopkrsvOJxvZ1OyIxlAmvalunOw/havDJVxgJ6HZ0PhBldaazf9L
         Drp6bGqjMKzEhduNEqZCij2AtDUCy5ncYzvgALOLv3jrOE4Z9yeAp2TeqjBU5pUFillq
         Uw6HdGogmeXgQiP6PinNzh3fBmO3MJGqJPOkRuDgtURhgZ2+tQ1mj5mPvsob7rL/I3ZB
         ++8l21tU+bbwJzp4RVF342PPO5zLrH7jy0nDt1V0/w/5doHDoMtsHA+sJ6k8ETiEXEyV
         eZvXvRIhzp2hzPOTIW9oqk4bv3jZHJNAn7bBmqToQGEtwuMeN2Hj6uPFhLXJ4Pbwy0ho
         X/Vg==
X-Gm-Message-State: AOJu0YyH1WNns9tMjiClXuA8qth+1zbDcgjSpYpkXbE4bd+JKdATSsSQ
	Xb/Zh8dECSYfgmQsQX2bF8BR0Z+YCyIiwlHpblqTcjQnPLTjplN78yve
X-Gm-Gg: Acq92OEPYeVHaumDERIbkwENcHIc+jZ4phevR7LyDTqL0uyPlproP+WqpDWgK/AFe06
	Dnkx6nqTt5+Ng3l8LCqNOmPPjsKHs4NeLkSzdJRdhLxuVn8qWSA9IMZqqrRwC1m3lNa55KOe7xL
	VN32m0lt37dNbQtTLFxRXUV3QWpX0QFeRty4zXTjTT8hIiUelZnZDd+pThJhsFy28sCjb6b6GQL
	/b5+tZs6nScSgtcTtFVBvd8RzHOuqSRoyuzVwNv2kpzGidqVC91feTGo5abfBKIYPLCqTfQ9pb7
	nlR2ZEWYyirkuVBFiHQuQdGpk/K3+5rxDQqOFq9kNQYFaW7PnYOjIxDp+IGyD6zzE2OioiOg29/
	zvAyOjVtLLBpmbfa8GoxrQIbTxP5xRS0SWTjonnDqpvcAB8Z7QtsrVt8Alivc/uoM/Gt+2L5vxa
	EDw9mOmK94gdT07djdx9+udwdkTBT07ycibpU=
X-Received: by 2002:a17:907:988:b0:bbe:37ee:8a2b with SMTP id a640c23a62f3a-bcaac454c4dmr348565366b.33.1778317938239;
        Sat, 09 May 2026 02:12:18 -0700 (PDT)
Received: from C-PF5D4647.localdomain ([147.161.248.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac3f66cadsm203819866b.42.2026.05.09.02.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:12:17 -0700 (PDT)
From: Jie Li <lj29312931@gmail.com>
X-Google-Original-From: Jie Li <jie.i.li@nokia.com>
To: wsa@kernel.org,
	linusw@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jie Li <jie.i.li@nokia.com>
Subject: [PATCH v4 1/2] gpiolib: add gpiod_is_single_ended() helper
Date: Sat,  9 May 2026 11:12:07 +0200
Message-ID: <20260509091208.18346-2-jie.i.li@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509091208.18346-1-jie.i.li@nokia.com>
References: <afiNrr4Llm0LWw-5@ninjato>
 <20260509091208.18346-1-jie.i.li@nokia.com>
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

