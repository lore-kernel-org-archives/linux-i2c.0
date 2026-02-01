Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2142F2905
	for <linux-i2c@vger.kernel.org>; Sun,  1 Feb 2026 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769944701; cv=none; b=FzqSNW0BUizcPawPTKOzsggz0GGLs8hG9oZdpnOX6y28FUCPx+SyoygsNpzrm0pCIZX0/HLK5RqWumqR+vJz1OKOrtkP8I3XuAwWpIE62Tg6HAQvRixTrmTImUYlak2s+SsokVwfQHCRfMkV7d3L5DeYYgrzafbk34jS5+575Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769944701; c=relaxed/simple;
	bh=nRpH/iLtlWIM8KUrHyohq2XqCM2gV6aIOs+uJYs9+8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2JF/1HcAioJSAKa78xMjvV0cP5IHFXlPCKGqzqXXosJwjPAzLwxxQvf3eXDZ/cbzJougL+4Zx5bcKi2zjS86lpI96PM8QrOKQdAfXxxMrw9dmVn6MeanYoqDy6LRRHyh6EIjqm4QafeHNlCJORxE9oQqcBAqnYTipvRuXXSBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0Uz3/IY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0Uz3/IY"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8842e5a2a1so498815066b.2
        for <linux-i2c@vger.kernel.org>; Sun, 01 Feb 2026 03:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769944698; x=1770549498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RzDUpXasUz2gSgQY0FnUVtM7tN13xUWfydJ/oE+LZw=;
        b=A0Uz3/IY2Nux+nmg/MuAPWM20U1jhVlUS3GUTiQIUdikLB7L3UmkE8Bfd0smX5x/Ky
         2wOCm7YZkjBhC/7N1vWOjG/aelNNfILoji9wKFr1kMalQvvmIKF+zHpLW2NSgJJD2Ulq
         AF1GKLWx8+IHcMNJ9jlih8IWwWzapcYBypIkspkmh0HpLcdfNSMv0XRlm6PrV7LLD06p
         Db00iVOTpzJI0dPM0b4SxGPGJpIlsG9PQ5GLpjeFWag4L/QEIpI6C1yljgRUoNKjW4ZU
         HHdAyX4I1cruEDuGMiemQfsWxrQf0267Yro0eaL4Jrn2mlegKISvlGrkQk0AWDyXbjH/
         cinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769944698; x=1770549498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/RzDUpXasUz2gSgQY0FnUVtM7tN13xUWfydJ/oE+LZw=;
        b=bVF0/fR/hR99GljOYA7wuLjkubn6cmJ2c3DvqbAXhptQFbU6pKcVd03oWjKEpV/9gT
         +WotIX6RrFIT/h4/FgjErJy4BWshw7cQXMp1sZkUQie8tmE3ESfqXPYHcpL4R9YMIcAe
         /DlHBAM83blM30onUmZT4mREik3C67BSWWCQvc8ChNx8fd0VOryTzq/KHnQ0yLiya1s5
         Kp28L3nGUwj1g+TZatNwCxtleo0lUZThXlhGmSQ8PuEKaK/gy4BfJmwMT87Es9twmvwt
         dUImmQ5YfFLMZk8JgN+Ux+l2bD/rPJjiHwLhmlYG8eRzuNdvaqyI5AqPPch9V006HDlF
         +6iw==
X-Gm-Message-State: AOJu0Yzry9X7dl7SKMFOf20ZWKtw9z4qb1ZYQyZHh4DQnvwSEiiHpd5Z
	xRPnBvqWiohUDLJ88IcUCe9hdhNjQMSkWVQQFuU1tFk4UnLO3p2VtfXP
X-Gm-Gg: AZuq6aI3yQ3z277HYZloZ9z1vlALzHhR8aCMa1iXL6Zf6uozUAuxKfmF3RfF3ei8nd3
	+M1iJ6xIukl7lx/S4wLzfzA0J5jF9YuNPQBptmI57NP12TMvqCJ4c5QuT7p/p2qeXt2KyhxBC1T
	0dNLIzvzwGh89R30u2pZ5kinX8ydbD6JWHLwi2/6R9vacnwojmFbxFWWGbSWK36oh77Nq40/g6U
	SPHWOHhyyghmuVqeX3cWxYP5k66BmUCAEiAC0r64nDPLJvBA/mUqwfCL3AqivydKQMaaTxu30/s
	LNoMVxLbSCkzBxnXIWCFmerwFy09dAin32WYSGVaROPfnroagfELKX/WLfhOcuR7Z8f4P4x+9al
	4Kia3wMHTlPYb8AWq172c7xiCIToQG4QJqRQIL0mgBGSRIXSCrdNkMuRelwXfmaqp9c/pY0BCK4
	swKONt4o7+Fq2oJKkJ9E4Xs9s=
X-Received: by 2002:a17:906:c155:b0:b84:40d3:43e7 with SMTP id a640c23a62f3a-b8dff514fd6mr457167866b.6.1769944698320;
        Sun, 01 Feb 2026 03:18:18 -0800 (PST)
Received: from C-PF5D4647.localdomain ([147.161.249.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2ed6besm714713066b.60.2026.02.01.03.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 03:18:17 -0800 (PST)
From: Jie Li <lj29312931@gmail.com>
X-Google-Original-From: Jie Li <jie.i.li@nokia.com>
To: wsa@kernel.org,
	linusw@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jie Li <jie.i.li@nokia.com>
Subject: [PATCH v3 1/2] gpiolib: add gpiod_is_single_ended() helper
Date: Sun,  1 Feb 2026 12:18:11 +0100
Message-ID: <20260201111812.18945-2-jie.i.li@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260201111812.18945-1-jie.i.li@nokia.com>
References: <CAD++jLnk_5KG_q1aCtpOrTCbhtK-FxXH6BhPFSwukyt2F4uxmQ@mail.gmail.com>
 <20260201111812.18945-1-jie.i.li@nokia.com>
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
index 1578cf3a8c74..08e6960053f8 100644
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
index cafeb7a40ad1..12ef6e07ee1a 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -109,6 +109,7 @@ void devm_gpiod_unhinge(struct device *dev, struct gpio_desc *desc);
 void devm_gpiod_put_array(struct device *dev, struct gpio_descs *descs);
 
 int gpiod_get_direction(struct gpio_desc *desc);
+bool gpiod_is_single_ended(struct gpio_desc *desc);
 int gpiod_direction_input(struct gpio_desc *desc);
 int gpiod_direction_output(struct gpio_desc *desc, int value);
 int gpiod_direction_output_raw(struct gpio_desc *desc, int value);
@@ -335,6 +336,10 @@ static inline int gpiod_get_direction(const struct gpio_desc *desc)
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

