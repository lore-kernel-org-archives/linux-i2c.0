Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B6B2FE59B
	for <linux-i2c@vger.kernel.org>; Sun, 25 Jan 2026 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769370690; cv=none; b=IMa2PCkbZaK5uqlToAOTDL6u0I893pyXd1VBzsh8cwDi26mAVh/ESLCmGrTTNekGVTJf2IgWbe1RERc7WlIwjl7qNkKrtYusbEq1t+LApfgRroOKDMR5Q6c2owjqusM/TcijnyfwUwHWCyen9LgitsU3co/zk8Ioz4t5mhnbP44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769370690; c=relaxed/simple;
	bh=8w5lKmFR001loRTJivMKIdgWcBfSThm7VC0mocH3zFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kx4yUf23zpW0+p2EGNmz9c28dZik2aKmtrUjh3GEAXPyEy64hyiRo6fClx2UhigCj0SdS6wYoQ7A1lk6ZP4aHukdQaiiYWLe6oj/iWFd/eEVhzQGo5icY5PJ5Lk0ukOVBj7MMYZwVEOlAxN7EBUB7Ln6StPMq7ePgwjbdwkfytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fB8h54Um; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB8h54Um"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65813e3e215so7215329a12.0
        for <linux-i2c@vger.kernel.org>; Sun, 25 Jan 2026 11:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769370688; x=1769975488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erE+uO6wlOkAnc1WeWGgsNOsOXXg2ec8Vg4q0viMQEU=;
        b=fB8h54UmaChrSybNinw0MbVmo7u+0g2mHSmKkaDGxcxB+zclhzxDFiYWjcf/j8GmWg
         8uVNCx51RZVSH1+pZqYwkzei16+LYgC2h643PSP6ZuQroFIJ9PFjAXK4lp1CphgNZVb/
         uP7LMlX/h2BZVupUJO7ov5mzYGHP7JcZ9CLJ3pp7vZ/gtIKFPWsb5t4wf/A46OZbh4IT
         PmjB3yNM34uVwDv/ZPvGLsyypqNeTHcEaizHQ1m+4DwEX3VAQ5t9DyylI85Aqorjrsv5
         MzSW5oSlHWVHFudM//5Co2O95QtbSCgF1ZtMQuBGSoOrviUzyF7TxRTWrc4Ru5WvF7QP
         azog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769370688; x=1769975488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=erE+uO6wlOkAnc1WeWGgsNOsOXXg2ec8Vg4q0viMQEU=;
        b=D1ygnpqu/3axgz31u61CO8vMx3vqWiWZb8pLjlwXsqvzAiEbHvW/YPvLzEbyEOPPQh
         VsMwcRvUJwlBetG0eE6Nab1FnBgY7hQ3zBQyHXUTUTD+A72PZw5Eo/ysnfy81fbES1Nl
         VHvQB1Zqo4mx/iJwpancVuVN1JZ8pJeaxaHvE9NzxrUyTVZXQyu6vKIEBNqryU1p3ZZZ
         ZEvEOJaqhT4jTzSn1CNe4UI0fgo9Yj2ixEc4/OIaNTQC7g3kXm7/xG7fktW6jBiN8dZv
         JjuGYnEs0rCHsxcImY2zRs4VAXla8fZsIOylyHrtRfGTsad+osCgpdcqj9SXdwGcIERM
         uUTA==
X-Gm-Message-State: AOJu0YxlFb0rYCfqg/qwi+Qv9TQFWDhqDNvwwfypPaJpMnoUM0t0y8Fv
	IU/VVu3opnWANq88PrMo2h04q8/fbBLNaQn+xAUUxFd0s9WhGckqmXbx
X-Gm-Gg: AZuq6aKrz0WY2eegF0MLjk64u+6ly4ko3kldPYp7D13jkSh/Sa7ZfCWFGwn/RWNExNU
	vfBeVny48dIeS075xbeGP1UyKW7KRgYJWDS08e84ecECmVRn7Z2W79dc8mMvtqFqTqfd5ptxJBi
	4zogH8YFBsFW4u41MQshOiGjWA6bkEBaenApawKSHdgO8hrVlHXlCqvWtToIR/4DP8JSiUcxjc3
	nWVokqg+ujLoXm4vKcrt5DUXCpvmR3L3ymk1s9gFCpfA++9iUhprBR5BqpjtmZueZgXwo9orGEg
	cCMOciR97WFVn27WUl+fgJcy9ACEUksnQ8qZsHFx3tHkWahmffAQ3VgLCYlGliggmNupQ73OKso
	A0v0xenWzC/X6zDP6yVt7CUyE67+wWzYnoVWuC9BQXO+vRfTJeepa5YC2oYDz9Hdo5u10SrfZZ6
	DFA41HUl74NKuftC/Uu0Ts+fg=
X-Received: by 2002:a05:6402:2351:b0:64b:588b:4375 with SMTP id 4fb4d7f45d1cf-65870690a9cmr1523024a12.2.1769370687586;
        Sun, 25 Jan 2026 11:51:27 -0800 (PST)
Received: from C-PF5D4647.localdomain ([147.161.248.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b965df4sm4010232a12.31.2026.01.25.11.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 11:51:27 -0800 (PST)
From: Jie Li <lj29312931@gmail.com>
X-Google-Original-From: Jie Li <jie.i.li@nokia.com>
To: wsa@kernel.org,
	linus.walleij@linaro.org
Cc: linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jie Li <jie.i.li@nokia.com>
Subject: [PATCH v2 0/2] i2c: improve bus recovery for single-ended GPIOs
Date: Sun, 25 Jan 2026 20:51:21 +0100
Message-ID: <20260125195123.248798-1-jie.i.li@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAD++jLmGMWjCD0gUcaJPuK0UzJa7nX1bdoVu-BA7aHAgcLTSpg@mail.gmail.com>
References: <CAD++jLmGMWjCD0gUcaJPuK0UzJa7nX1bdoVu-BA7aHAgcLTSpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

Apologies for the late reply, as things have been a bit hectic at work lately.

Thank you very much for the guidance and the suggestion to move the logic into
gpiolib. This is a far better approach than my initial one. As this is my first
time submitting code to the Linux community, I am very grateful for your
mentorship and support.

This series (v2) addresses a limitation in the I2C bus recovery 
mechanism where certain open-drain GPIOs are incorrectly identified 
as input-only, preventing the recovery logic from functioning.

Following the suggestion from Linus Walleij, this version drops the 
previously proposed "force-set-sda" DT property. Instead, it 
introduces a generic helper in the GPIO subsystem to identify 
single-ended configurations. This allows the I2C core to reliably 
enable recovery for open-drain lines regardless of the 
instantaneous hardware direction reporting.

Changes in v2:
- Replaced DT-based "force-set-sda" with a gpiolib helper.
- Added gpiod_is_single_ended() to drivers/gpio/gpiolib.c.
- Updated i2c-core-base.c to use the new helper.

Jie Li (2):
  gpiolib: add gpiod_is_single_ended() helper
  i2c: core: support recovery for single-ended GPIOs

 drivers/gpio/gpiolib.c        | 22 ++++++++++++++++++++++
 drivers/i2c/i2c-core-base.c   |  3 ++-
 include/linux/gpio/consumer.h |  5 +++++
 3 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.43.0

