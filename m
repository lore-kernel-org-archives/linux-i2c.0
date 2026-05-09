Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5FD3845B7
	for <linux-i2c@vger.kernel.org>; Sat,  9 May 2026 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317937; cv=none; b=lpQfENDkABeigkR8sfomHany/o76ZeDm/lPvOZvn9UGcr0wA+NH2Oer3/lFmih0fnqKUxZBhMkpMXYgl57t21LNzC4Q2YVV7QlMk2BN3f2oi8KP8axiNCx6Y/rVNzj2nzUFqt/RbHJOijs69X5VusfumU5WndxHicNojeV1XmRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317937; c=relaxed/simple;
	bh=24vHZ9abbKLv13pJboCYGh3ku98gbiKKOpblTf0HDEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQ3ZPaLyMoTQ63wK8MuMsYvbo/uPPHxPzJ5ztjmSHMlSEehmEJRuKpjJd0LeC7zmpkA4gbB3bTGDI+5qyVjOMBsXCb9mPTe6AAf6l00zjoa75TrW3ZbKCgHG4LfQypgZilsKj1mkFIpX69/HuuzEDklLWZwWKkX6kxUjtiyFQtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYnI8Mrz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYnI8Mrz"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bc2a455fd55so391865266b.2
        for <linux-i2c@vger.kernel.org>; Sat, 09 May 2026 02:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778317934; x=1778922734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XmSmHeKOJyWydkEazgErxJ2iT0ojoaDUHk1IjIBCo8=;
        b=SYnI8MrzSwk2K85yvqkC4mKCx1ld5K4edWgRsDSeUHxvPqpAuzoulpYb+HfqYdMmD+
         8f3gNOYiWLP3DkmDvQf1ZuNa70qtPVxZApFPp10I8YcAOohRkKoCI4KIoHNgdI+dn715
         w2Ea6x5yEEzRam+NKGZbsXBsuU0F39E8gStEywpmi5HYiOYObl4DM3ukWQJsYtmZFjzL
         UNqAWnOpmgy8sHNLO6dILgVIbZpXj2flLWcIGsfb+WdQi4iz3E6bBZZwLPa84YNT437G
         lQw0OQ33IwjafzOopKPjcvOPZ3EOre2I8vhWkrsUvUWbtvPMKG7Z2J10XoJLS/6Z4V/L
         cf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778317934; x=1778922734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4XmSmHeKOJyWydkEazgErxJ2iT0ojoaDUHk1IjIBCo8=;
        b=DYMOZYaWUNFlHVmthAOeiFh0LAklN1uj7CZt44SGAgELN5j+TSAfwq3qBQI27pxIfD
         u2FWbatlUWDR7DGETgCZSCeeUNGFdI0Ph7VZqhkePI6c+9sw62rplto6PSOotql7irzT
         jmI3Qln2Cmg09n10LjLWcPd2SFT7b1gkJMJUB0a0ljZhGBjqm93oI840/mSaSuTKM3AT
         kbPWOZYw49jxKIcMHnGNym7WD4DsY0A5/s2UnwWLVowxnJfUr/3Rqp2894WxUfIl4uXC
         0e+Mzl/GPJtIYocxazvvkXKL07+8mM+2rL52xrFxxoOiw9n5HNz1M8sV6vVG8cX7YG2p
         2S5Q==
X-Gm-Message-State: AOJu0YwdqErQg/VrpxnX3Agm9ai09NYNxfs1uAcgPaiIBicujyi+0PJL
	Km7XnB0R/rVKzMvoWS+/nKIwlZPLG2K1RGl/lENEP5jDOWIg/x+ttpmy
X-Gm-Gg: AeBDieu8XQcOsxkHv1NlGboq0i0zt3fdDnKudv93CuNozSqIZrTBL57AtPWDJiRUWgB
	HFGf1w0JMHa2UGoel0jbYprb8vuOBXw8vW4EngZlDdYTGMFgKzBWgwdBEK6jFRgnRzeb6OjJiSU
	r7lpWk4mwydezMuhwfZlOENbibfMTKtEwC6fRhJIZegYG7aQJ3R6V13eqnhE3gt2m+TnMfTc+YE
	2v4iGOPERPqqcPu8ZxIRXpSUrJ4O5gmxr9wIIoegAXMqBec14KKP77MAinaMpxWUUp41cYIDS9t
	irCAUBdKbpaU3331nn8XlNR9x4Z4Uk27obQqGmlEDyx4gMVXYLggQ2WHCNEwmBiW//LweLflSYq
	c4v0g04k7xIgV7ckMAfwywcY6xDJPCRGn6nADvV+c+a5Cv67LwJPVliEVn6FjCuCKiIJLg3DODd
	YveGpCCjP9/fehacdFEKmO935mSzet+peGu3e1acBntK38Dg==
X-Received: by 2002:a17:906:6a1e:b0:ba6:5855:1cc0 with SMTP id a640c23a62f3a-bcc1205a634mr81118366b.2.1778317933737;
        Sat, 09 May 2026 02:12:13 -0700 (PDT)
Received: from C-PF5D4647.localdomain ([147.161.248.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac3f66cadsm203819866b.42.2026.05.09.02.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:12:13 -0700 (PDT)
From: Jie Li <lj29312931@gmail.com>
X-Google-Original-From: Jie Li <jie.i.li@nokia.com>
To: wsa@kernel.org,
	linusw@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jie Li <jie.i.li@nokia.com>
Subject: [PATCH v4 0/2] i2c: improve bus recovery for single-ended GPIOs
Date: Sat,  9 May 2026 11:12:06 +0200
Message-ID: <20260509091208.18346-1-jie.i.li@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <afiNrr4Llm0LWw-5@ninjato>
References: <afiNrr4Llm0LWw-5@ninjato>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This series addresses a limitation in the I2C bus recovery mechanism
where certain open-drain GPIOs are incorrectly identified as
input-only, preventing the recovery logic from functioning.

Following the suggestion from Linus Walleij, this version drops the
previously proposed "force-set-sda" DT property. Instead, it
introduces a generic helper in the GPIO subsystem to identify
single-ended configurations. This allows the I2C core to reliably
enable recovery for open-drain lines regardless of the
instantaneous hardware direction reporting.

As suggested by Wolfram, this series should go via the GPIO tree,
since patch 2/2 depends on the new gpiolib helper introduced in
patch 1/2.

Changes in v4:
- Patch 2:
  - Use GPIO_LINE_DIRECTION_OUT instead of the literal '0' when
    checking the return value of gpiod_get_direction(), and drop
    the now-obsolete FIXME comment (suggested by Wolfram Sang).
  - Added Acked-by: Wolfram Sang.

Changes in v3:
- Patch 1:
  - Changed return type of gpiod_is_single_ended() from int to bool.
  - Updated return values from 0/1 to false/true.
  - Added Reviewed-by: Linus Walleij.
- Patch 2:
  - Added Reviewed-by: Linus Walleij.

Changes in v2:
- Replaced DT-based "force-set-sda" with a gpiolib helper.
- Added gpiod_is_single_ended() to drivers/gpio/gpiolib.c.
- Updated i2c-core-base.c to use the new helper.

Jie Li (2):
  gpiolib: add gpiod_is_single_ended() helper
  i2c: core: support recovery for single-ended GPIOs

 drivers/gpio/gpiolib.c        | 22 ++++++++++++++++++++++
 drivers/i2c/i2c-core-base.c   |  4 ++--
 include/linux/gpio/consumer.h |  5 +++++
 3 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.43.0

