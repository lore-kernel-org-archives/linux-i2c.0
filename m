Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292B03939A2
	for <linux-i2c@vger.kernel.org>; Sat,  9 May 2026 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317946; cv=none; b=D3NwWxcXL8UYmAfeBHI8aLheJ8JVHhuJEDHxTjfN6x+jimHlK6CYNcsY1DTu9I9CX+118jX+2c5fNC5UIkWo9Q+js53XqxXN1bPGqXg11lEeUqLI1FQ5aB5GAY3NGApGQi086JWvNnFnCOJIto7zyKEM8Xmw3fArGdQHehlYiOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317946; c=relaxed/simple;
	bh=ULSxsA99WtOVeyQnnnWwi4Szn0714xC40QbXKSsl18o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbiPM2zUoru1lCyxhget6Chxf19EGTJdj0MDtWqP1fPj2olgj4OT8d2zGus4eacyJBJMFJEE/c8SUKsA+WrIwcx2zai2rziWfsX0CqoGX/xkwG3UdoUq7KoKlKhMi58pRiPDUZKMiZqF/ev8QU/E3dJJaH8uaBjwTCy+3H9lh3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPitiYVR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPitiYVR"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8f97c626aaso476223366b.2
        for <linux-i2c@vger.kernel.org>; Sat, 09 May 2026 02:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778317942; x=1778922742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pk/ryGv+w8weiU5QHQuVNcKF565C/DJ9GpiFb4c/EJM=;
        b=iPitiYVRebqxAaucnGOFAC/4+/M5h1gtxJo9Zx+fH0B2iq/v2+cLZfs1evCq1i8qS5
         yhn7JmpwZoWDPyAta8hueKBtiPDhq36zJrmPZEQ+cPtP5io6WcRZWGJWkubAGUZLK57a
         Nkn+CgGZQ1xakpHBWsSLCsqAkDOaklXKqbgyT+Mv6nVjWJKQRA45bxPifBGZA1y16u+6
         miCOEaAlUtDpF+K+uJ9+ruuMh7xXMe28Q/dK1iQi58vGE9aGZmoM6jeRL4N3O7dvIuj2
         4F/NypL3EQ36kIwR8I/30j98lqKUUxlkU+zvz8rLq8NUMDkM6aNc33M139eTR4ila214
         lq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778317942; x=1778922742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pk/ryGv+w8weiU5QHQuVNcKF565C/DJ9GpiFb4c/EJM=;
        b=jFvf9Mo8/WNmdIqkL5r0XB2M+6Oor9VpWSdcxwqgXlHNzQvfnpf4OEx167r5szI50A
         29uVmnpe60kTtrWVrcfVVLaClq1gYjekLbWXxnR/L7/aMKkUfNzxHgMqtVWeEnYQict/
         FKdMSH3gPecc/yfuC/YA0XUuiddViSw8GcrZYa6/pjJ3Nw6yX1sHHnKWRLgFDFA5/+9/
         l2DfeHLmK6KCR/FAmfyoYA7QgLYP23u/VXnGYHU2ybWPwnDNpsJVxNywIxaXYZmhv7KC
         k1tIfFNP4gQ2NLB9WL2bNgUg6mt9H18NVdOxa878JxRnE0++18SSEtr5adVdZq9mzAGp
         bNVQ==
X-Gm-Message-State: AOJu0YyRs7oS5IWsMgYL/DQgsBDPnclftpqyKKmEey+0flIQAEn2XjEb
	EkbHoadyHY1epLRvyN7SQQRnwHsG05pkG1/7VEnJIB5x1KK1t4nOGVBP
X-Gm-Gg: Acq92OErlbIK55Dq/Ey13k0Y3QXVn7qVVXPebJyY63QIRYLP+TlZitJhx1Uo+mKukv6
	uqgr3g8vaCX92NsgQwptIt4M8WkGDDwf44UpfjRK/TX7h31clkeyDB3+3uADpIysTlm3q4jZfjf
	p0WlC6/dOeMuTGdX6jdEWrYVcdJbnEWpX1NLydqOn2Zw3JapYGLyTm0b8KcjGM9Nma2pyvEWZfl
	slu6C6Y7fQQNh3Wt2iF2oRKCjDZBwGN5zt8AT/XKrjS5F1jckA+/G6NsGI2m0gqioI+1nRb2wcX
	26cSxNWgioU7w4od5Hyt0YDdzFKaW0q9JG7MJ6gMo+yhs377qNVTT8ezFnZrUCQxYXWlQ9jbPEq
	8/2G+2HpwqvvCHXtByGDgawrM0tXrCHADUTuUMFUh6nGi0rz0Iw120xjk5P+w0oUeN3NQmfmZeJ
	znRuTTGrq6d+LIah3vndH3P/PUF8Z0M4jRDquqMW/lToYjow==
X-Received: by 2002:a17:907:9346:b0:bc3:b598:7f47 with SMTP id a640c23a62f3a-bcaad226929mr377767166b.42.1778317942195;
        Sat, 09 May 2026 02:12:22 -0700 (PDT)
Received: from C-PF5D4647.localdomain ([147.161.248.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac3f66cadsm203819866b.42.2026.05.09.02.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:12:21 -0700 (PDT)
From: Jie Li <lj29312931@gmail.com>
X-Google-Original-From: Jie Li <jie.i.li@nokia.com>
To: wsa@kernel.org,
	linusw@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jie Li <jie.i.li@nokia.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 2/2] i2c: core: support recovery for single-ended GPIOs
Date: Sat,  9 May 2026 11:12:08 +0200
Message-ID: <20260509091208.18346-3-jie.i.li@nokia.com>
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

Currently, i2c_init_recovery() only assigns the set_sda/set_scl
hooks if gpiod_get_direction() returns GPIO_LINE_DIRECTION_OUT.

This logic fails on certain SoC controllers where open-drain lines
in a high-impedance state are physically reported as inputs. This
leads to a "deadlock" where the I2C core refuses to assign the
recovery hooks because it incorrectly assumes the pins are
input-only, even though they are fully capable of driving the bus
low for recovery.

Update the recovery initialization to use the new
gpiod_is_single_ended() helper. If a GPIO is configured as
open-drain or open-source in the firmware, it is safe to assume
it can be used for bus recovery, even if the current hardware
direction is reported as input.

Signed-off-by: Jie Li <jie.i.li@nokia.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9c46147e3506..a3c33e804d47 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -445,8 +445,8 @@ static int i2c_init_recovery(struct i2c_adapter *adap)
 		bri->set_scl = set_scl_gpio_value;
 		if (bri->sda_gpiod) {
 			bri->get_sda = get_sda_gpio_value;
-			/* FIXME: add proper flag instead of '0' once available */
-			if (gpiod_get_direction(bri->sda_gpiod) == 0)
+			if (gpiod_get_direction(bri->sda_gpiod) == GPIO_LINE_DIRECTION_OUT ||
+			    gpiod_is_single_ended(bri->sda_gpiod))
 				bri->set_sda = set_sda_gpio_value;
 		}
 	} else if (bri->recover_bus == i2c_generic_scl_recovery) {
-- 
2.43.0

