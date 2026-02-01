Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898B324B24
	for <linux-i2c@vger.kernel.org>; Sun,  1 Feb 2026 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769944703; cv=none; b=IN2TL6w1F3t7yoR9hI5QEUXKVUUFc3VKUc4usxO8gx0OzV6CWniczBanu58WT/M4Fsb1F+1hvknG9hDK1TxEPBMjBjKur4IAqvfvtWUL5vyTEEhH6uYL3KKUL4HancifMIO0/QqWe3Y8J5Cd9FI0iXqoy1dUuzOKqjfiD706bxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769944703; c=relaxed/simple;
	bh=DT/AC0f3v8zTwDpTqWISUM92EMD8mREJDDZ5pNdtZYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Il3H3b3ic2BWksca2zhj08szFByKqCPkCq9Ii8U0yh8OtUVkoQggZwWlZLAmsqAd8VfQ/Dqw0hVog7oTRVBP9W/Gz3KgBkWqSTBin3uA4LY60ZinIoEkOqHgwB6dRXf3E34mEk7XMdNw7C4mCVyjrUMjhFIdlIKmvB+RrDff2Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNZPwrFf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNZPwrFf"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-658f1fde4bfso1888065a12.1
        for <linux-i2c@vger.kernel.org>; Sun, 01 Feb 2026 03:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769944700; x=1770549500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGn3i/O/y+GdrcNDRMS16OuGNGT+puPLYW3aCy6Bi54=;
        b=lNZPwrFfUVHJobP8737sLm3ff2MZU/dhdCu+vC14sb67nOdJXNh1rmUzZL4otHpH44
         DsT+CKHkQD6hRD6bODQuD2QQ+TXy15OhuTO/EF7pzwHXLjSVTr5Mpa4yDgPf4CHFEVev
         fMIvu394le0JZPH/9UgCjPDOQF/L69B55aFVyW8IyFiJPMllVgkt313tGlq6vBhm6lUy
         Pa66ggn2e8ZIQCGNnjiVX9V0Hn23aAlq3t9wTTHvoH0ekLxCtVU7cgC6Uc83b5thu7OX
         851g2upf33kOCRRf/xSpOe/Y5VdToKdkp/9s2+GRD3ihjXTLu4Dd+6i6DUCpERo5lzOu
         yFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769944700; x=1770549500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lGn3i/O/y+GdrcNDRMS16OuGNGT+puPLYW3aCy6Bi54=;
        b=Fmg7aXuNpOhLMqFJbQ+ECcBbp6uaj1ke8KbjCV6a/vSqXTZUYzQ18dvbhlwat1ryxN
         Uq6mjM6LjBqxiBK5RHF73VVddK8EZ0BtQi8YIjyYMbAehy4OlAYabLgEJulJl67S+6VW
         cERukn6QOdcCc1LQ1ehJzDm6gtF7/1MOK+aCLAnM7KYzgJvb4ccJD656CLQnQQiV6fkC
         e0ioRn5TkwbSpDcLwDrs98Tuc83T3zju82TkXhtqD2U3ArwiDLrQ4iAmxsugFQxA1yTv
         rafHyy3eNxgGD/Nzuks5vWXzRC7DiQLf2gEaYYlxWjDpu/WAM1jgT02aJAjYHT2IVRus
         rlOw==
X-Gm-Message-State: AOJu0YxclFW7qej7Iysc7Efsd48RVq2oov9fmuNVl/xLFj6m3C+61HOt
	8/thDAFlnAZcu4kw2/rQEGrvfLxWQ7ZRkAFoSyzIXbKuvEjWhn3wXo4w
X-Gm-Gg: AZuq6aJZeJrGLZWsf1/KM2FA1M2sTR94V2xyqzNZ9q75NXz0IWs4rwOgwlAta1Wn18o
	et8rY3IfsbMgHRIBtrhmypoe3LekKkiZRqCvVWXe4d27blxPR3AYuOesRkZFUFcou0tTKplG/Mp
	03v1OyyH9eIoJHQkP7EAub4jFsW2zMtiBuD8U9yIpYq0cOR9JEd3+0HHeWE43uFc3CkVsgfgfIk
	eu0VOJP2IlaFhZ4UDaD21z3RSPZCcM5aHOCLg/7gf7H1AllhJrkG/LIGupjia5/wsiTqGk0TOue
	YOCKUuPxp/MOMdxGjD7KbEoJXhxkk70oFxIChVvarKZjHA4PppZAtSKBIYtXsYDBNGf6ODE+yyr
	luJwGa+XBzLqq8CfD552Cpwlp3ACYYeX3kVRSeByFfKbB1x4PMchf7RvWhigN9en5ZauZwsYDzf
	piy8IbOHWeq5BNWOvokeQNnCE=
X-Received: by 2002:a17:907:3f08:b0:b8a:e013:9c5b with SMTP id a640c23a62f3a-b8dff1f35d0mr611231766b.4.1769944699726;
        Sun, 01 Feb 2026 03:18:19 -0800 (PST)
Received: from C-PF5D4647.localdomain ([147.161.249.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2ed6besm714713066b.60.2026.02.01.03.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 03:18:19 -0800 (PST)
From: Jie Li <lj29312931@gmail.com>
X-Google-Original-From: Jie Li <jie.i.li@nokia.com>
To: wsa@kernel.org,
	linusw@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jie Li <jie.i.li@nokia.com>
Subject: [PATCH v3 2/2] i2c: core: support recovery for single-ended GPIOs
Date: Sun,  1 Feb 2026 12:18:12 +0100
Message-ID: <20260201111812.18945-3-jie.i.li@nokia.com>
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

Currently, i2c_init_recovery() only assigns the set_sda/set_scl
hooks if gpiod_get_direction() returns 0 (output).

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
---
 drivers/i2c/i2c-core-base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index ae7e9c8b65a6..11bd801418e8 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -446,7 +446,8 @@ static int i2c_init_recovery(struct i2c_adapter *adap)
 		if (bri->sda_gpiod) {
 			bri->get_sda = get_sda_gpio_value;
 			/* FIXME: add proper flag instead of '0' once available */
-			if (gpiod_get_direction(bri->sda_gpiod) == 0)
+			if (gpiod_get_direction(bri->sda_gpiod) == 0 ||
+				gpiod_is_single_ended(bri->sda_gpiod))
 				bri->set_sda = set_sda_gpio_value;
 		}
 	} else if (bri->recover_bus == i2c_generic_scl_recovery) {
-- 
2.43.0

