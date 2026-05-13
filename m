Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A453D3485
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 06:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778652862; cv=none; b=K88WHY7zd+ueGV19S3bIra23gpqABnaqTVDmv/JAAm4Zw0s7KKLQNscy15qvhKqbAxz7rv2w/GhstpRxhJNSKMTjOQPUBI7pfSpEUWQLIb3xNVoi0jC2MpqKq+/UnekMikToeLTAoiv6fjUDKzekg+7ceEKVpYGr2m3UkZgEXTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778652862; c=relaxed/simple;
	bh=1Nb5K6b9vdJ82GOO2YqSTVU36l4hCMuI8qeYvM2NjdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3OC2gnRdjwkeMvHKpjVHsaMQzjgZnHHzmuJ2lzvYzgGYbxdf0dbLYYc8qMnmcT+o83/VoagCmBet88u8af/a8AqPN2C94JgD73Ziz5IZAC1z90RMGjOmVnbQlBs5+vh97s5+gCbn1wE8lEggjhajgL1gUfzhApi0CH/HuLDxI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gddHux3x; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gddHux3x"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c801d732058so3073750a12.1
        for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 23:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778652860; x=1779257660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbWUPZ03mDdxdSYYlsvSPmpVezNp0pNuUyGvANfB4Mo=;
        b=gddHux3xhkJZHky3kZ95IAc41t2ejdJ2w+M/H3MzhYcRO3bm1yEb+qzHz0qAZvIZKw
         HOYsauRX4TrJaFUtzo84q3HxCf302LxNhQt61rOMqXPGLX57D5+tCT0asBzzsBgBNDgY
         kBEFtRFDitL2hV51+yeIrNWZuB7bk+MjFY3Q4VIExqYzXaSCDhiRIAhCDEJYkUyua8Q+
         d+VXGfJNLVw5VW1kpf98/eksvccF2HYB/4ah8qfJzHdoW5pDztBs3/I3lNvm7PSX/VzB
         lSSJKLvGdmDOIo0ZT3NB039qoXYecSPLvPN2Ldj1DFwEmYUQhhFhDK7TfCXy6fVcSEmX
         FpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778652860; x=1779257660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MbWUPZ03mDdxdSYYlsvSPmpVezNp0pNuUyGvANfB4Mo=;
        b=jlOEqVtHjyZ/7KzATiCIJhGNLKryJPjhmZTfwk5ODQbuEoxR8KBOnVn5H5jBwDh+v5
         3An3oFz6b7HGSTeDGFa/Ajy4kTl8+7d3Bgq5ypYcaixnSI2YRMctyfoRX0SqD4aZR05u
         KZDoqNxwdN53JHD9+uhh8rBKTmixEfnZIcpFLnl0DHKuGd4IDYbOpK80M8atqwlOwPcd
         yJ2sy7V2Wv5J6aEBXCbQvQNnjDX6O2ZCuNsStVOAn0xT8tnMjNk4zukLWACxiM6morl4
         6EMV/9L4Y02dYp0xkfUbgl2HQTtdNcwzL6OMD2iCF7pcYr+v7DhO/ZLy9BZQ2kRSTHn+
         piOg==
X-Forwarded-Encrypted: i=1; AFNElJ9Ti3mA5BEq5st4SobHL2wp6VzdpF0xa1W7MbwlYHJHUX8CbZ5g72vb/wefaZQWnhF0x0j+f91eHTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBs7gy5NXwgg6Aa3SmDmgtQ3tngJivO5u1jTPqvokuvknbWD5q
	hb4NJSh8i5zFVZqEKn1MBdL4xlwaPxazrnzM2aqMs4cbWdN0mgqyFFxr
X-Gm-Gg: Acq92OHX2Sd0YcXGFlSjpl11VLS95n84DKSgv4IboAI2ixtajbQNStnep67UTZ7BMJz
	F4Jgq67ODXIFZDB9bMlkcz6zFQPzY4cTB0EoON9cUw6vU7A0CgJ04B130HgimpX4TwSgbY6G6L+
	e46q1jEbvaodY9H1UeX9bY/IPm3cDK4nbAZNTvcNE7PyPNvuomg5rmRm0wW2YhY94Jfal/Eju92
	JABQUx/QSin+ba/iX5aGiTHUJ8T9IVYeP7jLHtWKdO2tg490mk1ko7hzBbM3/BqCDygQYp9UAkp
	yEj9dmUIxrT3hWI5EhPbutRprHdBpyQeSkvQ+tKjKqA5SkTmst7wq/T2KYI8bGP1MjMo+moVkut
	+00itm5DqcGntnI0/zE2mRnl0JINw0UQzBMTokgvhOCoaai5ay+pfRVBCjDbl4AeHgJAJRj26sg
	dGcLf9dC1AIjYjzCtV+zqCe3l/bUTSJiyakSGIyRMSipT/XUA4VHOdX4Hh1gX3p1uVfnwYkTyWg
	oOkJZFVL7ODu3tfFAkJyeNS8n6M9Zwk2AVxFlWJ7ki48J1Vmtuw3OScLND75Wur
X-Received: by 2002:a05:6a21:338f:b0:3a2:f05a:795e with SMTP id adf61e73a8af0-3acd4207c22mr6738499637.3.1778652860126;
        Tue, 12 May 2026 23:14:20 -0700 (PDT)
Received: from hardik-yoga ([2401:4900:1c64:ff18:3fa8:7855:804e:9f49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826771a8a1sm13470874a12.24.2026.05.12.23.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 23:14:19 -0700 (PDT)
From: Hardik Prakash <hardikprakash.official@gmail.com>
To: linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: linus.walleij@linaro.org,
	wsa@kernel.org,
	andriy.shevchenko@intel.com,
	Hardik Prakash <hardikprakash.official@gmail.com>
Subject: [PATCH 1/2] pinctrl-amd: enable IRQ for WACF2200 touchscreen on Lenovo Yoga 7 14AGP11
Date: Wed, 13 May 2026 11:43:37 +0530
Message-ID: <20260513061338.9348-2-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513061338.9348-1-hardikprakash.official@gmail.com>
References: <20260513061338.9348-1-hardikprakash.official@gmail.com>
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
Assisted-by: Claude:claude-sonnet-4-6
Assisted-by: GPT-Codex:gpt-5.2-codex
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

