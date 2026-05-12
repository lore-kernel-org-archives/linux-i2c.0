Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8013FF88D
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571152; cv=none; b=jQw0H7VDKoCn4+dOTMhh19QhNNBwnMIBFbOPcwSjK/lTxEMRIqeqBPYmxC4BFLBRBgkB2rX3YJtSM+O66zy8muzogGXKQ9rj8ll7hfIdmdEKaZMJiA9bGTsJM3JDaB7vJFjZ0GufggfN1tE2t3jrbP94pGn5p5CeaEoy7Xsk3Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571152; c=relaxed/simple;
	bh=pdYvF+Sk+5Qtm7MPxsJdTzM7WXs+BtD0PbNzj9oHtYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Go53Cc7jhtRyq2grj51U5NxJ9yHBoP4w5TyAJic0D6YzyKL2eR9vSRaiUn0oEsjE7p9gxn5pBxj0BFruvCnvDVFwq/9X4ac+EHKLcFfX4L2KOdDcKeNva+Vw6HaKrULPXp8I547HQNrwgVTFd0L7wE5zY2HxMG5LkZNb8oGwbCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWf8Sw4K; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWf8Sw4K"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-366be8040a9so1759316a91.3
        for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 00:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778571150; x=1779175950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1U7TBG5kHM139IR5XJ/vRZGZx3+E8rlZI9Ha1Id3g8=;
        b=IWf8Sw4Kb4XjUldznu7+Af+m72gvTy0kln8NBrBTxBZTlwIvhbb+lHGn8jKyYMuoP9
         prmPZYtw47StqRqkXE7LusBkk+Whwn/W+5dF2zPwP6sqklXBy6VmLOlSFdzTlv6prxLD
         +z5O1pkjnNZOOc9jcsV8hZxpumL3B/z3o79tOU427yYxPFr6VW5x95eAZiq4FNZ7rVqN
         uO7Wu5wiPOb/GoyFEBNt2I4fIHkJ5ehxhlZlGZf5zEUatVW+L++4Ij3MsipWF14a9Dp5
         UqUnIxU3eIns63SAMe/hJVE9BatDrlzqOQsty203EwEItBaz4E7P4Zs17iSfCz/QVpcS
         K6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571150; x=1779175950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F1U7TBG5kHM139IR5XJ/vRZGZx3+E8rlZI9Ha1Id3g8=;
        b=OF9cA+p9EhDWVHAAFKmA40YNL6nUxE44T0KTlDXOqzLi79wrFHcpBQMK2/ArRm7kNn
         436WC/hQyUoCuxl3meLehix2fNNPbQhIAPlZHFmyowim3Yn/piHVYxbdshPiyCg9kx+n
         kMmKAsBe2SEq9Iz+wbFdPMcroizmT6DdrvNdYQOw4EXeSj042eiCKa2gA14KbhsSkPKQ
         sJ/jbWkLkUwhC8xDwoOeXXYB88b3v/yFlH5+0TuYdLrUwOZF6JeUEjWGW21UY5QqFhs1
         sXV2QH18nNlUK2ZI83pZQcXtl4zWYQ6DsOgKJWH+QVS+Sdqn9O8jIwGzp0YSIIeijfDF
         u/Lw==
X-Forwarded-Encrypted: i=1; AFNElJ+SgZWhf7WAhcHtzWZy7KErDCv7lfZ1lFoTJJXT/VHWdf3GTjaguqR4TF+OZMPKGljk2CRRT6Su1s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwScyXkTiradFJiy6nWC2ydXH32zIUYTOMnk9IieEpp9opnB1uU
	4ZlaeJvF0Qf/i6D3WPj4Ej390X9W4AGTTjP5AeZhNsr7W9rW/h1KSe+i
X-Gm-Gg: Acq92OF/e1KJpT5s11EF72Zmh0GRrfyLCtC+FZFSLq8FlfrpjF+aasTOdI3UZ/3DCS5
	H76j5GCqGggrL5TSHndVy6FQGpseVBCryFx30jfkuNQJhWq6VI5R1ri1zpZCgfDjOVANacX4e4r
	oWhwxQxa16BQEFKymJh9qxUMCeK7WwmKMktQ3LxbhrESK61GeDTv7mbYoAIZqKfgFfwpQ5rPnfH
	VOcI7C0W1sIuXiNq9BJtEkA5/GIoXSVipIo8Q6o/frkj3ZoLmfxp/5BYVr6QOA0QHmeM1LHt+JC
	MqBmL5ty1moj0JcaB5bkVwneGtgK2gnVW0wZ5MnJGj5d21I+opmwORiMg1iaN9YJBZ2D7qUN+pQ
	E6QKKPV3AhobcTtXMLnYAUf11V71a6IqKdW79fl/CzIZQWbLH1UPWyO9EoT4I5lWyQUtxmOWcuh
	/qO4KslY6+UuyoeACnnwNNaYvvhUODeuEWsjXEVoZXPh23h3ZoaiQymiWH2pOtWtizrsSMlDJFl
	GfwtqJVKwuWbti6FHTavQ9ZnL9ugajTFdFPYmEytRPkH1QKvypt1uTuOpnuFlk=
X-Received: by 2002:a17:90b:2710:b0:368:6a6e:94dd with SMTP id 98e67ed59e1d1-368b2726528mr2224622a91.24.1778571150068;
        Tue, 12 May 2026 00:32:30 -0700 (PDT)
Received: from hardik-yoga ([2401:4900:1c23:32d:3989:a15e:2491:59ba])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d63bad27sm12420410a91.10.2026.05.12.00.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:32:29 -0700 (PDT)
From: Hardik Prakash <hardikprakash.official@gmail.com>
To: linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: linus.walleij@linaro.org,
	wsa@kernel.org,
	Hardik Prakash <hardikprakash.official@gmail.com>
Subject: [PATCH 1/2] pinctrl-amd: enable IRQ for WACF2200 touchscreen on Lenovo Yoga 7 14AGP11
Date: Tue, 12 May 2026 13:01:38 +0530
Message-ID: <20260512073139.16343-2-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512073139.16343-1-hardikprakash.official@gmail.com>
References: <20260512073139.16343-1-hardikprakash.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Lenovo Yoga 7 14AGP11 (83TD), the WACF2200 touchscreen controller
is wired via I2C2 (AMDI0010:02) with its interrupt on GPIO pin 157
(confirmed via ACPI _CRS GpioInt decode). After amd_gpio_irq_init()
clears all GPIO interrupts at boot, pin 157 is never re-enabled,
preventing the touchscreen from signalling the driver.

Windows keeps GPIO 157 INTERRUPT_ENABLE (bit 11) and INTERRUPT_MASK
(bit 12) set after initialisation. Add a DMI quirk to restore these
bits after amd_gpio_irq_init() on this hardware.

Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
---
 drivers/pinctrl/pinctrl-amd.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index e3128b0045d22..64315b0edf2a6 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
 #include <linux/pinctrl/pinconf.h>
+#include <linux/dmi.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/string_choices.h>
@@ -39,6 +40,39 @@
 static struct amd_gpio *pinctrl_dev;
 #endif
 
+static const struct dmi_system_id amd_gpio_quirk_yoga7_14agp11[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83TD"),
+			DMI_MATCH(DMI_BOARD_NAME, "LNVNB161216"),
+		},
+	},
+	{ }
+};
+
+static void amd_gpio_apply_quirks(struct amd_gpio *gpio_dev)
+{
+	const unsigned int pin = 157; /* WACF2200 GpioInt per ACPI _CRS */
+	unsigned long flags;
+	u32 reg;
+
+	if (!dmi_check_system(amd_gpio_quirk_yoga7_14agp11))
+		return;
+	if (pin >= gpio_dev->gc.ngpio)
+		return;
+
+	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
+	reg = readl(gpio_dev->base + pin * 4);
+	reg |= BIT(INTERRUPT_ENABLE_OFF) | BIT(INTERRUPT_MASK_OFF);
+	writel(reg, gpio_dev->base + pin * 4);
+	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
+
+	dev_info(&gpio_dev->pdev->dev,
+		 "Enabled IRQ for GPIO %u (Yoga 7 14AGP11 touchscreen)\n",
+		 pin);
+}
+
 static int amd_gpio_get_direction(struct gpio_chip *gc, unsigned offset)
 {
 	unsigned long flags;
@@ -1219,6 +1253,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
 
 	/* Disable and mask interrupts */
 	amd_gpio_irq_init(gpio_dev);
+	amd_gpio_apply_quirks(gpio_dev);
 
 	girq = &gpio_dev->gc.irq;
 	gpio_irq_chip_set_chip(girq, &amd_gpio_irqchip);
-- 
2.54.0

