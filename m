Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E7C392814
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434858; cv=none; b=FdO8L40JgVE8SjRX/Rv+c82F25uIC3cCze3dZ2g7wpgflun5Y9D2+pUdaBgtqZM7pW6CYu+gbbeGJTdQme79CdGStkb/vC9/u8oX+SDy3bvFQEJ9HEYHlHSzFigZWDeMafaskFAksymyQpa0Cgw+9xr68kNpwArh3sMCAqSW1Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434858; c=relaxed/simple;
	bh=nUNbmShuRQtFklLJUC7OALhPN/3USFry3dwtYtcWKow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxuSMFA/UTwBNEoY79z6kjfo7SxejjyZicXpjl+d640TRC/24OlIMgV62Yt9+QRn8sa1bj9yYTJ8IM8YUpp7VnIAP5NBkSYLy1fKcUEbLRe1JlhDL0aagGA3yO4y6uh58EQYXAlsktLuO40lEFC7HyCcKAk0b/XjELNsgehlz8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBWjGRVQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBWjGRVQ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15e592da74so312709066b.1
        for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434846; x=1788039646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JMqBfKwQvAfQXaOYyEjha8jlIKlrCWyN6q7aDWdtxQg=;
        b=kBWjGRVQ5Tsqfej/Q/PXV0Qkvw43nVbNz2LERrDYIddPeRUnUwsv04llgVcbZWUqwP
         pjmMz2vR160XZ+WiWza1RyxZ4znOblNF6KZw0sPU3zoog8Tx3iJkw9x/GAdp0bFDSsKH
         pSaRx9jjghROZ5YguUPn4hfrj8aymIOYGTqyHz9kYyrVomSrHPJIEmmbN3yYhYCHNIxp
         IUEnSbQOuJF4+IK6DO+BwFP8MaI8IEYYri+GxJfwMfIDqw7cb1nZmmz9ehXnnIzwLDXn
         aZ+J1+70mXCfzIG4u9eRfxyY3eXJAr9s/nvgbhcEG/AwHaCXNsf6elrcDhG0RN669zH4
         +Byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434846; x=1788039646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JMqBfKwQvAfQXaOYyEjha8jlIKlrCWyN6q7aDWdtxQg=;
        b=N6Wirf/zyInuOuOGQalCRu4Ep45MiARO13V02jwU+pKQBY9Pb6PFdvIuC1RP5BJSsV
         ZeWRX6uai2JgWnxC0KKfLvaxGmKsLKZZdsBmq4U/9qzl/KwxLtjIz7Y0CDfh2rtaUual
         UHpxHOOY8MioCZ+gD4zQFX0OXVOdnMSsUNCGGwTvNun35S1Ls3mUnYRZ7rPsQgiLbxwI
         bZ1TlA3JfGiNsYvzZfaqLcQvvA5f0Hro1fAJDWp2QSOYCKfmIbOGA2ypOCqoijwc0N9A
         3XXRtC39IqzUPfhD6XIYp3Oh3NJyWAQNWGHDBlwMZ1KXvud+Ugk1KYIPUN4lV4sl3ZyB
         ltbg==
X-Forwarded-Encrypted: i=1; AHgh+RpK0RRIESXCWIpEVsgN/wuaaqdWIcOa0ERyLv4vJnB08jEStIVjwrfAMIwKQqXE7nLl2tzUmwH1NFs=@vger.kernel.org
X-Gm-Message-State: AFuF++nugHTAw4GJ9D+wlRZDb1oVkMWhEiWhvIeeLUOzdzh6GdGul9tC
	sjL+frVCfpu0KY4TxKAUlL+jDGYT8eQJ0UoOs10aDa4MiazyxMlYg5LR
X-Gm-Gg: AR+sD11ZqLUdvMAhmWzEbmPqCEVezMalBy/SdCVfmyw8PZqhyXKJmCchOgTDpAo2QyR
	phFwFffYlFB5lDAyyrtGkJDYFL0hN6vd3Y1AktIARSmxkXXWPyBN6LQHMMVxjxZj9wk5BVs4D/G
	X8pJp5uPdNBF565c+qEpDG7U1VCtVR1nMLxl3kXppZERLag7AmYpQwNf/noL3cvPSeSa62x9uN4
	Dcc1Rje3PZ2LQPR+V0AinY9WTzX80Fp4il5oTi/dxivoWppYRVeN/eAeTFNqjvUNvX4korMKKGR
	lGo1o8UZTxXJo7iJJCndkw+702/hlqMXj3NMP+QzgaGFD/jz/JUKpJLk4SBTC3Ahlco5U7nx8+5
	rhC12pIAJUsNmQJDuRfeKfBUl0S5TFNjrfa4O0PUF2MZh6pcwucBXljRTCPvKHKHPd0LWf7n1zR
	b+GmwAecpJKlOZwnN36Z+kT4hipPoLxwkIn9YnoFFAkPmtm8QPicx3ZXMCXJU=
X-Received: by 2002:a17:906:9c93:b0:c24:6687:bf6a with SMTP id a640c23a62f3a-c2492663ee3mr836396066b.21.1787434845967;
        Sat, 22 Aug 2026 14:40:45 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:45 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	Christina Quast <contact@christina-quast.de>,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH 10/13] HID: ft260: uart: fix active-low RTS/CTS/DTR/DSR polarity
Date: Sun, 23 Aug 2026 00:39:38 +0300
Message-ID: <20260822213941.98882-11-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260822213941.98882-1-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rio Liu <rio@r26.me>

The FT260 modem control GPIOs for RTS, CTS, DTR, and DSR are active-low.
Invert the TIOCMGET sense and the TIOCMSET drive levels for those pins
so userspace ioctl state matches the electrical lines. Leave DCD and RI
unchanged.

Signed-off-by: Rio Liu <rio@r26.me>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 0a1875a1a7ec..a2f4b6e5a16b 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1985,10 +1985,10 @@ static int ft260_uart_tiocmget(struct tty_struct *tty)
 
 	gpios = ft260_gpio_get_all(port->gc, FT260_GPIO_VALUE);
 
-	return (((gpios & FT260_GPIO_B) ? TIOCM_RTS : 0) |
-		((gpios & FT260_GPIO_E) ? TIOCM_CTS : 0) |
-		((gpios & FT260_GPIO_F) ? TIOCM_DTR : 0) |
-		((gpios & FT260_GPIO_H) ? TIOCM_DSR : 0) |
+	return ((!(gpios & FT260_GPIO_B) ? TIOCM_RTS : 0) |
+		(!(gpios & FT260_GPIO_E) ? TIOCM_CTS : 0) |
+		(!(gpios & FT260_GPIO_F) ? TIOCM_DTR : 0) |
+		(!(gpios & FT260_GPIO_H) ? TIOCM_DSR : 0) |
 		((gpios & FT260_GPIO_4) ? TIOCM_CAR : 0) |
 		((gpios & FT260_GPIO_5) ? TIOCM_RNG : 0));
 }
@@ -2013,13 +2013,13 @@ static int ft260_uart_tiocmset(struct tty_struct *tty,
 	mutex_lock(&port->lock);
 
 	if (set & TIOCM_RTS)
-		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 1);
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 0);
 	if (set & TIOCM_DTR)
-		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 1);
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 0);
 	if (clear & TIOCM_RTS)
-		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 0);
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 1);
 	if (clear & TIOCM_DTR)
-		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 0);
+		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 1);
 
 	ft260_dbg("dirs %#02x vals %#02x ex_dirs %#02x ex_vals %#02x\n",
 		  rep.gpio.dirs, rep.gpio.vals,
-- 
2.43.0

